message(${PROJECT_SOURCE_DIR})

set(IMGUI_PATH ${PROJECT_SOURCE_DIR}/deps/imgui)
set(IMGUI_SOURCES
        ${IMGUI_PATH}/imgui.cpp
        ${IMGUI_PATH}/imgui_demo.cpp
        ${IMGUI_PATH}/imgui_draw.cpp
        ${IMGUI_PATH}/imgui_tables.cpp
        ${IMGUI_PATH}/imgui_widgets.cpp
        ${IMGUI_PATH}/backends/imgui_impl_glfw.cpp
        ${IMGUI_PATH}/backends/imgui_impl_opengl3.cpp)

set_source_files_properties(${IMGUI_SOURCES} PROPERTIES LANGUAGE CUDA)

add_library(suite_visualizer
        App.cu
        App.cuh
        ${IMGUI_SOURCES})

target_link_libraries(suite_visualizer
        glfw
        glm::glm
        lua)

target_include_directories(suite_visualizer PUBLIC
        glfw
        glm::glm
        lua
        ${PROJECT_SOURCE_DIR}/deps/glad/include
        ${IMGUI_PATH}
        ${PROJECT_SOURCE_DIR})
