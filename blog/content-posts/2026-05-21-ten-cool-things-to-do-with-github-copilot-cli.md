# Ten cool things to do with GitHub Copilot CLI

**Date:** May 21, 2026  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/ten-cool-things-to-do-with-github-copilot-cli/

### Overview

The Copilot CLI has a lot of features! On one hand, if you wanted to learn about them all, you could just look at the official documentation. On the other hand, documentation does not tell you the practicalities of how a tool is used that you gain from experience using it.

So, rather than me simply reproduce documentation (and surely do a questionable job at it), I thought I'd share from my own experience some of the Copilot CLI features I think are actually useful and/or noteworthy to look into, along with a bite-size rundown of how to use each one.

### Important: turn on /experimental!

Many of these features are currently experimental. In order to access them, you must first run `/experimental` to turn on experimental features. Experimental features are ones that are still in development, but in my experience, they are as stable as any other.

### 1. Manage the same Copilot session from github.com or your phone with /remote

#### Or: How to keep prompting Copilot from your phone when you should be touching grass instead

_Docs link: [https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/steer-remotely](https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/steer-remotely)_

Ever wanted to keep prompting Copilot when you should be attending to real, adult responsibilities instead? Now you can!

`/remote` allows you to interact with the current session either on github.com or on your phone through the GitHub mobile app. Run `/remote on` to get a github.com link to the session, and then press `Ctrl`/`Cmd`+`E` to also get a nice little QR code right in your terminal. When scanned with your phone, the QR code will take you straight to the session on the GitHub mobile app.

