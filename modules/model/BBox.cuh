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

    BBox operator+(const BBox &another) const {
        BBox new_bbox;
        new_bbox.min = glm::min(min, another.min);
        new_bbox.max = glm::max(max, another.max);
        return new_bbox;
    }

    glm::vec3 span() const {
        return max - min;
    }

    glm::vec3 min, max;
};


#endif //SUITE_BBOX_CUH
