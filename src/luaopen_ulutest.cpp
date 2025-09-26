
#include <string_view>
#include <format>
#include <lua.hpp>

using std::format;
using std::string_view;
const auto modulename="ulutest";
string_view chunk_ulutest();

static int mkloader(lua_State*L, string_view impl)
{
    if (impl.size()==0)
    {
        const auto msg=format("Chunk is empty ('{}').", modulename);
        lua_pushlstring(L, msg.c_str(), msg.size());
        return lua_error(L);
    }
    const string_view errs[]=
    {
        "ok", // #define LUA_OK	0
        "yield error", // #define LUA_YIELD 1
        "runtime error", // #define LUA_ERRRUN 2
        "syntax error", // #define LUA_ERRSYNTAX 3
        "out of memory", // #define LUA_ERRMEM 4
        "unknown error", // #define LUA_ERRERR 5
    };
    if (const int rc=luaL_loadbufferx(L, impl.data(), impl.size(), modulename, nullptr); rc==LUA_OK) return 1;
    else
    {
        const auto msg=format("{}: loading '{}' failed with rc={}.", errs[rc], modulename, rc);
        lua_pushlstring(L, msg.c_str(), msg.size());
        return lua_error(L);
    }
}

#ifndef ULUTEST_EXPORTS
#define ULUTEST_EXPORTS
#endif

bool check_tty(int fd);

static int check_tty(lua_State*L)
{
    if (lua_gettop(L)<1) return lua_pushliteral(L, "isatty: Argument (int fd) expected."), lua_error(L);
    if (!lua_isinteger(L, 1)) return luaL_typeerror(L, 1, "integer");

    const auto fd=static_cast<int>(lua_tointeger(L, 1));
    return lua_pushboolean(L, check_tty(fd)), 1;
}

extern "C" int gtest_tags(lua_State*);
extern "C" int timestamp(lua_State*);

extern "C" ULUTEST_EXPORTS int luaopen_ulutest(lua_State*Q)
{
    if (mkloader(Q, chunk_ulutest())==1)
    {
        // Pass bindings to functions implemented in C to loader
        // for inclusion in module table.
        lua_createtable(Q, 0, 2);
            lua_pushcfunction(Q, timestamp);                     lua_setfield(Q, -2, "timestamp");
            lua_pushcfunction(Q, gtest_tags); lua_call(Q, 0, 1); lua_setfield(Q, -2, "tags");
            lua_pushcfunction(Q, check_tty);                     lua_setfield(Q, -2, "isatty");
        lua_call(Q, 1, 1);
        return 1;
    }
    lua_pushliteral(Q, "ulutest cannot be loaded (internal error).");
    return lua_error(Q), 0;
}
