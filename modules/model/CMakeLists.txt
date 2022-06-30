add_library(suite_model Model.cu Model.cuh Scene.cu Scene.cuh BBox.cuh Object.cu Object.cuh Camera.cuh)

target_link_libraries(suite_model
        assimp::assimp
        glm::glm)

target_include_directories(suite_model PUBLIC
        assimp::assimp
        glm::glm
        ${PROJECT_SOURCE_DIR})
