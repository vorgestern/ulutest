
-- Provide a 'system under test'.
local function demo1(a,b)
    return string.format("(%s,%s)", a, b)
end

local ok,ulu=pcall(require, "ulutest")

if not ok then error(string.format("\n\n%s\n", [[
    This is a demo for unit testing with ulutest.
    However, 'require "ulutest"' has failed.
    Build it right here with
        make                        (on Linux), or
        buildsys/VS17/ulutest.sln   (on Windows, Release/x86).]]))
end

local tt=ulu.TT

ulu.RUN(

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
}

)
