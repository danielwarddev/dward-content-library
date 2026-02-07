# Publish Container Image to Azure Container Registry

## Introduction

Azure Container Registry (ACR) is a managed, private Docker registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your private Docker container images.

After completing this module, you'll be able to:

- Explain the features and benefits Azure Container Registry offers
- Describe how to use ACR Tasks to automate builds and deployments
- Explain the elements in a Dockerfile
- Build and run an image in the ACR using Azure CLI commands

## Discover the Azure Container Registry

Azure Container Registry (ACR) is a managed registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your container images and related artifacts.

Use the ACR service with your existing container development and deployment pipelines, or use Azure Container Registry Tasks to build container images in Azure. Build on demand, or fully automate builds with triggers such as source code commits and base image updates.

### Use cases

Pull images from an Azure container registry to various deployment targets:

- **Scalable orchestration systems** that manage containerized applications across clusters of hosts, including Kubernetes, DC/OS, and Docker Swarm.
- **Azure services** that support building and running applications at scale, including Azure Kubernetes Service (AKS), App Service, Batch, and Service Fabric.

Developers can also push to a container registry as part of a container development workflow. For example, target a container registry from a continuous integration and delivery tool such as Azure Pipelines or Jenkins.

Configure ACR Tasks to automatically rebuild application images when their base images are updated, or automate image builds when your team commits code to a Git repository. Create multi-step tasks to automate building, testing, and patching multiple container images in parallel in the cloud.

### Azure Container Registry service tiers

Azure Container Registry is available in multiple service tiers. These tiers provide predictable pricing and several options for aligning to the capacity and usage patterns of your private Docker registry in Azure.

| Tier     | Description                                                                                                                                                                                                                                                                                                                                                                                  |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Basic    | A cost-optimized entry point for developers learning about Azure Container Registry. Basic registries have the same programmatic capabilities as Standard and Premium (such as Microsoft Entra authentication integration, image deletion, and webhooks). However, the included storage and image throughput are most appropriate for lower usage scenarios.                                 |
| Standard | Standard registries offer the same capabilities as Basic, with increased included storage and image throughput. Standard registries should satisfy the needs of most production scenarios.                                                                                                                                                                                                   |
| Premium  | Premium registries provide the highest amount of included storage and concurrent operations, enabling high-volume scenarios. In addition to higher image throughput, Premium adds features such as: geo-replication for managing a single registry across multiple regions, content trust for image tag signing, and private link with private endpoints to restrict access to the registry. |

### Supported images and artifacts

When images are grouped in a repository, each image is a read-only snapshot of a Docker-compatible container. Azure container registries can include both Windows and Linux images. In addition to Docker container images, Azure Container Registry stores related content formats such as Helm charts and images built to the Open Container Initiative (OCI) Image Format Specification.

### Automated image builds

Use Azure Container Registry Tasks (ACR Tasks) to streamline building, testing, pushing, and deploying images in Azure. Configure build tasks to automate your container OS and framework patching pipeline, and build images automatically when your team commits code to source control.

## Explore Storage Capabilities

All Azure Container Registry tiers benefit from advanced Azure storage features like encryption-at-rest for image data security and geo-redundancy for image data protection.

- **Encryption-at-rest:** All container images and other artifacts in your registry are encrypted at rest. Azure automatically encrypts an image before storing it, and decrypts it on-the-fly when you or your applications and services pull the image. Optionally apply an extra encryption layer with a customer-managed key.

- **Regional storage:** Azure Container Registry stores data in the region where the registry is created, to help customers meet data residency and compliance requirements. In all regions except Brazil South and Southeast Asia, Azure might also store registry data in a paired region in the same geography. In the Brazil South and Southeast Asia regions, registry data is always confined to the region, to accommodate data residency requirements for those regions.

    If a regional outage occurs, the registry data might become unavailable and isn't automatically recovered. Customers who wish to have their registry data stored in multiple regions for better performance across different geographies, or who wish to have resiliency in a regional outage event, should enable geo-replication.

- **Geo-replication:** For scenarios requiring high-availability assurance, consider using the geo-replication feature of Premium registries. Geo-replication helps guard against losing access to your registry in a regional failure event. Geo-replication provides other benefits, too, like network-close image storage for faster pushes and pulls in distributed development or deployment scenarios.

- **Zone redundancy:** A feature of the Premium service tier, zone redundancy uses Azure availability zones to replicate your registry to a minimum of three separate zones in each enabled region.

- **Scalable storage:** Azure Container Registry allows you to create as many repositories, images, layers, or tags as you need, up to the registry storage limit.

    High numbers of repositories and tags can impact the performance of your registry. Periodically delete unused repositories, tags, and images as part of your registry maintenance routine. Deleted registry resources like repositories, images, and tags _can't_ be recovered after deletion.

## Build and Manage Containers with Tasks

Azure Container Registry (ACR) tasks are a suite of features that:

- Provide cloud-based container image building for platforms like Linux, Windows, and Advanced RISC Machines (Arm).
- Extend the early parts of an application development cycle to the cloud with on-demand container image builds.
- Enable automated builds triggered by source code updates, updates to a container's base image, or timers.

### Task scenarios

ACR Tasks supports several scenarios to build and maintain container images and other artifacts.

- **Quick task** - Build and push a single container image to a container registry on-demand, in Azure, without needing a local Docker Engine installation. Think `docker build`, `docker push` in the cloud.

- **Automatically triggered tasks** - Enable one or more _triggers_ to build an image:
    - Trigger on source code update
    - Trigger on base image update
    - Trigger on a schedule

- **Multi-step task** - Extend the single image build-and-push capability of ACR Tasks with multi-step, multi-container-based workflows.

