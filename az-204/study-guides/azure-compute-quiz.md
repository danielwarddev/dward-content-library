# AZ-204 Study Guide: Azure Compute (Functions, App Service, Container Registry)
Generated: 2026-03-01
Source material: `az-204/ms-learn/explore-azure-functions.md`, `az-204/ms-learn/introduction-to-azure-app-service.md`, `az-204/ms-learn/publish-container-image-to-azure-container-registry.md`
Difficulty: Mixed (Fundamentals → Tricky Exam-Style)

## How to Use This Guide
1. Cover the answer sections (collapse them or use a sheet of paper)
2. Answer each question yourself FIRST
3. Then reveal the answer, mnemonic, and exam tip
4. Star (⭐) any you got wrong and revisit those before the exam

---

## Section 1: Concept Check

### Question 1: Functions vs. Logic Apps Development Model

**What is the primary development approach difference between Azure Functions and Azure Logic Apps?**

A) Functions are designer-first (declarative); Logic Apps are code-first (imperative)

B) Functions are code-first (imperative); Logic Apps are designer-first (declarative)

C) Both are code-first (imperative) but use different languages

D) Both are designer-first (declarative) but use different designers

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Functions are code-first (imperative); Logic Apps are designer-first (declarative)**

**Why:** Azure Functions is a serverless *compute* service where you write code to define behavior. Logic Apps is a serverless *workflow integration platform* where you design workflows visually or via config files. Option A has them reversed — a classic exam trap. Options C and D are wrong because they differ in approach.

**🧠 Memory Hook:** "**F**unctions = **F**ull code. **L**ogic Apps = **L**ayout designer." The F in Functions matches the F in "Full code" (imperative). The L in Logic Apps matches the L in "Layout" (visual designer).

**⚡ Exam Tip:** When the exam asks about choosing between Functions and Logic Apps, the deciding word is usually "code" vs. "connectors." If the scenario mentions writing custom processing logic → Functions. If it mentions integrating many SaaS services with minimal code → Logic Apps.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Compare Azure Functions and Azure Logic Apps"

</details>

---

### Question 2: App Service Plan - What It Defines

**Which of the following is NOT defined by an App Service plan?**

A) Operating System (Windows or Linux)

B) Region (e.g., West US, East US)

C) The application's programming language and framework version

D) Pricing tier (e.g., Free, Standard, Premium)

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) The application's programming language and framework version**

**Why:** An App Service plan defines the OS, region, number/size of VM instances, and pricing tier — it's about the *compute resources*. The programming language is a property of the *app itself*, not the plan. You can run .NET, Node.js, and Python apps all on the same plan. Options A, B, and D are all explicitly part of what an App Service plan defines.

**🧠 Memory Hook:** Think of an App Service plan like leasing an office floor: the plan picks the *building* (region), the *floor size* (VM size/tier), and whether it's Windows or Mac-equipped (OS). What language the workers *speak* (programming language) is up to whoever moves in.

**⚡ Exam Tip:** The exam loves testing whether you know the difference between what belongs to the *plan* vs. what belongs to the *app*. Plans = infrastructure. Apps = code.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Examine Azure App Service plans"

</details>

---

### Question 3: Functions Hosting - Default Plan

**What is the default hosting plan for Azure Functions?**

A) Premium plan

B) Dedicated plan

C) Consumption plan

D) Flex Consumption plan

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Consumption plan**

**Why:** The Consumption plan is the default hosting plan for Azure Functions. It's pay-as-you-go and scales automatically. The Premium plan is an upgrade for always-warm instances. The Dedicated plan runs on App Service infrastructure. Flex Consumption is a newer option with per-function scaling but is not the default.

**🧠 Memory Hook:** "Consumption is the *default* diet" — when you don't pick a fancy meal plan, you just consume what you need and pay for what you eat. It's the most basic, zero-commitment option.

**⚡ Exam Tip:** If a question doesn't mention any specific plan and asks about default behavior (like the 5-minute timeout), it's talking about the Consumption plan.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Consumption plan"

</details>

---

### Question 4: App Service Built-in Auth

**Where does the App Service authentication and authorization middleware run?**

A) In a separate Azure Function

B) On the same VM as your application

C) In Azure Front Door

D) In a dedicated authentication microservice in AKS

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) On the same VM as your application**

