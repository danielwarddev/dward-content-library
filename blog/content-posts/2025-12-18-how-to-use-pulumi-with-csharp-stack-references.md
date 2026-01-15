# How to use Pulumi with C# – Stack References

https://daninacan.com/how-to-use-pulumi-with-c-stack-references/

_This post is part of a series on using Pulumi:_

-   [Infrastructure as code (IaC) – what it is and why to use it](https://daninacan.com/infrastructure-as-code-iac-what-it-is-and-why-to-use-it/)
-   [How to use Pulumi with C# – Our first project](https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/)
-   [How to use Pulumi with C# – How Pulumi Works](https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/)
-   [How to use Pulumi with C# – Inputs and Outputs](https://daninacan.com/how-to-use-pulumi-with-c-inputs-and-outputs/)
-   [How to use Pulumi with C# – Component Resources](https://daninacan.com/how-to-use-pulumi-with-c-component-resources/)
-   [How to Use Pulumi with C# – Projects, Stacks, Config](https://daninacan.com/how-to-use-pulumi-with-c-projects-stacks-config/)
-   **How to Use Pulumi with C# – Stack References**

## Overview

We've made quite a bit of progress so far. We even have multiple stacks in our Pulumi project for different environments now. What if we wanted to pass data from one stack to another, though? For instance, we may be consuming a stack that another team at our company has put out there for others to use, or we may have just wanted to divide our own project up for simplicity's sake. We'll go over that in this post.

## Single Pulumi project or multiple?

Although our project is small for example purposes, imagine you were using Pulumi in a real enterprise environment: you'd probably have a more complex setup with things like databases, queues, multiple resource groups, and multiple teams sharing the same resources across different repos.

Just how you create new classes and C# projects for different use cases, you can create multiple Pulumi projects for different use cases. Eventually, you'll probably outgrow your monolith project (though I do recommend using a monolith until it's too cumbersome!), and it will be easier to manage your infrastructure with multiple Pulumi projects. As we'll see in the code, these projects can pass information to each other by using `StackReferences`.

Pulumi has a good series of posts on IaC best practices, and [they outline some reasons you may want to split out into multiple projects](https://www.pulumi.com/blog/iac-best-practices-structuring-pulumi-projects/#structuring-pulumi-projects), which I will summarize here:

-   Use case – multiple independent applications
-   Team boundaries – different teams, departments, or companies are responsible for different resources
-   Security – using separate projects lets you apply different permissions to each project in Pulumi Cloud if they're used by multiple teams
-   Resource relationships – shared/foundational infrastructure may be put in its own project
-   Resource lifecycle – resources that CRUD together may benefit from being in the same project
-   Resource change rate – to avoid coupling resources that hardly ever get updates with those that are updated often, it can help to have them in separate projects
-   Blast radius – on human error, having resources spread out across multiple projects limits the damage to only the affected project

Let's try this out ourselves and create another Pulumi project within our solution.

## Creating another Pulumi project

First, let's `pulumi destroy` both our dev and staging stacks so that we can see our upcoming changes more easily. As a reminder, you can select a stack with `pulumi stack select <stackName>`. Now that we've removed all of our resources, let's make some changes to how our project is structured.

Now, for our infrastructure strategy, let's say that we want two Pulumi projects: one project for our foundational infrastructure that all other projects make use of, and a second project for resources specifically for our console app. To do that, let's use the existing Pulumi project as the foundational one, create another Pulumi project to use as the one for the console app, then move some of the resources from the existing one to new one.

To create our new project, run these steps:

-   From the C# solution directory, create another folder. The name of this folder will also be the name of the new infrastructure project. I named mine PulumiCSharp.Infrastructure.ConsoleApp.
-   From inside that new folder, run `pulumi new azure-csharp`.
-   Run `pulumi stack init staging` so that it has a dev stack and a staging stack, just like the existing project.
-   Add the Pulumi.Command Nuget package to this new C# project.
-   Copy-paste the the original project's Pulumi.dev.yaml and Pulumi.staging.yaml files to the new project.
-   I also delete the .gitignore file the Pulumi template creates, since I prefer to have this at the repo level.
-   Move AzureFunctionApp.cs to from the old project to the new one.

We now have a second Pulumi project ready to use in our solution – but wait! We need a way for the first stack to pass data to the second. To do that, let's make some changes to our original Pulumi project.

## Updating the original Pulumi project

We want the original Pulumi project to have only the shared resources required for creating everything else. In our case, we'll say we just want it to have the resource group and storage account.

To do that, update Program.cs so that its contents are the following:

```csharp
using Pulumi.AzureNative.Resources;
using Pulumi.AzureNative.Storage;
using Pulumi.AzureNative.Storage.Inputs;
using System.Collections.Generic;

return await Pulumi.Deployment.RunAsync(() =>
{
    var resourceGroup = new ResourceGroup("resourceGroup");

    var storageAccount = new StorageAccount("sa", new StorageAccountArgs
    {
        ResourceGroupName = resourceGroup.Name,
        Sku = new SkuArgs { Name = SkuName.Standard_LRS },
        Kind = Kind.StorageV2
    });

    return new Dictionary<string, object?>
    {
        ["resourceGroupName"] = resourceGroup.Name,
        ["storageAccountName"] = storageAccount.Name
    };
});
```

Also, our stack config files for this project no longer need the function-count setting, since they're not creating the Function Apps anymore:

```yaml
config:
    azure-native:location: WestUS
    azure-native:subscriptionId: 11111111-1111-1111-1111-111111111111
```

This stack is pretty simple now. We create a resource group and storage account in it, then put the name of both of them in stack outputs so that other stacks can access them. So, how do we give outputs from one stack to another? Let's see that now.

## A note on extending Stack

Instead of putting everything in `RunAsync`, it's possible to create a new class that extends `Stack` and put the resources in its constructor. In this case, you also use the `[Output]` attribute for stack outputs instead of directly returning a `Dictionary<string, object?>`.

For instance, here's the equivalent of what we have by extending Stack:

```csharp
using Pulumi;
using Pulumi.AzureNative.Resources;
using Pulumi.AzureNative.Storage;
using Pulumi.AzureNative.Storage.Inputs;

namespace PulumiCSharp.Infrastructure;

public class FoundationStack : Stack
{
    public FoundationStack()
    {
        var resourceGroup = new ResourceGroup("resourceGroup");
        ResourceGroupName = resourceGroup.Name;

        var storageAccount = new StorageAccount("sa", new StorageAccountArgs
        {
            ResourceGroupName = resourceGroup.Name,
            Sku = new SkuArgs { Name = SkuName.Standard_LRS },
            Kind = Kind.StorageV2
        });
        StorageAccountName = storageAccount.Name;
    }

    [Output("resourceGroupName")]
    public Output<string> ResourceGroupName { get; set; }

    [Output("storageAccountName")]
    public Output<string> StorageAccountName { get; set; }
}
```

In this case, we'd also change Program.cs to be this:

```csharp
using PulumiCSharp.Infrastructure;

return await Pulumi.Deployment.RunAsync<FoundationStack>();
```

However, in general, **I don't recommend doing this**. If you have to do any `async` calls (not too uncommon in Pulumi), that will be more painful with a synchronous constructor. Also, [Pulumi themselves recommends](https://www.pulumi.com/blog/pulumi-targets-dotnet-6/) the functional approach with `RunAsync` (also see [this GitHub comment](https://github.com/pulumi/pulumi/issues/3619#issuecomment-1344337410)). I find that it's not too uncommon to find code examples online that use the `Stack` way, though, so I wanted to point it out so that you're aware if you encounter it.

## Connecting stacks

Let's go to our new Pulumi project. Moving the rest of the resources over, here's what this project's Program.cs should be:

```csharp
using Pulumi;
using Pulumi.Command.Local;
using PulumiCSharp.Infrastructure.ConsoleApp;
using System.Collections.Generic;
using System.IO;
using System.Linq;

return await Pulumi.Deployment.RunAsync(() =>
{
    var config = new Config();
    var foundationOrgName = config.Require("foundationOrgName");
    var foundationProjectName = config.Require("foundationProjectName");
    var foundationStackName = config.Require("foundationStackName");

    var foundationStack = new StackReference($"{foundationOrgName}/{foundationProjectName}/{foundationStackName}");
    var foundationResourceGroupName = foundationStack.RequireOutput("resourceGroupName").Apply(x => (string)x);
    var foundationStorageAccountName = foundationStack.RequireOutput("storageAccountName").Apply(x => (string)x);

    var publishCommand = Run.Invoke(new()
    {
        Command = $"dotnet clean && dotnet publish --output publish",
        Dir = Path.GetFullPath(Path.Combine("..", "PulumiCSharp.ConsoleApp")),
        Environment = new Dictionary<string, string>
        {
            ["DOTNET_CLI_TELEMETRY_OPTOUT"] = "1"
        }
    });

    var functionCount = config.RequireInt32("function-count");
    var functionApps = new List<AzureFunctionApp>();

    for (int i = 0; i < functionCount; i++)
    {
        var app = new AzureFunctionApp($"cool-function-{i + 1}", new()
        {
            ResourceGroupName = foundationResourceGroupName,
            StorageAccountName = foundationStorageAccountName,
            FunctionName = "MyCoolFunction",
            PublishPath = "../PulumiCSharp.ConsoleApp/publish",
            DotNetVersion = DotNetVersion.V8
        });
        functionApps.Add(app);
    }

    var functionUrls = Output
        .All(functionApps.Select(app => app.ApiUrl))
        .Apply(urls => urls.ToArray());

    return new Dictionary<string, object?>
    {
        ["functionAppApiUrls"] = functionUrls
    };
});
```

Everything else in here is the same, except for some new stuff at the very top. First, we get some values from our stack's config file, and then we create a `StackReference` using them. From that `StackReference`, we call `RequireOutput` with the name of the output and cast the value to a string. From there, we're free to use it as we normally would.

In my case, it will look for a stack called danielwarddev/PulumiCSharp/dev. danielwarddev is my Pulumi account name, PulumiCSharp is the project name, and dev is the stack name. Since these may change per environment (the stack name will for sure change, at least), it's a good idea to add them to the stack config.

Run `pulumi up` on the new Pulumi project. All of this output should be familiar by now, but the important part is that our new `StackReference` has succeeded!

How exactly is that `StackReference` fetching the stack outputs, though?

## How stack references work

We gave the `StackReference` constructor the name of the stack to look for, and it found it and gave us its stack outputs. How did it find it?

When we ran `pulumi login` when we first started using Pulumi, we logged into the managed Pulumi Cloud, because that's the default option for the backend. You can verify this by looking at your Pulumi credentials file at %USERPROFILE%/.pulumi/credentials.json. The managed Pulumi Cloud isn't the only option, [as you can see on their docs](https://www.pulumi.com/docs/iac/cli/commands/pulumi_login/) – you can use a self-hosted Pulumi Cloud, an S3 bucket, an Azure blob, a local file, and more.

The important bit is that, when you're logged in, Pulumi knows where to look for the backend. It goes to that backend, looks for the stack name you gave, and if it finds it (and has permissions to access it, if your backend supports that, such as the managed Pulumi cloud), it returns the stack outputs.

As you may have realized, this `StackReference` working relies on two things:

-   The stack that this stack is referencing needs to exist already. If it's part of the same repo, it probably needs to be deployed first, as well.
-   Pulumi somehow needs to know where to look for a stack called danielwarddev/PulumiCSharp/dev.

## Deploying multiple Pulumi projects together

Although this post doesn't cover what a CICD pipeline looks like with Pulumi, deploying multiple projects is a perfectly normal use case that it's able to handle.

Ultimately, you're able to deploy your Pulumi projects however you want. You can use the Pulumi CLI in whatever CICD platform you want to deploy stacks in specific orders, destroy stacks, or whatever else you want. Pulumi also has [their own GitHub Action](https://github.com/pulumi/actions), as well.

Also, of particular note is the [Pulumi Automation API](https://www.pulumi.com/docs/iac/automation-api/getting-started-automation-api/), which allows you to write a program in Pulumi's supported languages that deploys your infrastructure.

To start out, especially if your deployment process is simple, I recommend starting with the GitHub Action (or using the CLI commands if not on GitHub).

## Using developer stacks

Pulumi advocates for the use of [what they call "developer stacks."](https://www.pulumi.com/blog/iac-best-practices-enabling-developer-stacks-git-branches/) Essentially, rather than each developer deploying to the dev stack as they develop new infrastructure, they instead create a stack locally for only their own use, and then to deploy to that. This way, you avoid potential conflicts of multiple people trying to deploy to dev at the same time (if this happens, anyone who tries to pulumi up while the stack is already being deployed will receive a failure). You also avoid overwriting resources that were deployed earlier into dev but not yet merged into the main branch. Pulumi will inform you of the diff, but accidents happen.

These stacks should be treated as ephemeral, which means that you don't check in the stack's YAML config file (since nobody else but you cares about or uses it) and you run pulumi destroy on it when you're done (to save costs and not clog up your Azure/AWS/etc. account).

You can easily create a new stack that's a copy of the dev stack with the following commands:

```bash
pulumi stack init danielstack --copy-config-from dev
pulumi up
```

If your app has a URL or any other connections you need to access to test things out, you can provide those easily in, for instance, a comment on the pull request you create after you have the developer stack up and running. This way, other developers reviewing your code can see the new features live. As we covered with [Pulumi's resource naming](https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/), even if these developer stacks are deployed into the same account as the dev stack, you're guaranteed to get unique resource names, so you don't have to worry about resource name clashes, which is nice.

Like many things in software, it's probably easier to start simple. In this case, that's just using a central dev stack, and then scaling out to developer stacks when the former becomes too cumbersome.

## Concluding the series

This post marks the end of the C# Pulumi series! My hope was to provide a not-too-lengthy practical guide to both learn Pulumi essential concepts in C#, as well as put those things into practice, while also not just repeating what the Pulumi docs already say. I hope that you found this series useful in getting started!

## Digging further

If you'd like to see more, there are many other useful Pulumi features I didn't cover in this series that you may wish to use, such as:

-   [Pulumi Policies](https://www.pulumi.com/docs/insights/policy/get-started/) – create policies as code to enforce compliance, security, and best practices in your org
-   [Pulumi ESC](https://www.pulumi.com/docs/esc/get-started/) – centralized config/secrets management service
-   [Stack permissions](https://www.pulumi.com/docs/administration/access-identity/stack-permissions/) – control which teams can perform what operations on your stacks
-   [Pulumi Automation API](https://www.pulumi.com/docs/iac/automation-api/getting-started-automation-api/) – write your deployment process with code
-   [Pulumi packages](https://www.pulumi.com/docs/iac/concepts/packages/packages/) – share your component resources in any Pulumi-compatible language
-   [Pulumi YAML](https://www.pulumi.com/docs/iac/languages-sdks/yaml/) – write your Pulumi IAC in familiar YAML

## Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/PulumiCSharp](https://github.com/danielwarddev/PulumiCSharp)
