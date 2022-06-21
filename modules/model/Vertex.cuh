//
// Created by 42yea on 21/06/2022.
//

#ifndef SUITE_VERTEX_H
#define SUITE_VERTEX_H

#include <glm/glm.hpp>


struct Vertex {
    glm::vec3 position;
    glm::vec3 normal;
    glm::vec2 tex_coord;
};

#endif // SUITE_VERTEX_H
