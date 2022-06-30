cmake_minimum_required(VERSION 3.22)

project(lua CUDA)

set(LUA_SOURCES lapi.c lauxlib.c lbaselib.c lcode.c lcorolib.c lctype.c ldblib.c ldebug.c
        ldo.c ldump.c lfunc.c lgc.c linit.c liolib.c llex.c lmathlib.c lmem.c loadlib.c
        lobject.c lopcodes.c loslib.c lparser.c lstate.c lstring.c lstrlib.c ltable.c ltablib.c
        ltm.c lundump.c lutf8lib.c lvm.c lzio.c)

set_source_files_properties(${LUA_SOURCES} PROPERTIES LANGUAGE CUDA)

add_library(lua ${LUA_SOURCES})

set_target_properties(lua PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES ${PROJECT_SOURCE_DIR})
