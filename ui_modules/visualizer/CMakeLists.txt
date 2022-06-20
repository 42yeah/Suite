add_library(suite_visualizer
        App.cu
        App.cuh)

target_link_libraries(suite_visualizer
        glfw
        glm::glm)

target_include_directories(suite_visualizer PUBLIC
        glfw
        glm::glm
        ${PROJECT_SOURCE_DIR}/deps/glad/include)
