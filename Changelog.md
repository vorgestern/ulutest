
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
