cmake_minimum_required(VERSION 3.22)

project(suite CUDA)

set(CMAKE_CUDA_STANDARD 17)

find_package(glfw3 REQUIRED)
find_package(glm REQUIRED)
find_package(assimp REQUIRED)

add_executable(suite
        main.cu
        deps/glad/src/glad.cu)

add_subdirectory(modules/model)
add_subdirectory(ui_modules/visualizer)
add_subdirectory(ui_modules/opengl)
add_subdirectory(ui_modules/shader)

target_link_libraries(suite
        glfw
        glm::glm
        assimp::assimp
        suite_visualizer
        suite_model
        suite_opengl
        suite_program)

target_include_directories(suite PUBLIC
        glfw
        glm::glm
        assimp::assimp
        deps/glad/include)

set_target_properties(suite PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
