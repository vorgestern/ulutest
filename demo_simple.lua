
-- Prepare Lua's search path so locally built copies of ulutest will be found.
local bpattern={
    ["/"]="./?.so;",
    ["\\"]=".\\?.dll;",
}
package.cpath=(bpattern[package.config:sub(1,1)] or "")..package.cpath

local ok,ulu=pcall(require, "ulutest")

if not ok then error(string.format("\n\n%s\n", [[
    This is a demo for unit testing with ulutest.
    However, 'require "ulutest"' has failed.
    Build it right here with
        make                        (on Linux), or
        buildsys/VS17/ulutest.sln   (on Windows, Release/x86).]]))
end

-- Provide a 'system under test'.
local function demo1(a,b)
    return string.format("(%s,%s)", a, b)
end

local tt=ulu.TT

-- Most of these tests fail -- to demonstrate the error reporting.

ulu.RUN {

{
    name="function demo1",
    tt("exists", function(t)
        t:ASSERT_EQ("function", type(demo1))
    end),
    tt("string,string", function(t)
        t:ASSERT_EQ("(abc,xyz)", demo1("abc","xyz"))
    end)
},

{
    name="function demo2",
    tt("exists", function(t)
        -- t:ASSERT_EQ("function", type(demo2))
    end)
},

{
    name="function demo3",
    tt("exists", function(t)
        t:EXPECT_EQ("function", type(demo3), "wrong type:")
    end)
},

{
    name="predicate notnil",
    tt("expectation", function(t)
        t:EXPECT_NOTNIL(demo4)
    end),
    tt("assertion", function(t)
        t:ASSERT_NOTNIL(demo4)
    end)
},

{
    name="demo_setup_teardown",
    setup=function(t)
        t:ASSERT_NIL(demo4)
    end,
    tt("expectation", function(t)
        t:EXPECT_NIL(demo4)
    end),
    tt("assertion", function(t)
        t:ASSERT_NIL(demo4)
    end),
    teardown=function(t)
        t:ASSERT_NIL(demo4)
    end,
},

{
    name="demo_setup_fails",
    setup=function(t)
        t:EXPECT_NOTNIL(demo4)
    end,
    tt("expectation", function(t)
        t:EXPECT_NIL(demo4)
    end),
    tt("assertion", function(t)
        t:ASSERT_NIL(demo4)
    end),
    teardown=function(t)
        t:ASSERT_NIL(demo4)
    end,
},

}
