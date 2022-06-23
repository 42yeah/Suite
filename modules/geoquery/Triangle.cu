//
// Created by 42yea on 2022/6/22.
//

#include "Triangle.cuh"

Triangle::Triangle() : a(0.0f), b(0.0f), c(0.0f), center(0.0f), bbox() {

}

Triangle::Triangle(glm::vec3 a, glm::vec3 b, glm::vec3 c) : a(a), b(b), c(c), center(0.0f), bbox() {
    bbox.enclose(a);
    bbox.enclose(b);
    bbox.enclose(c);
    center += a;
    center += b;
    center += c;
    center /= 3.0f;
}
