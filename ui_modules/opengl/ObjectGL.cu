//
// Created by 42yea on 2022/6/21.
//

#include "ObjectGL.cuh"


ObjectGL::ObjectGL() : model(nullptr), transform(1.0f) {

}

ObjectGL::ObjectGL(std::shared_ptr<ModelGL> model, glm::mat4 transform) : model(std::move(model)), transform(transform) {

}

void ObjectGL::render_using(Program &program) const {
    glUniformMatrix4fv(program["model"], 1, GL_FALSE, glm::value_ptr(transform));
    if (model == nullptr) {
        std::cerr << "WARNING! Null model detected; that's are not supposed to happen." << std::endl;
    }
    model->render_using(program);
}

