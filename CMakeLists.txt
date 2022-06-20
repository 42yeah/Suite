cmake_minimum_required(VERSION 3.22)

project(suite CUDA)

set(CMAKE_CUDA_STANDARD 14)

find_package(glfw3 REQUIRED)
find_package(glm REQUIRED)

add_executable(suite
        main.cu
        deps/glad/src/glad.cu)

add_subdirectory(ui_modules/visualizer)

target_link_libraries(suite
        glfw
        glm::glm
        suite_visualizer)

target_include_directories(suite PUBLIC
        glfw
        glm::glm
        deps/glad/include)

set_target_properties(suite PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
