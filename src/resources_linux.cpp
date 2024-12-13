
#include <string_view>
#include <unistd.h>

using std::string_view;

// Symbols from ulutest.o, created with objcopy,
extern "C" char ulutest_start, ulutest_end;

string_view chunk_ulutest(){ return {&ulutest_start, static_cast<size_t>(&ulutest_end-&ulutest_start)}; }

bool check_tty(int fd)
{
    return isatty(fd)!=0;
}
