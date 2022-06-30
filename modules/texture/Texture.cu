//
// Created by 42yea on 29/06/2022.
//

#include "Texture.cuh"
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "deps/stb/stb_image_write.h"
#include "modules/cuda/CudaPtr.cuh"


__global__ void clear_texture_cuda(glm::vec4 *what, glm::ivec2 size, glm::vec4 color) {
    int x = threadIdx.x, y = blockIdx.x;

    what[y * size.x + x] = color;
}

__global__ void standardize_texture(glm::vec4 *input, glm::u8vec3 *output, glm::ivec2 size) {
    int x = threadIdx.x, y = blockIdx.x;

    output[y * size.x + x].r = (unsigned char) glm::clamp(input[y * size.x + x].r * 255.0f, 0.0f, 255.0f);
    output[y * size.x + x].g = (unsigned char) glm::clamp(input[y * size.x + x].g * 255.0f, 0.0f, 255.0f);
    output[y * size.x + x].b = (unsigned char) glm::clamp(input[y * size.x + x].b * 255.0f, 0.0f, 255.0f);
}


Texture::Texture(glm::ivec2 size) : size(size), data(new glm::vec4[size.x * size.y]) {

}

void Texture::clear(glm::vec4 color) {
    CudaPtr<glm::vec4> cuda_ptr(data.get(), size.x * size.y);

    clear_texture_cuda<<<size.y, size.x>>>(cuda_ptr.get(), size, color);
}

void Texture::export_as_jpg(const std::filesystem::path &path) const {
    std::shared_ptr<glm::u8vec3[]> standardized(new glm::u8vec3[size.x * size.y]);
    CudaPtr<glm::vec4> input_cuda(data.get(), size.x * size.y);

    {
        CudaPtr<glm::u8vec3> output_cuda(standardized.get(), size.x * size.y);

        standardize_texture<<<size.y, size.x>>>(input_cuda.get(), output_cuda.get(), size);
    }

    stbi__flip_vertically_on_write = true;
    stbi_write_jpg(path.string().c_str(), size.x, size.y, 3, standardized.get(), 100);
}

glm::vec4 &Texture::operator()(int x, int y) {
    if (x < 0 || x > size.x || y < 0 || y > size.y) {
        throw std::exception("Texture indexing out of bounds");
    }
    return data[y * size.x + x];
}

glm::ivec2 Texture::get_size() const {
    return size;
}
