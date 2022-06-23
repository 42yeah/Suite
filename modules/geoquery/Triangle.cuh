//
// Created by 42yea on 2022/6/22.
//

#ifndef SUITE_TRIANGLE_CUH
#define SUITE_TRIANGLE_CUH

#include "modules/model/Vertex.cuh"
#include "modules/model/BBox.cuh"


struct Triangle {
    Triangle();

    Triangle(glm::vec3 a, glm::vec3 b, glm::vec3 c);

    glm::vec3 a, b, c;
    glm::vec3 center;
    BBox bbox;
};

#endif //SUITE_TRIANGLE_CUH
