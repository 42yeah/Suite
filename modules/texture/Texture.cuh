//
// Created by 42yea on 29/06/2022.
//

#ifndef SUITE_TEXTURE_CUH
#define SUITE_TEXTURE_CUH

#include <iostream>
#include <filesystem>
#include <glm/glm.hpp>


class Texture {
public:
    explicit Texture(glm::ivec2 size);

    Texture(const Texture &) = delete;

    Texture(Texture &&) = default;

    void clear(glm::vec4 color);

    void export_as_jpg(const std::filesystem::path &path) const;

    glm::vec4 &operator()(int x, int y);

    glm::ivec2 get_size() const;

private:
    std::unique_ptr<glm::vec4[]> data;
    glm::ivec2 size;
};


#endif //SUITE_TEXTURE_CUH
