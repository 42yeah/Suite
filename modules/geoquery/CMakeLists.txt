add_library(suite_geoquery Triangle.cuh Triangle.cu)

target_link_libraries(suite_geoquery
        glm::glm)

target_include_directories(suite_geoquery PUBLIC
        ${PROJECT_SOURCE_DIR})
