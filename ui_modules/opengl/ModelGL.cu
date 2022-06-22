//
// Created by 42yea on 2022/6/21.
//

#include "ModelGL.cuh"


ModelGL::ModelGL(const Model &model) : VAO(0), VBO(0) {
    const std::vector<Vertex> &vertices = model.get_vertices();

    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glBindVertexArray(VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertex) * vertices.size(), &vertices[0], GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 8, nullptr);
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 8, (void *) (sizeof(float) * 3));
    glEnableVertexAttribArray(2);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 8, (void *) (sizeof(float) * 6));

    num_vertices = vertices.size();
}

ModelGL::~ModelGL() noexcept {
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
}

void ModelGL::render_using(Program &program) const {
    glBindVertexArray(VAO);

    glDrawArrays(GL_TRIANGLES, 0, num_vertices);
}

