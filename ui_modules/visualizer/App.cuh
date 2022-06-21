//
// Created by 42yea on 20/06/2022.
//

#ifndef SUITE_APP_H
#define SUITE_APP_H

#include <iostream>
#include <glm/glm.hpp>
#include <glad/glad.h>
#include <GLFW/glfw3.h>


class App {
public:
    App();

    App(const App &) = delete;

    App(App &&) = delete;

    ~App();

    void run();

private:
    GLFWwindow *window;
};


void start_app();

#endif //SUITE_APP_H
