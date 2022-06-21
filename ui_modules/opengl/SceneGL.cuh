//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_SCENEGL_CUH
#define SUITE_SCENEGL_CUH

#include <vector>
#include "modules/model/Scene.cuh"
#include "ui_modules/shader/Program.cuh"
#include "ModelGL.cuh"
#include "ObjectGL.cuh"


class SceneGL {
public:
    explicit SceneGL(const Scene &);

    SceneGL(const SceneGL &) = delete;

    SceneGL(SceneGL &&) = delete;

    void render_using(Program &program) const;

private:
    const Scene &scene;
    std::vector<std::shared_ptr<ModelGL> > models;
    std::vector<ObjectGL> objects;
};


#endif //SUITE_SCENEGL_CUH
