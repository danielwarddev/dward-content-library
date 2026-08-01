<h3>Overview</h3>
The Copilot CLI has a lot of features! On one hand, if you wanted to learn about them all, you could just look at the official documentation. On the other hand, documentation doesn't tell you the practicalities of how a tool is used that you gain from experience using it.

So, rather than me simply reproduce documentation (and surely do a questionable job at it), I thought I'd share from my own experience some of the Copilot CLI features I think are actually useful and/or noteworthy to look into, along with a bite-size rundown of how to use each one.

&nbsp;
<h3>Important: turn on /experimental!</h3>
Many of these features are currently experimental. In order you to access them, you must first run <code class="language-bash">/experimental</code> to turn on experimental features. Experimental features are ones that are still in development, but in my experience, they are as stable as any other.

&nbsp;
<h3>1. Manage the same Copilot session from github.com or your phone with /remote</h3>
<h5><em>Or: How to keep prompting Copilot from your phone when you should be touching grass instead</em></h5>
<em>📜 Docs link: <a href="https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/steer-remotely" target="_blank" rel="noopener">https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/steer-remotely</a></em>

Ever wanted to keep prompting Copilot when you should be attending to real, adult responsibilities instead? Now you can!

<code class="language-bash">/remote</code> allows you to interact with the current session either on github.com or on your phone through the GitHub mobile app. Run <code class="language-bash">/remote on</code> to get a github.com link to the session, and then press <code class="language-bash">ctrl</code>/<code class="language-bash">cmd</code>+<code class="language-bash">e</code> to also get a nice little QR code right in your terminal. When scanned with your phone, the QR code will take you straight to the session on the GitHub mobile app.

<a href="https://daninacan.com/wp-content/uploads/2026/05/remoteqrcode.jpg"><img class="alignnone size-full wp-image-1830" src="https://daninacan.com/wp-content/uploads/2026/05/remoteqrcode.jpg" alt="" width="666" height="553" /></a>

