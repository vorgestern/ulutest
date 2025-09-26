
local ulutest=require "ulutest"
local alltag=require "alltag"

local mt99={
    __concat=function(self, func) print("Hier ist concat(",func,")") end,
    __bxor=function(self, func) return ulutest.TT (self.name, func) end
}

local function mytest(name) return function(list) list.name=name return list end end
local function tt(name) return setmetatable({name=name}, mt99) end

local ut={

    mytest "Erstens" {
        tt "A" ~ function(t) t:ASSERT_EQ(1,1) end,
        tt "B" ~ function(t) t:ASSERT_EQ(2,1) end
    }

}

ulutest.RUN(ut)

print(alltag.formatany(ut))