**Why:** The authentication and authorization middleware is a platform feature that runs on the same VM as your app. Every incoming HTTP request passes through it before reaching your code. On Linux/containers, it runs in a separate *container* on the same host (not a separate VM or service). Options A, C, and D describe external services that have nothing to do with App Service's built-in auth.

**🧠 Memory Hook:** Think of the auth middleware as a *bouncer* standing right at the door of your apartment (same VM). The bouncer doesn't live across town — they're right there checking IDs before anyone gets in.

**⚡ Exam Tip:** The exam may try to trick you into thinking built-in auth requires code changes. It doesn't — it's configured at the platform level and requires no SDKs or code changes. But note: on Linux, it runs in a separate container, so no direct in-process integration with language frameworks.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Explore authentication and authorization in App Service"

</details>

---

### Question 5: WebJobs vs. Functions

**Which of the following is a capability of Azure Functions that Azure App Service WebJobs with the WebJobs SDK does NOT have?**

A) Source control integration

B) Serverless app model with automatic scaling

C) Monitoring with Application Insights

D) Connection to Azure services

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Serverless app model with automatic scaling**

**Why:** Both Functions and WebJobs support source control integration, Application Insights monitoring, and connections to Azure services. However, only Azure Functions has a serverless app model with automatic scaling, pay-per-use pricing, browser-based dev/test, and integration with Logic Apps. WebJobs runs within an App Service plan and does not auto-scale independently.

**🧠 Memory Hook:** WebJobs is like hiring a *full-time employee* (always there, fixed cost). Functions is like hiring a *freelancer* (shows up only when there's work, scales up, you pay per job). The freelancer auto-scales; the employee doesn't.

**⚡ Exam Tip:** The exam rarely asks you to choose WebJobs over Functions — Microsoft clearly favors Functions. If WebJobs appears as an option, it's usually a distractor unless the scenario involves an existing App Service with background tasks that don't need auto-scaling.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Compare Functions and WebJobs"

</details>

---

### Question 6: App Service Deployment Slots Minimum Tier

**What is the minimum App Service pricing tier required to use deployment slots?**

A) Basic

B) Free

C) Standard

D) Premium

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Standard**

**Why:** Deployment slots are available starting at the Standard tier. Free, Shared, and Basic tiers do not support deployment slots. The documentation specifically states "Standard App Service Plan tier or better." Premium works too, but Standard is the *minimum*.

**🧠 Memory Hook:** "**S**lots start at **S**tandard." Both start with S. If you can't remember anything else, remember the double-S: **S**lots = **S**tandard.

**⚡ Exam Tip:** This is a *high-frequency exam question*. Any time the scenario mentions zero-downtime deployment, blue/green deployments, or staging environments with slot swaps — the answer requires Standard tier or higher. If the question asks for the "minimum" tier, pick Standard, not Premium.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Use deployment slots"

</details>

---

### Question 7: ACR Geo-Replication Tier

**Which Azure Container Registry tier supports geo-replication?**

A) Basic

B) Standard

C) Premium

D) All tiers

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Premium**

**Why:** Geo-replication is a Premium-only feature in Azure Container Registry. The Premium tier also adds content trust for image tag signing and private link with private endpoints. Basic and Standard share the same programmatic capabilities (auth, image deletion, webhooks) but differ in storage/throughput and lack the advanced Premium features.

**🧠 Memory Hook:** "**G**eo-replication is a **G**rand **P**remium feature." Think of it like flying — Basic is economy, Standard is economy-plus, but only Premium (first class) gets you to multiple destinations (geo-replication across regions).

**⚡ Exam Tip:** For ACR questions, the magic word "geo-replication" always means Premium. Similarly, "private link" and "content trust" = Premium. If none of those features appear, Standard is usually sufficient for production.

**📖 Source:** az-204/ms-learn/publish-container-image-to-azure-container-registry.md → "Azure Container Registry service tiers"

</details>

---

### Question 8: Functions Orchestrations

**How do you create orchestrations in Azure Functions?**

A) By using a GUI or editing configuration files

B) By writing code and using the Durable Functions extension

C) By configuring Azure Logic Apps connectors within Functions

D) By deploying YAML-based workflow definitions

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) By writing code and using the Durable Functions extension**

