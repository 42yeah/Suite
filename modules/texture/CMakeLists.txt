add_library(suite_texture Texture.cu Texture.cuh)

target_link_libraries(suite_texture
        glm::glm)

target_include_directories(suite_texture PUBLIC
        glm::glm
        ${PROJECT_SOURCE_DIR})
