//
// Created by 42yea on 29/06/2022.
//

#include "SoftwareRasterizer.cuh"
#include <vector>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include "modules/model/Model.cuh"
#include "modules/model/Vertex.cuh"
#include "modules/geoquery/Triangle.cuh"
#include "modules/cuda/CudaPtr.cuh"


const Texture &SoftwareRasterizer::render(const Scene &scene, const Camera &camera) {
    // for each object...
    for (const Object &obj : scene.get_objects()) {
        rasterize(obj, output, camera);
    }
    return output;
}

const Texture &SoftwareRasterizer::render(const Object &object, const Camera &camera) {
    rasterize(object, output, camera);
    return output;
}

SoftwareRasterizer::SoftwareRasterizer(glm::ivec2 size) : size(size), output(size), depth(size) {
    output.clear(glm::vec4(0.5f, 0.0f, 0.5f, 1.0f));
    depth.clear(glm::vec4(std::numeric_limits<float>::max(), 0.0f, 0.0f, 1.0f));
}

__global__ void software_vertex_shader(glm::mat4 model, glm::mat4 view, glm::mat4 perspective,
                                       Vertex *vertices, Triangle *triangles, int n_triangles) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    if (x > n_triangles) {
        return;
    }

    for (int i = 0; i < 3; i++) {
        Vertex vert = vertices[x * 3 + i];

        vert.normal = glm::vec3(model * glm::vec4(vert.normal, 0.0f));

        // perform perspective divide
        glm::vec4 pos = perspective * view * model * glm::vec4(vert.position, 1.0f);
        vert.position = glm::vec3(pos) / pos.w;

        switch (i) {
            case 0:
                triangles[x].a = vert;
                break;

            case 1:
                triangles[x].b = vert;
                break;

            case 2:
                triangles[x].c = vert;
                break;

            default:
                break;
        }

        triangles[x].bbox.enclose(vert.position);
        triangles[x].center += vert.position;

    }

    triangles[x].center /= 3.0f;

}

__global__ void software_fragment_shader(Triangle *triangles, int n_tri, glm::vec4 *tex, glm::vec4 *depth,
                                         glm::ivec2 size) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i > n_tri) {
        return;
    }

    const Triangle &tri = triangles[i];
    BBox bbox = tri.bbox;

    if ((bbox.min.x > 1.0f || bbox.min.y > 1.0f) || (bbox.max.x < -1.0f || bbox.max.y < -1.0f)) {
        return;
    }

    Triangle tri_screen(glm::vec3(0.5f * tri.a.position + 0.5f) * glm::vec3(size, 0.0f),
            glm::vec3(0.5f * tri.b.position + 0.5f) * glm::vec3(size, 0.0f),
            glm::vec3(0.5f * tri.c.position + 0.5f) * glm::vec3(size, 0.0f));

    BBox bbox_screen = tri_screen.bbox;

    glm::ivec2 screen_min = glm::max(glm::ivec2(bbox_screen.min), 0);
    glm::ivec2 screen_max = glm::min(glm::ivec2(bbox_screen.max), glm::ivec2(size.x - 1, size.y - 1));

    for (int y = screen_min.y; y <= screen_max.y; y++) {
        for (int x = screen_min.x; x <= screen_max.x; x++) {
            // perform barycentric triangle test
            glm::vec3 barycentric = tri_screen.barycentric(glm::vec3(x, y, 0.0f));
            if (barycentric.x < 0.0f || barycentric.y < 0.0f || barycentric.z < 0.0f) {
                continue;
            }
            // barycentric interpolate current depth value & perform depth testing
            float z = barycentric.x * tri.a.position.z + barycentric.y * tri.b.position.z + barycentric.z * tri.c.position.z;
            if (depth[y * size.x + x].r < z) {
                continue;
            }
            depth[y * size.x + x].r = z;

            // evaluate phong shading
            glm::vec3 normal = barycentric.x * tri.a.normal + barycentric.y * tri.b.normal +
                               barycentric.z * tri.c.normal;
            glm::vec3 obj_color = glm::vec3(1.0f, 1.0f, 1.0f);
            float ambient = 0.2f;
            float diffuse = glm::max(glm::dot(normal, glm::vec3(0.0f, 1.0f, 0.0f)), 0.0f);

            tex[y * size.x + x] = glm::vec4((ambient + diffuse) * obj_color, 1.0f);
        }
    }
}

void SoftwareRasterizer::rasterize(const Object &object, Texture &texture, const Camera &camera) {
    std::vector<Vertex> vertices = object.model->get_vertices();
    std::vector<Triangle> triangles;
    triangles.resize(vertices.size() / 3);

    {
        CudaPtr<glm::vec4> tex_data(&texture(0, 0), texture.get_size().x * texture.get_size().y);
        CudaPtr<glm::vec4> depth_data(&depth(0, 0), depth.get_size().x * depth.get_size().y);
        CudaPtr<Vertex> vertices_cuda(&vertices[0], vertices.size());
        CudaPtr<Triangle> triangles_cuda(&triangles[0], triangles.size());

        constexpr int block_size = 512;
        int n_blocks = triangles.size() / block_size + 1;
        software_vertex_shader<<<n_blocks, block_size>>>(object.transform,
                                                         camera.view, camera.perspective,
                                                         vertices_cuda.get(),
                                                         triangles_cuda.get(),
                                                         triangles.size());

        // rasterize each triangle
        software_fragment_shader<<<n_blocks, block_size>>>(triangles_cuda.get(),
                                                           triangles.size(),
                                                           tex_data.get(),
                                                           depth_data.get(),
                                                           texture.get_size());
    }
}

void SoftwareRasterizer::clear(glm::vec4 color) {
    output.clear(color);
    depth.clear(glm::vec4(std::numeric_limits<float>::max(), 0.0f, 0.0f, 1.0f));
}