**Why:** Azure Functions uses the Durable Functions extension for orchestrations — you write code (C#, JavaScript, Python, etc.) to define the orchestration workflow. Option A describes Logic Apps' approach (designer/config). Option C conflates two separate services. Option D describes something more like GitHub Actions or ACR Tasks.

**🧠 Memory Hook:** "**D**urable Functions = **D**o-it-in-co**D**e." Three D's. Logic Apps = "**L**ay it out" (visually). Code for Functions, GUI for Logic Apps.

**⚡ Exam Tip:** If the exam scenario mentions "fan-out/fan-in," "function chaining," or "human interaction patterns," it's pointing you toward Durable Functions. These are orchestration patterns that require the Durable Functions extension.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Compare Azure Functions and Azure Logic Apps"

</details>

---

## Section 2: Code & Configuration

### Question 9: Dockerfile Analysis

**What does the following Dockerfile do?**

```dockerfile
FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app
COPY bin/Release/net6.0/publish/ .
EXPOSE 80
CMD ["dotnet", "MyApp.dll"]
```

A) Builds a .NET 6 app from source code, compiles it, and runs it on port 80

B) Sets up a .NET 6 runtime container, copies pre-built app files, documents port 80, and starts the app

C) Pulls a .NET 6 SDK image, restores NuGet packages, and exposes port 80 to the internet

D) Creates a multi-stage build that compiles and publishes a .NET 6 application

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Sets up a .NET 6 runtime container, copies pre-built app files, documents port 80, and starts the app**

**Why:** This Dockerfile uses the *runtime* image (not SDK), so it doesn't compile anything — option A is wrong. It COPYs already-published files from `bin/Release/net6.0/publish/`. EXPOSE only *documents* the port; it doesn't publish it to the host (ruling out C's "exposes to the internet"). There's no multi-stage build here (ruling out D) since there's only one FROM statement.

**🧠 Memory Hook:** "EXPOSE is a **Post-it note**, not a **door.**" It tells other developers which port the app listens on, but it doesn't actually open the port. You need `docker run -p` for that. Imagine EXPOSE as sticking a Post-it on the container that says "I listen on 80" — it doesn't actually do anything.

**⚡ Exam Tip:** For code questions, focus on the METHOD NAMES and KEY WORDS — `runtime` (not SDK), `COPY` (not `RUN dotnet build`), `EXPOSE` (documentation only). These are what distinguish the options.

**📖 Source:** az-204/ms-learn/publish-container-image-to-azure-container-registry.md → "Create a Dockerfile"

</details>

---

### Question 10: Azure CLI — Find Outbound IPs

**Which Azure CLI command retrieves the outbound IP addresses currently used by your App Service app?**

A) `az webapp show --resource-group <group> --name <app> --query outboundIpAddresses --output tsv`

B) `az webapp show --resource-group <group> --name <app> --query possibleOutboundIpAddresses --output tsv`

C) `az webapp list --resource-group <group> --query outboundIpAddresses --output tsv`

D) `az appservice plan show --resource-group <group> --name <plan> --query outboundIpAddresses --output tsv`

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: A) `az webapp show --resource-group <group> --name <app> --query outboundIpAddresses --output tsv`**

**Why:** Option A queries the *current* outbound IP addresses for a specific app. Option B gets *all possible* outbound IPs (a superset, useful for firewall rules). Option C uses `list` instead of `show` — wrong command structure. Option D queries the plan, not the app — outbound IPs are a property of the app, not the plan.

**🧠 Memory Hook:** "**Current** = `outboundIpAddresses`. **Complete** (all possible) = `possibleOutboundIpAddresses`." Both start with the same letter as their meaning: **C**urrent, **C**omplete. The shorter property name gives you the smaller, current set.

**⚡ Exam Tip:** The exam loves asking about the difference between `outboundIpAddresses` and `possibleOutboundIpAddresses`. Remember: if the question says "currently used" → `outboundIpAddresses`. If it says "all possible" or "firewall allowlist" → `possibleOutboundIpAddresses`.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Find outbound IPs"

</details>

---

### Question 11: ACR Quick Build Command

**You want to build a container image in the cloud without a local Docker installation. Which Azure CLI command should you use?**

A) `az container build`

B) `az acr build`

C) `docker build --cloud`

D) `az webapp container build`

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) `az acr build`**

**Why:** ACR Tasks' quick task feature allows you to build and push container images using `az acr build` — no local Docker Engine needed. It sends the build context to ACR Tasks in the cloud. Option A doesn't exist. Option C is a made-up flag. Option D doesn't exist either.

**🧠 Memory Hook:** "**ACR** builds in the **A**zure **C**loud **R**emotely." `az acr build` = Azure Container Registry build. Think of ACR as your cloud-based Docker daemon.

