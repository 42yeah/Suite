//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_OBJECT_CUH
#define SUITE_OBJECT_CUH

#include <glm/glm.hpp>
#include <utility>
#include "Model.cuh"
#include "BBox.cuh"


struct Object {
    Object() : model(nullptr), transform(1.0f) {

    }

    Object(std::shared_ptr<Model> model, glm::mat4 transform) : model(std::move(model)), transform(transform) {

    }

    BBox bbox() const {
        BBox bbox = model->get_bbox();
        bbox.min = glm::vec3(transform * glm::vec4(bbox.min, 1.0f));
        bbox.max = glm::vec3(transform * glm::vec4(bbox.max, 1.0f));
        return bbox;
    }

    std::shared_ptr<Model> model;
    glm::mat4 transform;
};


#endif //SUITE_OBJECT_CUH
