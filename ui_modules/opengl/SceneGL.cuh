//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_SCENEGL_CUH
#define SUITE_SCENEGL_CUH

#include <vector>
#include "modules/model/Scene.cuh"
#include "modules/model/Camera.cuh"
#include "ui_modules/shader/Program.cuh"
#include "ModelGL.cuh"
#include "ObjectGL.cuh"


class SceneGL {
public:
    explicit SceneGL(const Scene &);

    SceneGL(const SceneGL &) = delete;

    SceneGL(SceneGL &&) = delete;

    void render_using(Program &program, const Camera &camera) const;

    glm::vec3 get_center() const;

    BBox bbox() const;

    const std::vector<std::shared_ptr<ModelGL> > &get_models() const;

    std::vector<ObjectGL> get_objects() const;

private:
    std::vector<std::shared_ptr<ModelGL> > models;
    std::vector<ObjectGL> objects;
    glm::vec3 center;
};


#endif //SUITE_SCENEGL_CUH
