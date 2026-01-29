# AI-Assisted Unit Testing - How to Stop AI From Cheating On Your Tests

## Description

We've all been there - ask AI to fix a failing test, and instead watch it delete the test, gut the code, or hardcode a passing value. While AI tools can be very helpful for coding, they often miss the mark and need a guiding hand to get them to the right spot.

This session will go over how to use specific coding practices and AI features to get your AI assistants to actually create tests that test. The good news is that the same practices that help AI are the same ones that make your code better and more readable anyway!

## Organizer notes

Although specific, this is, in my experience, a VERY common problem among devs using AI, especially if they're newer to using it. Automated tests are table stakes at a lot of companies now, but AI seems to have a hard time with making trustworthy ones. This talk will go over how to solve that.

Talk outline:
- What developers expect vs. what actually happens when AI generates tests
- Patterns that help AI - variable/method/class names, Arrange Act Assert, testing one thing per test, general guardrails (such as, "don't test implementation details, just the result")
- Features that help AI - Agent Skills to describe how to write tests, existing tests in your codebase to provide as context
- If possible, write the test first as context for the AI to then write the production code
- Demo interwoven through all of the above

The lightning talk version of this talk would quickly go over the patterns and tools to achieve the desired result, along with a quick demo.