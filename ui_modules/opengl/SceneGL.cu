//
// Created by 42yea on 2022/6/21.
//

#include "SceneGL.cuh"
#include <map>


SceneGL::SceneGL(const Scene &scene) : center(0.0f) {
    std::map<std::shared_ptr<Model>, std::shared_ptr<ModelGL> > lookup;
    for (const auto &model : scene.get_models()) {
        models.push_back(std::make_shared<ModelGL>(*model));
        lookup[model] = models.back();
    }
    for (const auto &obj : scene.get_objects()) {
        if (obj.model == nullptr) {
            objects.emplace_back(nullptr, obj.transform);
            continue;
        }
        objects.emplace_back(lookup[obj.model], obj.transform);
    }
    center = scene.center();
}

void SceneGL::render_using(Program &program, const Camera &camera) const {
    for (const auto &obj : objects) {
        obj.render_using(program, camera);
    }
}

glm::vec3 SceneGL::get_center() const {
    return center;
}

BBox SceneGL::bbox() const {
    BBox bbox;
    for (const auto &obj : objects) {
        bbox = bbox + obj.bbox();
    }
    return bbox;
}

const std::vector<std::shared_ptr<ModelGL> > &SceneGL::get_models() const {
    return models;
}

std::vector<ObjectGL> SceneGL::get_objects() const {
    return objects;
}
