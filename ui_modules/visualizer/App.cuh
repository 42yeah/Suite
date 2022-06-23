//
// Created by 42yea on 20/06/2022.
//

#ifndef SUITE_APP_H
#define SUITE_APP_H

#include <iostream>
#include <optional>
#include <glm/glm.hpp>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "modules/model/Camera.cuh"
#include "ui_modules/opengl/ModelGL.cuh"
#include "ui_modules/opengl/SceneGL.cuh"
#include "ui_modules/shader/Program.cuh"


class App {
public:
    App();

    App(const App &) = delete;

    App(App &&) = delete;

    ~App();

    void run();

private:
    void update_camera();

    GLFWwindow *window;

    std::shared_ptr<Program> program;
    std::shared_ptr<Program> bbox_program;
    std::shared_ptr<SceneGL> scene;

    // camera manipulation
    Camera camera;
    std::optional<glm::vec2> start_cursor_pos, start_py;
    double previous_instant;
    float delta_time;
};


void start_app();

#endif //SUITE_APP_H