**⚡ Exam Tip:** If the scenario says "no local Docker Engine" or "build in the cloud," the answer is always `az acr build`. The exam may also ask about `az acr task create` for automated/triggered builds — but for one-off quick builds, it's `az acr build`.

**📖 Source:** az-204/ms-learn/publish-container-image-to-azure-container-registry.md → "Quick task"

</details>

---

### Question 12: App Service Auth — Token Submission Header

**When using client-directed flow (with provider SDK) in App Service, which HTTP header does client code use to present the authentication token?**

A) `Authorization: Bearer <token>`

B) `X-ZUMO-AUTH`

C) `X-MS-TOKEN`

D) `X-FORWARDED-AUTH`

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) `X-ZUMO-AUTH`**

**Why:** In client-directed flow, the client signs the user in via the provider's SDK and then submits the token to App Service. For subsequent requests, the client presents the authentication token in the `X-ZUMO-AUTH` header (automatically handled by Mobile Apps client SDKs). "ZUMO" comes from Azure Mobile Services (codename "Zumo"). Options A, C, and D are either generic HTTP headers or fabricated.

**🧠 Memory Hook:** "**ZUMO** sounds like **Sumo** — a big wrestler guarding the door." The sumo wrestler checks your token at the gate. It's a weird enough naming that you'll remember it because it stands out — "Why is it called ZUMO?!" The oddness makes it stick.

**⚡ Exam Tip:** This is a detail question. The exam tests whether you know the specific header name. `X-ZUMO-AUTH` is the legacy Mobile Services header that App Service still uses. Don't confuse it with the standard `Authorization: Bearer` header — that's for calling external APIs, not for passing tokens TO App Service.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Authentication flow"

</details>

---

### Question 13: Deploy a Container to App Service

**You want to continuously deploy a containerized app to App Service with zero downtime. Which of the following is the correct sequence of pipeline steps?**

A) Push image → Update production slot → Restart app

B) Build and tag image → Push tagged image to registry → Update staging deployment slot with new image tag → Swap staging and production slots

C) Build image with "latest" tag → Push to Docker Hub → App Service auto-detects the change

D) Build image → Deploy directly to production via FTP → Restart app

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Build and tag image → Push tagged image to registry → Update staging deployment slot with new image tag → Swap staging and production slots**

**Why:** The documentation explicitly describes this three-step container deployment process: build and tag (avoid "latest"), push to registry, update the deployment slot. Swapping slots provides zero-downtime deployment. Option A skips staging. Option C uses "latest" tag which the docs warn against. Option D uses FTP which doesn't support container workflows.

**🧠 Memory Hook:** "**B**uild, **P**ush, **U**pdate slot, **S**wap" — **B**aby **P**enguins **U**sually **S**lide. Picture baby penguins sliding from the staging slot into the production slot with zero downtime. They were tagged with ID bands first (image tagging).

**⚡ Exam Tip:** Two red flags to eliminate wrong answers: (1) "latest" tag is explicitly warned against — if you see it, it's wrong. (2) Any answer that deploys directly to production without staging = wrong when the question mentions zero-downtime.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Continuously deploy containers"

</details>

---

### Question 14: ACR Task Triggers

**You want to automatically rebuild your container image whenever your base image is updated in Docker Hub. Which ACR Tasks trigger type should you use?**

A) Quick task

B) Source code update trigger

C) Base image update trigger

D) Schedule trigger

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Base image update trigger**

**Why:** ACR Tasks can track dependencies on base images and automatically rebuild application images when the base image is updated — even in public repos like Docker Hub. Quick tasks are manual one-offs. Source code triggers fire on commits/PRs. Schedule triggers are timer-based.

**🧠 Memory Hook:** "The **base** of your house shifted — time to **rebuild** everything on top of it." When the foundation (base image) changes, everything built on top needs to be reconstructed. ACR Tasks does this automatically.

**⚡ Exam Tip:** Eliminate-first strategy: "automatically" rules out Quick task (option A, which is manual). "base image" is right in the question, making option C obvious — but the exam might bury this cue in a longer scenario. Read the question last, find the keyword.

**📖 Source:** az-204/ms-learn/publish-container-image-to-azure-container-registry.md → "Trigger on base image update"

</details>

---

## Section 3: Scenario-Based

### Question 15: Choosing Between Functions Plans

