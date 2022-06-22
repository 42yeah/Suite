//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_OBJECTGL_CUH
#define SUITE_OBJECTGL_CUH

#include <iostream>
#include <utility>
#include <glm/gtc/type_ptr.hpp>
#include "modules/model/Object.cuh"
#include "modules/model/Camera.cuh"
#include "ModelGL.cuh"


struct ObjectGL {
    ObjectGL();

    ObjectGL(std::shared_ptr<ModelGL> model, glm::mat4 transform);

    void render_using(Program &program, const Camera &camera) const;

    std::shared_ptr<ModelGL> model;
    glm::mat4 transform;
};


#endif //SUITE_OBJECTGL_CUH
