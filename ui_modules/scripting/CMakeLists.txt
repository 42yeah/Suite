add_library(suite_scripting
        Scripting.cu
        Scripting.cuh)

 target_link_libraries(suite_scripting
         lua)

 target_include_directories(suite_scripting PUBLIC
         lua)
