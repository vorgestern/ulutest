
local ulu=require "ulutest"

--[[
    Demonstrate each combination of
    Test predicate (EXPECT, EXPECT_NIL, EXPECT_EQ, ASSERT, ASSERT_NIL, ASSERT_EQ)
    with result (ok, fail)
    with hint (present, not present)

    ==> 6*2*2  = 24 Tests from 6 cases
--]]

ulu.RUN(

{
    name="EXPECT",
    ulu.TT("succeeds", function(t)
        t:EXPECT(1<2)
    end),
    ulu.TT("succeeds_with_hint", function(t)
        t:EXPECT(1<2, "has to be less")
    end),
    ulu.TT("fails", function(t)
        local result=1
        t:EXPECT(result>2)
    end),
    ulu.TT("fails_with_hint", function(t)
        local result=1
        t:EXPECT(result>2, "result should be greater than 2")
    end)
},

{
    name="EXPECT_NIL",
    ulu.TT("succeeds", function(t)
        t:EXPECT_NIL(nil)
    end),
    ulu.TT("succeeds_with_hint", function(t)
        t:EXPECT_NIL(nil, "has to be nil")
    end),
    ulu.TT("fails", function(t)
        t:EXPECT_NIL(true)
    end),
    ulu.TT("fails_with_hint", function(t)
        local result=true
        t:EXPECT_NIL(result, "result")
    end)
},

{
    name="EXPECT_EQ",
    ulu.TT("succeeds", function(t)
        local result=3
        t:EXPECT_EQ(3, result)
    end),
    ulu.TT("succeeds_with_hint", function(t)
        local result=3
        t:EXPECT_EQ(3, result, "result")
    end),
    ulu.TT("fails", function(t)
        local result=2
        t:EXPECT_EQ(3, result)
    end),
    ulu.TT("fails_with_hint", function(t)
        local result=2
        t:EXPECT_EQ(3, result, "result")
    end)
},

{
    name="ASSERT",
    ulu.TT("succeeds", function(t)
        t:ASSERT(1<2)
    end),
    ulu.TT("succeeds_with_hint", function(t)
        t:ASSERT(1<2, "has to be less")
    end),
    ulu.TT("fails", function(t)
        local result=1
        t:ASSERT(result>2)
    end),
    ulu.TT("fails_with_hint", function(t)
        local result=1
        t:ASSERT(result>2, "result should be greater than 2")
    end)
},

{
    name="ASSERT_NIL",
    ulu.TT("succeeds_with_no_hint", function(t)
        t:ASSERT_NIL(nil)
    end),
    ulu.TT("succeeds", function(t)
        t:ASSERT_NIL(nil, "has to be nil")
    end),
    ulu.TT("fails_with_no_hint", function(t)
        t:ASSERT_NIL(true)
    end),
    ulu.TT("fails", function(t)
        local result=true
        t:ASSERT_NIL(result, "result")
    end)
},

{
    name="ASSERT_EQ",
    ulu.TT("succeeds_with_no_hint", function(t)
        local result=3
        t:ASSERT_EQ(3, result)
    end),
    ulu.TT("succeeds", function(t)
        local result=3
        t:ASSERT_EQ(3, result, "result")
    end),
    ulu.TT("fails", function(t)
        local result=2
        t:ASSERT_EQ(3, result)
    end),
    ulu.TT("fails_with_hint", function(t)
        local result=2
        t:ASSERT_EQ(3, result, "result")
    end)
}

)
