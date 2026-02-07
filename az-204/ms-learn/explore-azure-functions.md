# Explore Azure Functions

## Introduction

Azure Functions lets you develop serverless applications on Microsoft Azure. You can write just the code you need for the problem at hand, without worrying about a whole application or the infrastructure to run it.

After completing this module, you'll be able to:

- Explain functional differences between Azure Functions, Azure Logic Apps, and WebJobs
- Describe Azure Functions hosting plan options
- Describe how Azure Functions scale to meet business needs

## Discover Azure Functions

Azure Functions is a serverless solution that allows you to write less code, maintain less infrastructure, and save on costs. Instead of worrying about deploying and maintaining servers, the cloud infrastructure provides all the up-to-date resources needed to keep your applications running.

We often build systems to react to a series of critical events. Whether you're building a web API, responding to database changes, processing IoT data streams, or even managing message queues - every application needs a way to run some code as these events occur.

Azure Functions supports _triggers_, which are ways to start execution of your code, and _bindings_, which are ways to simplify coding for input and output data. There are other integration and automation services in Azure and they all can solve integration problems and automate business processes. They can all define input, actions, conditions, and output.

### Compare Azure Functions and Azure Logic Apps

Both Functions and Logic Apps are Azure Services that enable serverless workloads. Azure Functions is a serverless compute service, whereas Azure Logic Apps is a serverless workflow integration platform. Both can create complex _orchestrations_. An orchestration is a collection of functions or steps, called actions in Logic Apps, that are executed to accomplish a complex task.

For Azure Functions, you develop orchestrations by writing code and using the Durable Functions extension. For Logic Apps, you create orchestrations by using a GUI or editing configuration files.

The following table lists some of the key differences between Functions and Logic Apps:

| Topic                 | Azure Functions                                                       | Logic Apps                                                                                             |
| --------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| **Development**       | Code-first (imperative)                                               | Designer-first (declarative)                                                                           |
| **Connectivity**      | About a dozen built-in binding types, write code for custom bindings  | Large collection of connectors, Enterprise Integration Pack for B2B scenarios, build custom connectors |
| **Actions**           | Each activity is an Azure function; write code for activity functions | Large collection of ready-made actions                                                                 |
| **Monitoring**        | Azure Application Insights                                            | Azure portal, Azure Monitor logs                                                                       |
| **Management**        | REST API, Visual Studio                                               | Azure portal, REST API, PowerShell, Visual Studio                                                      |
| **Execution context** | Runs in Azure, or locally                                             | Runs in Azure, locally, or on premises                                                                 |

### Compare Functions and WebJobs

Like Azure Functions, Azure App Service WebJobs with the WebJobs SDK is a code-first integration service that is designed for developers. Both are built on Azure App Service and support features such as source control integration, authentication, and monitoring with Application Insights integration.

Azure Functions is built on the WebJobs SDK, so it shares many of the same event triggers and connections to other Azure services. Here are some factors to consider when you're choosing between Azure Functions and WebJobs with the WebJobs SDK:

| Factor                                          | Functions                                                                                                                                                     | WebJobs with WebJobs SDK                                                                                                   |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Serverless app model with automatic scaling** | Yes                                                                                                                                                           | No                                                                                                                         |
| **Develop and test in browser**                 | Yes                                                                                                                                                           | No                                                                                                                         |
| **Pay-per-use pricing**                         | Yes                                                                                                                                                           | No                                                                                                                         |
| **Integration with Logic Apps**                 | Yes                                                                                                                                                           | No                                                                                                                         |
| **Trigger events**                              | Timer, Azure Storage queues and blobs, Azure Service Bus queues and topics, Azure Cosmos DB, Azure Event Hubs, HTTP/WebHook (GitHub, Slack), Azure Event Grid | Timer, Azure Storage queues and blobs, Azure Service Bus queues and topics, Azure Cosmos DB, Azure Event Hubs, File system |

Azure Functions offers more developer productivity than Azure App Service WebJobs does. It also offers more options for programming languages, development environments, Azure service integration, and pricing. For most scenarios, it's the best choice.

## Compare Azure Functions hosting options

When you create a function app in Azure, you must choose a hosting plan for your app. Azure provides you with these hosting options for your function code:

| Hosting option            | Service              | Availability             | Container support |
| ------------------------- | -------------------- | ------------------------ | ----------------- |
| **Consumption plan**      | Azure Functions      | Generally available (GA) | None              |
| **Flex Consumption plan** | Azure Functions      | GA                       | None              |
| **Premium plan**          | Azure Functions      | GA                       | Linux             |
| **Dedicated plan**        | Azure Functions      | GA                       | Linux             |
| **Container Apps**        | Azure Container Apps | GA                       | Linux             |

Azure App Service infrastructure facilitates Azure Functions hosting on both Linux and Windows virtual machines. The hosting option you choose dictates the following behaviors:

- How your function app is scaled.
- The resources available to each function app instance.
- Support for advanced functionality, such as Azure Virtual Network connectivity.
- Support for Linux containers.

The plan you choose also impacts the costs for running your function code.

### Overview of plans

Following is a summary of the benefits of the various hosting options:

#### Consumption plan

The Consumption plan is the default hosting plan. Pay for compute resources only when your functions are running (pay-as-you-go) with automatic scale. On the Consumption plan, instances of the Functions host are dynamically added and removed based on the number of incoming events.

