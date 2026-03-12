# Put An Agent Inside Your App In 10 Minutes Or Less With the GitHub Copilot SDK

## Description

What if adding a custom AI agent to your app took less time than your next standup? Custom AI solutions for your company used to require a dedicated team and a big budget. Now, with the GitHub Copilot SDK, you can embed AI capabilities that understand your enterprise domain knowledge, tools, and workflows in an afternoon.

This session shows you how to go from zero to a working AI agent embedded in your application in 10 minutes or less, live on stage. We'll cover how to set up the tools, why you might want to use the Copilot SDK, and what kind of agents you can build with it. You'll leave with working knowledge of how to use the GitHub Copilot SDK to put Copilot's capabilities into your existing applications today.

The live demo will be in C#, but the SDK is in a variety of languages, so the knowledge is transferable.

## Organizer notes

The GitHub Copilot SDK is very newly released (this week!) and so is very topical. Additionally, I think that, since GitHub Copilot has not been talked about as much on social media, less people know how it works.

Attendees will learn how and why to use the GitHub Copilot SDK, see the code for a custom agent using the SDK and see it in action, and how they could use it on their teams today.

### 20-minute version

Talk outline:
- Why build custom agents? Limitations and benefits
- GitHub Copilot SDK - what it is, SDK vs building from scratch
- Demo of using the SDK to build a custom agent

The lightning talk version of this session would just be a quicker overview of the GitHub Copilot SDK with a short demo.

### 60-minute version

The 60-minute version keeps the same core structure and adds significant depth. Talk outline:
- What is an agent? (deeper, with step-by-step reasoning examples and non-determinism)
- GitHub Copilot SDK - what it is, architecture, auth options, BYOK
- SDK vs. prompting - when to use which (with decision flowchart)
- Tool design deep dive - naming, descriptions, rules of thumb, live contrast demo
- Demo 1: Build a simple agent from scratch in ~10 minutes (live coding)
- Testing AI agents - deterministic vs. non-deterministic, snapshot testing, hooks
- Production gotchas - latency, cost, guardrails, CLI in prod, observability
- Demo 2: Real-world MVP generator walkthrough (pre-built, shows scale)
- Where the SDK fits in the landscape (vs. agent frameworks)

Detailed outline: [copilot-sdk-60min-outline.md](copilot-sdk-60min-outline.md)