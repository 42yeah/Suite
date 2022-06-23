add_library(suite_bvh BVH.cu BVH.cuh)

target_link_libraries(suite_bvh
        glm::glm)

target_include_directories(suite_bvh PUBLIC
        glm::glm
        ${PROJECT_SOURCE_DIR})
