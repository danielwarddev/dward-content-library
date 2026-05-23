Overview

The GitHub Copilot SDK came out at the beginning of this year, and it offers a lot of possibility in the way of integrating AI into your own custom apps. I've been having quite a bit of fun with it since its release, so I figured a post on it was due by now!




Why use the GitHub Copilot SDK?

Using the GitHub Copilot SDK has the exact same effect as calling the Copilot CLI, but in code. Practically, this means that you can wrap GitHub Copilot functionality inside of whatever other logic you want, which you can use to make your own AI-powered applications.

Now, it's true that you can already "chain" together multiple tasks for AI to handle without involving code at all - just create some things like custom prompts, skills, and agents to orchestrate them together and you're good to go. Depending on the task, though, I think the SDK is much better suited, and the result will be much more reliable.

In general, it comes down to who you want to own the workflow as a whole. Do you feel comfortable with AI owning that workflow and connecting all the moving parts, or would it be more better for deterministic code to own the workflow and then AI does only the creative/judgemental tasks?

I don't think one is necessarily better than the other, but it seems to me that the bigger and more complex the workflow as a whole gets, the better an option the SDK becomes.

For instance, here are a few ideas:

Read messages off a deadletter queue and have Copilot analyze why they might have failed and how to fix them.
Your own helper app/agent/bot, ala OpenClaw or Burke Holland's Max.
A production bug fixer  - monitor production logs for defects, fetch related logs when they happen, fetch the GitHub repo and find the offending code based on the stack trace, propose a fix, and create a pull request in the repo once it's finished.




Prerequisites

To be able to use the GitHub Copilot SDK in C#, you'll need the following:

.NET 8+

