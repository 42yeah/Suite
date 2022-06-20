add_library(suite_model Model.cu Model.cuh)

target_link_libraries(suite_model 
        glm::glm)

target_include_directories(suite_model PUBLIC
        glm::glm)
