add_library(suite_program Program.cu Program.cuh)

target_include_directories(suite_program PUBLIC
        ${PROJECT_SOURCE_DIR}/deps/glad/include)
