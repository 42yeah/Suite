//
// Created by 42yea on 21/06/2022.
//

#ifndef SUITE_BBOX_CUH
#define SUITE_BBOX_CUH

#include <glm/glm.hpp>
#include "modules/cuda/CudaMacros.cuh"


struct BBox {
    CUDA_FUNC_DECL BBox() : min(std::numeric_limits<float>::max()), max(std::numeric_limits<float>::min()) {

    }

    CUDA_FUNC_DECL void enclose(const glm::vec3 &p) {
        min = glm::min(min, p);
        max = glm::max(max, p);
    }

    CUDA_FUNC_DECL BBox operator+(const BBox &another) const {
        BBox new_bbox;
        new_bbox.min = glm::min(min, another.min);
        new_bbox.max = glm::max(max, another.max);
        return new_bbox;
    }

    CUDA_FUNC_DECL glm::vec3 span() const {
        return max - min;
    }

    CUDA_FUNC_DECL float surface_area() const {
        const glm::vec3 s = span();
        return 2.0f * (s.x * s.y + s.x * s.z + s.y * s.z);
    }

    CUDA_FUNC_DECL glm::vec3 center() const {
        return (min + max) / 2.0f;
    }

    glm::vec3 min, max;
};


#endif //SUITE_BBOX_CUH
