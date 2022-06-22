add_library(suite_prim prim.cuh prim.cu)

target_link_libraries(suite_prim
        glm::glm)

target_include_directories(suite_prim PUBLIC
        glm::glm
        ${PROJECT_SOURCE_DIR}/deps/glad/include
        ${PROJECT_SOURCE_DIR})
