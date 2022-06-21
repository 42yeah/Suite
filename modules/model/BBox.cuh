//
// Created by 42yea on 21/06/2022.
//

#ifndef SUITE_BBOX_CUH
#define SUITE_BBOX_CUH

#include <glm/glm.hpp>


struct BBox {
    BBox() : min(std::numeric_limits<float>::max()), max(std::numeric_limits<float>::min()) {

    }

    void enclose(const glm::vec3 &p) {
        min = glm::min(min, p);
        max = glm::max(max, p);
    }

    glm::vec3 min, max;
};


#endif //SUITE_BBOX_CUH
