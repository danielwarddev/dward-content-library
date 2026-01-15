# How to use Pulumi with C# – Our first project

**Date:** April 11, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/

_This post is part of a series on using Pulumi:_

-   [Infrastructure as code (IaC) – what it is and why to use it](https://daninacan.com/infrastructure-as-code-iac-what-it-is-and-why-to-use-it/)
-   **How to use Pulumi with C# – Our first project**
-   [How to use Pulumi with C# – How Pulumi Works](https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/)
-   [How to use Pulumi with C# – Inputs and Outputs](https://daninacan.com/how-to-use-pulumi-with-c-inputs-and-outputs/)
-   [How to use Pulumi with C# – Component Resources](https://daninacan.com/how-to-use-pulumi-with-c-component-resources/)
-   [How to Use Pulumi with C# – Projects, Stacks, Config](https://daninacan.com/how-to-use-pulumi-with-c-projects-stacks-config/)
-   [How to use Pulumi with C# – Stack References](https://daninacan.com/how-to-use-pulumi-with-c-stack-references/)

## Overview

Since the last post was all theory, let's dive into Pulumi and showcase it actually working! For this post, we'll make a new project with Pulumi and then deploy some resources to Azure. We'll also talk a bit about how Pulumi works under the covers.

## First off, what is Pulumi?

Pulumi is an infrastructure as code (IaC) tool that allows you to write your IaC in a variety of programming languages, rather than something declarative like JSON or YAML. This series will use C#.

Using Pulumi, you can define what resources you want in your provider (some provider examples are Azure, AWS, and Kubernetes), then deploy those resources out to it. "Resources" here really just means anything that provider can create – in Azure's case, some examples are a resource group, an Azure Function, and a blob.

To wet your whistle, here's a very simple example of how you'd use Pulumi with C# to define a resource group and storage account in Azure:

```csharp
var resourceGroup = new AzureNative.Resources.ResourceGroup("resourceGroup");

var account = new AzureNative.Storage.StorageAccount("sa", new()
{
    ResourceGroupName = resourceGroup.Name,
    Sku = new AzureNative.Storage.Inputs.SkuArgs
    {
        Name = AzureNative.Storage.SkuName.Standard_LRS
    },
    Kind = AzureNative.Storage.Kind.StorageV2
});
```

## Prerequisites

We'll need to set up a few things in order to get started with using Pulumi. I won't seek to recreate their respective instructions here (which are pretty straightforward, anyway), so I'll just link to the installations of each:

-   Install [the .NET SDK](https://dotnet.microsoft.com/en-us/download) if you don't have that already
-   Download [the Pulumi CLI](https://www.pulumi.com/docs/iac/download-install/)
-   Create a [Pulumi account](https://www.pulumi.com/) (free)\*
-   Create an [Azure account](https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account) (also free; just don't go spinning up any resources willy-nilly)
-   Download the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
-   Authenticate to your Azure account locally using the Azure CLI with `az login` (Pulumi will automatically use your credentials from this – [docs here](https://www.pulumi.com/registry/packages/azure-native/installation-configuration/#authenticate-using-the-cli))

\*There is actually a technical reason you need a Pulumi account, and it's to store your state between deployments so Pulumi has a diff to compare against. More on that in the next post.

## Creating a new project with Pulumi

Once you've got all the requirements above taken care of, we can create a new Pulumi project!

1. The Pulumi CLI will create a new C# project for you, but not a solution. So, first create a new solution. You can do that with your preferred IDE or with the CLI using `dotnet new sln --output MySolutionName`.
2. Inside the solution directory, create another new directory for the project and name it whatever you like. As a convention, I like to name my Pulumi projects `AppName.Infrastructure`.
3. Inside of that new project directory, run `pulumi new azure-csharp`.
4. If this is your first time using Pulumi, it will ask you to log in first. Log in using your Pulumi account. The browser option is probably easier.
5. It will now run you through a short wizard to set up a new project. The default values for the project name, description, stack name, and Azure region work fine (we'll cover what a stack is in the next post).

You now have a C# Pulumi project! Also, if you're curious to see other templates, you can [see them on Github](https://github.com/pulumi/templates) or by just running `pulumi new`.

## What's in the template?

Thankfully, the template is pretty small – it's just two YAML files and a Program.cs.

If you look at Pulumi.yaml, you can see that it's the values you entered in for the wizard. As for Pulumi.dev.yaml, there's only one value, and it's the Azure region you chose. We'll mess with the configs a bit more later, but we can leave them alone for now.

Program.cs is where all the meat is. You'll see that everything is inside a `Pulumi.Deployment.RunAsync()` method, which is the entry point for your Pulumi application. All cloud resources must be made inside of this lambda.

Really, this file is pretty straightforward. In order, it:

-   Creates a resource group
-   Creates a storage account in that resource group
-   Makes an API call to Azure to get the storage account's keys
-   Outputs the primary key (we'll talk about outputs later)

All you need to do is instantiate C# objects, such as a `ResourceGroup` and `StorageAccount`, and Pulumi will end up creating the corresponding resource in Azure, as we're about to see. We'll go over how exactly it does that a bit more in the next post, but for now, let's just see it in action.

## Deploying to Azure

Let's actually run our Pulumi program. Run `pulumi up`, Pulumi's deployment command:

```bash
>pulumi up
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev/previews/d77816a8-15da-43d8-bd15-0ac67acc62c5

     Type                                   Name                              Plan
 +   pulumi:pulumi:Stack                    PulumiCSharp.Infrastructure-dev   create
 +   ├─ azure-native:resources:ResourceGroup  resourceGroup                    create
 +   └─ azure-native:storage:StorageAccount   sa                               create

Outputs:
    primaryStorageKey: output<string>

Resources:
    + 3 to create

Do you want to perform this update? [Use arrows to move, type to filter]
  yes
> no
  details
```

From the output, you can see that it didn't actually deploy anything yet. First, it gives you a preview of the changes it's going to make (you can also run `pulumi preview` to get only this preview). In this case, we're not creating too much – just a resource group and then a storage account inside of it.

Accept the changes and Pulumi will begin to deploy them to Azure. This will probably take around 30 seconds or so, so don't be alarmed when it's not done immediately.

Once it finishes, go out to your Azure account to see your new resource group, with the new storage account within it.

Pretty cool!

But wait – you might notice the names of the created resources look a little funky! It's important for us to understand why.

## A quick lesson on resource names

For each resource, there's actually two separate names that Pulumi needs to keep track of:

-   The name inside Azure (or any other provider) – this is called the **physical name**
-   The name Pulumi uses internally to uniquely identify the resource – this is called the **logical name**

For instance, in our case, our resource group's logical name is `resourceGroup`. We can see this name in our C# code. The physical name for that resource group, in my case, is `resourceGroup17b630de`. Pulumi autonamed the resources using the logical name plus some random characters on the end.

While you can easily hardcode physical names if you want to (it's just a `Name` property on the C# type), that's generally advised against for two reasons:

-   The random bit at the end ensures unique names for resources as many teams all deploy to the same account.
-   In some situations, Pulumi cannot update a resource directly. Instead, it has to delete it and create a new one with the updated properties. When it does this, it **creates the new resource first before deleting the old one**. It does this so you can have zero-downtime deployments. However, Azure requires resource names to be unique, so if you're hardcoding the physical name, then you'll run into naming conflicts in Azure in these cases. This will cause your deployment to fail. Allowing Pulumi to add some random characters on the end ensures uniqueness for these cases.

Now that we've had a successful run, this is a good opportunity to add something new to our project and talk about how Pulumi is actually deploying your stuff. That will be the topic of the next post.

## Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/PulumiCSharp
