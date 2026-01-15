# Writing Contract Tests in C# With Pact – Pact Brokers

**Date:** March 11, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/writing-contract-tests-in-c-with-pact-pact-brokers/

_This post is part of a series on contract testing:_

-   [What contract testing is and why to write them](https://daninacan.com/what-contract-testing-is-and-why-to-write-them/)
-   [How to Write Contract Tests in C# With Pact – Consumer Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-consumer-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider Tests](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-tests/)
-   [How to Write Contract Tests in C# With Pact – Provider States](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-states/)
-   [(Optional) How to Write Contract Tests in C# With Pact – Using Testcontainers](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-using-testcontainers)
-   [How to Write Contract Tests in C# With Pact – Provider State Parameters](https://daninacan.com/how-to-write-contract-tests-in-c-with-pact-provider-state-parameters/)
-   [Writing Contract Tests in C# With Pact – Query Parameters](https://daninacan.com/writing-contract-tests-in-c-with-pact-query-parameters/)
-   [Writing Contract Tests in C# With Pact – Message Interactions](https://daninacan.com/writing-contract-tests-in-c-with-pact-message-interactions/)
-   **Writing Contract Tests in C# With Pact – Pact Brokers**

## Overview

Up until now, all of our provider's contract tests have been reading from local files for the contract using `WithFileSource()`. This works fine for demonstrating Pact, but probably isn't very useful in a real scenario where you're working across teams and want to check if your contract is valid at deployment time.

Pact brokers solve this problem, and are what we'll be looking at in this post.

## What's a Pact broker?

Rather than taking from a local file, a Pact broker works as follows:

When the consumer's tests run in your deployment pipeline and generate its contract files, it sends those contract to the Pact broker, which is an independent service. Multiple consumers that use the same provider can all send their contract to the broker. When the provider runs its contract tests, it pulls all contracts from the Pact broker from all consumers that rely on it. Then, it runs its contract tests against all of those contracts.

## What should I use for a Pact broker?

There are 3 general choices for this:

-   **This is what this post will use.** Pact provides the [pact-broker Docker image](https://hub.docker.com/r/pactfoundation/pact-broker) free and open source for you to host however you like.
-   SmartBear offers a paid solution called [API Hub](https://pactflow.io/) (previously PactFlow). Since this is a paid service, it also comes with many additional features, as well.
-   Roll your own ([docs for how to do that](https://docs.pact.io/pact_broker#rolling-your-own))

This post will use the first option with the Docker image, so you'll need Docker installed on your computer (Podman probably works, as well, though I haven't tested it).

## Using the pact-broker Docker image

Linked above, the image's page on Docker Hub has pretty good instructions for how to get up and running with it, so I won't repeat them here. I will say that I think the easiest option is to probably just use the `docker-compose.yml` file they provide [here](https://github.com/pact-foundation/pact-broker-docker/blob/master/docker-compose.yml). You'll also need the `ssl` folder in that example, as it's used for an example of how to use a reverse proxy.

Let's add that `docker-compose.yml` file and the `ssl` folder into our own project (I created a new folder called `PactBroker` for it), then run `docker-compose build` then `docker-compose up` in the directory it's in.

After it finishes, you can access the Pact broker in your browser (or with curl) at `http://localhost`. If you install the certificate in the `ssl` folder, you can also access it at `https://localhost:8443`.

There's not much in the example, but you can get an idea for how more consumers and providers would look if you click around. In particular, the network graph shows app relationships and is pretty neat.

Now, with our Pact broker up and running locally, before we start updating our tests, we need to install the CLI.

## Using the Pact CLI

[According to Pact's documentation](https://docs.pact.io/pact_broker/publishing_and_retrieving_pacts), the recommended way for a consumer to publish contract files to the broker is by using the CLI. You can either [install the executable](https://github.com/pact-foundation/pact_broker-client/releases) for this or use another Docker image, which is [on Docker Hub as pact-cli](https://hub.docker.com/r/pactfoundation/pact-cli). The executable method is fairly straightforward, and after it's installed you can see all the options using `pact-broker help`.

If you choose to use the Docker image (which is what this post will use), you can do that by pulling the image with `docker pull pactfoundation/pact-cli`. Since the CLI is coming from that image, instead of running `pact-broker` commands directly, you'll run them inside a container. For instance, the above help command would instead be `docker run --rm pactfoundation/pact-cli:latest pact-broker help`.

With the CLI set up, let's change our tests to actually publish to and read from the broker, rather than using local files.

## Publishing to the Pact broker as the consumer

Our consumer tests will still generate a local file, just like before. However, we'll now take that local file and use its file path to publish it to the broker.

In my repo (you can find it on Github at the bottom of this post), I've placed my contract files in a folder called `Pacts` inside the consumer test project, and my broker is running at `http://localhost`, so my publish command will need to use those. Given that, this is what the publish CLI command looks like:

-   Using the CLI executable:

    ```
    pact-broker publish "${PWD}/Consumer.IntegrationTests/Pacts/Employee Message Consumer-Employee Message Publisher.json" --consumer-app-version 1.0.0 --branch main --broker-base-url http:localhost
    ```

-   Using the CLI Docker image:
    ```
    docker run --rm -w //${PWD} -v //${PWD}://${PWD} pactfoundation/pact-cli:latest pact-broker publish "//${PWD}/Consumer.IntegrationTests/Pacts/Employee Message Consumer-Employee Message Publisher.json" --consumer-app-version 1.0.0 --branch main --broker-base-url http://host.docker.internal:80
    ```

❗ Notice that in the Docker image method, we don't use `localhost`, since that would try to use the `localhost` of the container, and in this example, our broker is running from `localhost`. Instead, we replace it with `http://host.docker.internal:80`.

❗ Also, putting `//` before all the paths avoids [an issue with mingw](https://github.com/docker/cli/issues/2204#issuecomment-638993192) with an error that would read, "Error response from daemon: the working directory 'C:/WS/Repos/ContractTestingCSharp' is invalid, it needs to be an absolute path."

After you run this command, you should see a response like so (this is from the Docker image CLI):

```bash
Created Employee Message Consumer version 1.0.0 with branch main
Pact successfully published for Employee Message Consumer version 1.0.0 and provider Employee Message Publisher.
  View the published pact at http://host.docker.internal/pacts/provider/Employee%20Message%20Publisher/consumer/Employee%20Message%20Consumer/version/1.0.0
Events detected: contract_published, contract_content_changed (first time untagged pact published)
Next steps:
  * Add Pact verification tests to the Employee Message Publisher build. See https://docs.pact.io/go/provider_verification
  * Configure separate Employee Message Publisher pact verification build and webhook to trigger it when the pact content changes. See https://docs.pact.io/go/webhooks
```

Now, let's go check out the Pact broker in our browser again. As you can see, our new pact now shows up! You can click inside the options just as you could with the example one. Very cool! In a real pipeline, you'd execute this command after your tests run successfully and create the contract file.

## Reading from the Pact broker as the provider

We don't have to change much in our provider's contract tests to have it read from the Pact broker instead of a local file. Previously, our tests used `.WithFileSource(new FileInfo(pactPath))`. We'll change this to instead be `.WithPactBrokerSource(new Uri("http://localhost"))`. Change one of the tests to use that and run it. You should see the test pass and the output begin with the following message:

```bash
The pact at http://localhost/pacts/provider/Employee%20Message%20Publisher/consumer/Employee%20Message%20Consumer/pact-version/ffe5cc30a19c81d599764b2b5f3d3ea6aef8ee83 is being verified because the pact content belongs to the consumer version matching the following criterion:
  * latest version of Employee Message Consumer from the main branch 'main' (1.0.0)
```

Success! Using the CLI, the consumer sent its contract file to the Pact broker, and then the provider read from that broker to get the contract file to run its tests against.

## Webhooks – triggering the provider on a consumer build

Using `WithPactBrokerSource()` works for when the provider changes code on their side to ensure they don't break any consumers. What about when a consumer changes their code, though? Pact provides a webhook trigger for this case, kicking off a provider build when a consumer triggers the webhook. The consumer build then passes or fails based on the results of the provider. If you remember, this was shown in the initial diagram at the beginning of this post!

## Putting it all together with the can-i-deploy tool and the Pact Matrix

To go along with this, Pact also provides a CLI tool called can-i-deploy, which pretty much does what it sounds like – it tells both the consumers and the provider if it's safe to deploy their changes based on the contract files.

It accomplishes this with what's called the "Pact matrix," why is just a fancy way of describing how both the consumer and provider will have different versions of their service, and which versions are verified to work with each other by running against the broker.

For example, here is a simple Pact matrix (keep in mind the matrix will only show the versions that have actually been tested against the broker):

| Consumer service | Provider service | Verified |
| ---------------- | ---------------- | -------- |
| v1               | v1               | true     |
| v1               | v2               | false    |
| v2               | v2               | true     |
| v2               | v3               | false    |
| v3               | v3               | true     |

If all of an app's microservices are being deployed to a Pact broker, you can know when deploying a version of a specific service will break what's in production. In the above example, if the consumer service only has v2 in production, then the provider service could know it's not yet safe to deploy its v3 to production.

You can also view the Pact matrix for any pair of services from the Pact Broker index page by clicking on the matrix icon in the table row.

To run a can-i-deploy command in your pipeline, you'll do something like this: `pact-broker can-i-deploy --pacticipant Consumer --version 3 --to-environment production`. While this post won't detail how to do that in a pipeline, you can read more about the tool [on Pact's docs page](https://docs.pact.io/pact_broker/can_i_deploy).

## Conclusion

I feel that this series has already covered quite a bit, and I hope that it makes things much easier for those looking to start contract testing with Pact with C#. Even so, there are concepts that I didn't cover in this series, since I wanted to cover mostly the essential concepts (and maybe a bit more) from a .NET slant, rather than recreate the Pact docs in C#. For instance, these posts didn't cover [handling auth tokens in your contract tests](https://docs.pact.io/provider/handling_auth) or many of [the Pact broker features](https://docs.pact.io/pact_broker). Hopefully, though, these posts give you a strong enough starting point to figure out the rest as you go.

## Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/ContractTestingCSharp
