# From Liability to Lifeline: AI Test Generation That Actually Works

## Description

AI is notorious for "solving" test failures in questionable ways. Ask AI to fix a failing test and watch it delete the test entirely; ask it to write new tests and get hardcoded values that always pass. Teams often end up wasting time "babysitting" the AI to get it to work right, or outright stop trusting AI altogether, never taking advantage of its full potential as a collaborator. At worst, teams may accept faulty tests from AI that give false confidence in their production system.

The good news is that there are techniques you can use to get AI to give you both consistent and high-quality test results. Not only that, but the same practices also help make your code more maintainable.

This session covers strategies that make test generation with AI actually work. You'll leave with test structures, coding standards, prompts, and specific AI features to apply immediately on your own projects that help turn AI from liability to a lifeline.

## Organizer notes

Although specific, this is, in my experience, a VERY common problem among devs using AI, especially if they're newer to using it. Automated tests are table stakes at a lot of companies now, but AI seems to have a hard time with making trustworthy ones. This talk will go over how to solve that.

Talk outline:
- What developers expect vs. what actually happens when AI generates tests
- Patterns that help AI - variable/method/class names, Arrange Act Assert, testing one thing per test, general guardrails (such as, "don't test implementation details, just the result")
- Features that help AI - Agent Skills to describe how to write tests, existing tests in your codebase to provide as context
- If possible, write the test first as context for the AI to then write the production code
- Demo interwoven through all of the above

The lightning talk version of this talk would quickly go over the patterns and tools to achieve the desired result, along with a quick demo.