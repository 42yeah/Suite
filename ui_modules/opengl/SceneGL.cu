//
// Created by 42yea on 2022/6/21.
//

#include "SceneGL.cuh"
#include <map>


SceneGL::SceneGL(const Scene &scene) : scene(scene) {
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
}

void SceneGL::render_using(Program &program) const {
    for (const auto &obj : objects) {
        obj.render_using(program);
    }
}
