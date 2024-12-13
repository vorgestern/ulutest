
XFILES   := main
CPPFLAGS := -I/usr/include/lua5.4 -I LuaAide/include
CXXFLAGS := --std=c++20 -Wall -Werror
.PHONY: clean dir

all: dir ulutest.so
clean:
	@rm -rf b/* *.so
dir:
	@mkdir -p b

# ============================================================

b/%.o: src/%.cpp LuaAide/include/LuaAide.h
	g++ -c -Wall -Werror -fpic -o $@ $< $(CPPFLAGS) $(CXXFLAGS)

# ============================================================

ulutest.so: b/luaopen_ulutest.o b/ulu.o b/resources_linux.o b/ulutest.o
	g++ -shared -fpic -o $@ $^

b/luaopen_ulutest.o: src/luaopen_ulutest.cpp
	g++ -o $@ -c $< -fpic $(CPPFLAGS) $(CXXFLAGS)
b/resources_linux.o: src/resources_linux.cpp
	g++ -o $@ -c $< -fpic $(CPPFLAGS) $(CXXFLAGS)
b/ulu.o: src/ulu.cpp
	g++ -o $@ -c $< -fpic $(CPPFLAGS) $(CXXFLAGS)
b/ulutest.o: b/ulutest.luac
	objcopy -I binary -O elf64-x86-64\
		--redefine-sym _binary_b_ulutest_luac_start=ulutest_start\
		--redefine-sym _binary_b_ulutest_luac_end=ulutest_end $< $@
	nm $@ > $(@:.o=.symbols)
b/ulutest.luac: src/ulutest.lua
	luac -o $@ $<
