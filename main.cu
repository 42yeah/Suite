#include "ui_modules/visualizer/App.cuh"
#include "modules/model/Model.cuh"
#include <GLFW/glfw3.h>


int main() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    Model model;
    
    App app;
    app.run();

    return 0;
}
