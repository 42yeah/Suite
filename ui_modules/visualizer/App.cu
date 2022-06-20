//
// Created by 42yea on 20/06/2022.
//

#include "App.cuh"


constexpr int window_w = 1280, window_h = 720;

App::App() {
    window = glfwCreateWindow(window_w, window_h, "Suite", nullptr, nullptr);
    glfwMakeContextCurrent(window);
    gladLoadGL();
    glClearColor(1.0f, 0.0f, 1.0f, 1.0f);
}

void App::run() {
    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glfwSwapBuffers(window);
    }
}

App::~App() {
    glfwDestroyWindow(window);
}
