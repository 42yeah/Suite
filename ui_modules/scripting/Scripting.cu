//
// Created by 42yea on 2022/6/23.
//

#include "Scripting.cuh"


 ScriptingLayer::ScriptingLayer() {
     lua_state = luaL_newstate();
     luaL_openlibs(lua_state);
 }

 ScriptingLayer::~ScriptingLayer() {
     lua_close(lua_state);
 }

 std::optional<std::string> ScriptingLayer::operator()(const std::string &cmd) {
     int error = luaL_loadstring(lua_state, cmd.c_str()) ||
             lua_pcall(lua_state, 0, 0, 0);
     if (error) {
         std::string err = lua_tostring(lua_state, -1);
         lua_pop(lua_state, 1);
         errors.push_back(err);
         return err;
     }
     return std::nullopt;
 }

 const std::vector<std::string> &ScriptingLayer::get_errors() const {
     return errors;
 }

