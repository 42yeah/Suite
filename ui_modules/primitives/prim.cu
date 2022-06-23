//
// Created by 42yea on 2022/6/22.
//

#include "prim.cuh"
#include <glm/glm.hpp>


std::shared_ptr<ModelGL> gen_triangle() {
    std::vector<Vertex> vertices;

    vertices.push_back(Vertex{
        glm::vec3(0.0f, 0.0f, 0.0f),
        glm::vec3(0.0f, 0.0f, 1.0f),
        glm::vec2(0.0f, 0.0f)
    });
    vertices.push_back(Vertex{
            glm::vec3(0.5f, 0.0f, 0.0f),
            glm::vec3(0.0f, 0.0f, 1.0f),
            glm::vec2(0.5f, 0.0f)
    });
    vertices.push_back(Vertex{
            glm::vec3(0.0f, 0.5f, 0.0f),
            glm::vec3(0.0f, 0.0f, 1.0f),
            glm::vec2(0.0f, 0.5f)
    });

    Model model(vertices);
    std::shared_ptr<ModelGL> model_gl = std::make_shared<ModelGL>(model);
    return model_gl;
}

std::shared_ptr<ModelGL> box = nullptr;

ObjectGL gen_bounding_box(const BBox &bbox) {
    if (box == nullptr) {
        glm::vec3 v0(-1.0f, -1.0f, -1.0f),
            v1(1.0f, -1.0f, -1.0f),
            v2(1.0f, -1.0f, 1.0f), //
            v3(-1.0f, -1.0f, 1.0f), //
            v4(-1.0f, 1.0f, -1.0f),
            v5(1.0f, 1.0f, -1.0f),
            v6(1.0f, 1.0f, 1.0f), //
            v7(-1.0f, 1.0f, 1.0f); //

        glm::vec3 n0(0.0f, -1.0f, 0.0f),
            n1(0.0f, 1.0f, 0.0f),
            n2(-1.0f, 0.0f, 0.0f),
            n3(1.0f, 0.0f, 0.0f),
            n4(0.0f, 0.0f, -1.0f),
            n5(0.0f, 0.0f, 1.0f);

        glm::vec2 t0(0.0f, 0.0f),
            t1(1.0f, 0.0f),
            t2(1.0f, 1.0f),
            t3(0.0f, 1.0f);

        std::vector<Vertex> vertices = {
            Vertex{ v0, n0, t0 },
            Vertex{ v1, n0, t1 },
            Vertex{ v2, n0, t2 },
            Vertex{ v2, n0, t2 },
            Vertex{ v3, n0, t3 },
            Vertex{ v0, n0, t0 },

            Vertex{ v4, n1, t0 },
            Vertex{ v5, n1, t1 },
            Vertex{ v6, n1, t2 },
            Vertex{ v6, n1, t2 },
            Vertex{ v7, n1, t3 },
            Vertex{ v4, n1, t0 },

            Vertex{ v0, n2, t0 },
            Vertex{ v3, n2, t1 },
            Vertex{ v7, n2, t2 },
            Vertex{ v7, n2, t2 },
            Vertex{ v4, n2, t3 },
            Vertex{ v0, n2, t0 },

            Vertex{ v1, n3, t0 },
            Vertex{ v2, n3, t1 },
            Vertex{ v6, n3, t2 },
            Vertex{ v6, n3, t2 },
            Vertex{ v5, n3, t3 },
            Vertex{ v1, n3, t0 },

            Vertex{ v0, n4, t0 },
            Vertex{ v1, n4, t1 },
            Vertex{ v5, n4, t2 },
            Vertex{ v5, n4, t2 },
            Vertex{ v4, n4, t3 },
            Vertex{ v0, n4, t0 },

            Vertex{ v3, n5, t0 },
            Vertex{ v2, n5, t1 },
            Vertex{ v6, n5, t2 },
            Vertex{ v6, n5, t2 },
            Vertex{ v7, n5, t3 },
            Vertex{ v3, n5, t0 }
        };

        Model model(vertices);
        box = std::make_shared<ModelGL>(model);
    }

    glm::vec3 box_center = (bbox.min + bbox.max) / 2.0f;
    glm::mat4 transform = glm::translate(glm::mat4(1.0f), box_center);
    transform = glm::scale(transform, bbox.span() * 0.5f);
    return { box, transform };
}