**Your company runs an Azure Functions app that processes IoT sensor data. The app runs continuously, requires virtual network connectivity to reach an on-premises database, and occasionally experiences burst traffic. Which hosting plan should you choose?**

A) Consumption plan

B) Flex Consumption plan

C) Premium plan

D) Dedicated plan

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Premium plan**

**Why:** The Premium plan checks every box: (1) prewarmed workers for continuous/near-continuous execution with no cold starts, (2) virtual network connectivity, (3) event-driven autoscaling for burst traffic. Consumption plan doesn't support VNet. Flex Consumption supports VNet but the scenario's "runs continuously" and "prewarmed workers" pattern fits Premium best. Dedicated could work but doesn't have event-driven auto-scale — it's manual/autoscale only.

**🧠 Memory Hook:** Premium is the **"always warm, always connected"** plan. Picture a premium sports car that's always warmed up in a gated community (VNet). When traffic gets heavy (burst), it has a turbo button (auto-scale). Consumption is a cold bicycle. Dedicated is a reliable but slow bus.

**⚡ Exam Tip:** Start from the bottom of the scenario question. The question is "which plan?" Now scan for trigger words: "continuously" + "virtual network" + "burst" = Premium. If any ONE of VNet or continuous execution appears, Consumption is eliminated. If auto-scale is needed, Dedicated is eliminated. That leaves Premium.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Premium plan"

</details>

---

### Question 16: App Isolation Decision

**You have three apps sharing an App Service plan. One of them, a CPU-intensive image processing API, is causing the other two apps to slow down. The other two apps are simple, low-traffic websites. What should you do to solve this with minimum effort?**

A) Scale up the App Service plan to a higher pricing tier

B) Move the image processing app into a separate App Service plan

C) Move all three apps to separate App Service plans

D) Convert the image processing app to Azure Functions on a Consumption plan

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Move the image processing app into a separate App Service plan**

**Why:** When apps share a plan, they share the same VM instances. The resource-intensive app should be isolated into its own plan. Option A might help temporarily but doesn't solve the root cause — the CPU-heavy app still starves the others. Option C is more work than necessary (the two simple apps coexist fine). Option D is a complete architecture change, not "minimum effort."

**🧠 Memory Hook:** "The noisy roommate gets their own apartment." You don't renovate the whole building (A), move everyone out (C), or send the roommate to a different city (D). You just get them their own place (B).

**⚡ Exam Tip:** Watch for "MINIMUM effort" — the simplest correct answer wins. Moving one app is simpler than moving all three or changing architectures entirely. The docs explicitly list "resource-intensive" as a reason to isolate into a new plan.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "What if my app needs more capabilities or features?"

</details>

---

### Question 17: Functions Timeout Scenario

**Your Azure Functions app on the Consumption plan processes large files that take 8 minutes each. Users report that some files fail to process. What is the most likely cause?**

A) The Consumption plan has a maximum timeout of 5 minutes by default

B) The function app is hitting memory limits

C) The Consumption plan doesn't support file processing

D) Azure Functions can't process files larger than 100 MB

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: A) The Consumption plan has a maximum timeout of 5 minutes by default**

**Why:** The Consumption plan has a default timeout of 5 minutes and a maximum of 10 minutes. If file processing takes 8 minutes, it exceeds the 5-minute default and will time out. The fix is to increase the timeout to 10 minutes in host.json or switch to a plan with unbounded timeout (Premium, Flex Consumption, or Dedicated). Options B, C, and D are fabricated limitations.

**🧠 Memory Hook:** "**C**onsumption = **C**inco (5) minutes default, ma**X**imum of te**N** (10)." Five fingers on one hand (default), ten on both (maximum). Every other plan gets 30 minutes default with unbounded maximum. Consumption is the odd one out.

**⚡ Exam Tip:** Timeouts are an *extremely* common exam topic. Memorize just two numbers: Consumption = 5/10. Everything else = 30/unbounded. Also remember: HTTP-triggered functions have a hard 230-second (≈4 min) limit regardless of plan, due to Azure Load Balancer's idle timeout.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Function app time-out duration"

</details>

---

### Question 18: Choosing Auth Behavior

**Your company has a single-page application (SPA) hosted on App Service. The home page must be publicly accessible, but certain API endpoints require authentication. How should you configure App Service authentication?**

A) Require authentication — redirect unauthenticated users to the login page

B) Allow unauthenticated requests — handle authorization in your application code

