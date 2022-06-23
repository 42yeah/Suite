//
// Created by 42yea on 21/06/2022.
//

#ifndef SUITE_SCENE_H
#define SUITE_SCENE_H

#include <iostream>
#include <vector>
#include "Model.cuh"
#include "Object.cuh"
#include "BBox.cuh"


class Scene {
public:
    Scene() = default;

    Scene(const Scene &) = delete;

    Scene(Scene &&) = delete;

    explicit Scene(const std::string &path);

    const std::vector<std::shared_ptr<Model> > &get_models() const;

    std::vector<Object> get_objects() const;

    glm::vec3 center() const;

    BBox bbox() const;

    // TODO: simple path tracing
    // TODO: software rasterizer

private:
    std::vector<std::shared_ptr<Model> > models;
    std::vector<Object> objects;
};


#endif //SUITE_SCENE_H
