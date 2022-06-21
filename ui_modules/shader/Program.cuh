//
// Created by 42yea on 2022/6/21.
//

#ifndef SUITE_PROGRAM_CUH
#define SUITE_PROGRAM_CUH

#include <iostream>
#include <glad/glad.h>
#include <map>


class Program {
public:
    Program() : program(0) {

    };

    Program(const std::string &vertex_shader_path, const std::string &fragment_shader_path);

    Program(const Program &) = delete;

    Program(Program &&) = delete;

    ~Program();

    GLint operator[](const std::string &uniform_name);

    inline void use() {
        glUseProgram(program);
    }

private:
    GLuint program;
    std::map<std::string, GLint> loc;
};


#endif //SUITE_PROGRAM_CUH