[![Remote QR code screenshot](https://daninacan.com/wp-content/uploads/2026/05/remoteqrcode.jpg)](https://daninacan.com/wp-content/uploads/2026/05/remoteqrcode.jpg)

(And no, you can't access my session by scanning that code. You only have access to your own sessions, so stop that.)

Something important to keep in mind is that **the session is still running locally from the CLI on your machine.** It merely allows you to access that locally running session from github.com or the mobile app. Practically, this means that your computer needs to stay on. You can use the `/keep-alive` command to help with this.

Also of particular note is that you'll quickly notice that **slash commands are not available on github.com or the mobile app,** although skill commands still seem to manually invoke correctly. To me, this makes this feature's use case something along the lines of, "I'm stepping away, but still want to see where things are with Copilot, approve a tool/answer a question it's asking me, or send a quick correction."

### 2. Run deep research with /research

_Docs link: [https://docs.github.com/en/copilot/concepts/agents/copilot-cli/research](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/research)_

Run `/research <your topic>` to have the Copilot CLI research that topic. This can be something about your codebase, or something completely different that you just happened to be interested in.

When it's finished, it produces a (rather long) markdown document with both its findings and all its sources listed. You can view the research after it's done with `Ctrl`/`Cmd`+`Y`.

In my experience, this usually takes around 10-30 minutes to run, and the research document it produces is around 500 lines of content with 30-50 sources referenced.

### 3. Share session history and research results as markdown, HTML, or to a gist with /share

_Docs link: None_

This one pairs naturally with `/research`, since you can share the research results. In addition to sharing research results, you can also share any session as a markdown or HTML file.

The different options for this command can be a little confusing at first glance, so here's the summary:

- You can export either the current session history or a research document from the current session
- You can export these as either a markdown file or an HTML file
- You can export as either a local file or a gist

For some example output, here's what `/share html session` produced for one of my sessions. It's quite thorough!

[![Session HTML screenshot](https://daninacan.com/wp-content/uploads/2026/05/session-html.jpg)](https://daninacan.com/wp-content/uploads/2026/05/session-html.jpg)

### 4. Complete a task with multiple subagents in parallel with /fleet

_Docs link: [https://docs.github.com/en/copilot/concepts/agents/copilot-cli/fleet](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/fleet)_

Running `/fleet <prompt>` will complete the requested task by spinning up multiple subagents to do as much work in parallel as possible. The subagents used in fleet mode can also be custom agents you've created. If you want to be sure your custom agents are used, you can explicitly tell Copilot to use them (and how to use them) in your prompt.

According to [Evan Boyle of the Copilot CLI team](https://www.linkedin.com/posts/evan-boyle-107a1445_fleet-is-available-in-experimental-mode-activity-7425264653586403328-pvxv), `/fleet` works by using a SQLite database for the session that helps inform dependencies between tasks to make the parallelization possible. Pretty cool!

This is not to say you should use `/fleet` by default. From my own experience, there does seem to be some level of overhead when using it that makes your prompts take longer. I assume this is the time it takes to orchestrate the work between the subagents. If your task is relatively small and would not gain much of a speed boost from being done in parallel somehow, you might be better off without it.

### 5. Use autopilot mode to allow Copilot to work autonomously in a loop

_Docs link: [https://docs.github.com/en/copilot/concepts/agents/copilot-cli/autopilot](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/autopilot)_

Autopilot mode is a good follow-up after talking about `/fleet`, since they go hand in hand. Running `/autopilot` (or hitting `Shift`+`Tab` to switch modes) will put you in autopilot mode, which looks like this:

[![Autopilot CLI screenshot](https://daninacan.com/wp-content/uploads/2026/05/autopilotcli.jpg)](https://daninacan.com/wp-content/uploads/2026/05/autopilotcli.jpg)

This is essentially Copilot CLI's built-in implementation of a [ralph loop](https://ghuntley.com/ralph/). The long and short of it is that, **when given a task in autopilot mode, Copilot will continue to iterate until the overarching task itself is complete.** Let's talk about what that means real quick.

You can run in autopilot mode without running in `/yolo` mode (all permissions allowed), but the CLI will recommend you turn on yolo mode when you enable autopilot. Also, just like the `--no-ask-user` flag, autopilot mode will not use the `ask_user` tool for clarifying questions.

The practical difference is that, without autopilot mode and given a large enough task, you'll almost certainly need to prompt Copilot multiple times along the way until that task is complete. Autopilot allows Copilot to work continuously until the task is done.

Because autopilot is an autonomous loop to complete a large task, I recommend the following when using autopilot:

- Use the `--max-autopilot-continues <number>` flag to limit the number of loops it can perform, unless you know for certain you can be at your computer to monitor it the entire time.
- Make a plan file first to help guide its work. You can use `/plan` for this or just tell it to start off its work by making a plan first.
- Use `/fleet` mode to parallelize the work to get it done faster.

I think of this feature as mostly useful for a more "vibe coding" style of usage, where I'm not going to do a super thorough review of the output and I just want to push out something like a quick proof of concept. For production work, I prefer to work in smaller batches to maintain control over what AI is doing and review its work. Both styles of working have their place!

### 6. Review changes using a different model family with rubberducking

_Docs link: [https://docs.github.com/en/copilot/concepts/agents/copilot-cli/rubber-duck](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/rubber-duck)_

Rubberducking is a built-in way to do adversarial review, and even better, it happens by itself. When Copilot works on a task, it will sometimes choose to ["rubber duck"](https://en.wikipedia.org/wiki/Rubber_duck_debugging) the work. When this happens, it reviews the changes that were made **while using a different model family than the one being used to perform the work.** So, if you did the work using a GPT model, it will rubberduck with a Claude model, and vice versa.

Also, **this feature is currently only available when using GPT or Claude models.**

Here's an example of the Rubber-duck agent being run:

[![Rubber duck agent screenshot](https://daninacan.com/wp-content/uploads/2026/05/rubberduck-agent.jpg)](https://daninacan.com/wp-content/uploads/2026/05/rubberduck-agent.jpg)

According to the Copilot documentation, rubberducking will occur:

- After planning a non-trivial change, but before implementing it
- Mid-implementation
- After writing tests
- When Copilot hits repeated failures or unexpected results

You can also manually ask for a rubber duck using `/rubber-duck` or just asking in plain English in your prompt (for example, "rubber duck the plan" or "critique the changes").

### 7. Ask a side question while Copilot is working with /ask

_Docs link: None_

`/ask` allows you to ask Copilot a question on the side while it's already doing work without interrupting that work. This sounds like it's not really a huge deal, but it actually is quite nice to not have to open up a new session just for a quick question, which would also make you lose out on your current context.

Even better, `/ask` **does not take up context in the main session,** so you don't have to worry about bloating your context window from the one-off and sometimes unrelated questions you have.

Notice how there's no input box here for me to prompt again after Copilot responds, since `/ask` is meant for one-offs:

[![Side question screenshot](https://daninacan.com/wp-content/uploads/2026/05/sidequestion.jpg)](https://daninacan.com/wp-content/uploads/2026/05/sidequestion.jpg)

### 8. Ask about your session history and prompting patterns with /chronicle

_Docs link: [https://docs.github.com/en/copilot/concepts/agents/copilot-cli/chronicle](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/chronicle)_

Your separate conversations with Copilot are called "sessions." In the Copilot CLI, the session data is stored locally both in session state files (at `~/.copilot/session-state/`) and a SQLite database (at `~/.copilot/session-store.db`). The session state files are considered the source of truth, and the SQLite database is created from them.

`/chronicle` allows you to get feedback on your Copilot usage based on that SQLite database. There are four ways to do this:

1. `/chronicle standup`. Gives you a "standup" report by summarizing what work you did in your recent Copilot CLI sessions.
2. `/chronicle tips`. Copilot reviews the history of how you've prompted Copilot in the current repo and gives you tips on how to use it better.
3. `/chronicle improve`. Copilot looks for places where it misunderstood you or where there was a lot of back and forth. From those, it adds points to your copilot-instructions.md to help mitigate those misunderstandings in the future.
4. `/chronicle cost-tips`. Copilot looks at your session histories, not only the current session, to see not only your prompting patterns, but how well optimized your Copilot usage is with things like how many times a skill is injected, any redundant instructions, and if you could ever manually `/compact`.

There's also `/chronicle reindex`, but this is just a way to rebuild the SQLite database from the flat files in case you manually delete some session data.

### 9. Add monthly quota, context window %, reasoning level, and custom info to the status line

_Docs link: None_

You can run `/statusline` to choose some additional information to display in Copilot's status bar. I like to display everything, including the reasoning effort, remaining premium requests, and the session context percentage. In my opinion, these should be the default options, anyway!

You can also add custom information to the status bar, though this is done outside of the `/statusline` command itself.

In this screenshot, notice that it's displaying all the things mentioned above, as well as a silly custom status line script I made.

[![Status line screenshot](https://daninacan.com/wp-content/uploads/2026/05/statusline.jpg)](https://daninacan.com/wp-content/uploads/2026/05/statusline.jpg)

### 10. Fork a session to try different strategies from the same context with /fork

_Docs link: None_

Running `/fork` will duplicate your current session, including its session history. This allows you to use the same starting point of context to try different strategies.

This is a simple one, but quite useful when you want to experiment with what the AI does in different situations. Without this, you'd have to instead open up a new session with an empty context and give it the information it needs, which still isn't exactly equivalent to duplicating the session.

### That's it!

As said, I hope that you can find this guide useful as either a reference or a tutorial of sorts.
