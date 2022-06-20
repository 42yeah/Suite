// #pragma warning(suppress: 20012-D)

#include "ui_modules/visualizer/App.cuh"
#include <GLFW/glfw3.h>


int main() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    App app;
    app.run();

    return 0;
}
