
# Changelog

## 0.2 (31.1.2025)
ulutest.RUN now expects a list of testcases. Previously, each testcase
was an argument on its own. To adapt existing unittests, simply replace

    ULU.RUN(
    ...
    )
with

    ULU.RUN {
    ...
    }

## 0.21 (27.9.2025)
Added option to output colored markdown, sadly not usable on github.
Turned off.

## 0.3 (16.9.2026)
- Added setup- and teardown-steps per testcase.
- Added ASSERT_NOTNIL and EXPECT_NOTNIL

## to be done
- Reduce global state