#### Flex Consumption plan

Get high scalability with compute choices, virtual networking, and pay-as-you-go billing. On the Flex Consumption plan, instances of the Functions host are dynamically added and removed based on the configured per instance concurrency and the number of incoming events.

You can reduce cold starts by specifying the number of pre-provisioned (always ready) instances. Scales automatically based on demand.

#### Premium plan

Automatically scales based on demand using prewarmed workers, which run applications with no delay after being idle, runs on more powerful instances, and connects to virtual networks.

Consider the Azure Functions Premium plan in the following situations:

- Your function apps run continuously, or nearly continuously.
- You want more control of your instances and want to deploy multiple function apps on the same plan with event-driven scaling.
- You have a high number of small executions and a high execution bill, but low GB seconds in the Consumption plan.
- You need more CPU or memory options than are provided by consumption plans.
- Your code needs to run longer than the maximum execution time allowed on the Consumption plan.
- You require virtual network connectivity.
- You want to provide a custom Linux image in which to run your functions.

#### Dedicated plan

Run your functions within an App Service plan at regular App Service plan rates. Best for long-running scenarios where Durable Functions can't be used.

Consider an App Service plan in the following situations:

- You must have fully predictable billing, or you need to manually scale instances.
- You want to run multiple web apps and function apps on the same plan.
- You need access to larger compute size choices.
- Full compute isolation and secure network access provided by an App Service Environment (ASE).
- High memory usage and high scale (ASE).

#### Container Apps

Create and deploy containerized function apps in a fully managed environment hosted by Azure Container Apps.

Use the Azure Functions programming model to build event-driven, serverless, cloud native function apps. Run your functions alongside other microservices, APIs, websites, and workflows as container-hosted programs.

Consider hosting your functions on Container Apps in the following situations:

- You want to package custom libraries with your function code to support line-of-business apps.
- You need to migrate code execution from on-premises or legacy apps to cloud native microservices running in containers.
- You want to avoid the overhead and complexity of managing Kubernetes clusters and dedicated compute.
- You need the high-end processing power provided by dedicated CPU compute resources for your functions.

### Function app time-out duration

The `functionTimeout` property in the _host.json_ project file specifies the time-out duration for functions in a function app. This property applies specifically to function executions. After the trigger starts function execution, the function needs to return/respond within the time-out duration.

The following table shows the default and maximum values (in minutes) for specific plans:

| Plan                      | Default | Maximum    |
| ------------------------- | ------- | ---------- |
| **Flex Consumption plan** | 30      | Unbounded² |
| **Premium plan**          | 30      | Unbounded² |
| **Dedicated plan**        | 30      | Unbounded³ |
| **Container Apps**        | 30      | Unbounded⁵ |
| **Consumption plan**      | 5       | 10         |

¹ Regardless of the function app time-out setting, 230 seconds is the maximum amount of time that an HTTP triggered function can take to respond to a request. This is because of the default idle time-out of Azure Load Balancer. For longer processing times, consider using the Durable Functions async pattern or defer the actual work and return an immediate response.

² There's no maximum execution time-out duration enforced. However, the grace period given to a function execution is 60 minutes during scale in for the Flex Consumption and Premium plans, and a grace period of 10 minutes is given during platform updates.

³ Requires the App Service plan be set to Always On. A grace period of 10 minutes is given during platform updates.

⁴ The default time-out for version 1.x of the Functions host runtime is _unbounded_.

⁵ When the minimum number of replicas is set to zero, the default time-out depends on the specific triggers used in the app.

## Scale Azure Functions

The following table compares the scaling behaviors of the various hosting plans. Maximum instances are given on a per-function app (Consumption) or per-plan (Premium/Dedicated) basis, unless otherwise indicated.

| Plan                      | Scale out                                                                                                                                                                                                   | Max # instances                                                            |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| **Consumption plan**      | Event driven. Scales out automatically, even during periods of high load. Functions infrastructure scales CPU and memory resources by adding more instances based on the number of incoming trigger events. | **Windows:** 200, **Linux:** 100¹                                          |
| **Flex Consumption plan** | Per-function scaling. Event-driven scaling decisions are calculated on a per-function basis, which provides a more deterministic way of scaling the functions in your app.                                  | Limited only by total memory usage of all instances across a given region. |
| **Premium plan**          | Event driven. Scale out automatically based on the number of events that its functions are triggered on.                                                                                                    | **Windows:** 100, **Linux:** 20-100²                                       |
| **Dedicated plan**³       | Manual/autoscale                                                                                                                                                                                            | 10-30, 100 (ASE)                                                           |
| **Container Apps**        | Event driven. Scale out automatically by adding more instances of the Functions host, based on the number of events that its functions are triggered on.                                                    | 10-300⁴                                                                    |

¹ During scale-out, there's currently a limit of 500 instances per subscription per hour for Linux apps on a Consumption plan.

² In some regions, Linux apps on a Premium plan can scale to 100 instances.

³ For specific limits for the various App Service plan options, see the App Service plan limits.

⁴ On Container Apps, you can set the maximum number of replicas, which is honored as long as there's enough cores quota available.

## Summary

In this module, you learned how to:

- Explain functional differences between Azure Functions, Azure Logic Apps, and WebJobs
- Describe Azure Functions hosting plan options
- Describe how Azure Functions scale to meet business needs