Each ACR Task has an associated source code context - the location of a set of source files used to build a container image or other artifact. Example contexts include a Git repository or a local filesystem.

### Quick task

The _inner-loop_ development cycle is the iterative process of writing code, building, and testing your application before committing to source control. It's really the beginning of container lifecycle management.

ACR Tasks's quick task feature can provide an integrated development experience by offloading your container image builds to Azure. With quick tasks, you can verify your automated build definitions and catch potential problems before committing your code.

Using the familiar `docker build` format, the `az acr build` command in the Azure CLI takes a context (the set of files to build), sends it to ACR Tasks and, by default, pushes the built image to its registry upon completion.

### Trigger task on source code update

Trigger a container image build or multi-step task when code is committed, or a pull request is made or updated, to a Git repository in GitHub or Azure DevOps Services. For example, configure a build task with the Azure CLI command `az acr task create` by specifying a Git repository and optionally a branch and Dockerfile. When your team updates code in the repository, an ACR Tasks-created webhook triggers a build of the container image defined in the repo.

### Trigger on base image update

You can set up an ACR task to track a dependency on a base image when it builds an application image. When the updated base image is pushed to your registry, or a base image is updated in a public repo such as in Docker Hub, ACR Tasks can automatically build any application images based on it.

### Schedule a task

Optionally schedule a task by setting up one or more timer triggers when you create or update the task. Scheduling a task is useful for running container workloads on a defined schedule, or running maintenance operations or tests on images pushed regularly to your registry.

### Multi-step tasks

Multi-step tasks, defined in a YAML file, specify individual build and push operations for container images or other artifacts. They can also define the execution of one or more containers, with each step using the container as its execution environment. For example, you can create a multi-step task that automates the following actions:

1. Build a web application image
2. Run the web application container
3. Build a web application test image
4. Run the web application test container, which performs tests against the running application container
5. If the tests pass, build a Helm chart archive package
6. Perform a `helm upgrade` using the new Helm chart archive package

### Image platforms

By default, ACR Tasks builds images for the Linux OS and the amd64 architecture. Specify the `--platform` tag to build Windows images or Linux images for other architectures. Specify the OS and optionally a supported architecture in OS/architecture format (for example, `--platform Linux/arm`). For Advanced RISC Machine (ARM) architectures, optionally specify a variant in OS/architecture/variant format (for example, `--platform Linux/arm64/v8`):

| OS      | Architecture           |
| ------- | ---------------------- |
| Linux   | AMD64, Arm, Arm64, 386 |
| Windows | AMD64                  |

## Explore Elements of a Dockerfile

A Dockerfile is a script that contains a series of instructions that are used to build a Docker image. Dockerfiles typically include the following information:

- The base or parent image we use to create the new image
- Commands to update the base OS and install other software
- Build artifacts to include, such as a developed application
- Services to expose, such a storage and network configuration
- Command to run when the container is launched

### Create a Dockerfile

The first step in creating a Dockerfile is choosing a base image that serves as the foundation for your application. For example, if you're building a .NET application, you might choose a Microsoft .NET image as your base.

```dockerfile
# Use the .NET 6 runtime as a base image
FROM mcr.microsoft.com/dotnet/runtime:6.0

# Set the working directory to /app
WORKDIR /app

# Copy the contents of the published app to the container's /app directory
COPY bin/Release/net6.0/publish/ .

# Document that the application listens on port 80 (does not publish it)
EXPOSE 80

# Set the command to run when the container starts
CMD ["dotnet", "MyApp.dll"]
```

Let's go through each line to see what it does:

- **`FROM mcr.microsoft.com/dotnet/runtime:6.0`**: This command sets the base image to the .NET 6 runtime, which is needed to run .NET 6 apps.
- **`WORKDIR /app`**: Sets the working directory to `/app`, which is where app files are copied.
- **`COPY bin/Release/net6.0/publish/ .`**: Copies the contents of the published app to the container's `/app` directory. We assume that the .NET 6 app is built and published to the `bin/Release/net6.0/publish` directory.
- **`EXPOSE 80`**: Documents what port the application expects. Change this line accordingly if your app listens on a different port. The `EXPOSE` instruction doesn't publish the port to the host machine. To make the application accessible externally, use `docker run -p <host_port>:<container_port>` to specify ports.
- **`CMD ["dotnet", "MyApp.dll"]`**: The command to run when the container starts. In this case, we're running the dotnet command with the name of our app's DLL file (`MyApp.dll`). Change this line to match your apps name and entry point.

We're not going to cover the Dockerfile file specification. Visit the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/) for more information. Each of these steps creates a cached container image as we build the final container image. These temporary images are layered on top of the previous and presented as single image once all steps complete.

### Resources

- Docker run reference (CLI)
    - https://docs.docker.com/engine/reference/run/
- Docker build reference
    - https://docs.docker.com/engine/reference/commandline/build/

## Exercise - Build and Run a Container Image with Azure Container Registry Tasks

> **Note:** This unit contains a hands-on exercise. The exercise involves building and pushing a container image to Azure Container Registry using the Azure CLI. Tasks performed include creating an ACR resource, building and pushing an image from a Dockerfile, verifying results, and running the image in ACR. The exercise takes approximately 20 minutes and requires an Azure subscription with a paid plan.

> **Important:** Azure Container Registry task runs are temporarily paused from Azure free credits. This exercise requires a pay-as-you-go, or another paid plan.

## Summary

In this module, you learned how to:

- Explain the features and benefits Azure Container Registry (ACR) offers
- Describe how to use ACR Tasks to automate builds and deployments
- Explain the elements in a Dockerfile
- Build and run an image in the ACR using Azure CLI commands
