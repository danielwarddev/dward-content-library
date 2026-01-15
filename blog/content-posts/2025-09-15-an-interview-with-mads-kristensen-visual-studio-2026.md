# An Interview with Mads Kristensen: Visual Studio 2026

https://daninacan.com/an-interview-with-mads-kristensen-visual-studio-2026/

_What users will see upon installing the new Visual Studio 2026 Insiders._

## Overview

Visual Studio 2026 Insiders is officially here! Visual Studio 2026 is the first major release since 2022, with AI, performance, and UI seeming to be its big themes. The Insiders version [just went public last week on September 9](https://devblogs.microsoft.com/visualstudio/visual-studio-2026-insiders-is-here/). You can check out [the release notes here](https://learn.microsoft.com/en-us/visualstudio/releases/vs18/release-notes-insiders?wt.mc_id=MVP_367508).

I sat down (virtually) with Mads Kristensen to dig into what's new, what it means for developers, and how decisions for Visual Studio are made.

[Mads Kristensen](https://devblogs.microsoft.com/visualstudio/author/madsk/) is a Principal Product Manager at Microsoft working on Visual Studio.

## Interview

_Since the interview was about an hour long, and this is a written blog post rather than a video and I want it to still be readable, the following is a **summarized** interview between Mads and I about Visual Studio 2026._

### Intro & community feedback

---

> Right now we're fixing 18 user-reported bugs per workday in the past 12 months, and that trend is going up.

**Daniel: First off, introduce yourself! Who are you? What's your role on the Visual Studio team? What do you do?**

Mads: I'm a Product Manager for Visual Studio on the developer community team. My main focus is to be a conduit between users and product teams. I funnel in feedback, work to communicate with teams the features that users want, and issues that bug them the most, to create solutions. I'm kind of like the glue between users and the product teams. I also tease new features and blog about them on the official Visual Studio blog and social media.

**Daniel: I'm curious about the community feedback aspect. How do you handle feedback within Visual Studio? Do you take feature suggestions in something like GitHub issues?**

Mads: We primarily use the Help/Send Feedback service within Visual Studio for both bug reports and feature requests. That also gives us things like crash dumps, log files, call stacks, and general diagnostic reports. Right now we're fixing 18 user-reported bugs per workday in the past 12 months, and that trend is going up. We actually have a system that routes the feedback from a bug directly to a team in Azure DevOps and assigns a bug to them in the normal bug triage that every team has. Although it's something people have asked us for, we don't use GitHub, because we'd lose that integration.

From there, it's the normal process. Just because we receive a bug doesn't necessarily mean we'll work on it right away. Like any other software, they're still prioritized based on things like time, scope, and value. We're not different than any other team in that regard.

**Daniel: Are the things being worked on public?**

Mads: Yes; the things being worked on have a state. So they can be, like, "on roadmap," "under review," or if it's fixed, "pending release." You can see them at [developercommunity.visualstudio.com](https://developercommunity.visualstudio.com/home).

### Why a new major version?

---

> We hear from many people who say stuff like, "hey, if I didn't have Visual Studio, I would just give up programming completely."

**Daniel: This major release took a bit of time, since the last major version was Visual Studio 2022. Do you have a release cadence you try to hit, or is it more "it's ready when it's ready?"**

Mads: We usually need a good reason to do a new major version. There's lots of stuff that needs to be done, like marketing machinery, getting the business people, the license people, and legal since we need new EULAs. We don't really have a rule that says we have to release within a certain amount of time, and if we do have one, it would be ourselves who made it, so we could change it.

So, for instance, for Visual Studio 2022, the main reason was that we wanted to bring back compatibility for all our extensions.

This time around, it was around performance and integrating AI into different areas of Visual Studio. There was some accessibility changes around a new modern UI. If you would look at it, some of the themes look, like, kind of dated. If you're coding in Visual Studio all day long and basically half your life is spent looking at Visual Studio, that's a long time to look at something that's outdated. It's kind of like having an old kitchen in your house! So, it didn't make people feel really good or proud about what they're using. Visual Studio is not just another tool or word processor or something; people have built their careers on C# and Visual Studio.

We hear from many people who say stuff like, "hey, if I didn't have Visual Studio, I would just give up programming completely." They tie their programmer identity and their desire to code to the fact that they're using Visual Studio. That's a good amount of people, and we want them to feel good when they use Visual Studio.

Then, there's the name. In order to change the name, there's a bunch of complexity around things like licensing, subscriptions, and support agreements.

So, this time around, I would say there's not one big reason, but a lot of moderate reasons.

**Daniel: This release is simply called Visual Studio 2026. Do you have marketing concerns about tying the release name to the year in that it could potentially sound dated in the future?**

Mads: It's a worry if we're not going to change more. The idea is that it's not just a not change, but something deeper happening. We do have some news coming soon around the name, so keep an eye on the Visual Studio blog for that.

### Features yet to come

---

> The big one for me is an extension called [File Explorer](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.WorkflowBrowser)… We want to build that in somewhere down the line in a minor version.

**Daniel: I'm sure there's always features you wanted that didn't make it in for the initial release. Do you have any of those?**

Mads: Yeah, you always have to cut a bunch of stuff. The big one for me is an extension called [File Explorer](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.WorkflowBrowser). It allows you to, similar to solution folders, pin real folders on disk in your solution, and you can access all the files in there, whether they're in your solution or not. Things like a README file, Dockerfile, GitHub workflows, Copilot instructions, all those. That extension is pretty popular and it's my absolute favorite extension.

We want to build that in somewhere down the line in a minor version. We're doing monthly releases, so hopefully it won't be too long, but I can't say when it will be prioritized.

**Daniel: And who chooses that priority? Is it you?**

Mads: No, there's no one person who decides. There's a bunch of factors that come into play. I come into that discussion as a user ambassador, so maybe I do have a good amount of weight to my argument in that way, but there's a bunch of other things. How feasible is it; how expensive is it; are there any technical debt or infrastructure changes that have to happen first; are there any other high ticket items; does anything in the business need to happen first? Same as everybody else!

### AI & Copilot

---

> Right now, a lot people are pushing back against AI for the sake of itself, which is a sentiment we get a lot. I totally understand that, and it's not the purpose. The purpose is to help you learn more and open doors so you become a better developer.

**Daniel: Obviously, AI is a pretty big thing right now, not just with Visual Studio, but everywhere. Is it fair to say that AI is the theme of this release or is that whittling it down too much?**

Mads: I would say it's one theme, but not the theme. I think AI is part of the story.

I think we're still in the initial phases of learning how to use AI, so AI is its own category. On the release notes, we have a Copilot category. I think in the future, we'll make AI more ambient, so it just becomes a layer that sits inside or underneath Visual Studio. So, the need to talk about, "AI as a feature," I think is going to go down significantly.

What it becomes eventually is a way to be better at debugging, so it's a debugging story. Or, it provides better code completion, so it's a code completion story. Or, it helps you handle your performance optimizations, which is a really hard thing to do, so it's a profiling story.

Let's say that for profiling, there's 10 things you need to do, and some of them you can do without AI. AI doesn't add value for those steps. There's some steps that AI is required to do, though. So, you could say, for this journey that's 10 steps long, we used AI to enable 3 of those steps.

I think that's where we're going. AI becomes more of a foundational building block you can pull out of your toolbox to implement solutions to the same old problems that developers have had for decades. It's not like problems change that much. The problems we face as developers are kind of the same. It's just that now we have another tool to help solve them better. So, it might be problems that were solved already, but we can make the solution even better than what it is with AI.

Right now, a lot people are pushing back against AI for the sake of itself, which is a sentiment we get a lot. I totally understand that, and it's not the purpose. The purpose is to help you become better and open doors so you learn more and become a better developer. So, that kind of joint story happens, but it's not Copilot for the sake of Copilot.

**Daniel: One of the complaints I've read a lot on places like Reddit is that the AI features aren't optional and that they can't be turned off if you don't want them. Is that true?**

Mads: [laughs] We have some tools that analyze social media, and Reddit is definitely the place where people are the most AI-hesitant.

You can turn them off. It's checked by default in the installer, but if you don't want the features, you can uncheck the checkbox for those features.

**Daniel: One of the new features that stood out to me was the built-in code reviews. That looked really cool!**

Mads: Yes – imagine you're a junior developer and afraid to create a PR. This is something we've learned from our own teams. People are hesitant to open source things because, "oh, I have to make the code pretty, it's not good enough yet." It's the same if you're a junior developer and you're going to send your first PR, and you're like, "I'm going to show my boss this awful code?" So in particular for a junior, this is like the perfect tool.

**Daniel: A few weeks ago, [the CEO of AWS actually said that junior developers are more important](https://www.finalroundai.com/blog/aws-ceo-matt-garman-says-replacing-junior-developers-with-ai-the-dumbest-thing), if anything, because they lean into AI the most, and that's what will be important in the future.**

Mads: We talk about cloud-native – well, Gen Z is AI native. I don't think anyone is being replaced, really, I think it's that you get more stuff done at a higher quality. I don't think you can get away with fewer people. At least, I haven't seen that anywhere in the developer world. I would love to have higher velocity. All people have a backlog that's longer than what they can get to.

### Favorite features

---

> Copy-paste is kind of just the cost of doing business; it's part of the dance. Now that we all see this solution to it, we're like, "yeah, that's magic," because you didn't even know you had the problem.

**Daniel: With this major release, are there any features that you're most excited about?**

Mads: [laughs] Everybody asks this question. I try to give a different answer every time.

I'll bring up AI since we talked about that. It illustrates the idea that the problems we have as developers haven't changed, and now we have a tool that otherwise would be improbable, and now we have a tool so that we can solve it for the first time. That would be [adaptive paste](https://devblogs.microsoft.com/visualstudio/effortless-adjustments-with-an-adaptive-paste/).

**Daniel: Actually, adaptive paste might be the feature that I'm most excited about, too, which sounds a little underwhelming at first.**

Mads: When you explain it to people, they're like, "oh, it's not really that big of a problem." But when you debug something for two hours only to find out something little was wrong…

**Daniel: Especially as a blogger, too, I think it's pretty common for people to copy-paste the code snippets into their project, and this helps a lot with that.**

Mads: Right, and it's always been a problem when you copy-paste code, whether it's from the same file or project or StackOverflow or something, you've always had to massage to make it fit your style and also your specific code. The fact that adaptive paste has that ability to make those calls is great.

That's one of the reasons this hasn't been solved before, because you can't do it deterministically. It has to understand a broader context and look at things semantically.

Copy-paste is kind of just the cost of doing business; it's part of the dance. Now that we all see this solution to it, we're like, "yeah, that's magic," because you didn't even know you had the problem. Those are the best things, when there's a solution to something your brain has trained itself to not even consider that's a problem anymore.

**Daniel: There's a project template now for benchmarks using [BenchmarkDotNet](https://github.com/dotnet/BenchmarkDotNet), which is great. Since most developers are [dark matter developers](https://www.hanselman.com/blog/dark-matter-developers-the-unseen-99), I think most probably didn't know about that library, and now that it's built into the IDE, they will, which is great.**

Mads: Yeah! Also, now if you use the Profiler Agent and ask it to performance optimize, it will actually add [BenchmarkDotNet](https://github.com/dotnet/BenchmarkDotNet) to your code, run it, make its optimizations, then run it again to tell you the difference.

That's another example where we've had the Profiler for a long time, and you can use it to find things like expensive lines it code and excessive memory allocations, and most people that use the Profiler know how to do that. What do you do with those, now? How do you know how to optimize an expensive line of code? Sometimes, you don't. Or, at least you don't know how to do it the best way.

So, yeah, we give you the tools to do all those things, like steps 1 through 7. If you really want to take it to the next level and really optimize everything and scientifically prove that you did improve performance, like by running benchmarks a thousand times or something, Copilot makes that possible. Not only that, it does stuff that you might now know, like, oh, now I know to use a HashSet instead of a Dictionary in this situation, and you learn from it.

**Daniel: Are there any features in Visual Studio like that, but for tests?**

Mads: So already, you can just ask Copilot things like, "what am I missing in my tests" or something. It can do a bunch of stuff on its own. We are looking at, though, the foundational stuff, where we can go deeper with AI in Visual Studio.

The [Profiler Agent](https://devblogs.microsoft.com/visualstudio/copilot-profiler-agent-visual-studio/) is the first feature that uses that, but we're going to see more stuff with testing come out, where Visual Studio is able to execute the tests, see the results, that kind of thing. Same thing with debugging, where you need to debug your multi-threaded async call stacks. So, what do you do with those situations?

So, we give you the tools to get to a certain point, but you have to be really low-level to take it from there, and from that point on, you kind of need AI to finish the job. So it's kind of democratizing performance optimization, debugging, test excellence, and all that.

### Cloud-native

---

> It can actually give you very highly educated recommendations on both code and Azure usage. You can ask it to save you money or optimize for performance.

**Daniel: Even with the AI hotness, I think cloud-native is still a pretty big thing. Are there any cloud-native features coming out or planned?**

Mads: Yeah, I think some stuff is coming. Brady Gaster is working on that. One of the more exciting things we did recently is the [Azure MCP server](https://learn.microsoft.com/en-us/azure/developer/azure-mcp-server/get-started/tools/visual-studio?tabs=manual).

What I really like about that is that, if Visual Studio can know about your Azure topology, it can make suggestions for you not only for your code, but for your Azure resources. Should you scale this up or down; should you convert this to a function? It can actually give you very highly educated recommendations on both code and Azure usage. You can ask it to save you money or optimize for performance. Since it knows Azure, it can really go deep.

We have a lot of things coming with security and cloud. I don't know if it will make it in GA or be afterwards. One thing is a secret scanner. This is something that's hard to do deterministically. For instance, you can go through your app settings and check if they follow a certain pattern, but what about other types of secrets? Other YAML files, passwords inside C# strings; that's not really something that's easy to do. So, instead of talking about Copilot as the problem and the solution, the problem here is, "how do you scan for secrets so you don't expose security vulnerabilities?" Also, what's the best way to store that secret? Is it a connection string? That's hard and not obvious.

So, you can imagine the AI saying, "here's what we found; here's what we recommend; do you want me to help with that?" Because it has access to your Azure, it can put it in your Key Vault, hash it, or whatever is the best practice for security, it can do on an individual basis based on the type of vulnerability. I think that's a great, story, too. The problem is the same old problem of security and leaking sensitive information, but the solution has been very difficult. So, using AI as our new tool, we can come up with a better solution than what we had.

### Free features & target audience

---

> We used to make a big deal out of it, but we haven't done any Enterprise-only features for years. So, it's kind of a legacy concept… Code coverage is one we've been wanting to do for a long time and the stars aligned on that one.

**Daniel: Code coverage is no longer an Enterprise-only feature, and is now included in Community and Professional. This was pleasantly surprising to me, since code coverage is such an important tool, and I assume you want to funnel users into paid versions. How do you decide what's free?**

Mads: It's kind of an old strategy to have enterprise-only IDE features. The main reason you want to go Enterprise over Pro or Community is in the things like support deals, MSDN downloads, and priority bug fixing and feature requests. We used to make a big deal out of it, but we haven't done any Enterprise-only features for years. So, it's kind of a legacy concept, but because of the way licenses work, it's actually really hard for us to do anything about it. Code coverage is one we've been wanting to do for a long time and the stars aligned on that one.

**Daniel: Do you have a specific audience or persona in mind for Visual Studio? Is it just all .NET users?**

Mads: The Visual Studio vision is very clear. We want to create the most lovable developer experience for C# and C++. That means, for instance, we don't do Python, we don't do Rust, we don't do Javascript.

**Daniel: You do support, Javascript, though.**

Mads: Well, we won't suck at Javascript. [laughs] Maybe Javascript was the wrong example.

**Daniel: What about F# and Visual Basic? Are those also prioritized by default if you're covering C#?**

Mads: So, it's really funny how that works. If you ask random people what they think of .NET, they're like, "oh, it's this old thing that's closed source and for Microsoft Windows, and it sucks." If you ask the same people what they think of C#, they say, "oh, it's cross platform and it's a beautiful modern language." So, we're changing the way we're talking about it a little bit to be C#.

I think if you're using C#, you know what .NET is, and that includes VB and F#. If you talk to Mads Torgersen, who's the language architect, C# is the main focus. VB will get stuff from C#, and F# is community-driven to an extent, so it kind of has its own rhythm.

So, that's why we say, "lovable experience for C# and C++." That includes .NET, but we're trying to not say .NET because of the new users out there.

### Competition

> The premier experience for developers is in Visual Studio on Windows. If you're using Windows and you want the best developer experience for C++ and C#, it's Visual Studio all the way.

**Daniel: Why should I use Visual Studio over other options like Visual Studio Code and JetBrains Rider?**

Mads: The premier experience for developers is in Visual Studio on Windows. If you're using Windows and you want the best developer experience for C++ and C#, it's Visual Studio all the way. If you're not on Windows, then we recommend VS Code. We've made it so that you can use VS Code successfully with C# Dev Kit and C++ extensions, but we're on Windows and it's not our goal to be on Mac or on Linux.

We've invested way more in the developer experience for VS than VS Code. If you prefer Rider, okay. People have different preferences, and if you're on a Mac, you don't have the option to use Visual Studio.

**Daniel: That's everything I have! Thanks for entertaining all my questions.**

Mads: Yeah, thanks, take care!
