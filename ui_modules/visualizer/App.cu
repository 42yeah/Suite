//
// Created by 42yea on 20/06/2022.
//

#include <glm/gtc/type_ptr.hpp>
#include "App.cuh"

constexpr int window_w = 1280, window_h = 720;


App::App() {
    window = glfwCreateWindow(window_w, window_h, "Suite", nullptr, nullptr);
    glfwMakeContextCurrent(window);
    gladLoadGL();
    glClearColor(0.5f, 0.0f, 0.5f, 1.0f);
    glEnable(GL_DEPTH_TEST);

    program = std::make_shared<Program>("shaders/default/default.vert", "shaders/default/default.frag");
    camera = Camera(glm::vec3(0.0f, 0.0f, 5.0f), glm::radians(45.0f), (float) window_w / window_h, 0.1f, 100.0f);

    Scene scene_raw("models/ball.dae");
    scene = std::make_shared<SceneGL>(scene_raw);

    previous_instant = glfwGetTime();
    delta_time = 0.0f;
}

void App::run() {
    Program &prog = *this->program;

    while (!glfwWindowShouldClose(window)) {
        double time = glfwGetTime();
        delta_time = (float) (time - previous_instant);
        previous_instant = time;

        glfwPollEvents();
        update_camera();

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        prog.use();
        scene->render_using(prog, camera);

        glfwSwapBuffers(window);
    }
}

App::~App() {
    glfwDestroyWindow(window);
}

void App::update_camera() {
    glm::vec3 right = glm::normalize(glm::cross(camera.front, glm::vec3(0.0f, 1.0f, 0.0f)));
    bool should_update_camera = false;
    if (glfwGetKey(window, GLFW_KEY_W)) {
        camera.eye += camera.front * camera.speed * delta_time;
        should_update_camera = true;
    }
    if (glfwGetKey(window, GLFW_KEY_S)) {
        camera.eye -= camera.front * camera.speed * delta_time;
        should_update_camera = true;
    }
    if (glfwGetKey(window, GLFW_KEY_D)) {
        camera.eye += right * camera.speed * delta_time;
        should_update_camera = true;
    }
    if (glfwGetKey(window, GLFW_KEY_A)) {
        camera.eye -= right * camera.speed * delta_time;
        should_update_camera = true;
    }

    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_1)) {
        double xpos, ypos;
        glfwGetCursorPos(window, &xpos, &ypos);
        if (!start_cursor_pos) {
            start_cursor_pos = glm::vec2(xpos, ypos);
            start_py = glm::vec2(camera.pitch, camera.yaw);
        }

        glm::vec2 del_cursor_pos = glm::vec2(xpos, ypos) - *start_cursor_pos;
        del_cursor_pos = del_cursor_pos / glm::vec2(window_w, window_h) * glm::pi<float>();
        camera.pitch = start_py->x - del_cursor_pos.y;
        camera.yaw = start_py->y + del_cursor_pos.x;
        should_update_camera = true;
    } else if (start_cursor_pos) {
        // finalize
        start_cursor_pos = std::nullopt;
        start_py = std::nullopt;
        should_update_camera = true;
    }

    if (should_update_camera) {
        camera.update_camera();
    }
}


void start_app() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    App app;
    app.run();
}
