//
// Created by 42yea on 2022/6/22.
//

#ifndef SUITE_TRIANGLE_CUH
#define SUITE_TRIANGLE_CUH

#include "modules/model/Vertex.cuh"
#include "modules/model/BBox.cuh"
#include "modules/cuda/CudaMacros.cuh"


struct Triangle {
    CUDA_FUNC_DECL Triangle();

    CUDA_FUNC_DECL Triangle(Vertex a, Vertex b, Vertex c);

    CUDA_FUNC_DECL Triangle(glm::vec3 a, glm::vec3 b, glm::vec3 c);

    /// evaluate barycentric coordinate of point p
    ///
    /// \param p point to evaluate
    /// \return barycentric coordinate
    CUDA_FUNC_DECL glm::vec3 barycentric(glm::vec3 p) const;

    Vertex a, b, c;
    glm::vec3 center;
    BBox bbox;
};

#endif //SUITE_TRIANGLE_CUH
