# What contract testing is and why to write them

**Date:** September 5, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/what-contract-testing-is-and-why-to-write-them/

_This post is part of a series on contract testing:_

-   **What contract testing is and why to write them**
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   [Writing Contract Tests in C# With Pact – Pact Brokers](https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/)

### Overview

_High-quality image definitely not made in Powerpoint of a microservices architecture_

If you've worked in a corporate programming job, you've probably worked with microservices. If you've worked with microservices, you've probably written some kinds of tests around them, whether it's testing your own or verifying you're calling another one correctly and that it returns responses as expected. These would be written as either integration or end-to-end tests, or both.

Generally, we write these tests because we want to ensure that we're calling those other services correctly and that we're getting the expected responses back from them. While these tests do accomplish this, there are some undesired side effects that come along with this approach:

-   As an example, how often have you marked tests to be skipped because of flaky tests? Calling real external services in your tests makes your deployment pipeline dependent on them, and if they fail, they're completely out of your control (even if you own the other service, it shouldn't make another deployment fail, anyway). What if you needed to send out a hotfix for something completely unrelated to that test, for instance?
-   End-to-end tests are also more expensive to write and maintain, since it's not obvious what went wrong if a test fails. If the difference between developers fixing a bug goes from a few hours to a few days, that becomes quite an expensive bug to fix. The same is true to a lesser extent for integration tests.
-   Calling real services in your test suite also takes longer, which makes your feedback cycle slower.

Might there be a way we could get the benefits of these tests between microservices without the baggage that comes along with them?

### What is contract testing?

As you might have guessed from this post's title, I'll be presenting contract testing as a solution to these issues. Ultimately, contact testing is way to ensure correct interaction between services without needing to actually call the real services in your tests.

Contract testing works by having would-be consumers of an API first write their tests against it in their app, whether or not the actual API exists yet. When the consumer's tests are run, they hit a local web server instead of the real thing, and a **contract file** is generated. This is just a JSON file that describes the expected responses when it receives specific requests (and in a more descriptive way than OpenAPI).

The provider (AKA the API) then receives the contract files from the consumers and **writes the functionality of the API according to the consumers' expectations**. The provider has contract tests inside of its repo that ensures all of the contracts are adhered to, as to avoid regressions and to make sure that new changes won't break any consumers. If they would, that means some cross-team communication may need to happen to straighten things out.

_Contract testing simplified_

### Why contract testing?

It might seem odd at first to develop in a way where the consumers drive what the API will look like, rather than the team writing the API itself. This methodology is called **consumer-driven contracts**. However, this is really how we treat (or should treat) every other piece of software we write – by having the customer define the requirements.

If you're the writer of an internal API, the consumers of that API are your customers. The difference with an internal API is that you have a captive audience. Other teams in the business don't have another option to use besides your API; it's that or nothing. So, we should at least ensure that our API causes the least amount of pain possible for how consumers will actually use it.

Contract testing encourages regular human interaction across teams (it's hard/impossible to implement this successfully without ever talking) to figure out the requirements of a service, as opposed to creating a service alone, releasing it out to the company, and saying, "good luck" without ever talking to the customers of it. If a generated contract file doesn't make sense to the provider team or something breaks, you need to talk together to figure out why. This doesn't mean that consumers can't begin their work until the provider is fully made – as long as you've talked and agreed on how the provider will look, you can develop according to that contract.

_Multiple consumers sending their contract to the provider creates an API that works for everyone without extra work_

By the end, what you're left with is an API that has nothing more or less than what the consumers have actually told the provider (ideally verbally) they'll need. Depending on the use case, it may be more practical for either the provider or consumer to change their side of the code, but at least everybody knows what's going on and why.

So, with the use of JSON files for contracts, ultimately created from teams talking to each other about what the API should look like, your test suite can avoid actually calling the external service while still getting the confidence that your services are talking to each other in the expected way. Not only that, contract testing pushes you towards good cross-team practices, putting the customer first and encouraging communication. The specifics of how you implement this practice will be covered by the following posts in this series.

### A note: when contract testing does not fit

Because contract testing works by consumers sending the provider their contract and the provider ensuring those contracts are adhered to, contract testing works best when the consumers are known and can actually be reached out to. So, it works well for internal APIs.

It does not work well in any situation where you can't know the consumers, such as with public APIs. In those cases, it's neither practical nor efficient to try to validate every single consumer, especially when there could potentially be millions of them. Instead, a documented specification should just be made public and consumers try their best to call it correctly.
