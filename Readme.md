
# ulutest

Ulutest is a unittest framework for Lua, which produces output very similar to
the output of googletest.

It can be used to test modules for lua (written in Lua or C).

Writing a test requires minimal information beyond what to test and
what result to expect. Ulutest produces output that is easy to
read and easy to interpret from the formulation of the test itself.
Therefore it is easy to write robust tests with minimal effort.

<div style="background-color:#220; color:white; font-family:Courier">
<span style='color:#8080ff'>[==========]</span> Running 4 tests from 3 test cases.	<br/>
<span style='color:#8080ff'>[----------]</span> Global test environment set-up.	<br/>
<span style='color:#8080ff'>[----------]</span> 2 tests from function demo1	<br/>
<span style='color:#8080ff'>[&nbsp;RUN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]</span> function demo1.exists	<br/>
<span style='color:#2F2'>[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OK&nbsp;]</span> function demo1.exists (0 ms)	<br/>
<span style='color:#8080ff'>[&nbsp;RUN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]</span> function demo1.string,string	<br/>
<span style='color:#2F2'>[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OK&nbsp;]</span> function demo1.string,string (0 ms)	<br/>
<span style='color:#8080ff'>[----------]</span> 2 tests from function demo1 (0 ms total)	<br/>

<span style='color:#8080ff'>[----------]</span> 1 test from function demo2	<br/>
<span style='color:#8080ff'>[&nbsp;RUN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]</span> function demo2.exists	<br/>
<span style='color:yellow'>[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OK&nbsp;]</span> Warning: Test applies no criteria	<br/>
<span style='color:#8080ff'>[----------]</span> 1 test from function demo2 (0 ms total)	<br/>

<span style='color:#8080ff'>[----------]</span> 1 test from function demo3	<br/>
<span style='color:#8080ff'>[&nbsp;RUN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]</span> function demo3.exists	<br/>
<span style='color:red'>[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FAIL&nbsp;]</span> Unmet Expectation: demo_simple.lua:41: wrong type: unexpected (expected 'function', but was 'nil')	<br/>
<span style='color:red'>[&nbsp;&nbsp;FAILED&nbsp;&nbsp;]</span> exists: unmet expectations	<br/>
<span style='color:#8080ff'>[----------]</span> 1 test from function demo3 (0 ms total)	<br/>

<span style='color:#8080ff'>[----------]</span> Global test environment tear-down	<br/>
<span style='color:#8080ff'>[==========]</span> 4 tests from 3 test cases ran. (0 ms total)	<br/>
<span style='color:#2F2'>[&nbsp;&nbsp;PASSED&nbsp;&nbsp;]</span> 3 tests	<br/>
<span style='color:red'>[&nbsp;&nbsp;FAILED&nbsp;&nbsp;]</span> 1 test, listed below:	<br/>
<span style='color:red'>[&nbsp;&nbsp;FAILED&nbsp;&nbsp;]</span> function demo3.exists	<br/>

  1 FAILED TESTs	<br/>
</div>

This output was produced with demo_simple.lua, essentially ..

    ... load system under test and ulutest ...
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
        }
    }

# To do
## still ..
- Account for the difference in the bottom line if tests have been skipped.
- Introduce setup and teardown on a per test basis.
- Allow listing and filtering tests.
## no more
- Make ulutest process a list of tests rather than a random number of test arguments.
