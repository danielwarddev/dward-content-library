# Using Central Package Management with .NET solutions

**Date:** February 19, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/using-central-package-management-with-net-solutions/

### Overview

If you've ever had a large .NET solution with lots of project inside of it and struggled to reconcile different package versions (or worse, different behavior due to the versions!) of the same package between the projects, Central Package Management is for you. You'll be able to keep your common packages across projects in a centralized place, all with one version shared between them.

### Benefits of Central Package Management (CPM)

Managing package versions is typically not a problem for smaller .NET solutions, in my experience. However, when a .NET solution gets enough projects (I've heard of some being in the hundreds – what are you people doing?), you'll inevitably get common packages used in them, and mismatched versions between them can cause headaches. Perhaps the way a method worked was tweaked in one version to the next, so some projects get slightly different functionality without you knowing. Or, a new method might be missing entirely, which can be confusing if it shows up in one project but not another.

### Requirements

In order to use CPM, you must be using:

-   Nuget 6.2.0 or later
-   .NET SDK 6.0.300 or later
-   If using Visual Studio, Visual Studio 2022 17.2 or later
-   If using JetBrains Rider, Rider 2022.3 or later

Older tooling will ignore any CPM configuration.

### Adding CPM to an existing or new solution

To add CPM to any project, create a `Directory.Packages.props` file at the root of your solution. Set a property called `ManagePackageVersionsCentrally` inside of it to true and add packages to it like so:

```xml
<Project>
  <PropertyGroup>
    <ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
  </PropertyGroup>
  <ItemGroup>
    <PackageVersion Include="Serilog" Version="3.1.1" />
  </ItemGroup>
</Project>
```

That's it!

If you like, you can also get more granular with this configuration. You can actually have multiple `Directory.Packages.props` files in your solution, and each project will use the one that is closest to it. So, for example, if your repository had multiple solutions in it, you could have a `Directory.Packages.props` file at the root of your repository, then another one for each solution. If you ask me, that's more trouble that it's worth, but I'm sure someone out there has a use case for that.

❗ If you're adding CPM to an existing project that already has packages in it, you might see a bunch of errors and warnings on build – notably, [NU1008](https://learn.microsoft.com/en-us/nuget/reference/errors-and-warnings/nu1008) and [NU1507](https://learn.microsoft.com/en-us/nuget/reference/errors-and-warnings/nu1507):

> NU1008: Projects that use central package version management should not define the version on the PackageReference items but on the PackageVersion items: PackageId.

> NU1507: There are 2 package sources defined in your configuration. When using central package management, please map your package sources with package source mapping (https://aka.ms/nuget-package-source-mapping) or specify a single package source. The following sources are defined: https://api.nuget.org/v3/index.json, https://contoso.myget.org/F/development/.

### Fixing NU1008

NU1008 is telling you to specify package versions in your `Directory.Packages.props` file in a `PackageReference` property, rather than inside your .csproj files. For instance, this means that in your .csproj file, this line would change as follows:

```xml
<!-- Old -->
<PackageReference Include="Serilog" Version="3.1.1" />

<!-- New -->
<PackageReference Include="Serilog" />
```

Notice how the version is no longer specified at the project level. You then add it to your `Directory.Packages.props` file with the following:

```xml
<PackageVersion Include="Serilog" Version="3.1.1" />
```

Once you update all your package versions to do this, NU1008 will be fixed.

### Fixing NU1507

You'll see NU1507 if you have more than one package source. This is an effort from Microsoft to try and push people to use [package source mapping](https://learn.microsoft.com/en-us/nuget/consume-packages/package-source-mapping), as it's more secure, since it only allows packages to come from specified sources.

You have 3 options here, as detailed in this [thread on Github](https://github.com/dotnet/sdk/issues/25379#issuecomment-1142552846):

-   Use only a single feed instead of multiple
-   Use package source mapping
-   Suppress the warning

If you opt to suppress the warning, you can do that by adding a `NoWarn` property to your `Directory.Packages.props` file:

```xml
<Project>
  <PropertyGroup>
    <ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
    <NoWarn>NU1507</NoWarn>
  </PropertyGroup>
</Project>
```

### Making exceptions for specific packages

Sometimes, even if you have a centralized package, you might want to have a different version of it in one of your projects. In that case, in the .csproj file, you can set `VersionOverride` on the `PackageReference` property like so:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Serilog" VersionOverride="3.1.0" />
  </ItemGroup>
</Project>
```

Alternatively, you can exclude a specific project from CPM entirely by setting `ManagePackageVersionsCentrally` to false in the .csproj file:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <ManagePackageVersionsCentrally>false</ManagePackageVersionsCentrally>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Serilog" Version="3.1.0" />
  </ItemGroup>
</Project>
```

### One step further: using global packages

If you have packages that are used in every project in your solution (or almost every project), you can opt to make them global packages. Doing so allows you to remove their reference from your .csproj files completely, and they'll still be included in those projects. As an example, to make this package global, you would change this line in your `Directory.Packages.props` file as follows:

```xml
<!-- Old -->
<PackageVersion Include="Serilog" Version="3.1.1" />

<!-- New -->
<GlobalPackageReference Include="Serilog" Version="3.1.1" />
```

In this example, Serilog 3.1.1 will now be implicitly included in all projects in the solution without being included in the .csproj files.

### Workaround for using hierarchical Directory.Packages.props

There is a non-obvious gotcha when using Directory.Package.props, which does have a workaround.

Global packages [are intentionally not included as compile-time assembly references](https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management#global-package-references?wt.mc_id=MVP_367508), because they are often packages that don't need to be included with your shipped application, such as [Nerdbank.Gitversioning](https://github.com/dotnet/Nerdbank.GitVersioning).

That makes sense, but it also means that **using `GlobalPackageReference` will not work in any Directory.Packages.props file except the root one**.

As a workaround, as detailed [in this GitHub issue](https://github.com/xunit/xunit/issues/3128), you can use a Directory.Build.props and a Directory.Packages.props in the nested folder to add the non-global package reference.

Here's an example, using the same packages from that GitHub issue. Thanks to [Brad Wilson](https://bradwilson.dev/) for originally offering this solution on that issue:

```xml
<!-- Directory.Build.props -->
<Project>
  <ItemGroup>
    <PackageReference Include="Microsoft.NET.Test.Sdk" />
    <PackageReference Include="xunit.v3" />
    <PackageReference Include="xunit.runner.visualstudio" />
  </ItemGroup>
</Project>

<!-- Directory.Packages.props -->
<Project>
  <ItemGroup>
    <!-- PackageVersion, not GlobalPackageReference! -->
    <PackageVersion Include="Microsoft.NET.Test.Sdk" Version="17.12.0" />
    <PackageVersion Include="xunit.v3" Version="1.0.1" />
    <PackageVersion Include="xunit.runner.visualstudio" Version="3.0.1" />
  </ItemGroup>
</Project>
```

### Summary

That's it! This post went over the following:

-   Benefits of Central Package Management (CPM)
-   How to add CPM to a new or existing project
-   How to fix NU1008 and NU1507
-   How to exclude certain packages or projects from CPM
-   How to make packages global
-   Workaround for non-root Directory.Packages.props
