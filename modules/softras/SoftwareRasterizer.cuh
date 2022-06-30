//
// Created by 42yea on 29/06/2022.
//

#ifndef SUITE_SOFTWARERASTERIZER_CUH
#define SUITE_SOFTWARERASTERIZER_CUH

#include <glm/glm.hpp>
#include "modules/texture/Texture.cuh"
#include "modules/model/Scene.cuh"
#include "modules/model/Camera.cuh"


class SoftwareRasterizer {
public:
    explicit SoftwareRasterizer(glm::ivec2 size);

    void clear(glm::vec4 color);

    const Texture &render(const Scene &scene, const Camera &camera);

    const Texture &render(const Object &object, const Camera &camera);

private:
    void rasterize(const Object &obj, Texture &texture, const Camera &camera);

    Texture output, depth;

    glm::ivec2 size;
};


#endif //SUITE_SOFTWARERASTERIZER_CUH