C) Disable App Service authentication and use a third-party auth library only

D) Require authentication — return HTTP 403 for all unauthenticated requests

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Allow unauthenticated requests — handle authorization in your application code**

**Why:** The documentation explicitly warns: "Restricting access applies to all calls to your app, which may not be desirable for apps wanting a publicly available home page, as in many single-page applications." Allowing unauthenticated requests lets the SPA serve the home page to everyone while your code enforces auth on specific API routes. Options A and D would block the public home page. Option C unnecessarily abandons the built-in feature entirely.

**🧠 Memory Hook:** "**SPA** = **S**ome **P**ages **A**nonymous." If a SPA needs some pages public, you can't use the nuclear "reject all" option. You let everyone in the door, then check VIP passes at the specific rooms (API endpoints).

**⚡ Exam Tip:** The word "single-page application" in a scenario is a strong signal that the answer is "allow unauthenticated requests." The exam uses this exact SPA scenario frequently. Also watch for "publicly available home page" — same answer.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Authorization behavior"

</details>

---

### Question 19: Container Sidecar Pattern

**You need to add a centralized logging agent to your containerized App Service app without modifying the application's source code. What App Service feature should you use?**

A) Deployment slots

B) Sidecar containers

C) WebJobs

D) App Service diagnostics logging

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Sidecar containers**

**Why:** App Service supports up to nine sidecar containers per custom container app. Sidecars enable adding services like monitoring, logging, and networking without tightly coupling them to the main application container — exactly what the scenario describes. Deployment slots are for deployments, not adding logging agents. WebJobs are background tasks, not container-based logging. Built-in diagnostics logging exists but the question says "logging agent" (a separate container).

**🧠 Memory Hook:** "Sidecars ride alongside the motorcycle without modifying the bike." A sidecar container rides alongside your app container — same pod, separate container, no changes to the main app code.

**⚡ Exam Tip:** Sidecar containers are a Linux-only, custom-container-only feature. If the scenario mentions Windows containers or built-in runtime stacks, sidecar containers won't apply.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Sidecar containers"

</details>

---

### Question 20: Functions Scaling — Linux vs. Windows

**Your team deploys an Azure Functions app on the Consumption plan using Linux. During a load test, the app scales to 100 instances but won't go beyond that. On a Windows Consumption plan, a similar app scales to 200 instances. Why?**

A) Linux Consumption plan has a maximum of 100 instances; Windows Consumption plan has a maximum of 200

B) Linux does not support auto-scaling on the Consumption plan

C) The load test isn't generating enough events to require more than 100 instances

D) Linux Consumption plan instances are twice as powerful as Windows instances

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: A) Linux Consumption plan has a maximum of 100 instances; Windows Consumption plan has a maximum of 200**

**Why:** The documentation states maximum instances for the Consumption plan are "Windows: 200, Linux: 100." This is a hard limit. Linux apps also have a per-subscription limit of 500 instances per hour. Option B is false — Linux does support auto-scaling. Options C and D are fabricated explanations.

**🧠 Memory Hook:** "**W**indows gets **2**00 (W looks like two Vs = double). **L**inux gets **1**00 (L = one stroke = one hundred)." Or think: Windows is double-paned (200), Linux is single-paned (100).

**⚡ Exam Tip:** The platform-specific instance limits are a gotcha question favorite. Memorize: Consumption = 200W/100L. Premium = 100W / 20-100L. Dedicated = 10-30 (100 with ASE). Container Apps = 10-300.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Scale Azure Functions"

</details>

---

## Section 4: Tier & Service Comparison

### Question 21: App Service Pricing Tier Categories

**Match each App Service pricing tier category to its description:**

1. **Shared compute**
2. **Dedicated compute**
3. **Isolated**

A) Runs on dedicated Azure VMs on dedicated Azure Virtual Networks; maximum scale-out capabilities

B) Free and Shared tiers; apps share Azure VMs with other customers' apps; can't scale out

C) Basic through PremiumV3; apps run on dedicated VMs shared only within the same App Service plan

**Which mapping is correct?**

A) 1→B, 2→C, 3→A

B) 1→C, 2→A, 3→B

C) 1→A, 2→B, 3→C

D) 1→B, 2→A, 3→C

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: A) 1→B, 2→C, 3→A**

