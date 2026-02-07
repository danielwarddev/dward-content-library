# Introduction to Azure App Service

## Introduction

Your company is considering moving their web apps to the cloud and you're asked to evaluate Azure App Service.

### Learning objectives

After completing this module, you'll be able to:

- Describe Azure App Service key components and value.
- Explain how Azure App Service manages authentication and authorization.
- Identify methods to control inbound and outbound traffic to your web app.
- Deploy a containerized app to App Service.

## Examine Azure App Service

Azure App Service is a fully managed platform designed to simplify the deployment and scaling of web apps, mobile back ends, and RESTful APIs. It abstracts away infrastructure management, letting you focus on writing code and shipping features faster.

You can build using your preferred stack—whether it's .NET, Java (Java SE, Tomcat, JBoss), Node.js, Python, or PHP—and deploy to either Windows or Linux environments. If you're working with containers, App Service also supports custom container deployments, giving you full control over your runtime.

### Built-in auto scale support

The ability to scale up/down or scale out/in is baked into the Azure App Service. Depending on the usage of the web app, you can scale the resources of the underlying machine that is hosting your web app up/down. Resources include the number of cores or the amount of RAM available. Scaling out/in is the ability to increase, or decrease, the number of machine instances that are running your web app.

### Container support

With Azure App Service, you can deploy and run containerized web apps on Windows and Linux. You can pull container images from a private Azure Container Registry or Docker Hub. Azure App Service also supports multi-container apps, Windows containers, and Docker Compose for orchestrating container instances.

### Continuous integration/deployment support

The Azure portal provides out-of-the-box continuous integration and deployment with Azure DevOps Services, GitHub, Bitbucket, FTP, or a local Git repository on your development machine. Connect your web app with any of the above sources and App Service can automatically sync your code and apply changes as they're pushed to the connected repository. Continuous integration and deployment for containerized web apps is also supported using either Azure Container Registry or Docker Hub.

### Deployment slots

When deploying a web app, you can use a separate deployment slot instead of the default production slot when you're running in the Standard App Service pricing tier or better. Deployment slots are live apps with their own host names. App content and configurations elements can be swapped between two deployment slots, including the production slot.

### App Service on Linux

App Service can also host web apps natively on Linux for supported application stacks. It can also run custom Linux containers (also known as _Web App for Containers_). App Service on Linux supports many language specific built-in images. Just deploy your code. Supported languages and frameworks include: .NET Core, Java (Tomcat, JBoss EAP, or Java SE with an embedded web server), Node.js, Python, and PHP. If the runtime your application requires isn't supported in the built-in images, you can deploy it with a custom container.

The languages, and their supported versions, are updated regularly. You can retrieve the current list by using the following command in the Cloud Shell.

```bash
az webapp list-runtimes --os-type linux
```

#### Limitations

App Service on Linux does have some limitations:

- App Service on Linux isn't supported on Shared pricing tier.
- The Azure portal shows only features that currently work for Linux apps. As features are enabled, they're activated on the portal.
- When deployed to built-in images, your code and content are allocated as a storage volume for web content, backed by Azure Storage. The disk latency of this volume is higher and more variable than the latency of the container filesystem. Apps that require heavy read-only access to content files might benefit from the custom container option, which places files in the container filesystem instead of on the content volume.

### App Service Environment

App Service Environment is an Azure App Service feature that provides a fully isolated and dedicated environment for running App Service apps. It offers improved security at high scale.

