//
// Created by 42yea on 2022/6/21.
//

#include "ObjectGL.cuh"


ObjectGL::ObjectGL() : model(nullptr), transform(1.0f) {

}

ObjectGL::ObjectGL(std::shared_ptr<ModelGL> model, glm::mat4 transform) : model(std::move(model)), transform(transform) {

}

void ObjectGL::render_using(Program &program, const Camera &camera) const {
    glUniformMatrix4fv(program["model"], 1, GL_FALSE, glm::value_ptr(transform));
    glUniformMatrix4fv(program["view"], 1, GL_FALSE, glm::value_ptr(camera.view));
    glUniformMatrix4fv(program["perspective"], 1, GL_FALSE, glm::value_ptr(camera.perspective));
    if (model == nullptr) {
        std::cerr << "WARNING! Null model detected; that's are not supposed to happen." << std::endl;
    }
    model->render_using(program);
}

BBox ObjectGL::bbox() const {
    BBox bbox = model->get_bbox();
    bbox.min = glm::vec3(transform * glm::vec4(bbox.min, 1.0f));
    bbox.max = glm::vec3(transform * glm::vec4(bbox.max, 1.0f));
    return bbox;
}

