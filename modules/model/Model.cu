//
// Created by 42yea on 21/06/2022.
//

#include "Model.cuh"


Model::Model(std::vector<Vertex> m_vertices) : vertices(std::move(m_vertices)), center(0.0f) {
    for (const auto &v : vertices) {
        center += v.position;
        bbox.enclose(v.position);
    }
    center /= vertices.size();
}

const std::vector<Vertex> &Model::get_vertices() const {
    return vertices;
}