A GitHub Copilot account (there's a free tier)
Install the GitHub Copilot CLI

Create a new project and add the Nuget package GitHub.Copilot.SDK




A note on documentation

At the time of this writing, the GitHub Copilot SDK is not yet in version 1.0. You may see this a bit as you use it - members sometimes don't have XML docs, some types aren't surfaced as they should be, and you may use magic strings instead of enums, depending on the type.

As far as I can tell, the actual Copilot functionality is all there, but speaking from my own experience, you may have to look at the docs in the SDK repo to get some guidance (which are quite good, admittedly).

I will reference the docs throughout this post to give some helpful context. At the bottom of this post, you'll also find a more complete and realistic example project that uses the Copilot SDK if you'd like to use it as a reference.




How to use the GitHub Copilot SDK

Let's start by showing a quick snippet right off the bat:

var client = new CopilotClient();
await using var session = await client.CreateSessionAsync(new SessionConfig
{
    Model = "gpt-5-mini",
    OnPermissionRequest = PermissionHandler.ApproveAll, // Warning: this is YOLO mode!
});
var response = await session.SendAndWaitAsync(new MessageOptions{ Prompt = "Hey! How's it going today?" });
Console.WriteLine(response?.Data.Content);

If we run this, we see the response from Copilot in the console:

Doing well, thanks - ready to help. What would you like to work on today?

Boiled down, this small snippet is essentially the entire workflow when working with the Copilot SDK.

It's a pretty small code snippet, but let's break it down to point out how some things are working.




The CopilotClient

Firstly, you may notice that there's no API key! This is intentional - while the SDK does support BYOK (bring your own key), by default, it just uses the Copilot CLI that's installed on the host machine. That means that the Copilot CLI needs to be installed on whatever machine is calling the SDK.

There are a few options for giving the SDK access to the Copilot CLI, all of which can be set from the CopilotClientOptions (which we don't use in our example):

(Default) The SDK uses the Copilot CLI executable on the host machine by running "copilot" from your PATH.
Same as above, but you provide a different path to the Copilot CLI executable.
You can bundle the Copilot CLI with your app so that it doesn't need to be installed separately on the host machine.
You can have the Copilot CLI hosted on a remote server and hit that remote server for Copilot responses.

While there's several options, they all still require the Copilot CLI at some point, so it still boils down to the Copilot CLI one way another.




CopilotSessions & OnPermissionRequest

Next, we create a CopilotSession. Sessions are just the different conversations you have with Copilot, same as in the CLI. They can be stopped (CopilotClient.StopAsync()) and resumed (CopilotClient.ResumeSessionAsync()) at a later point in time, and you can have many running at once.

You'll notice that, aside from the model, we set one additional property on the session: OnPermissionRequest. This property is very important and is not a hook or a session event (covered later in this post); it's its own property that decides if Copilot's permission requests get through or not.

In fact, it's so important that you actually get an exception if you don't set the property:

System.ArgumentException: 'An OnPermissionRequest handler is required when creating a session. For example, to allow all permissions, use CreateSessionAsync(new() { OnPermissionRequest = PermissionHandler.ApproveAll });'

We set it to an out-of-the-box handler, PermissionHandler.ApproveAll. This is the same as using YOLO mode in the Copilot CLI, and all requests will be approved. However, if your app is user-facing, you almost certainly don't want to do this, and instead want more granular approvals.

Here's an example of a custom permission handler that denies all requests except for Powershell commands:

OnPermissionRequest = (request, invocation) =>
{
    if (request.Kind == "powershell")
    {
        return Task.FromResult(new PermissionRequestResult { Kind = PermissionRequestResultKind.Approved });
    }
    return Task.FromResult(new PermissionRequestResult { Kind = PermissionRequestResultKind.DeniedByRules });
}

Aside from that, the SessionConfig has some of the more interesting properties to set, such as:

Model. The model to use and its reasoning level (ReasoningEffort if the model supports it)
SystemMessage. The system prompt, which can be overwritten or appended to
AvailableTools, ExcludedTools, and Tools. Available tools to the model, with Tools being custom ones
McpServers. Self-explanatory
Hooks. Similar to session events, but these are built into Copilot itself and also exist outside the SDK. We talk about session events and hooks more below
More!

We won't go over everything in this post, but I encourage you to play around with the different options. In particular, if you're making a custom solution, you may want to override or add to the default system prompt that Copilot has.




Sending the message - that's it!

Finally, we send a prompt in the session and get the response back from the model. You can attach files and directories in the MessageOptions here for context if you like, although we don't in this post (the repo lined below has an example of this, though).

That's pretty much the entire process picked apart.

The rest of this post will be looking at bit deeper at some of the different options to give Copilot some more capabilities in that process, though there's far too many to cover everything in a single post. This is just to whet your whistle!




Using session events

Let's cover session events, which are quite powerful. To illustrate them, we'll use streaming responses.

The above code doesn't use streaming responses. If you've used any kind of AI tool, streaming responses are probably what you're used to seeing, where the response comes in gradually as it's created. If you're making something user-facing, you should probably use streaming responses.

To demonstrate the response streaming, let's listen for a couple of events from the Copilot SDK, so that we can see how the response comes in. Here's how to do that:

var client = new CopilotClient();
await using var session = await client.CreateSessionAsync(new SessionConfig
{
    Model = "gpt-5-mini",
    OnPermissionRequest = PermissionHandler.ApproveAll,
    Streaming = true
});

var subscriptions = session.On(sessionEvent =>
{
    if (sessionEvent is AssistantMessageDeltaEvent deltaEvent)
    {
        Console.Write($"{deltaEvent.Data.DeltaContent}***");
    }

    if (sessionEvent is SessionIdleEvent)
    {
        Console.WriteLine("idle...");
    }
});
        
var response = await session.SendAndWaitAsync(new MessageOptions { Prompt = "Hey! How's it going today?" });
Console.WriteLine(response?.Data.Content);

Running this, we see something like the following (the asterisks just help us to see the different chunks as they came in):

Doing*** well*** -*** ready*** to*** help***.*** What*** would*** you*** like*** to*** work*** on*** today***?***idle...
Doing well - ready to help. What would you like to work on today?


As you can see, we can still get the completed response at the end, but we can also respond to more granular events as Copilot does its work.

For events, we call On() on our session object, which allows us to react to session events from Copilot. In this case, we're responding to two session events:

AssistantMessageDeltaEvent, which fires off whenever we get a new piece of the response from Copilot.
SessionIdleEvent, which fires off when the response is fully complete.

There are a large variety of other events, as well, which you can see here. They are quite granular, so you can react to a lot of things, such as user input, MCP usage, subagent work, and much more.




Using hooks

Hooks are similar to session events in that they let you respond to things happening with Copilot. Hooks are a normal Copilot feature that also exist outside of the SDK, though, and the hooks you can use inside the SDK are the same hooks you can use outside the SDK. Namely, these are

onPreToolUse, onPostToolUse
onSessionStart, onSessionEnd
onUserPromptSubmitted
onErrorOccurred

Here's an example of using hooks:

var client = new CopilotClient();
await client.StartAsync();

var session = await client.CreateSessionAsync(new SessionConfig
{
    Model = "gpt-5-mini",
    OnPermissionRequest = PermissionHandler.ApproveAll,
    Hooks = new SessionHooks
    {
        OnUserPromptSubmitted = async (input, invocation) =>
        {
            return await Task.FromResult(new UserPromptSubmittedHookOutput
            {
                ModifiedPrompt = $"You must talk like a pirate in your response.\n\n{input.Prompt}"
            });
        }
    }
});

var response = await session.SendAndWaitAsync(new MessageOptions
{
    Prompt = "How's the weather in San Antonio today?"
});

Console.WriteLine(response.Data.Content);

This returns a response like the following:

Arrr - I canna fetch the live weather fer San Antonio right now; the internet seas be closed to me. Typically in early April ye can expect mild-to-warm days - highs about 70-85°F (21-29°C) and nights ~50-65°F (10-18°C), with a fair chance o' showers or thunderstorms. If ye want an exact current forecast, hand over a weather link or say the word and I'll tell ye how to fetch it yerself.

In this case, we used a hook to perform prompt injection on the user's prompt.

You can use hooks to do things like log tool executions, modify a tool's arguments before it executes, deny tool execution, modify tool results, modify the user prompt, and more. Combined with session events, you essentially have free reign to do what you like in your code with the tool invocations and results.




Using MCP servers

MCP servers are added in the SessionConfig. We can have add both local servers (McpLocalServerConfig) and remote ones (McpRemoteServerConfig).

The way you configure these is pretty much the same as you would in any other Copilot environment. Here's an example:

var client = new CopilotClient();
await using var session = await client.CreateSessionAsync(new SessionConfig
{
    Model = "gpt-5-mini",
    Streaming = true,
    McpServers = new Dictionary<string, object>
    {
        ["playwright"] = new McpLocalServerConfig
        {
            Command = "npx",
            Args = ["@playwright/mcp@latest"],
            Tools = ["*"]
        }
    }
});

var response = await session.SendAndWaitAsync(new MessageOptions { Prompt = "Open up a browser using Playwright MCP and go to google.com" });
Console.WriteLine(response?.Data.Content);

As this runs, you should see a browser open up, go to google.com, then close as your dotnet process spins down.




Using custom tools

In my opinion, custom tools are one of the more powerful (and cooler) features of the SDK. They allow you to give whatever C# code you want to Copilot to execute as a tool. It'll even hit your breakpoints in them!

Here's an example:

var client = new CopilotClient();
await client.StartAsync();

var session = await client.CreateSessionAsync(new SessionConfig
{
    Model = "gpt-5-mini",
    OnPermissionRequest = PermissionHandler.ApproveAll,
    Tools = [AIFunctionFactory.Create(GetWeather)], // C# code given to the model as a tool here
});

var response = await session.SendAndWaitAsync(new MessageOptions
{
    Prompt = "How's the weather in San Antonio today?"
});

Console.WriteLine(response.Data.Content);

// Custom weather tool written in C#
[DisplayName("get_weather")]
[Description("Gets the current weather for a given city.")]
WeatherData GetWeather([Description("The name of the city to get the weather for")] string cityName)
{
    return new WeatherData(cityName, 100, "It's too dang hot");
}

record WeatherData(string City, int Temperature, string Condition);

Running this, we get a response like this, confirming our tool use:

San Antonio: 100°F, "It's too dang hot."

The DisplayName and Description attributes tell model how to use our tool, and AIFunctionFactory.Create() is a helper from Microsoft.Extensions.AI that takes care of turning our C# code into something the model knows how to call.

You can even put a breakpoint in the C# code of the tool if you want!

Keep in mind that you can't use spaces in tool names. Also, the AI decides for itself when and how to use tools based on the tool name, tool description, and parameter descriptions, so be sure to make those descriptive enough so that it's more likely to get it right.




Make sure you dispose!

Note that that On() returns an IDisposable, and the CopilotClient implements IDisposable and IDisposableAsync. Be sure to dispose of them properly!




Repo example - a more realistic app

Rather than only code snippets, I'd also like to provide you with a more realistic example with patterns you might actually see with the Copilot SDK in a bigger app: https://github.com/danielwarddev/PocGenerator.

This example is a side project I've been working on for myself that I simply called PocGenerator. It uses the Copilot SDK to take in a markdown file describing an app idea in English, then goes through three phases of Planning > Generation > Verification to spit out a working proof-of-concept application of the idea in about 30-90 minutes.

It uses most of the features mentioned in this post and some others not mentioned, so I'd like to think that it's a good resource to use as an example. Check it out if you're so inclined!