(And no, you can't access my session by scanning that code. You only have access to your own sessions, so stop that.)

Something important to keep in mind is that <strong>the session is still running locally from the CLI on your machine.</strong> It merely allows you to access that locally-running session from github.com or the mobile app. Practically, this means that your computer needs to stay on. You can use the <code class="language-bash">/keep-alive</code> command to help with this.

Also of particular note is that you'll quickly notice that <strong>slash commands aren't available on github.com or the mobile app,</strong> although skill commands still seem manually invoke correctly. To me, this makes this feature's use case something along the lines of, "I'm stepping away, but still want to see where things are with Copilot, approve a tool/answer a question it's asking me, or send a quick correction."

&nbsp;
<h3>2. Run deep research with /research</h3>
<em>📜 Docs link: <a href="https://docs.github.com/en/copilot/concepts/agents/copilot-cli/research" target="_blank" rel="noopener">https://docs.github.com/en/copilot/concepts/agents/copilot-cli/research</a></em>

Run <code class="language-bash">/research &lt;your topic&gt;</code> to have the Copilot CLI research that topic. This can be something about your codebase, or something completely different that you just happened to be interested in.

When it's finished, it produces a (rather long) markdown document with both its findings and all its sources listed. You can view the research after it's done with <code class="language-bash">ctrl</code>/<code class="language-bash">cmd</code>+<code class="language-bash">y</code>.

In my experience, this usually takes around 10-30 minutes to run, and the research document it produces is around 500 lines of content and with 30-50 sources referenced.
<h3></h3>
<h3>3. Share session history and research results as markdown, HTML, or to a gist with /share</h3>
<em>📜 Docs link: None</em>

This one pairs naturally with <code class="language-bash">/research</code>, since you can share the research results. In addition to sharing research result, you can also share any session as a markdown or HTML file.

The different options for this command can be a little confusing at first glance, so here's the summary:
<ul>
 	<li>You can export either the current session history or a research document from the current session</li>
 	<li>You can export these as either a markdown file or an HTML file</li>
 	<li>You can export as either a local file or a gist</li>
</ul>
For some example output, here's what <code class="language-bash">/share html session</code> produced for one of my sessions. It's quite thorough!

<a href="https://daninacan.com/wp-content/uploads/2026/05/session-html.jpg"><img class="alignnone size-full wp-image-1824" src="https://daninacan.com/wp-content/uploads/2026/05/session-html.jpg" alt="" width="1513" height="738" /></a>

&nbsp;
<h3>4. Complete a task with multiple subagents in parallel with /fleet</h3>
<em>📜 Docs link:</em><a href="https://docs.github.com/en/copilot/concepts/agents/copilot-cli/fleet" target="_blank" rel="noopener"><em> https://docs.github.com/en/copilot/concepts/agents/copilot-cli/fleet</em></a>

Running <code class="language-bash">/fleet &lt;prompt&gt;</code> will complete the requested task by spinning up multiple subagents to do as much work in parallel as possible. The subagents used in fleet mode can also be custom agents you've created. If you want to be sure your custom agents are used, you can explicitly tell Copilot to use them (and how to use them) in your prompt.

<a href="https://www.linkedin.com/posts/evan-boyle-107a1445_fleet-is-available-in-experimental-mode-activity-7425264653586403328-pvxv" target="_blank" rel="noopener">According to Evan Boyle of the Copilot CLI team</a>, <code class="language-bash">/fleet</code> works by using a SQLite database for the session that helps inform dependencies between tasks to make the parallelization possible. Pretty cool!

This is not to say you should use <code class="language-bash">/fleet</code> by default. From my own experience, there does seem to be some level of overhead when using it that makes your prompts take longer. I assume this is the time it takes to orchestrate the work between the subagents. If your task is relatively small and wouldn't gain much of a speed boost from being done in parallel somehow, you might be better off without it.

&nbsp;
<h3>5. Use autopilot mode to allow Copilot to work autonomously in a loop</h3>
<em> 📜 Docs link: <a href="https://docs.github.com/en/copilot/concepts/agents/copilot-cli/autopilot" target="_blank" rel="noopener">https://docs.github.com/en/copilot/concepts/agents/copilot-cli/autopilot</a></em>

Autopilot mode is good followup after talking about <code class="language-bash">/fleet</code>, since they go hand-in-hand. Running <code class="language-bash">/autopilot</code> (or hitting <code class="language-bash">shift</code>+<code class="language-bash">tab</code> to switch modes) will put you in autopilot mode, which looks like this:

<a href="https://daninacan.com/wp-content/uploads/2026/05/autopilotcli.jpg"><img class="alignnone size-full wp-image-1832" src="https://daninacan.com/wp-content/uploads/2026/05/autopilotcli.jpg" alt="" width="209" height="61" /></a>

This is essentially Copilot CLI's built-in implementation of a <a href="https://ghuntley.com/ralph/" target="_blank" rel="noopener">ralph loop</a>. The long and short of it is that, <strong>when given a task in autopilot mode, Copilot will continue to iterate until the overarching task itself is complete. </strong>Let's talk about what that means real quick.

You can run in autopilot mode without running in <code class="language-bash">/yolo</code> mode (all permissions allowed), but the CLI will recommend you turn on yolo mode when you enable autopilot. Also, just like the <code class="language-bash">--no-ask-user flag</code>, autopilot mode will not use the <code class="language-bash">ask_user</code> tool for clarifying questions.

The practical difference is that, without autopilot mode and given a large enough task, you'll almost certainly need to prompt Copilot multiple times along the way until that task is complete. Autopilot allows Copilot to work continuously until the task is done.

Because autopilot is an autonomous loop to complete a large task, I recommend the following when using autopilot:
<ul>
 	<li>Use the <code class="language-bash">--max-autopilot-continues &lt;number&gt;</code> flag to limit the number of loops it can perform, unless you know for certain you can be at your computer to monitor it the entire time.</li>
 	<li>Make a plan file first to help guide its work. You can use <code class="language-bash">/plan</code> for this or just tell it to start off its work by making a plan first.</li>
 	<li>Use <code class="language-bash">/fleet</code> mode to parallelize the work to get it done faster.</li>
</ul>
I think of this feature as mostly useful for a more "vibe coding" style of usage, where I'm not going to do a super thorough review of the output and I just want to push out something like a quick proof-of-concept. For production work, I prefer to work in smaller batches to maintain control over what AI is doing and review its work. Both styles of working have their place!

&nbsp;
<h3>6. Review changes using a different model family with rubberducking</h3>
<em>📜 Docs link:</em><a href="https://docs.github.com/en/copilot/concepts/agents/copilot-cli/rubber-duck" target="_blank" rel="noopener"><em> https://docs.github.com/en/copilot/concepts/agents/copilot-cli/rubber-duck</em></a>

Rubberducking is a built-in way to do adversarial review, and even better, it happens by itself. When Copilot works on a task, it will sometimes choose to <a href="https://en.wikipedia.org/wiki/Rubber_duck_debugging">"rubber duck"</a> the work. When this happens, it reviews the changes that were made <strong>while using a different model family than the one being used to perform the work.</strong> So, if you did the work using a GPT model, it will rubberduck with a Claude model, and vice versa.

Also, <strong>this feature is currently only available when using GPT or Claude models.</strong>

Here's an example of the Rubber-duck agent being run:

<a href="https://daninacan.com/wp-content/uploads/2026/05/rubberduck-agent.jpg"><img class="alignnone size-full wp-image-1823" src="https://daninacan.com/wp-content/uploads/2026/05/rubberduck-agent.jpg" alt="" width="996" height="176" /></a>

According to the Copilot documentation, rubberducking will occur:
<ul>
 	<li>After planning a non-trivial change, but before implementing it</li>
 	<li>Mid-implementation</li>
 	<li>After writing tests</li>
 	<li>When Copilot hits repeated failures or unexpected results</li>
</ul>
You can also manually ask for a rubberduck using <code>/rubber-duck</code> or just asking in plain English in your prompt (eg, "rubber duck the plan" or "critique the changes").

&nbsp;
<h3>7. Ask a side question while Copilot is working with /ask</h3>
<em>📜 Docs link: None</em>

<code class="language-bash">/ask</code> allows you to ask Copilot a question on the side while it's already doing work without interrupting that work. This sounds like it's not really a huge deal, but it actually is quite nice to not have to open up a new session just for a quick question, which would also make you lose out on your current context.

Even better, <code class="language-bash">/ask</code> <strong>does not take up context in the main session</strong>, so you don't have to worry about bloating your context window from the one-off and sometimes unrelated questions you have.

Notice how there's no input box here for me to prompt again after Copilot responds, since <code class="language-bash">/ask</code> is meant for one-offs:

<a href="https://daninacan.com/wp-content/uploads/2026/05/sidequestion.jpg"><img class="alignnone size-full wp-image-1833" src="https://daninacan.com/wp-content/uploads/2026/05/sidequestion.jpg" alt="" width="681" height="250" /></a>

&nbsp;
<h3>8. Ask about your session history and prompting patterns with /chronicle</h3>
<em>📜 Docs link: </em><a href="https://docs.github.com/en/copilot/concepts/agents/copilot-cli/chronicle" target="_blank" rel="noopener"><em>https://docs.github.com/en/copilot/concepts/agents/copilot-cli/chronicle</em></a>

Your separate conversations with Copilot are called "sessions." In the Copilot CLI, the session data is stored locally both in session state files (at <code class="language-bash">~/.copilot/session-state/</code>) and a SQLite database (at <code class="language-bash">~/.copilot/session-store.db</code>). The session state files are considered the source of truth, and the SQLite database is created from them.

<code class="language-bash">/chronicle</code> allows you to get feedback on your Copilot usage based on that SQLite database. There are four ways to do this:
<ol>
 	<li><code class="language-bash">/chronicle standup</code>. Gives you a "standup" report by summarizing what work you did in your recent Copilot CLI sessions.</li>
 	<li><code class="language-bash">/chronicle tips</code>. Copilot reviews the history of how you've prompted Copilot in the current repo and gives you tips on how to use it better.</li>
 	<li><code class="language-bash">/chronicle improve</code>. Copilot looks for places where it misunderstood you or where there was a lot of back-and-forth. From those, it adds points to your copilot-instructions.md to help mitigate those misunderstandings in the future.</li>
 	<li><code class="language-bash">/chronicle cost-tips</code>. Copilot looks at your session histories (not only the current session) to see not only your prompting patterns, but how well-optimized your Copilot usage is with things like how many times a skill is injected, any redundant instructions, and if you could ever manually <code class="language-bash">/compact</code>.</li>
</ol>
There's also <code class="language-bash">/chronicle reindex</code>, but this is just a way to rebuild the SQLite database from the flat files in case you manually delete some session data.

&nbsp;
<h3>9. Add monthly quota, context window %, reasoning level, and custom info to the status line</h3>
<em>📜 Docs link: None</em>

You can run <code class="language-bash">/statusline</code> to choose some additional information to display in Copilot's status bar. I like to display everything, including the reasoning effort, remaining premium requests, and the session context percentage . In my opinion, these should be the default options, anyway!

You can also add custom information to the status bar, though this is done outside of the <code class="language-bash">/statusline</code> command itself.

In this screenshot, notice that it's displaying all the things mentioned above, as well as a silly custom status line script I made.

<a href="https://daninacan.com/wp-content/uploads/2026/05/statusline.jpg"><img class="alignnone size-full wp-image-1828" src="https://daninacan.com/wp-content/uploads/2026/05/statusline.jpg" alt="" width="925" height="137" /></a>

&nbsp;
<h3>10. Fork a session to try different strategies from the same context with /fork</h3>
<em>📜 Docs link: None</em>

Running <code class="language-bash">/fork</code> will duplicate your current session, including its session history. This allows you to use the same starting point of context to try different strategies.

This is a simple one, but quite useful when you want to experiment with what the AI does in different situations. Without this, you'd have to instead open up a new session with an empty context and give it the information it needs, which still isn't exactly equivalent to duplicating the session.

&nbsp;
<h3>That's it!</h3>
As said I hope that you can find this guide useful as either a reference or a tutorial of sorts.