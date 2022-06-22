# Dependencies: suite_program

add_library(suite_opengl SceneGL.cu SceneGL.cuh ModelGL.cu ModelGL.cuh ObjectGL.cu ObjectGL.cuh)

target_link_libraries(suite_opengl
        glm::glm)

message("JANKY ${PROJECT_SOURCE_DIR}")

target_include_directories(suite_opengl PUBLIC
        glm::glm
        ${PROJECT_SOURCE_DIR}/deps/glad/include
        ${PROJECT_SOURCE_DIR})
