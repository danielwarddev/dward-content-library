# How to use Pulumi with C# – Component Resources

https://daninacan.com/how-to-use-pulumi-with-c-component-resources/

_This post is part of a series on using Pulumi:_

-   [Infrastructure as code (IaC) – what it is and why to use it](https://daninacan.com/infrastructure-as-code-iac-what-it-is-and-why-to-use-it/)
-   [How to use Pulumi with C# – Our first project](https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/)
-   [How to use Pulumi with C# – How Pulumi Works](https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/)
-   [How to use Pulumi with C# – Inputs and Outputs](https://daninacan.com/how-to-use-pulumi-with-c-inputs-and-outputs/)
-   **How to use Pulumi with C# – Component Resources**
-   [How to Use Pulumi with C# – Projects, Stacks, Config](https://daninacan.com/how-to-use-pulumi-with-c-projects-stacks-config/)
-   [How to use Pulumi with C# – Stack References](https://daninacan.com/how-to-use-pulumi-with-c-stack-references/)

## Overview

At this point, our Pulumi program is creating a working Azure Function that can be accessed through a URL, and that Azure Function runs a C# project that came from the same solution.

This is great! However, our code isn't very reusable. As a common example, what if we wanted to use this pattern in multiple places in our project to create multiple Azure Functions in the same way? We can do that with a component resource in Pulumi.

A component resource is how you create your own resources in Pulumi, logically grouping together other resources. From there, you can reuse it yourself and share it throughout your org. In our case, we'll create a component resource to group together everything we need for our Azure Function.

## Turning our existing code into a component resource

Let's create a component resource. Create a new class called `AzureFunctionApp` with this content:

```csharp
public class AzureFunctionApp : ComponentResource
{
    public AzureFunctionApp(string name, ResourceArgs args, ComponentResourceOptions? options = null)
        : base("danielwarddev:PulumiCSharp:AzureFunctionApp", name, args, options)
    {
    }
}
```

There's not too much going on here yet, but let's go over what is there:

-   We inherit from `ComponentResource` to get all the benefits of being a resource in Pulumi, like state tracking and everything the base class provides (more on this later).
-   This constructor is actually the same as the constructor of every other Pulumi resource we've created so far – we give the resource a name, pass it an object of arguments we want to set, and then give it an optional object for the options. We'll be using all of these.
-   We call the base constructor with these arguments, along with a string, which will be the unique type name for the resource inside Pulumi.
-   This call to the base constructor is what actually records this resource's state in Pulumi and allows it to be tracked across deployments so that you can see diffs in the resource, just like how we've seen with the other resources.
-   The type string can be whatever value you want, **but it must be unique inside your Pulumi state**. Thus, [Pulumi recommends](https://www.pulumi.com/docs/iac/concepts/components/#authoring-a-new-component-resource) it be in the form of `package:module:type` to ensure uniqueness and avoid any type conflicts. In my case, it's `danielwarddev:PulumiCSharp:AzureFunctionApp`.

Let's put some resources in our component resource.

## Putting things in our component resource

There's not really any restrictions here – we can move whatever resources we'd like into this component resource. Thinking practically, though, users of this resource will probably already have a resource group and a storage account set up, so we don't want to create those every time. So, we'll leave those out.

Let's start with moving a single resource inside. We'll do the blob container first:

```csharp
public class AzureFunctionApp: ComponentResource
{
    public AzureFunctionApp(string name, ResourceArgs args, ComponentResourceOptions? options = null)
        : base("danielwarddev:PulumiCSharp:AzureFunctionApp", name, args, options)
    {
        // Create a new blob container and blob to hold the ZIP file of the packaged app for the Azure Function
        var blobContainer = new BlobContainer("function-zip-container", new BlobContainerArgs
        {
            ResourceGroupName = resourceGroup.Name,
            AccountName = storageAccount.Name,
            PublicAccess = PublicAccess.None
        });
    }
}
```

## Adding inputs

Right away, we can see we have a couple compilation errors around `resourceGroup` and `storageAccount`, since we don't have those references in our component resource. While we don't want to create them, we _do_ need to reference them. We can use Pulumi inputs for that, just like we did for the built-in Pulumi components we made.

To do that, we create our own custom type for the args that inherits from `ResourceArgs`. For us, that would look like this:

```csharp
public class AzureFunctionAppArgs : ResourceArgs
{
    [Input("resourceGroupName", true)]
    public required Input<string> ResourceGroupName { get; set; }

    [Input("storageAccountName", true)]
    public required Input<string> StorageAccountName { get; set; }
}

public class AzureFunctionApp : ComponentResource
{
    public AzureFunctionApp(string name, AzureFunctionAppArgs args, ComponentResourceOptions? options = null)
        : base("danielwarddev:PulumiCSharp:AzureFunctionApp", name, args, options)
    {
        var blobContainer = new BlobContainer("function-zip-container", new BlobContainerArgs
        {
            ResourceGroupName = args.ResourceGroupName,
            AccountName = args.StorageAccountName,
            PublicAccess = PublicAccess.None
        });
    }
}
```

> 📝 **Note**
> Pulumi's convention for input names seems to be to use camel case, so I'm following that convention here, even though my C# property itself is pascal case.

With this, our compiler errors are now gone!

We gave the `Input` attribute two arguments: the name of the input and whether it's required or not. This is a bit confusing, in my opinion, since we also set these things in the C# syntax itself! There is a difference, however.

**Internally, Pulumi will refer to the input using values from the attribute, not your C# variable.** Anything on the C# variable itself is purely for the compile-time benefits that C# provides for you and is separate from Pulumi. So, internally, Pulumi knows the first input as `resourceGroupName`, not `ResourceGroupName` (you can verify this yourself by viewing Pulumi's state using `pulumi stack export > stack.json`).

Likewise, whether or not Pulumi requires this input to have a value **at runtime** is not determined by the `required` keyword, but by the boolean passed to the attribute. Technically, I'm not sure how you'd end up without a value at runtime when using C#'s `required`, but in my opinion, it's good practice to do both. Plus, if you add multi-language support to your component resource (so it can be consumed in other languages besides C#), the values in the attribute are what will be carried over.

## Resource naming

With the errors gone, let's also instantiate this class in our `Program` class. Put it after we create the resource group and storage account:

```csharp
...
new AzureFunctionApp("function-app", new()
{
    ResourceGroupName = resourceGroup.Name,
    StorageAccountName = storageAccount.Name
});
...
```

Run `pulumi preview`, and we see that we get a Pulumi error:

```bash
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev/previews/80a9f008-4d73-4f72-949f-e30085d53918

     Type                                    Name                            Plan        Info
     pulumi:pulumi:Stack                     PulumiCSharp.Infrastructure-dev
 ├─  azure-native:storage:BlobContainer     function-zip-container                      1 error
 +   └─ danielwarddev:PulumiCSharp:AzureFunctionApp  function-app             create

Diagnostics:
  azure-native:storage:BlobContainer (function-zip-container):
    error: Duplicate resource URN 'urn:pulumi:dev::PulumiCSharp.Infrastructure::azure-native:storage:BlobContainer::function-zip-container'; try giving it a unique name
```

From the error logs, we can see that this failed in the preview step, with the reason being that we're trying to create two `BlobContainer`s both named `function-zip-container` – one inside the component resource and one outside.

The takeaway here is that Pulumi won't modify your resource names just because they're inside a component resource. However, resource names inside Pulumi must be unique, so we'll have to change it somehow.

A common pattern to solve this is to prefix the child resource name with the `name` passed to the `ComponentResource`. In our case, that would mean changing it like so:

```csharp
var blobContainer = new BlobContainer($"{name}-function-zip-container", new BlobContainerArgs { ... });
```

In this way, you can reliably make all the resource names inside a component resource unique. Run `pulumi preview` again and this time it succeeds:

```bash
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev/previews/d419b64d-3429-489a-865f-9d6bbab45030

     Type                                           Name                                      Plan        Info
     pulumi:pulumi:Stack                            PulumiCSharp.Infrastructure-dev                       7 messages
 +   ├─ danielwarddev:PulumiCSharp:AzureFunctionApp my-function                               create
 +   └─ azure-native:storage:BlobContainer          my-function-function-zip-container        create
```

## Setting the parent

If you look closely at the above output, you may notice that this isn't quite what we want. The `BlobContainer` should be inside the `AzureFunctionApp`, but they're at the same level!

To fix this, there's one more thing we need to put on our blob container, which is to set its parent. The code change for this is very small:

```csharp
var blobContainer = new BlobContainer($"{name}-function-zip-container", new BlobContainerArgs
{
    ResourceGroupName = args.ResourceGroupName,
    AccountName = args.StorageAccountName,
    PublicAccess = PublicAccess.None
}, new() { Parent = this });
```

We set the `Parent` in the `CustomResourceOptions` of the `BlobContainer`'s constructor, which pretty much does what it sounds like, specifying our `AzureFunctionApp` as the parent for this `BlobContainer`.

Run `pulumi preview` once again to see our resources displaying correctly:

```bash
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev/previews/573e5037-d695-4183-a425-d746b1a267b4

     Type                                           Name                                      Plan        Info
     pulumi:pulumi:Stack                            PulumiCSharp.Infrastructure-dev                       7 messages
 +   └─ danielwarddev:PulumiCSharp:AzureFunctionApp my-function                               create
 +      └─ azure-native:storage:BlobContainer       my-function-function-zip-container        create
```

Our resources now display correctly! This way, it's much easier to see what each resource is a part of logically.

## Filling in the rest of the component resource

> 📝 **Note**
> These two code snippets are rather lengthy, so I recommend copy-pasting them.

Filling in the rest of the resources we'll need, our component resource ends up looking like this:

```csharp
using Pulumi;
using Pulumi.AzureNative.Insights;
using Pulumi.AzureNative.OperationalInsights;
using Pulumi.AzureNative.OperationalInsights.Inputs;
using Pulumi.AzureNative.Storage;
using Pulumi.AzureNative.Web;
using Pulumi.AzureNative.Web.Inputs;

namespace PulumiCSharp.Infrastructure;

public class DotNetVersion : ResourceArgs
{
    public static readonly DotNetVersion V8 = new DotNetVersion { NetFrameworkVersion = "v8.0", LinuxFxVersion = "DOTNET-ISOLATED|8.0" };
    public static readonly DotNetVersion V9 = new DotNetVersion { NetFrameworkVersion = "v9.0", LinuxFxVersion = "DOTNET-ISOLATED|9.0" };

    [Input("netFrameworkVersion", true)]
    public required Input NetFrameworkVersion { get; set; }

    [Input("linuxFxVersion", true)]
    public required Input LinuxFxVersion { get; set; }
}

public class AzureFunctionAppArgs : ResourceArgs
{
    [Input("region", true)]
    public required Input<string> Region { get; set; }

    [Input("resourceGroupName", true)]
    public required Input ResourceGroupName { get; set; }

    [Input("storageAccountName", true)]
    public required Input StorageAccountName { get; set; }

    [Input("functionName", true)]
    public required Input FunctionName { get; set; }

    [Input("publishPath", true)]
    public required Input PublishPath { get; set; }

    [Input("dotNetVersion", true)]
    public required Input DotNetVersion { get; set; }
}

public class AzureFunctionApp : ComponentResource
{
    [Output]
    public Output ApiUrl { get; set; }

    public AzureFunctionApp(string name, AzureFunctionAppArgs args, ComponentResourceOptions? options = null)
        : base("danielwarddev:PulumiCSharp:AzureFunctionApp", name, args, options)
    {
        // Create a new blob container and blob to hold the ZIP file of the packaged app for the Azure Function
        var blobContainer = new BlobContainer($"{name}-function-zip-container", new BlobContainerArgs
        {
            ResourceGroupName = args.ResourceGroupName,
            AccountName = args.StorageAccountName,
            PublicAccess = PublicAccess.None
        }, new() { Parent = this });

        var blob = new Blob($"{name}-functionZipBlob", new BlobArgs
        {
            ResourceGroupName = args.ResourceGroupName,
            AccountName = args.StorageAccountName,
            ContainerName = blobContainer.Name,
            Type = BlobType.Block,
            Source = args.PublishPath.Apply(path => new FileArchive(path) as AssetOrArchive)
        }, new() { Parent = this });

        // Get the signed URL for the blob by calling ListStorageAccountServiceSAS on Azure
        var sasToken = ListStorageAccountServiceSAS.Invoke(new ListStorageAccountServiceSASInvokeArgs
        {
            ResourceGroupName = args.ResourceGroupName,
            AccountName = args.StorageAccountName,
            Protocols = HttpProtocol.Https,
            SharedAccessStartTime = "2022-01-01",
            SharedAccessExpiryTime = "2030-01-01",
            Resource = SignedResource.C,
            Permissions = Permissions.R,
            CanonicalizedResource = Output.Format($"/blob/{args.StorageAccountName}/{blobContainer.Name}")
        }, new() { Parent = this })
        .Apply(result => result.ServiceSasToken);

        var codeBlobUrl = Output.Format($"https://{args.StorageAccountName}.blob.core.windows.net/{blobContainer.Name}/{blob.Name}?{sasToken}");

        // Create an Azure workspace and Application Insights inside of it
        var workspace = new Workspace($"{name}-workspace", new()
        {
            ResourceGroupName = args.ResourceGroupName,
            RetentionInDays = 30,
            Sku = new WorkspaceSkuArgs { Name = "PerGB2018" },
            Features = new WorkspaceFeaturesArgs { EnableDataExport = true }
        }, new() { Parent = this });

        var appInsights = new Component($"{name}-appInsights", new()
        {
            ResourceGroupName = args.ResourceGroupName,
            ApplicationType = "web",
            Kind = "web",
            WorkspaceResourceId = workspace.Id
        }, new() { Parent = this });

        var appServicePlan = new AppServicePlan($"{name}-appServicePlan", new AppServicePlanArgs
        {
            ResourceGroupName = args.ResourceGroupName,
            Kind = "Linux",
            Sku = new SkuDescriptionArgs { Name = "Y1", Tier = "Dynamic" },
            Reserved = true,
            Location = args.Region
        }, new() { Parent = this });

        // Use everything above to create the app
        var app = new WebApp($"{name}-my-function-app", new()
        {
            ResourceGroupName = args.ResourceGroupName,
            ServerFarmId = appServicePlan.Id,
            Kind = "FunctionApp",
            SiteConfig = new SiteConfigArgs
            {
                NetFrameworkVersion = args.DotNetVersion.Apply(x => x.NetFrameworkVersion),
                LinuxFxVersion = args.DotNetVersion.Apply(x => x.LinuxFxVersion),
                DetailedErrorLoggingEnabled = true,
                HttpLoggingEnabled = true,
                AppSettings = new[]
                {
                    new NameValuePairArgs { Name = "FUNCTIONS_WORKER_RUNTIME", Value = "dotnet-isolated" },
                    new NameValuePairArgs { Name = "FUNCTIONS_EXTENSION_VERSION", Value = "~4" },
                    new NameValuePairArgs { Name = "WEBSITE_RUN_FROM_PACKAGE", Value = codeBlobUrl },
                    new NameValuePairArgs { Name = "APPINSIGHTS_INSTRUMENTATIONKEY", Value = appInsights.InstrumentationKey }
                },
                Cors = new CorsSettingsArgs { AllowedOrigins = new[] { "*" } },
            },
        }, new() { Parent = this });

        ApiUrl = Output.Format($"https://{app.DefaultHostName}/api/{args.FunctionName}");
        RegisterOutputs();
    }
}
```

We use an enum class for the .NET version so that it's easier to provide correct values. Notice that this class must also inherit from `ResourceArgs`, since it's used as an `Input`.

We also don't put the publish command in `AzureAppFunction`. Instead, we run that first in `Program`, then pass in the path of the command's output. This is for two reasons:

-   In the event that you create multiple Azure Functions using the same .NET project, you needlessly publish the same project multiple times, which is rather slow.
-   The Azure WebJobs package seems to error out if you try to build the same project more than once. See [this GitHub issue](https://github.com/Azure/Azure-Functions/issues/2016) for an example.

## Using our component resource

Meanwhile, to consume this, our `Program` becomes a fair bit smaller:

```csharp
using System;
using Pulumi.AzureNative.Resources;
using Pulumi.AzureNative.Storage;
using Pulumi.AzureNative.Storage.Inputs;
using System.Collections.Generic;
using System.IO;
using Pulumi.Command.Local;
using Kind = Pulumi.AzureNative.Storage.Kind;
using StorageAccountArgs = Pulumi.AzureNative.Storage.StorageAccountArgs;
using PulumiCSharp.Infrastructure;

return await Pulumi.Deployment.RunAsync(async () =>
{
    var resourceGroup = new ResourceGroup("resourceGroup");

    var storageAccount = new StorageAccount("sa", new StorageAccountArgs
    {
        ResourceGroupName = resourceGroup.Name,
        Sku = new SkuArgs { Name = SkuName.Standard_LRS },
        Kind = Kind.StorageV2
    });

    var publishCommand = Run.Invoke(new()
    {
        Command = $"dotnet clean && dotnet publish --output publish",
        Dir = Path.GetFullPath(Path.Combine("..", "PulumiCSharp.ConsoleApp")),
        Environment = new Dictionary<string, string>
        {
            ["DOTNET_CLI_TELEMETRY_OPTOUT"] = "1"
        }
    });

    publishCommand.Apply(x =>
    {
        Console.WriteLine(x.Stdout);
        return x;
    });

    var functionApp1 = new AzureFunctionApp("cool-function-1", new()
    {
        Region = "WestUS",
        ResourceGroupName = resourceGroup.Name,
        StorageAccountName = storageAccount.Name,
        FunctionName = "MyCoolFunction",
        PublishPath = "../PulumiCSharp.ConsoleApp/publish",
        DotNetVersion = DotNetVersion.V8
    });

    var functionApp2 = new AzureFunctionApp("cool-function-2", new()
    {
        Region = "WestUS",
        ResourceGroupName = resourceGroup.Name,
        StorageAccountName = storageAccount.Name,
        FunctionName = "MyCoolFunction",
        PublishPath = "../PulumiCSharp.ConsoleApp/publish",
        DotNetVersion = DotNetVersion.V8
    });

    return new Dictionary<string, object?>
    {
        ["coolApp1-apiUrl"] = functionApp1.ApiUrl,
        ["coolApp2-apiUrl"] = functionApp2.ApiUrl
    };
});
```

Here, I'm creating two `AzureFunctionApp`s, just to show how easy it is to create more than one of them and still have them run normally in Azure.

## Registering outputs

Our component resource can have outputs, just like any other Pulumi resource. Outputs are values that will be accessible by the consumer after this resource is created. Depending on what you're creating and how you use it, you may decide you want additional outputs.

You might have noticed that at the very end of the `AzureFunctionApp` class above, we call `RegisterOutputs()`. In addition, we have one output in the class at the top – `ApiUrl`, which is annotated with the `[Output]` attribute.

We don't have to use the `[Output]` attribute, but I think it makes things a little cleaner for us. Otherwise, you have to pass a `Dictionary<string, object>?` to `RegisterOutputs()` like so:

```csharp
// Equivalent to the [Output] pattern we're using
RegisterOutputs(new Dictionary<string, object?>()
{
    ["apiUrl"] = Output.Format($"https://{app.DefaultHostName}/api/{args.FunctionName}");
});
```

`[Output]` uses reflection under the hood to do this for you to save you a bit of trouble. Use whichever way you think is cleanest.

Also, **even if you have no outputs in a component resource, you should still call `RegisterOutputs()` with no arguments!** Not including this call won't cause your component resource to fail creation, [but it may cause confusion and problems with Pulumi's state down the line, as it signals to Pulumi that the resource is done](https://www.pulumi.com/docs/iac/concepts/components/#what-registeroutputs-does). It's a single line and good practice, so just remember to include at the end of your component resources.

## Bonus: why not just use a normal C# class?

You might be wondering why we couldn't just abstract our code away into a normal C# class that doesn't inherit from `ComponentResource`.

Actually, you could do this – and it would even still work with Pulumi. The primary difference between these two is how the Pulumi will treat the resources in the state hierarchy.

For example, here's what the state changes look like with a `ComponentResource`, how this post did it:

```bash
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev/previews/78778bd9-c3ed-468e-958a-2acf5085cc3a

     Type                                           Name                                      Plan        Info
 +   pulumi:pulumi:Stack                            PulumiCSharp.Infrastructure-dev           create      20 messages
 +   ├─ azure-native:resources:ResourceGroup        resourceGroup                             create
 +   ├─ azure-native:storage:StorageAccount         sa                                        create
 +   └─ danielwarddev:PulumiCSharp:AzureFunctionApp cool-function-1                           create
 +      ├─ azure-native:storage:BlobContainer       cool-function-1-function-zip-container    create
 +      ├─ azure-native:web:AppServicePlan          cool-function-1-appServicePlan            create
 +      ├─ azure-native:operationalinsights:Workspace cool-function-1-workspace               create
 +      ├─ azure-native:insights:Component          cool-function-1-appInsights               create
 +      ├─ azure-native:storage:Blob                cool-function-1-functionZipBlob           create
 +      └─ azure-native:web:WebApp                  cool-function-1-my-function-app           create
```

Comparatively, here's the state changes without inheriting from `ComponentResource`:

```bash
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/danielwarddev/PulumiCSharp.Infrastructure/dev/previews/7db8ea96-bd7c-46d4-9fe5-8da4e31f8f27

     Type                                           Name                                      Plan        Info
 +   pulumi:pulumi:Stack                            PulumiCSharp.Infrastructure-dev           create      20 messages
 +   ├─ azure-native:resources:ResourceGroup        resourceGroup                             create
 +   ├─ azure-native:storage:StorageAccount         sa                                        create
 +   ├─ azure-native:web:AppServicePlan             cool-function-1-appServicePlan            create
 +   ├─ azure-native:operationalinsights:Workspace  cool-function-1-workspace                 create
 +   ├─ azure-native:insights:Component             cool-function-1-appInsights               create
 +   ├─ azure-native:storage:BlobContainer          cool-function-1-function-zip-container    create
 +   ├─ azure-native:storage:Blob                   cool-function-1-functionZipBlob           create
 +   └─ azure-native:web:WebApp                     cool-function-1-my-function-app           create
```

As you can see, an immediate obvious difference is in the state hierarchy. When inheriting from `ComponentResource`, our `AzureFunctionApp` itself is also treated as a resource in Pulumi (it even gets its own URN), and all the resources created inside of it are children of it. Without inheriting from `ComponentResource`, we can't set the `Parent` of child resources, register any outputs, or call the base constructor. So, everything ends up at the same level in the hierarchy, and `AzureFunctionApp` isn't actually a resource in the state.

This has consequences such as:

-   Resource lifecycles/dependencies. Using a `ComponentResource`, other resources can depend on that parent resource, waiting until all child resources inside of it have finished creating/updating/deleting before hooking into that lifecycle. Without it, Pulumi has no way of knowing when CRUD events on it are completed.
-   Logical grouping. Using a `ComponentResource`, it's visible in the state tree that the child components are grouped under the parent and form a logical group, working together.

So, this whole section was just a long way to say that your component resources should inherit from `ComponentResource`, and if they don't, it will probably make things harder for you. Doing this takes care of connecting the resources to Pulumi's overall state management.

## Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/PulumiCSharp](https://github.com/danielwarddev/PulumiCSharp)