Unlike the App Service offering, where supporting infrastructure is shared, with App Service Environment, compute is dedicated to a single customer. For more information on the differences between App Service Environment and App Service, see the [comparison](https://learn.microsoft.com/en-us/azure/app-service/environment/ase-multi-tenant-comparison).

## Examine Azure App Service plans

In App Service, an app always runs in an _App Service plan_. An App Service plan defines a set of compute resources for a web app to run. One or more apps can be configured to run on the same computing resources (or in the same App Service plan).

When you create an App Service plan in a certain region (for example, West Europe), a set of compute resources is created for that plan in that region. Whatever apps you put into this App Service plan run on these compute resources as defined by your App Service plan. Each App Service plan defines:

- Operating System (Windows, Linux)
- Region (West US, East US, etc.)
- Number of VM instances
- Size of VM instances (for example, P1v3, P2v3, based on pricing tier)
- Pricing tier (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, IsolatedV2)

The _pricing tier_ of an App Service plan determines what App Service features you get and how much you pay for the plan. There are a few categories of pricing tiers:

- **Shared compute**: **Free** and **Shared**, the two base tiers, runs an app on the same Azure VM as other App Service apps, including apps of other customers. These tiers allocate CPU quotas to each app that runs on the shared resources, and the resources can't scale out.
- **Dedicated compute**: The **Basic**, **Standard**, **Premium**, **PremiumV2**, and **PremiumV3** tiers run apps on dedicated Azure VMs. Only apps in the same App Service plans share the same compute resources. The higher the tier, the more VM instances are available to you for scale-out.
- **Isolated**: The **Isolated** and **IsolatedV2** tiers run dedicated Azure VMs on dedicated Azure Virtual Networks. It provides network isolation on top of compute isolation to your apps. It provides the maximum scale-out capabilities.

> **Note:** App Service Free and Shared hosting plans are base tiers that run on the same Azure virtual machines as other App Service apps. Some apps might belong to other customers. These tiers are intended to be used only for development and testing purposes.

### How does my app run and scale?

In the **Free** and **Shared** tiers, an app receives CPU minutes on a shared VM instance and can't scale out. In other tiers, an app runs and scales as follows:

- An app runs on all the VM instances configured in the App Service plan.
- If multiple apps are in the same App Service plan, they all share the same VM instances.
- If you have multiple deployment slots for an app, all deployment slots also run on the same VM instances.
- If you enable diagnostic logs, perform backups, or run WebJobs, they also use CPU cycles and memory on these VM instances.

In this way, the App Service plan is the **scale unit** of the App Service apps. If the plan is configured to run five VM instances, then all apps in the plan run on all five instances. If the plan is configured for autoscaling, then all apps in the plan are scaled out together based on the autoscale settings.

### What if my app needs more capabilities or features?

Your App Service plan can be scaled up and down at any time. It's as simple as changing the pricing tier of the plan. If your app is in the same App Service plan with other apps, you might want to improve the app's performance by isolating the compute resources. You can do it by moving the app into a separate App Service plan.

You can potentially save money by putting multiple apps into one App Service plan. However, since apps in the same App Service plan all share the same compute resources you need to understand the capacity of the existing App Service plan and the expected load for the new app.

Isolate your app into a new App Service plan when:

- The app is resource-intensive.
- You want to scale the app independently from the other apps in the existing plan.
- The app needs resources in a different geographical region.

This approach gives you a dedicated resource pool and greater control over your app's performance and scaling.

## Deploy to App Service

Every development team has unique requirements that can make implementing an efficient deployment pipeline difficult on any cloud service. App Service supports both automated and manual deployment.

### Automated deployment

Automated deployment, or continuous deployment, is a process used to push out new features and bug fixes in a fast and repetitive pattern with minimal effect on end users.

Azure App Service supports automated deployment from several source control systems as part of a continuous integration and deployment (CI/CD) pipeline. The following options are available:

- **Azure DevOps Services**: You can push your code to Azure DevOps Services, build your code in the cloud, run the tests, generate a release from the code, and finally, push your code to an Azure Web App.
- **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub are automatically deployed for you.
- **Bitbucket**: Bitbucket is supported, though GitHub and Azure DevOps are more commonly used and better integrated.

### Manual deployment

There are a few options that you can use to manually push your code to Azure:

- **Git**: App Service web apps feature a Git URL that you can add as a remote repository. Pushing to the remote repository deploys your app.
- **CLI**: The `az webapp up` is a feature of the `az` command-line interface that packages your app and deploys it. Unlike other deployment methods, `az webapp up` can create a new App Service web app for you.
- **Zip deploy**: Use `curl` or a similar HTTP utility to send a ZIP of your application files to App Service.
- **FTP/S**: FTP or FTPS is a traditional way of pushing your code to many hosting environments, including App Service.

> **Note:** App Service uses Kudu for Git and zip-based deployments. Kudu handles file syncing and deployment triggers.

### Use deployment slots

Whenever possible, use deployment slots when deploying a new production build. When using a Standard App Service Plan tier or better, you can deploy your app to a staging environment and then swap your staging and production slots. The swap operation warms up the necessary worker instances to match your production scale, thus eliminating downtime.

#### Continuously deploy code

If your project designates branches for testing, QA, and staging, then each of those branches should be continuously deployed to a staging slot. This allows your stakeholders to easily access and test the deployed branch.

#### Continuously deploy containers

For custom containers from Azure Container Registry or other container registries, deploy the image into a staging slot and swap into production to prevent downtime. The automation is more complex than code deployment because you must push the image to a container registry and update the image tag on the webapp.

- **Build and tag the image**: As part of the build pipeline, tag the image with the git commit ID, timestamp, or other identifiable information. It's best not to use the default "latest" tag. Otherwise, it's difficult to trace back what code is currently deployed, which makes debugging far more difficult.
- **Push the tagged image**: Once the image is built and tagged, the pipeline pushes the image to your container registry. In the next step, the deployment slot will pull the tagged image from the container registry.
- **Update the deployment slot with the new image tag**: When this property is updated, the site automatically restarts and pulls the new container image.

### Sidecar containers

In Azure App Service, you can add up to nine sidecar containers for each sidecar-enabled custom container app. Sidecar containers are supported for Linux-based custom container apps and enable deploying extra services and features without making them tightly coupled to your main application container. For example, you can add monitoring, logging, configuration, and networking services as sidecar containers.

You can add a sidecar container through the **Deployment Center** in the app's management page.

## Explore authentication and authorization in App Service

Azure App Service provides built-in authentication and authorization support. You can sign in users and access data by writing minimal or no code in your web app, RESTful API, mobile back end, or Azure Functions.

### Why use the built-in authentication?

You're not required to use App Service for authentication and authorization. Many web frameworks are bundled with security features, and you can use them if you like. If you need more flexibility than App Service provides, you can also write your own utilities.

The built-in authentication feature for App Service and Azure Functions can save you time and effort by providing out-of-the-box authentication with federated identity providers, allowing you to focus on the rest of your application.

- Azure App Service allows you to integrate various auth capabilities into your web app or API without implementing them yourself.
- Auth is built directly into the platform and doesn't require any particular language, SDK, security expertise, or code.
- You can integrate with multiple login providers. For example, Microsoft Entra ID, Facebook, Google, X.

### Identity providers

App Service uses federated identity, in which a third-party identity provider manages the user identities and authentication flow for you. The following identity providers are available by default:

| Provider                    | Sign-in endpoint              | How-To guidance                                                                                                                                |
| --------------------------- | ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Microsoft Entra             | `/.auth/login/aad`            | [App Service Microsoft Entra platform login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-aad)        |
| Facebook                    | `/.auth/login/facebook`       | [App Service Facebook login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-facebook)                   |
| Google                      | `/.auth/login/google`         | [App Service Google login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-google)                       |
| X                           | `/.auth/login/x`              | [App Service X login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-twitter)                           |
| Any OpenID Connect provider | `/.auth/login/<providerName>` | [App Service OpenID Connect login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-openid-connect)       |
| GitHub                      | `/.auth/login/github`         | [App Service GitHub login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-github)                       |
| Apple                       | `/.auth/login/apple`          | [App Service sign-in via Apple sign-in (preview)](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-apple) |

When you configure this feature with one of these providers, its sign-in endpoint is available for user authentication and for validation of authentication tokens from the provider. You can provide your users with any number of these sign-in options.

### How it works

The authentication and authorization middleware component is a feature of the platform that runs on the same VM as your application. When enabled, every incoming HTTP request passes through it before being handled by your application.

The platform middleware handles several things for your app:

- Authenticates users and clients with the specified identity provider
- Validates, stores, and refreshes OAuth tokens issued by the configured identity provider
- Manages the authenticated session
- Injects identity information into HTTP request headers

The module runs separately from your application code and can be configured using Azure Resource Manager settings or using a configuration file. No SDKs, specific programming languages, or changes to your application code are required.

> **Note:** In Linux and containers the authentication and authorization module runs in a separate container, isolated from your application code. Because it doesn't run in-process, no direct integration with specific language frameworks is possible.

#### Authentication flow

The authentication flow is the same for all providers, but differs depending on whether you want to sign in with the provider's SDK.

- **Without provider SDK**: The application delegates federated sign-in to App Service. This delegation is typically the case with browser apps, which can present the provider's login page to the user. The server code manages the sign-in process and is referred to as _server-directed flow_ or _server flow_.
- **With provider SDK**: The application signs users in to the provider manually and then submits the authentication token to App Service for validation. This is typically the case with browser-less apps, which can't present the provider's sign-in page to the user. The application code manages the sign-in process and is referred to as _client-directed flow_ or _client flow_. This applies to REST APIs, Azure Functions, JavaScript browser clients, and native mobile apps that sign users in using the provider's SDK.

The following table shows the steps of the authentication flow.

| Step                            | Without provider SDK                                                                             | With provider SDK                                                                                                                               |
| ------------------------------- | ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Sign user in                    | Redirects client to `/.auth/login/<provider>`.                                                   | Client code signs user in directly with provider's SDK and receives an authentication token. For information, see the provider's documentation. |
| Post-authentication             | Provider redirects client to `/.auth/login/<provider>/callback`.                                 | Client code posts token from provider to `/.auth/login/<provider>` for validation.                                                              |
| Establish authenticated session | App Service adds authenticated cookie to response.                                               | App Service returns its own authentication token to client code.                                                                                |
| Serve authenticated content     | Client includes authentication cookie in subsequent requests (automatically handled by browser). | Client code presents authentication token in `X-ZUMO-AUTH` header (automatically handled by Mobile Apps client SDKs).                           |

For client browsers, App Service can automatically direct all unauthenticated users to `/.auth/login/<provider>`. You can also present users with one or more `/.auth/login/<provider>` links to sign in to your app using their provider of choice.

#### Authorization behavior

In the Azure portal, you can configure App Service with many behaviors when an incoming request isn't authenticated.

- **Allow unauthenticated requests:** This option defers authorization of unauthenticated traffic to your application code. For authenticated requests, App Service also passes along authentication information in the HTTP headers. This option provides more flexibility in handling anonymous requests. It lets you present multiple sign-in providers to your users.
- **Require authentication:** This option rejects any unauthenticated traffic to your application. This rejection can be a redirect action to one of the configured identity providers. In these cases, a browser client is redirected to `/.auth/login/<provider>` for the provider you choose. If the anonymous request comes from a native mobile app, the returned response is an `HTTP 401 Unauthorized`. You can also configure the rejection to be an `HTTP 401 Unauthorized` or `HTTP 403 Forbidden` for all requests.

> **Caution:** Restricting access in this way applies to all calls to your app, which may not be desirable for apps wanting a publicly available home page, as in many single-page applications.

#### Token store

App Service provides a built-in token store, which is a repository of tokens that are associated with the users of your web apps, APIs, or native mobile apps. When you enable authentication with any provider, this token store is immediately available to your app.

> **Note:** The token store is only available when using the built-in authentication feature, and tokens can be accessed via environment variables or HTTP headers.

#### Logging and tracing

If you enable application logging, authentication and authorization traces are collected directly in your log files. If you see an authentication error that you didn't expect, you can conveniently find all the details by looking in your existing application logs.

## Discover App Service networking features

By default, apps hosted in App Service are accessible directly through the internet and can reach internet-hosted endpoints. For many applications, you need to control the inbound and outbound network traffic.

There are two main deployment types for Azure App Service:

- The multitenant public service hosts App Service plans in the Free, Shared, Basic, Standard, Premium, PremiumV2, and PremiumV3 pricing SKUs.
- The single-tenant App Service Environment (ASE) hosts Isolated SKU App Service plans directly in your Azure virtual network.

### Multitenant App Service networking features

Azure App Service is a distributed system. The roles that handle incoming HTTP or HTTPS requests are called _front ends_. The roles that host the customer workload are called _workers_. All the roles in an App Service deployment exist in a multitenant network. Because there are many different customers in the same App Service scale unit, you can't connect the App Service network directly to your network.

Instead of directly connecting the networks, App Service provides networking features for different aspects of application communication. Inbound features control traffic coming to your app, and outbound features govern connections your app makes to external endpoints. Use inbound features to solve inbound problems and outbound features to solve outbound problems.

| Inbound features     | Outbound features                            |
| -------------------- | -------------------------------------------- |
| App-assigned address | Hybrid Connections                           |
| Access restrictions  | Gateway-required virtual network integration |
| Service endpoints    | Virtual network integration                  |
| Private endpoints    |                                              |

You can mix the features to solve your problems with a few exceptions. The following inbound use cases are examples of how to use App Service networking features to control traffic inbound to your app.

| Inbound use case                                                 | Feature              |
| ---------------------------------------------------------------- | -------------------- |
| Support IP-based SSL needs for your app                          | App-assigned address |
| Support unshared dedicated inbound address for your app          | App-assigned address |
| Restrict access to your app from a set of well-defined addresses | Access restrictions  |

### Default networking behavior

Azure App Service scale units support many customers in each deployment. The Free and Shared SKU plans host customer workloads on multitenant workers. The Basic and higher plans host customer workloads that are dedicated to only one App Service plan. If you have a Standard App Service plan, all the apps in that plan run on the same worker. If you scale out the worker, all the apps in that App Service plan are replicated on a new worker for each instance in your App Service plan.

#### Outbound addresses

The worker virtual machines are broken down in large part by the App Service plans. The Free, Shared, Basic, Standard, and Premium plans all use the same worker virtual machine type. The PremiumV2 plan uses another virtual machine type. PremiumV3 uses yet another virtual machine type. When you change the virtual machine family, you get a different set of outbound addresses.

There are many addresses that are used for outbound calls. The outbound addresses used by your app for making outbound calls are listed in the properties for your app. These addresses are shared by all the apps running on the same worker virtual machine family in the App Service deployment. If you want to see all the addresses that your app might use in a scale unit, there's a property called `possibleOutboundIpAddresses` that lists them.

#### Find outbound IPs

To find the outbound IP addresses currently used by your app in the Azure portal, select **Properties** in your app's left-hand navigation.

You can find the same information by running the following Azure CLI command in the Cloud Shell. They're listed in the **Additional Outbound IP Addresses** field.

```bash
az webapp show \
    --resource-group <group_name> \
    --name <app_name> \
    --query outboundIpAddresses \
    --output tsv
```

To find all possible outbound IP addresses for your app, regardless of pricing tiers, run the following command in the Cloud Shell.

```bash
az webapp show \
    --resource-group <group_name> \
    --name <app_name> \
    --query possibleOutboundIpAddresses \
    --output tsv
```

## Exercise: Deploy a containerized app to Azure App Service

> **Lab exercise**: This unit contains a hands-on exercise where you deploy a containerized app to Azure App Service. The exercise requires an Azure subscription and walks you through creating an Azure App Service resource, deploying a containerized app, viewing the results, and cleaning up resources. Visit the module on Microsoft Learn to complete this exercise.

## Summary

In this module, you learned how to:

- Describe Azure App Service key components and value.
- Explain how Azure App Service manages authentication and authorization.
- Identify methods to control inbound and outbound traffic to your web app.
- Deploy a containerized app to App Service.
