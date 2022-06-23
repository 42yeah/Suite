//
// Created by 42yea on 20/06/2022.
//

#include "App.cuh"
#include <glm/gtc/type_ptr.hpp>
#include <imgui.h>
#include <backends/imgui_impl_glfw.h>
#include <backends/imgui_impl_opengl3.h>
#include "ui_modules/primitives/prim.cuh"


constexpr int window_w = 1280 * 2, window_h = 720 * 2;


App::App() : window_size(0) {
    window = glfwCreateWindow(window_w, window_h, "Suite", nullptr, nullptr);
    glfwMakeContextCurrent(window);
    gladLoadGL();
    glClearColor(0.5f, 0.0f, 0.5f, 1.0f);
    glEnable(GL_DEPTH_TEST);

    program = std::make_shared<Program>("shaders/default/default.vert", "shaders/default/default.frag");
    bbox_program = std::make_shared<Program>("shaders/bbox/bbox.vert", "shaders/bbox/bbox.frag");
    camera = Camera(glm::vec3(0.0f, 0.0f, 5.0f), glm::radians(45.0f), (float) window_w / window_h, 0.1f, 100.0f);

    Scene scene_raw("models/ball.dae");
    scene = std::make_shared<SceneGL>(scene_raw);

    previous_instant = glfwGetTime();
    delta_time = 0.0f;

     ImGui::CreateContext();
     ImGuiIO &io = ImGui::GetIO();
     ImGui_ImplGlfw_InitForOpenGL(window, true);
     ImGui_ImplOpenGL3_Init("#version 330 core");
     io.IniFilename = nullptr;
     io.FontGlobalScale = 2.0f;
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

        glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
        bbox_program->use();
        gen_bounding_box(scene->get_objects()[0].bbox()).render_using(*bbox_program, camera);
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        ImGui::ShowDemoWindow();

        show_scripting_layer_window();

        ImGui::Render();
        glfwGetFramebufferSize(window, &window_size.x, &window_size.y);
        glViewport(0, 0, window_size.x, window_size.y);
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

        glfwSwapBuffers(window);
    }
}

App::~App() {
    glfwDestroyWindow(window);
}

void App::update_camera() {
    if (window_size.y != 0) {
        camera.aspect = (float) window_size.x / window_size.y;
    }

    glm::vec3 right = glm::normalize(glm::cross(camera.front, glm::vec3(0.0f, 1.0f, 0.0f)));
    if (glfwGetKey(window, GLFW_KEY_W)) {
        camera.eye += camera.front * camera.speed * delta_time;
    }
    if (glfwGetKey(window, GLFW_KEY_S)) {
        camera.eye -= camera.front * camera.speed * delta_time;
    }
    if (glfwGetKey(window, GLFW_KEY_D)) {
        camera.eye += right * camera.speed * delta_time;
    }
    if (glfwGetKey(window, GLFW_KEY_A)) {
        camera.eye -= right * camera.speed * delta_time;
    }

    if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_1)) {
        double xpos, ypos;
        glfwGetCursorPos(window, &xpos, &ypos);
        if (!start_cursor_pos) {
            start_cursor_pos = glm::vec2(xpos, ypos);
            start_py = glm::vec2(camera.pitch, camera.yaw);
        }

        glm::vec2 del_cursor_pos = glm::vec2(xpos, ypos) - *start_cursor_pos;
        del_cursor_pos = del_cursor_pos / (float) glm::max(window_w, window_h) * glm::pi<float>();
        camera.pitch = start_py->x - del_cursor_pos.y;
        camera.yaw = start_py->y + del_cursor_pos.x;
    } else if (start_cursor_pos) {
        // finalize
        start_cursor_pos = std::nullopt;
        start_py = std::nullopt;
    }

    camera.update_camera();
}

void App::show_scripting_layer_window() {
    static char buf[1024] = { 0 };
    ImGui::Begin("Lua Scripting Layer");

    // ImGui::SetNextItemWidth(-std::numeric_limits<float>::min());
    ImGui::InputText("command", buf, sizeof(buf));

    ImGui::SameLine();

    if (ImGui::Button("OK")) {
        layer(buf);
    }

    ImGui::BeginTable("error_list", 1);
    for (const auto &err : layer.get_errors()) {
        ImGui::TableNextRow();
        ImGui::TableNextColumn();

        ImGui::Selectable(err.c_str());
    }
    ImGui::EndTable();

    ImGui::End();
}

void start_app() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    App app;
    app.run();
}
