//
// Created by 42yea on 2022/6/22.
//

#include "prim.cuh"
#include <glm/glm.hpp>


std::shared_ptr<ModelGL> gen_triangle() {
    std::vector<Vertex> vertices;

    vertices.push_back(Vertex{
        glm::vec3(0.0f, 0.0f, 0.0f),
        glm::vec3(0.0f, 0.0f, 1.0f),
        glm::vec2(0.0f, 0.0f)
    });
    vertices.push_back(Vertex{
            glm::vec3(0.5f, 0.0f, 0.0f),
            glm::vec3(0.0f, 0.0f, 1.0f),
            glm::vec2(0.5f, 0.0f)
    });
    vertices.push_back(Vertex{
            glm::vec3(0.0f, 0.5f, 0.0f),
            glm::vec3(0.0f, 0.0f, 1.0f),
            glm::vec2(0.0f, 0.5f)
    });

    Model model(vertices);
    std::shared_ptr<ModelGL> model_gl = std::make_shared<ModelGL>(model);
    return model_gl;
}