**Why:** Shared compute (Free/Shared) = shared VMs, no scale-out. Dedicated compute (Basic→PremiumV3) = dedicated VMs shared only within your plan. Isolated = dedicated VMs on dedicated VNets with maximum scale-out. The docs map these exactly.

**🧠 Memory Hook:** Think of housing:
- **Shared** = hostels (Free/Shared) — bunk beds with strangers, no room to stretch out (can't scale)
- **Dedicated** = apartments (Basic→PremiumV3) — your own rooms, shared building (same plan shares VMs)
- **Isolated** = private island (Isolated/IsolatedV2) — your own land, your own infrastructure, maximum space

**⚡ Exam Tip:** The exam loves asking "which tier supports scale-out?" Remember: Free and Shared CANNOT scale out. Everything else can. This is the single most important tier distinction.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Examine Azure App Service plans"

</details>

---

### Question 22: Functions Plan Timeout Comparison

**Which Azure Functions hosting plan has the most restrictive timeout limits?**

A) Premium plan (default 30 min, max unbounded)

B) Consumption plan (default 5 min, max 10 min)

C) Dedicated plan (default 30 min, max unbounded)

D) Flex Consumption plan (default 30 min, max unbounded)

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Consumption plan (default 5 min, max 10 min)**

**Why:** Consumption is the ONLY plan with a restrictive maximum timeout (10 minutes). Every other plan defaults to 30 minutes with an unbounded maximum. This makes Consumption unsuitable for long-running tasks unless you use Durable Functions' async patterns.

**🧠 Memory Hook:** "Consumption is on a **strict diet** — only 5 minutes to eat (default), and 10 max even if you beg for more. Everyone else gets a **30-minute all-you-can-eat buffet** with no closing time (unbounded)."

**⚡ Exam Tip:** If the scenario involves "long-running processes" and the function is on the Consumption plan, the answer almost always involves either: (1) switching to Premium/Dedicated, or (2) using the Durable Functions async pattern. The exam will NEVER suggest keeping long-running tasks on Consumption.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Function app time-out duration"

</details>

---

### Question 23: ACR Tier Feature Comparison

**A development team needs a container registry with private endpoints for security and geo-replication to serve images from multiple Azure regions. Which ACR tier is required?**

A) Basic — all programmatic features are the same across tiers

B) Standard — it satisfies most production scenarios

C) Premium — it's the only tier with geo-replication and private link

D) Any tier, since these are platform-level features

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Premium — it's the only tier with geo-replication and private link**

**Why:** While Basic and Standard share the same *programmatic* capabilities (auth, image deletion, webhooks), Premium is the only tier that adds: (1) geo-replication, (2) content trust for image signing, and (3) private link with private endpoints. Option A is misleading — programmatic capabilities are the same, but these are *infrastructure* features exclusive to Premium.

**🧠 Memory Hook:** ACR Premium's three exclusive features spell "**GCP**" — **G**eo-replication, **C**ontent trust, **P**rivate link. Ironic since it's Azure, not GCP. The irony makes it memorable: "You need GCP features? Pay for Premium."

**⚡ Exam Tip:** Option A is a classic distractor — it's technically true that programmatic capabilities are the same, but the question asks about geo-replication and private endpoints, which are *not* programmatic capabilities. Read the question carefully.

**📖 Source:** az-204/ms-learn/publish-container-image-to-azure-container-registry.md → "Azure Container Registry service tiers"

</details>

---

### Question 24: App Service Linux Limitations

**Which App Service pricing tier does NOT support Linux?**

A) Free

B) Shared

C) Basic

D) Standard

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Shared**

**Why:** The documentation explicitly states: "App Service on Linux isn't supported on Shared pricing tier." Free tier does support Linux (it's a common misconception). Basic, Standard, and all higher tiers support Linux. The Shared tier is the odd one out.

**🧠 Memory Hook:** "Linux doesn't like to **share**." The Shared tier is the only one that doesn't support Linux. It's the annoying roommate that Linux refuses to live with.

**⚡ Exam Tip:** This is a tricky one because you'd expect Free to also be excluded, but it's not — only Shared is excluded. The exam exploits this assumption. If you see "Shared" and "Linux" together, it's almost certainly wrong.

**📖 Source:** az-204/ms-learn/introduction-to-azure-app-service.md → "Limitations" (App Service on Linux)

</details>

---

### Question 25: Functions Hosting Plan — Container Support

**You want to deploy Azure Functions in a Linux container. Which of the following hosting plans support this? (Select all that apply)**

A) Consumption plan

