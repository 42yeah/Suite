//
// Created by 42yea on 2022/6/22.
//

#include "Triangle.cuh"

CUDA_FUNC_DECL Triangle::Triangle() : a(Vertex{}), b(Vertex{}), c(Vertex{}), center(0.0f), bbox() {

}

CUDA_FUNC_DECL Triangle::Triangle(Vertex a, Vertex b, Vertex c) : a(a), b(b), c(c), center(0.0f), bbox() {
    bbox.enclose(a.position);
    bbox.enclose(b.position);
    bbox.enclose(c.position);
    center += a.position;
    center += b.position;
    center += c.position;
    center /= 3.0f;
}

CUDA_FUNC_DECL glm::vec3 Triangle::barycentric(glm::vec3 p) const {
    glm::vec3 bc = c.position - b.position;
    glm::vec3 ba = a.position - b.position;

    float s_abc = glm::cross(bc, ba).z;
    float s_pbc = glm::cross(bc, p - b.position).z;
    float s_pac = glm::cross(p - b.position, ba).z;

    float u = s_pbc / s_abc;
    float v = s_pac / s_abc;
    float w = 1.0f - u - v;

    return { u, v, w };
}

CUDA_FUNC_DECL Triangle::Triangle(glm::vec3 a, glm::vec3 b, glm::vec3 c) : a(Vertex{ a }), b(Vertex{ b }), c(Vertex{ c }), center(0.0f), bbox() {
    bbox.enclose(a);
    bbox.enclose(b);
    bbox.enclose(c);
    center += a;
    center += b;
    center += c;
    center /= 3.0f;
}
