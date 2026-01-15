# How to use Pulumi with C# – How Pulumi Works

**Date:** May 12, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/

_This post is part of a series on using Pulumi:_

-   [Infrastructure as code (IaC) – what it is and why to use it](https://daninacan.com/infrastructure-as-code-iac-what-it-is-and-why-to-use-it/)
-   [How to use Pulumi with C# – Our first project](https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/)
-   **How to use Pulumi with C# – How Pulumi Works**
-   [How to use Pulumi with C# – Inputs and Outputs](https://daninacan.com/how-to-use-pulumi-with-c-inputs-and-outputs/)
-   [How to use Pulumi with C# – Component Resources](https://daninacan.com/how-to-use-pulumi-with-c-component-resources/)
-   [How to Use Pulumi with C# – Projects, Stacks, Config](https://daninacan.com/how-to-use-pulumi-with-c-projects-stacks-config/)
-   [How to use Pulumi with C# – Stack References](https://daninacan.com/how-to-use-pulumi-with-c-stack-references/)

## Overview

We now have a Pulumi project up and running, and it can successfully deploy to Azure. Let's make it just a tad more interesting by adding a new resource. Afterwards, we'll also go over how Pulumi does its magic under the covers.

## Adding a new resource

Right after our storage account code, let's create a new App Service plan with the following code:

```csharp
var appServicePlan = new AppServicePlan("appServicePlan", new AppServicePlanArgs
{
    ResourceGroupName = resourceGroup.Name,
    Kind = "Linux",
    Sku = new SkuDescriptionArgs
    {
        Name = "Y1",
        Tier = "Dynamic"
    },
    Reserved = true // Required when Kind is "Linux"
});
```

Now, run another `pulumi up`, and you'll see the changes it's going to make:

```bash
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev/previews/37d9a48f-af59-4001-84d0-0753fa341af4

     Type                                 Name                              Plan
     pulumi:pulumi:Stack                  PulumiCSharp.Infrastructure-dev
 +   └─ azure-native:web:AppServicePlan   appServicePlan                    create

Resources:
    + 1 to create
    3 unchanged
```

> ❗ **Quota error**
>
> If you get an error like this:
>
> ```
> error: Status=401 Message="{"Code":"Unauthorized","Message":"This region has quota of 0 instances for your subscription. Try selecting different region or SKU."...
> ```
>
> then you may need to switch your Azure region. For some reason, my subscription did not allow me to create an Azure App Service plan in my original default region, `WestUS2`, due to an apparent quota I have there. I changed it to `WestUS` and it worked.
>
> If you get this error, try changing your region of your Pulumi stack by running `pulumi config set azure-native:location <location>`. Afterwards, you'll need to also run `pulumi destroy` and `pulumi up` to put the resources into the new region.

You can go ahead and deploy this change. It's pretty simple, and as you can see, there's only one change to make, which is creating our new resource. Pulumi correctly saw that one resource was new, and the rest didn't change, so don't need to be messed with. How did it know that, though? Let's take a look!

## How Pulumi works

When we say "Pulumi," there are really three different components being used that work together. This understanding is important to understand how Pulumi works – and Pulumi's open-source status.

### 1. The language host

Let's start with the entry point for your C# Pulumi project.

Pulumi needs to take your C# code and somehow register the desired resources from it. Whenever you create a new C# object from one of the Pulumi packages (such as with `new ResourceGroup()`), you "register" that resource with Pulumi. The component responsible for this is called the **language host**, which consists of two parts.

Firstly, the language host has a _language executor_ (named pulumi-language-dotnet in this case, with different ones for other languages). The executor launches the .NET runtime for your Pulumi program, which makes it the entry point for the process. The executor is included in the CLI. When you run `pulumi up`, this part kicks off your program.

Secondly, the language host also has a _language SDK_, which is responsible for observing your app as it runs and sending the resource registrations to the deployment engine.

### 2. The deployment engine

As mentioned above, resource registrations are sent to another component called the **deployment engine,** which is the logic that determines what changes (create, update, or delete) need to actually be made to the provider to reflect your desired state. It's embedded in the CLI and makes the changes by using another component, resource providers.

### 3. Resource providers

Finally, there's **resource providers**, which make the actual changes to the provider (Azure, AWS, Kubernetes, etc.). A resource provider also consists of two parts.

The first part is the C# _SDK_ you used. These are just normal C# packages that you're used to, such as `Pulumi.AzureNative.Storage`.

The second part is the _resource plugin_ binaries. These are SDKs provided by Pulumi that make the actual API calls to the provider. As mentioned above, the deployment engine uses these plugins to make the actual changes. These are stored locally, so if you like, you can even view the binaries yourself at `%USERPROFILE%/.pulumi/plugins`.

### Summary

So, as a shorter summary, here are the three core Pulumi components:

-   **Language host**
    -   _Language executor_. Entry point for your Pulumi program. Starts the .NET runtime for your app
    -   _Language SDK_. Sends resources registrations to the deployent engine
-   **Deployment engine**. Determines what changes need to be made to the provider to achieve your desired state
-   **Resource provider**
    -   _SDK_. The C# libraries provided
    -   _Resource plugin_. Binary used by the deployment engine to actually manage a resource

As well as a diagram of how everything fits together:

[How Pulumi works diagram](https://daninacan.com/wp-content/uploads/2025/05/How-Pulumi-works-diagram.jpeg)

_Click to enlarge_

If you like, you can also read a bit longer of an explanation along with an example at [Pulumi's docs](https://www.pulumi.com/docs/iac/concepts/how-pulumi-works/).

## Is Pulumi open-source?

**Everything talked about so far is free and open-source.** What isn't, however, is Pulumi Cloud.

Remember how the deployment engine determines if something needs to be created, updated, or deleted? To do that, it needs to compare the current state deployed to the desired state you're asking for. So, it needs that previous state stored somewhere to check against (the state is just a JSON file). Pulumi Cloud is the default option for this, and is a paid service for enterprises that also comes with some other features. However, you're free to use whatever method you like, including storing that state yourself somewhere. See more on that at the [docs here](https://www.pulumi.com/docs/iac/concepts/state-and-backends/).

## Bonus: viewing Pulumi's state

You can actually view Pulumi's JSON state quite easily. Although it's not necessary, I'd encourage you to do it once to get an idea for what it actually looks like under the hood.

If you run `pulumi stack export > stack.json`, it will put the state into a new file named stack.json. It's pretty long and ugly, but you can get the gist of it by scrolling through for a few seconds.

You might even notice that in this file you can see each resource's physical name and logical name, which we talked about in the previous post. You'll also see the `urn` field on everything, which is the resource's unique Uniform Resource Name.

## Caution: avoid state drift!

This will be covered fully in a later post, but for now, I'd just like to mention that Pulumi will **not know about changes made to the provider that happened outside of Pulumi**. For this reason, if you use Pulumi to create your infrastructure, you should try as hard as possible to minimize creating infrastructure outside of it, or else risk "state drift," where your Pulumi state no longer reflects what's actually in production.

## Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/PulumiCSharp
