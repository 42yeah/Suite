//
// Created by 42yea on 2022/6/23.
//

#ifndef SUITE_SCRIPTING_CUH
#define SUITE_SCRIPTING_CUH

#include <iostream>
#include <optional>
#include <vector>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>


class ScriptingLayer {
public:
    ScriptingLayer();

    ~ScriptingLayer();

    ScriptingLayer(const ScriptingLayer &) = delete;

    ScriptingLayer(ScriptingLayer &&) = delete;

    std::optional<std::string> operator()(const std::string &cmd);

    const std::vector<std::string> &get_errors() const;

private:
    lua_State *lua_state;
    std::vector<std::string> errors;
};


#endif //SUITE_SCRIPTING_CUH
