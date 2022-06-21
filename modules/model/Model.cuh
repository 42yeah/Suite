//
// Created by 42yea on 21/06/2022.
//

#ifndef SUITE_MODEL_H
#define SUITE_MODEL_H

#include <iostream>
#include <vector>
#include "BBox.cuh"
#include "Vertex.cuh"


class Scene;

class Model {
public:
    Model() : center(0.0f), bbox() {  }

    explicit Model(std::vector<Vertex> vertices);

    Model(const Model &) = delete;

    Model(Model &&) = delete;

    const std::vector<Vertex> &get_vertices() const;

private:
    std::vector<Vertex> vertices;
    glm::vec3 center;
    BBox bbox;
};


#endif // SUITE_MODEL_H
