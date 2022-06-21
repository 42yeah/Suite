//
// Created by 42yea on 2022/6/21.
//

#include "Program.cuh"
#include <fstream>
#include <sstream>
#include <optional>


std::optional<GLuint> compile(GLuint type, const std::string &path) {
    std::ifstream reader(path);

    if (!reader.good()) {
        std::cerr << "ERR! Cannot open: " << path << std::endl;
        return std::nullopt;
    }
    std::stringstream ss;
    ss << reader.rdbuf();
    std::string str = ss.str();
    const char *src = str.c_str();

    GLuint shader = glCreateShader(type);
    glShaderSource(shader, 1, &src, nullptr);
    glCompileShader(shader);

    GLint state;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &state);
    if (state != GL_TRUE) {
        char log[512] = { 0 };
        glGetShaderInfoLog(shader, sizeof(log), nullptr, log);
        std::cerr << "ERR! Failed to ocmpile shader: " << path << ": " << log << std::endl;
        glDeleteShader(shader);
        return std::nullopt;
    }
    return shader;
}

std::optional<GLuint> link(GLuint vertex_shader, GLuint fragment_shader) {
    GLuint program = glCreateProgram();
    glAttachShader(program, vertex_shader);
    glAttachShader(program, fragment_shader);
    glLinkProgram(program);
    GLint state;
    glGetProgramiv(program, GL_LINK_STATUS, &state);
    if (state != GL_TRUE) {
        char log[512] = { 0 };
        glGetProgramInfoLog(program, sizeof(log), nullptr, log);
        std::cerr << "ERR! Failed to link shader: " << log << std::endl;
        glDeleteProgram(program);
        return std::nullopt;
    }
    return program;
}

Program::Program(const std::string &vertex_shader_path, const std::string &fragment_shader_path) :
    program(0) {

    GLuint vertex_shader = *compile(GL_VERTEX_SHADER, vertex_shader_path);
    GLuint fragment_shader = *compile(GL_FRAGMENT_SHADER, fragment_shader_path);

    program = *link(vertex_shader, fragment_shader);

    glDeleteShader(vertex_shader);
    glDeleteShader(fragment_shader);
}

GLint Program::operator[](const std::string &uniform_name) {
    if (loc.find(uniform_name) == loc.end()) {
        GLint pos = glGetUniformLocation(program, uniform_name.c_str());
        if (pos < 0) {
            std::cerr << "WARNING! Cannot find uniform: " << uniform_name << std::endl;
        }
        loc[uniform_name] = pos;
    }
    return loc[uniform_name];
}

Program::~Program() {
    if (program != 0) {
        glDeleteProgram(program);
    }
}
