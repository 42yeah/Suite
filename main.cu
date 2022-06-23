#include "ui_modules/visualizer/App.cuh"
#include <lua.h>
#include <lauxlib.h>


int main() {
    start_app();
    luaL_newstate();
    return 0;
}