B) Premium plan

C) Dedicated plan

D) Container Apps

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Premium plan, C) Dedicated plan, D) Container Apps**

**Why:** According to the hosting options table, container support is: Consumption = None, Flex Consumption = None, Premium = Linux, Dedicated = Linux, Container Apps = Linux. The Consumption and Flex Consumption plans do NOT support containers at all.

**🧠 Memory Hook:** "**C**onsumption **C**an't **C**ontain" — the three C's. Consumption and containers don't mix. If you need containers, you need to pay for Premium, go Dedicated, or use Container Apps. Think of it like takeout food: Consumption plan is like eating at the restaurant (no container needed) — if you want to take it home (containerize), you need to upgrade.

**⚡ Exam Tip:** This is a "select all that apply" style question. On the real exam, look for the container support column. Consumption = None is the key elimination. Don't be tricked by Flex Consumption either — it also has no container support despite being newer.

**📖 Source:** az-204/ms-learn/explore-azure-functions.md → "Compare Azure Functions hosting options"

</details>

---

## 📅 Spaced Repetition Plan
- **Today:** Complete this quiz. Star (⭐) every question you got wrong.
- **Tomorrow:** Re-do ONLY the starred questions.
- **Day 3:** Re-do starred questions again. Unstar any you now get right.
- **Day 7:** Full quiz again. Re-star any you miss.
- **Day 14:** Final full review. Anything still starred = write it on a cheat sheet for exam-day morning review.

---

## 🗣️ Teach-It-Back Challenges
Explain these out loud (or in writing) as if teaching a junior developer. If you can't explain it simply, you don't know it well enough:

1. **Explain the difference between Azure Functions hosting plans** — When would you pick Consumption vs. Premium vs. Dedicated? What are the trade-offs in cost, scaling, and features?
2. **Describe App Service pricing tier categories** — What's the difference between Shared compute, Dedicated compute, and Isolated? Why does it matter for your app's performance?
3. **Walk through a zero-downtime container deployment on App Service** — What are the steps, why do you tag images instead of using "latest," and how do deployment slots help?

---

## 📊 Quick-Reference: Azure Functions Hosting Plans at a Glance

| Feature | Consumption | Flex Consumption | Premium | Dedicated | Container Apps |
|---|---|---|---|---|---|
| **Default timeout** | 5 min | 30 min | 30 min | 30 min | 30 min |
| **Max timeout** | 10 min | Unbounded | Unbounded | Unbounded | Unbounded |
| **Max instances (Windows)** | 200 | N/A | 100 | 10-30 (100 ASE) | N/A |
| **Max instances (Linux)** | 100 | Region-limited | 20-100 | 10-30 (100 ASE) | 10-300 |
| **Scaling** | Event-driven | Per-function | Event-driven | Manual/Autoscale | Event-driven |
| **Container support** | None | None | Linux | Linux | Linux |
| **VNet connectivity** | No | Yes | Yes | Yes (ASE) | Yes |
| **Pricing model** | Pay-per-use | Pay-as-you-go | Pre-warmed + usage | Fixed plan cost | Usage-based |

## 📊 Quick-Reference: App Service Pricing Tiers at a Glance

| Feature | Free | Shared | Basic | Standard | Premium (V2/V3) | Isolated (V2) |
|---|---|---|---|---|---|---|
| **Compute type** | Shared | Shared | Dedicated | Dedicated | Dedicated | Dedicated + Dedicated VNet |
| **Scale out** | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ (max) |
| **Deployment slots** | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ |
| **Linux support** | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |
| **Custom domains** | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Auto-scale** | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ |
| **VNet integration** | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ (native) |
| **Use case** | Dev/Test | Dev/Test | Small apps | Production | High-perf production | Compliance/Isolation |

## 📊 Quick-Reference: Azure Container Registry Tiers at a Glance

| Feature | Basic | Standard | Premium |
|---|---|---|---|
| **Storage** | 10 GiB | 100 GiB | 500 GiB |
| **Auth, deletion, webhooks** | ✅ | ✅ | ✅ |
| **Geo-replication** | ❌ | ❌ | ✅ |
| **Content trust (signing)** | ❌ | ❌ | ✅ |
| **Private link / endpoints** | ❌ | ❌ | ✅ |
| **Zone redundancy** | ❌ | ❌ | ✅ |
| **Best for** | Learning/Dev | Most production | High-volume / Enterprise |
