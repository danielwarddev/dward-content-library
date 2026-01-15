# Testing Your Tests: Mutation Testing in C# with Stryker

## Description

Testing your code is an essential part of creating quality software - but are you sure your tests are testing what you think they are?

A misleading test can sometimes be worse than no test at all. On the surface, it appears to protect your application, while it actually gives false confidence, leaving parts of your app untested! Branches of code that you assume are working as expected may actually be silently producing bugs due to uncovered cases by your tests. In the worst case, the bugs throw no exceptions, and aren't discovered until data in production has been damaged.

Mutation testing offers a solution to this, giving more confidence in our test suites. Without writing any additional code, we can use tools that allow us to test our tests, uncovering blind spots in test cases. This session will show how to do mutation testing in C# using a tool called Stryker, using a live coding demo to demonstrate using the tool and the results it can give.