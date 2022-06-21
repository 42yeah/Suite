//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_OBJECT_CUH
#define SUITE_OBJECT_CUH

#include <glm/glm.hpp>
#include <utility>
#include "Model.cuh"


struct Object {
    Object() : model(nullptr), transform(1.0f) {

    }

    Object(std::shared_ptr<Model> model, glm::mat4 transform) : model(std::move(model)), transform(transform) {

    }

    std::shared_ptr<Model> model;
    glm::mat4 transform;
};


#endif //SUITE_OBJECT_CUH
