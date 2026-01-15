# Infrastructure as code (IaC) – what it is and why to use it

**Date:** March 30, 2025  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/infrastructure-as-code-iac-what-it-is-and-why-to-use-it/

_This post is part of a series on using Pulumi:_

-   **Infrastructure as code (IaC) – what it is and why to use it**
-   [How to use Pulumi with C# – Our first project](https://daninacan.com/how-to-use-pulumi-with-c-our-first-project/)
-   [How to use Pulumi with C# – How Pulumi Works](https://daninacan.com/how-to-use-pulumi-with-c-how-pulumi-works/)
-   [How to use Pulumi with C# – Inputs and Outputs](https://daninacan.com/how-to-use-pulumi-with-c-inputs-and-outputs/)
-   [How to use Pulumi with C# – Component Resources](https://daninacan.com/how-to-use-pulumi-with-c-component-resources/)
-   [How to Use Pulumi with C# – Projects, Stacks, Config](https://daninacan.com/how-to-use-pulumi-with-c-projects-stacks-config/)
-   [How to use Pulumi with C# – Stack References](https://daninacan.com/how-to-use-pulumi-with-c-stack-references/)

_Photo by [Karl Abuid](https://unsplash.com/@spongzy?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash) on [Unsplash](https://unsplash.com/photos/a-multicolored-building-made-of-wooden-blocks-7ezVb0oTQ6M?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)_

## What is infrastructure as code (IaC)?

**The short version**: infrastructure as code is the practice of using code, either imperative or declarative, to create and manage infrastructure, as opposed to manually creating these things. When using IaC, the same team that creates an app is also usually responsible for managing the infrastructure of that app using IaC.

"Infrastructure" means any hardware or networking resources that the app needs to run, such as allotting CPU or RAM, defining private networks, or creating message buses and queues. IaC is often used with cloud providers, such as Azure and AWS.

However, in order to really understand why IaC is helpful, we have to understand the previous alternative.

## What problem is IaC solving?

Historically, provisioning and managing infrastructure has been the job of an "operations team" – a team whose job it is to do these kinds of tasks specifically. This team would both deploy application code, as well as manage the hardware of the infrastructure itself. This might mean adding more RAM, adding a whole new server, upgrading a CPU, adding a load balancer, etc.

Multiple dev teams would each write their own application code and then "throw it over the wall" to that operations team to deploy. Practically, this looks like creating some kind of request or ticket in an internal system that the company uses, then waiting until the request has been completed. In my experience, the wait time for this ranges from a day or two to a week.

Truth be told, this system works and creates working software! However, it's got some fixable downsides that you may have spotted already from that description, especially if you've been on either side of that equation before.

-   For one, on the operation team's side, deploying (read: copying and pasting) artifacts (read: files) onto a server isn't exactly the most thrilling task. Plus, if something goes wrong, you have to do the same thing again and hope it works this time. This is even more frustrating if you have to do something like change IIS settings.
-   Secondly, on the dev team's side, the dev process is often blocked either partially or entirely by waiting on these deployments or infrastructure changes. If the changes truly can't wait and it requires a change right now, then this also disrupts the operation team's work, since they have to pivot to a different task from whatever they were doing before.

## Okay, so how does IaC help?

Allowing dev teams to use IaC to manage their own infrastructure solves both of the above issues at the same time. Whenever devs have some code that is ready to go to production, they don't have to wait on anybody, as they have the keys to everything necessary for deployment. It's not too hard to imagine how this can speed up software delivery significantly!

Dev teams probably shouldn't be given literally free reign over the infrastructure accounts, but a reasonable enough amount that they very rarely or never need to ask for access to things.

Putting guard rails around what devs are allowed to do is common, using tools such as [checkov](https://www.checkov.io/) and [Pulumi CrossGuard](https://www.pulumi.com/crossguard/). These are quite flexible, and in conjunction with tools from a cloud provider or your own on-prem management, you can enforce rules such as:

-   Enforce encryption on all data at rest and in transit
-   Disallow the use of certain cloud services
-   Require cloud connections to on-prem be private

Incidentally, this removal of "throwing it over the wall" from the dev team to the operations team is how the whole DevOps movement started – giving a single team both the development and operations responsibilities, but only within the scope of their applications.

## What happens to the operations team?

The nice thing is that using IaC presents a win-win situation, because the operations team doesn't go away, but they do shift responsibilities, as they are no longer doing tasks like the ones mentioned earlier. Since this team is still ultimately the one deciding what the company-wide infrastructure will look like, they can now take on responsibilities such as:

-   Defining what the guard rails for the infrastructure will be and how they will be enforced
-   Bootstrapping cloud accounts for teams by both putting the guard rails up and also making things easier for those teams (for instance, by predefining common security roles)
-   Discovering common problems that are repeatedly solved in a similar way in the org and providing/managing a universal solution for teams to use (such as Dynatrace for monitoring apps or Splunk for central logging)

A team with these kinds of responsibilities is usually called a "platform team."

If you'd like to learn more about these different team responsibilities and how they work together, I highly recommend a book called [Team Topologies](https://teamtopologies.com/book).

## How does IaC play into this again?

Admittedly, this post ended up being a lot of theory. IaC matters because it's the method by which dev teams take control of their own infrastructure, which in turn enables them to iterate and release software more quickly. By describing how they want their infrastructure to look with JSON, YAML, or a programming language, the dev team can change and deploy their own architecture at will without waiting on another team.

Even, since IaC is just normal files you check into your repo, you can deploy your resources to each environment easily to ensure parity and avoid "environment drift."

IaC took off with declarative code using JSON or YAML, mostly with [Terraform](https://www.terraform.io/). Nowadays, there are also mature options for writing in an imperative manner, including C#, Typescript, Java, Go, and more, using tools like the [AWS CDK](https://aws.amazon.com/cdk/) and [Pulumi](https://www.pulumi.com/).

As a dev, the imperative option is my preference, but both are good options. Declarative also has a benefit of being usable by teams other than dev teams, but in my opinion, it's not nearly as nice of an experience to write in, and in my opinion, declarative languages start becoming very hard to read once the complexity grows (but that could be my dev side talking).

## Going forward

If you're not sure if IaC will work for you or not, I encourage you to try a quick and dirty – maybe around 30-60 seconds – value stream map of your software process. How much time is spent between your "code ready" and "deployed" steps? IaC can often reduce that time drastically. Mapping this process out and collecting hard numbers also helps make a case for it to management.
