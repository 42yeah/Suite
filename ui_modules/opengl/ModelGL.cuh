//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_MODELGL_CUH
#define SUITE_MODELGL_CUH

#include <glad/glad.h>
#include "ui_modules/shader/Program.cuh"
#include "modules/model/Model.cuh"
#include "modules/model/BBox.cuh"


class ModelGL {
public:
    explicit ModelGL(const Model &model);

    ~ModelGL() noexcept;

    ModelGL(const ModelGL &) = delete;

    ModelGL(ModelGL &&) = delete;

    /// render the model using program.
    /// note that the program won't be used.
    /// \param program the actual program
    void render_using(Program &program) const;

    BBox get_bbox() const;

public:
    GLuint VAO, VBO;
    int num_vertices;
    BBox bbox;
};

#endif //SUITE_MODELGL_CUH
