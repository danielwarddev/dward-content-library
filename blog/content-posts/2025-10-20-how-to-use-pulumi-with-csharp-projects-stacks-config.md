# How to Use Pulumi with C# – Projects, Stacks, Config

https://daninacan.com/how-to-use-pulumi-with-c-projects-stacks-config/

_This post is part of a series on using Pulumi:_

-   [Infrastructure as code (IaC) – what it is and why to use it](https://daninacan.com/infrastructure-as-code-iac-what-it-is-and-why-to-use-it/)
-   [How to use Pulumi with C# – Our first project](https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/)
-   [How to use Pulumi with C# – How Pulumi Works](https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/)
-   [How to use Pulumi with C# – Inputs and Outputs](https://daninacan.com/how-to-use-pulumi-with-c-inputs-and-outputs/)
-   [How to use Pulumi with C# – Component Resources](https://daninacan.com/how-to-use-pulumi-with-c-component-resources/)
-   **How to Use Pulumi with C# – Projects, Stacks, Config**
-   [How to use Pulumi with C# – Stack References](https://daninacan.com/how-to-use-pulumi-with-c-stack-references/)

## Overview

Our Pulumi program is in a pretty nice spot now! We have a modular component resource we can use wherever we want, our actual business app is in the same .NET solution as our Pulumi app, and our Pulumi app even runs a `dotnet publish` on the business app for us.

However, there's still something rather important we've not covered so far – how to deploy the same Pulumi program to different environments! Almost every application will need this requirement so that you can safely deploy the same infrastructure to dev, staging, prod, etc., while also being able to tweak some of the configuration values.

So, this post will take a look at how to deploy the same Pulumi program to another Azure account or region, as well as how to tweak some of the values per environment. We'll discuss Pulmi projects and stacks to do this.

## Creating a staging stack

To begin, we'll take our Pulumi app and make sure it gets deployed to a second region in Azure. To do this, we're going to create a new Pulumi stack.

We'll go over what that means shortly, but first, run `pulumi stack init staging`. This will create a stack in your Pulumi project called `staging`.

You can run `pulumi stack ls` to view the stacks in your project:

```bash
NAME        LAST UPDATE   RESOURCE COUNT  URL
dev         2 weeks ago   19              https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev
staging*    n/a           n/a             https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/staging
```

We already had one stack called `dev`. Pulumi created this stack for us when we created a new Pulumi project. Our new `staging` stack is also there, but we still need to create a new config file for it.

You can create one just how you would a normal file, but it might be easier to instead run `pulumi config set myKey myValue`. This inserts this value into the config file for the current stack, but it also creates the config file first if it doesn't already exist. Once you run it, indeed, you'll see a new Pulumi.staging.yaml file!

That being said, all we want to do is copy-paste the contents from the dev config into this config. The only value we want to change is `azure-native:location`. My dev stack's region was `WestUS`, so I'm going to set my staging stack's region to `CentralUS`, just to be something different.

> ❗ **Quota error**
>
> Neither the the EastUS or EastUS2 region worked for me, with the staging subscription giving me a 401 error because of a quota limit:
> `error: Status=401 Message="{\"Code\":\"Unauthorized\",\"Message\":\"Operation cannot be completed without additional quota.`
> If you get an error like this, try a different region. Although EastUS and EastUS2 didn't work for me, CentralUS did.

## Using the new Azure location

We have our new stack and its config now, but how does our code use it?

At least for the case of `azure-native:location`, we don't actually have to do anything! [As we can see from the Pulumi docs](https://www.pulumi.com/registry/packages/azure-native/installation-configuration/#configuration-options), Pulumi automatically attempts to discover some Azure settings itself if they weren't given explicitly, and the Azure location is one of those. Before, we indeed didn't provide the location explicitly – Pulumi was able to work by getting the Azure location from our CLI authentication. That's also why we didn't have to set the `Location` property on any of the resources we created. If the value is in the stack config, though, it will use that.

That's not very exciting, however, since we wouldn't actually get to use a config value in our C# code! Instead, let's create a custom config setting to change how many Functions are created depending on the stack.

## Using Pulumi config values in code

Run `pulumi config set function-count 2`, then open up your Pulumi.staging.yaml file and change the value to an int by changing `"2"` to `2` (unfortunately, `pulumi config set` seems to always set values as strings). Add this value to Pulumi.dev.yaml, as well, but instead give it a value of `1`.

Also, `pulumi config set` doesn't do anything special, and you can edit the files by hand if you prefer for the same result.

We can then access our stack config by instantiating a `Config` object. We'll also loop through the count variable. Here's how to do that:

```csharp
// Change your AzureFunctionApp creation to this code
var config = new Pulumi.Config();
var functionCount = config.RequireInt32("function-count");
var functionApps = new List<AzureFunctionApp>();

for (int i = 0; i < functionCount; i++)
{
    var app = new AzureFunctionApp($"cool-function-{i + 1}", new()
    {
        ResourceGroupName = resourceGroup.Name,
        StorageAccountName = storageAccount.Name,
        FunctionName = "MyCoolFunction",
        PublishPath = "../PulumiCSharp.ConsoleApp/publish",
        DotNetVersion = DotNetVersion.V8
    });
    functionApps.Add(app);
}

return functionApps.ToDictionary(
    app => $"{app.GetResourceName()}-api-url",
    app => (object?)app.ApiUrl
);
```

The `RequireInt32()` function looks for an integer value with the specified key from the config. Like the name implies, it will throw an error if it doesn't find that value from the config.

Two things that are worth noting about Pulumi configs that we won't be using here: firstly, there are other methods for getting config values besides integers, like `RequireBool()` and `RequireString()`. There's also methods for getting optional config values, which start with Get instead of Require, eg. `GetBool()` and `GetInt32()`.

Secondly, if you want to get a config value out of a certain section of the config, you must make a separate `Config` object for the section itself. For instance, if you wanted to get the Azure location, you would create a `Config` object like `var azureConfig = new Config("azure-native")`, then call methods on that object to get values from that config section.

## Deploying the new stack

Let's redeploy our stacks to see the changes. I'm also going to destroy both my stacks so I can see the differences in the full runs when using the new config value. Altogether, here's the commands I'm running in order:

-   `pulumi stack select dev && pulumi destroy`
-   `pulumi up --skip-preview`
-   `pulumi stack select staging && pulumi up --skip-preview`

I'll spare you the Pulumi output, but you should see that the dev stack created one `AzureFunctionApp`, while the staging stack created two. They're also in different subscriptions and regions, although the Pulumi output doesn't give this information.

Let's take a glance in the Azure Portal to verify what things look like:

Success! We have two different resource groups, both in a different subscription and region. Also, the first resource group has one Function App, while the second resource group has two, just like we configured.

Also, although this series won't cover it, you can also define schemas for your Pulumi config and set default values at the project level. If you're interested, [check out their post on that!](https://www.pulumi.com/blog/project-config-mvp/)

## What's a stack? What's a project?

So, what exactly did we just do? What's a "stack" in Pulumi?

The top level of your Pulumi app is called your "project." Your Pulumi project is wherever your Pulumi.yaml file is, which is the config for the whole project. There's nothing stopping you from having multiple projects in different directories, either, but you probably want to have some kind of logical separation between them for the sake of organization. Our small example app isn't nearly complicated enough for multiple projects, so we'll just stick with our one.

A project contains many "stacks." Up until now, we've only had the one stack called "dev," and we just created a second one for staging. Like we just saw in our example, **a stack is simply a deployable instance of your Pulumi program**. Each stack also has its own configuration.

Stacks are configurable, so it's common to use stacks to have separate instances of your program per environment, such as dev, staging, and prod. The config file for a stack is Pulumi.<stackName>.yaml. You may also choose to create new stacks for logical reasons, similar to how you divide your business logic up by classes. For instance, you might have a logging stack, a monitoring stack, or a database stack (if you have a more complex setup with redundancy and disaster recovery, perhaps).

> 📝 **Keep it simple**
>
> Especially when starting out, I highly recommend keeping it simple and sticking to one stack per environment. If it ever becomes too cumbersome to manage your monolithic stacks that way, you can split them up later if needed. Pulumi also has a very nice docs page on some [philosophy of stack organization here](https://www.pulumi.com/docs/iac/using-pulumi/organizing-projects-stacks/).

## You only use one stack at a time!

It's important to note that, since the stack configuration is what holds things like the Azure subscription ID and tenant ID, **we work with a single stack at a time** and **deploy our resources to a specific stack at a time**. Pulumi takes the subscription and tenant from our Azure CLI login if we don't put them in the stack config, which is why it worked before we had our stack config files.

Previously in this series, when we've run commands in the CLI like `pulumi preview` and `pulumi up`, we've actually been running those commands specifically on the dev stack. When you run `pulumi stack ls`, you can see which one is the **active stack** by whichever one has a asterisk `*` next to it.

The takeaway here is that **Pulumi commands operate on the active stack**.

You can change the active stack by running `pulumi stack select <stack name>`.

## Stack outputs

This whole series, you may have been wondering what that `Dictionary` being returned at the bottom of our Program.cs is all about… That's a stack output, and will be the topic of the next post in this series, so hang tight!

## Bonus: deploying to different subscriptions within the same stack using Providers

This is a good chance to talk about how things work under the covers a bit and solve a potential problem you may run into.

You may have a use case where you'd like to access multiple Azure subscriptions within the same stack. For example, you may need to access a resource owned by another team that lives in a different subscription. Things like this are possible by creating `Provider`s in your C# code.

> 📝 **Azure regions**
>
> If you need to deploy to multiple Azure regions, rather than multiple subscriptions, you can actually do that from a single stack. An Azure subscription provides access to all regions, regardless of the default one defined in your Pulumi program. However, consider that a stack is managed, created, and destroyed as a single unit, and if doing that to all regions involved at the same time is fine for your use case.

We've already been using a provider in Pulumi, but not explicitly. If you remember way back from [the first Pulumi post in this series](https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/), a **resource provider** in Pulumi is what actually handles communicating with the cloud service to CRUD the resources you request. In our case, we've been use the [Azure Native](https://www.pulumi.com/registry/packages/azure-native/) provider. [Like the Pulumi docs say](https://www.pulumi.com/docs/iac/concepts/resources/providers/#default-and-explicit-providers), Pulumi creates a default provider for us behind the scenes and gives it some configuration (which we can override parts of, like we did earlier in this post).

However, we can also create `Provider` objects explicitly in our code, configure them however we want, then tell our resources to use a specific `Provider`.

For instance, here's how to create two `Provider`s, each for a different subscription, and put resources into both of them:

```csharp
// As examples...
// 1) You might want to manage resources in multiple subscriptions at once...
var devWestProvider = new Pulumi.AzureNative.Provider("Dev-WestUS", new()
{
    Location = "EastUS",
    SubscriptionId = "11111111-1111-1111-1111-111111111111"
});
var stagingCentralProvider = new Pulumi.AzureNative.Provider("Staging-CentralUS", new()
{
    Location = "WestUS",
    SubscriptionId = "22222222-2222-2222-2222-222222222222"
});
var devResourceGroup = new ResourceGroup("devResourceGroup", options: new Pulumi.CustomResourceOptions()
{
    Provider = devWestProvider
});
var stagingResourceGroup = new ResourceGroup("stagingResourceGroup", options: new Pulumi.CustomResourceOptions()
{
    Provider = stagingCentralProvider
});

// 2) ...or maybe read existing resources from other subscriptions you don't own
// Pulumi won't manage these resources! You'll just have access to them in your stack
var subscriptionId = "33333333-3333-3333-3333-333333333333";
var resourceGroupName = "other-teams-rg";
var keyVaultName = "other-teams-vault";
var otherTeamsAccountProvider = new Pulumi.AzureNative.Provider("some-other-account", new()
{
    Location = "EastUS",
    SubscriptionId = subscriptionId
    // When accessing a subscription you don't own, you may need to specify the authentication info
    // eg. ClientId, ClientSecret, UseMsi, UseOidc, etc.
});
// You can also use the command, Pulumi.AzureNative.KeyVault.GetVault.Invoke
var keyVault = Pulumi.AzureNative.KeyVault.Vault.Get(
    "other-team-vault",
    $"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{keyVaultName}",
    new() { Provider = otherTeamsAccountProvider }
);
```

This way, we can access multiple subscriptions in a single stack, whether we own the resources or not. Keep in mind that this shouldn't be your typical way of managing resources, but the option is there if you need it.

## Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/PulumiCSharp](https://github.com/danielwarddev/PulumiCSharp)
