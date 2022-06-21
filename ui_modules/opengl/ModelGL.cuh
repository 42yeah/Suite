//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_MODELGL_CUH
#define SUITE_MODELGL_CUH

#include <glad/glad.h>
#include "ui_modules/shader/Program.cuh"
#include "modules/model/Model.cuh"


class ModelGL {
public:
    explicit ModelGL(const Model &model);

    ~ModelGL() noexcept;

    ModelGL(const ModelGL &) = delete;

    ModelGL(ModelGL &&) = delete;

    void render_using(Program &program) const;

private:
    const Model &model;
    GLuint VAO, VBO;
    int num_vertices;
};


#endif //SUITE_MODELGL_CUH
