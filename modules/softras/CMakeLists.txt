add_library(suite_softras SoftwareRasterizer.cu SoftwareRasterizer.cuh)

target_link_libraries(suite_softras
        glm::glm)

target_include_directories(suite_softras PUBLIC
        glm::glm
        ${PROJECT_SOURCE_DIR})

