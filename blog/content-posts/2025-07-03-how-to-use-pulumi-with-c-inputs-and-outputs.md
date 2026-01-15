# How to use Pulumi with C# – Inputs and Outputs

**Date:** July 3, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-use-pulumi-with-c-inputs-and-outputs/

_This post is part of a series on using Pulumi:_

-   [Infrastructure as code (IaC) – what it is and why to use it](https://daninacan.com/infrastructure-as-code-iac-what-it-is-and-why-to-use-it/)
-   [How to use Pulumi with C# – Our first project](https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/)
-   [How to use Pulumi with C# – How Pulumi Works](https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/)
-   **How to use Pulumi with C# – Inputs and Outputs**
-   [How to use Pulumi with C# – Component Resources](https://daninacan.com/how-to-use-pulumi-with-c-component-resources/)
-   [How to Use Pulumi with C# – Projects, Stacks, Config](https://daninacan.com/how-to-use-pulumi-with-c-projects-stacks-config/)
-   [How to use Pulumi with C# – Stack References](https://daninacan.com/how-to-use-pulumi-with-c-stack-references/)

## Overview

Now that we've got some fundamentals and basic infrastructure out of the way, let's add a working Azure Function to our resources, and learn about Pulumi inputs and outputs in the process. We'll also go over a new package, Pulumi.Command, to help automate our process.

## Adding a new project for our app

Let's add a new Azure Function. First, to do that, we'll need to create a new C# project, which will be the code that the Function actually executes.

Create a new C# project in your solution, naming it whatever you like. I named it `PulumiCSharp.ConsoleApp`, while my Pulumi project is named `PulumiCSharp.Infrastructure`.

We'll want this new project to have an Azure Function in it with an HTTP trigger, which you can create easily in a few different ways. Both Visual Studio ([docs](https://learn.microsoft.com/en-us/azure/azure-functions/functions-create-your-first-function-visual-studio#create-a-function-app-project?wt.mc_id=MVP_367508)) and JetBrains Rider ([docs](https://blog.jetbrains.com/dotnet/2020/10/29/build-serverless-apps-with-azure-functions/)) have templates for that. Here's the code I'm using for the Function:

```csharp
[Function("MyCoolFunction")]
public IActionResult Run([HttpTrigger(AuthorizationLevel.Anonymous, "get")] HttpRequest req)
{
    _logger.LogInformation("Function called!");
    return new OkObjectResult("Function succeeded!");
}
```

Also, I'm just using the default host.json file the template created, but if you want to check it, you can view the GitHub repo at the bottom of the post.

## Updating infrastructure for the Function

Now that we have an actual app, let's make the changes to the infrastructure to create an Azure Function. In our Pulumi project, put the following resources below the `AppServicePlan`.

```csharp
// Create a new blob container and blob to hold the ZIP file of the packaged app for the Azure Function
var blobContainer = new BlobContainer("function-zip-container", new BlobContainerArgs
{
    ResourceGroupName = resourceGroup.Name,
    AccountName = storageAccount.Name,
    PublicAccess = PublicAccess.None
});

var blob = new Blob("functionZipBlob", new BlobArgs
{
    ResourceGroupName = resourceGroup.Name,
    AccountName = storageAccount.Name,
    ContainerName = blobContainer.Name,
    Type = BlobType.Block,
    Source = new FileArchive("../PulumiCSharp.ConsoleApp/publish") // This will create a .zip for us from the folder
});

// Get the signed URL for the blob by calling ListStorageAccountServiceSAS on Azure
var sasToken = ListStorageAccountServiceSAS.Invoke(new ListStorageAccountServiceSASInvokeArgs
{
    ResourceGroupName = resourceGroup.Name,
    AccountName = storageAccount.Name,
    Protocols = HttpProtocol.Https,
    SharedAccessStartTime = "2022-01-01",
    SharedAccessExpiryTime = "2030-01-01",
    Resource = SignedResource.C, // Container
    Permissions = Permissions.R, // Read
    CanonicalizedResource = Output.Format($"/blob/{storageAccount.Name}/{blobContainer.Name}")
}).Apply(result => result.ServiceSasToken);

var codeBlobUrl = Output.Format($"https://{storageAccount.Name}.blob.core.windows.net/{blobContainer.Name}/{blob.Name}?{sasToken}");

// Create an Azure workspace and Application Insights inside of it
var workspace = new Workspace("workspace", new()
{
    ResourceGroupName = resourceGroup.Name,
    RetentionInDays = 30,
    Sku = new WorkspaceSkuArgs { Name = "PerGB2018", },
    Features = new WorkspaceFeaturesArgs { EnableDataExport = true }
});

var appInsights = new Component("appInsights", new()
{
    ResourceGroupName = resourceGroup.Name,
    ApplicationType = "web",
    Kind = "web",
    WorkspaceResourceId = workspace.Id
});

// Use everything above to create the app
var app = new WebApp("my-function-app", new()
{
    ResourceGroupName = resourceGroup.Name,
    ServerFarmId = appServicePlan.Id,
    Kind = "FunctionApp",
    SiteConfig = new SiteConfigArgs
    {
        NetFrameworkVersion = "v8.0",
        LinuxFxVersion = "DOTNET-ISOLATED|8.0",
        DetailedErrorLoggingEnabled = true,
        HttpLoggingEnabled = true,
        AppSettings = new[]
        {
            new NameValuePairArgs { Name = "FUNCTIONS_WORKER_RUNTIME", Value = "dotnet-isolated", },
            new NameValuePairArgs { Name = "FUNCTIONS_EXTENSION_VERSION", Value = "~4", },
            new NameValuePairArgs { Name = "WEBSITE_RUN_FROM_PACKAGE", Value = codeBlobUrl, },
            new NameValuePairArgs { Name = "APPINSIGHTS_INSTRUMENTATIONKEY", Value = appInsights.InstrumentationKey }
        },
        Cors = new CorsSettingsArgs { AllowedOrigins = new[] { "*", }, },
    },
});
```

Also, change the `Dictionary` at the bottom so it now has a new item in it:

```csharp
return new Dictionary<string, object?>
{
    ["primaryStorageKey"] = primaryStorageKey,
    ["apiUrl"] = app.DefaultHostName.Apply(x => $"https://{x}/api/MyCoolFunction") // This one is new!
};
```

## A note about overlapping types

When adding the imports for some of these namespaces, you might notice that the type names overlap between many different namespaces. For instance, just from this screenshot, we can see that there are (ignoring the different versions) at least four different namespaces in `Pulumi.AzureNative` that have a type called `Workspace`.

These kinds of overlaps are common with Pulumi. The important thing to note here is that if you're using any overlapping namespaces, you'll have to specify which one you want.

You can either fully qualify the namespace every time you create an object or alias a namespace. I recommend using aliases, as I feel this ultimately ends up cleaner, but use whichever you feel is best.

## Publishing our new app

Before we run `pulumi up`, we need to do one more thing – we need to run `dotnet publish` on our new app! This will create the artifacts we give to the Azure Function. Navigate to your new app project's directory and run `dotnet publish --output publish`. Notice that this corresponds to the `Source` property on the `Blob` arguments.

After that, run `pulumi up` to push out your new resources. You'll also see the new value from the `Dictionary` in the console:

```bash
Outputs:
    apiUrl           : "https://my-function-app18a7afe6.azurewebsites.net/api/MyCoolFunction"
    primaryStorageKey: [secret]
```

This isn't necessary, but it's an easy way to see the URL so we can trigger our Function, letting us see our logs in Application Insights and verify that everything works.

Go to that URL, and you should see an unstyled web page that says, "Function succeeded!" You can see the logs in Azure by going to your Function App, then selecting Monitoring > Log stream. Load the URL again while the log stream page is open, and you'll see our "Function called!" log. Very cool!

## Explaining the new resources

Although this is a fair bit of new code, we're really only creating a few Azure resources here, and they're all only for one ultimate purpose, which is to create our Function. Altogether, we have:

-   A blob container, which we need to hold a blob, which is the zip archive of our app.
-   The signed URL for reading the blob, which we get by making an API call to Azure in the middle of our Pulumi program with `ListStorageAccountServiceSAS.Invoke()`. This will be used for the `WEBSITE_RUN_FROM_PACKAGE` config on the Function.
-   A `Workspace`, which we need to create an Application Insights component for the Function, so that we can see logs.
-   Finally, the Function itself, referencing values from all of the above. The type name `WebApp` is a little misleading, since this isn't actually a web application. This is a little more obvious if you like at the `Kind` property, which is "FunctionApp".

You may also notice some `Apply()` and `Output` functions around the code. To explain what these are and why they're necessary, let's try replacing one of them with a normal string concatenation.

Try changing this line of code, then run `pulumi up`:

```csharp
// Old
// var codeBlobUrl = Output.Format($"https://{storageAccount.Name}.blob.core.windows.net/{blobContainer.Name}/{blob.Name}?{sasToken}");

// New
var codeBlobUrl = $"https://{storageAccount.Name}.blob.core.windows.net/{blobContainer.Name}/{blob.Name}?{sasToken}";
```

You'll see this warning (several times):

```bash
warning: Calling [ToString] on an [Output<T>] is not supported.
To get the value of an Output<T> as an Output<string> consider:
1. o.Apply(v => $"prefix{v}suffix")
2. Output.Format($"prefix{hostname}suffix");
```

As well as an error when the run fails:

```bash
error: update failed
azure-native:web:WebApp (my-function-app):
    error: Status=400 Message="{"Code":"BadRequest","Message":"The parameter WEBSITE_RUN_FROM_PACKAGE has an invalid value."...
```

So, why did it fail? Even the C# compiler is fine with our string concatenation!

## Inputs and outputs

The reason has to do with inputs and outputs in Pulumi. Inputs and outputs are similar in concept to async in C#, in that they represent values that _will_ be present, but we don't know what they are _ahead of time_.

Consider the resource group we create at the very beginning of this program. We pass that resource group's name into many other resources. However, we don't actually know what that name will be at build time, because the resource group may not actually exist yet. This is why, if you look at what type `resourceGroup.Name` is, you'll see it's not a `string`, but an `Output<string>`.

So, outputs represent values that will be known at some point in deployment time, but not at build time. They're values that are returned by the cloud provider API. Inputs are merely values that can be assigned to either an output or just a normal type. If you look at the types of any of the arguments on any of the resources, you'll see that they're all `Input`s.

Since we may still have situations where we want to transform our outputs in some way, Pulumi provides the `Apply()` function, as well as a number of static methods on `Output`. Here are some common ones:

-   `Apply()` – Access a single output value. This is used in our code on `ListStorageAccountServiceSAS.Invoke()`, which returns an `Output`, to get the SAS token.
-   `Output.All()` – Access multiple output values
-   `Output.Format()` – Rather than having to parse everything in an `Output.All()`, this is a lot cleaner if you want simple string concatenation, like we did for the code blob URL.

It's almost important to note that **you can't convert an `Output<T>` into its underlying `T` type**. So, when we try to treat the `Output<string>` as a `string`, Pulumi fails. Ultimately, you can see that `WEBSITE_RUN_FROM_PACKAGE`'s value ends up as null. The compiler doesn't throw a warning because every type in C# has a `ToString()` method – which unfortunately is a little misleading in this case.

## Automating the publish with commands

We had to run a `dotnet publish` to put our code into a zip archive. However, it's pretty annoying to have to manually publish your project before every single deployment so that the blob will get the new code. It's also easy to forget to do, which would result in waiting on our deployment only to eventually push out what was already there.

We can solve this using the [Pulumi.Command](https://www.pulumi.com/registry/packages/command/) package. Like the name implies, this package allows us to run command line commands at deployment time!

There are two main ways to execute commands with this package:

-   Using `Run.Invoke()`. This is the simpler method, and the one we'll be using. It executes during the preview step.
-   Creating a command using `new Command()`. This executes during the deployment step. With this method, the command counts as an actual resource inside Pulumi and also allows you to hook into creation, update, and delete lifecycle events to run different commands for each one if needed.

You can do more with this package than the simple use case we have here (eg. execute an Azure Function right after it's created or clean up a Kubernetes cluster on deletion) so I encourage you to take a quick look at the docs for this package to get an idea of what's possible.

Add the Pulumi.Command package to your infrastructure project, then add the code below after the `BlobContainer` creation:

```csharp
var publishCommand = Run.Invoke(new()
{
    Command = "dotnet publish --output publish",
    Dir = Path.GetFullPath(Path.Combine("..", "PulumiCSharp.ConsoleApp")),
    Environment = new Dictionary<string, string>
    {
        ["DOTNET_CLI_TELEMETRY_OPTOUT"] = "1"
    }
});
```

Giving the command an output location instead of using the default location of `[project_file_folder]/bin/[configuration]/[framework]/publish` keeps our publish command from breaking when we upgrade the .NET version of the app (since the publish path would change per framework).

Also, the environment variable is optional, but may be desired. By default, [Microsoft collects usage data about how you use the .NET CLI](https://learn.microsoft.com/en-us/dotnet/core/tools/telemetry?wt.mc_id=MVP_367508), and setting `DOTNET_CLI_TELEMETRY_OPTOUT` to 1 opts out of that.

> **Checking publish command arguments**
>
> It's worth double checking if you should set [any of the flags for dotnet publish](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-publish?wt.mc_id=MVP_367508), especially if you're running something before .NET 8.
>
> For instance, the `--configuration` flag's default value is Release for 8 and later, but Debug for before 8. The `--self-contained` flag may also be useful depending on the environment you're deploying to, since it packages the .NET runtime with the app, making it so the environment doesn't need it. In our case, our Function does come with .NET 8, so we don't need this.

Run `pulumi up` again. Once it's finished, you'll have a Function App using code that was published automatically inside Pulumi!

## Seeing command output

One last thing – you might notice that we didn't get any output for the command. You will see any errors that happen, but if you want to also see the normal output, you can access it like so, putting this right after the command:

```csharp
publishCommand.Apply(x =>
{
    Console.WriteLine(x.Stdout);
    return x; // We don't care about this, but Apply<T>() forces you to return a T
});
```

Now, when you run `pulumi preview` or `pulumi up`, you'll see the output for the command. Note that, since we're using `Run.Invoke()`, we see the logs during the preview step before changes are actually deployed.

## Summary

This post was a bit longer than previous. To summarize:

-   We created a new C# project, then the Azure resources required to create an Azure Function that runs the code in the new project.
-   We went over inputs and outputs in Pulumi. Outputs are values that won't be known until the cloud provider API returns them at runtime, and so need to be accessed a bit differently than normal values. Inputs are just properties on resources that configure them, such as `ResourceGroupName`. `Input<T>` means that the variable can be assigned a value of either `T` or `Output<T>`.
-   We automated the running of dotnet publish, so that we could have a consistent and reliable deployment.

## Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/PulumiCSharp
