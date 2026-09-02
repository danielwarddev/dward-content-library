# Game Development Plan

**Context:** The third side-income stream, alongside [workshop-on-ramp-plan.md](workshop-on-ramp-plan.md)
(the income plan) and [building-plan.md](building-plan.md) (the solo-building track). See
[README.md](README.md) for the overview.

## Objective

Explore game development as a side-income opportunity without allowing uncertain commercial outcomes to undermine the enjoyment of the hobby.

The recommended strategy is a barbell:

1. **Commercial side:** Build game-development tools, plugins, templates, or educational products that take advantage of professional expertise in .NET, testing, AI, and software architecture.
2. **Creative side:** Build deliberately small games, validate them with real players, and invest further only when player behavior demonstrates unusual promise.

Complete indie games can produce meaningful income, but their returns are highly unpredictable. Developer tools are generally a better fit for specialized technical expertise and an introvert-friendly, asynchronous business.

## Commercial Reality

Game development is viable for side income, but making and selling complete games is not a predictable path to it.

Major storefronts receive a large volume of releases, and revenue is heavily concentrated among a relatively small number of successful games. Steam's standard revenue share is 30%, and Steam Direct charges a recoupable $100 submission fee per product. Third-party estimates of median game revenue vary because datasets and inclusion criteria differ, but they consistently indicate a hit-driven market in which many games earn relatively little.

Good engineering is necessary for many games, but it does not by itself create:

- A compelling player fantasy
- A satisfying core interaction
- Strong art direction
- Effective positioning
- Storefront discovery
- A receptive community
- Retention and word of mouth

Treat a first commercial game as a bounded experiment and learning project, not as dependable income.

## Side-Income Routes

| Route | Income predictability | Introvert-friendly | Upside | Primary challenge |
|---|---:|---:|---:|---|
| Engine plugins and developer tools | Medium | High | Medium–High | Support and marketplace discovery |
| Templates, systems, and starter kits | Medium | High | Medium | Commoditization, piracy, and compatibility |
| Game-development education | Medium | High | Medium | Consistent content and audience development |
| Small commercial games | Low | High | Very high | Hit-driven demand and discoverability |
| Contract game programming | Medium–High | Medium | Medium | Selling time and finding clients |
| User-generated content platforms | Low–Medium | High | High | Platform dependence and volatile discovery |

The strongest initial route is likely a developer tool or plugin, followed by education or templates derived from real development experience. Complete games can remain a parallel creative pursuit with commercial upside.

## Existing Advantages

- Strong C# and .NET expertise
- Deep software-testing experience
- AI knowledge
- Experience with professional architecture and engineering practices
- Recognition as a Microsoft MVP
- An established technical blog and audience
- Ability to create reliable tooling rather than only gameplay prototypes

Many independent game developers are capable gameplay programmers but have limited experience with automated testing, release engineering, observability, migrations, data integrity, or maintainable architecture. That gap creates a differentiated niche.

## Developer-Tool Opportunities

Potential product areas include:

- Save/load frameworks with schema versioning and migrations
- Deterministic simulation and replay tooling
- Automated gameplay testing
- Screenshot-based visual regression testing
- Build and release automation
- Localization validation
- Dialogue and quest consistency checking
- Performance-regression reporting
- Crash-report triage for small studios
- Dependency and project-health analysis
- AI NPC evaluation and regression testing
- Test-data and scenario generation
- Architecture templates for larger Unity or Godot projects
- Multiplayer testing and network-condition simulation
- CI integrations designed for small game studios

These are hypotheses to validate, not a list of products to build simultaneously.

## Recommended Tool Hypothesis

> An automated game-testing toolkit that runs scripted scenarios, captures screenshots and performance metrics, and identifies behavioral regressions.

This concept combines game development with existing strengths in testing, AI, and professional engineering.

### Possible Core Workflow

1. A developer defines or records a gameplay scenario.
2. The tool runs the scenario locally or in CI.
3. It captures screenshots, logs, timing, memory, frame-rate, and game-state checkpoints.
4. It compares the run with an approved baseline.
5. It produces a concise report with evidence for each regression.
6. The developer reviews and approves intentional changes.

### Smallest Useful Version

The first version should solve one narrow problem, such as:

- Capture screenshots at named checkpoints.
- Compare them with approved baseline images.
- Apply configurable tolerances.
- Generate an HTML or Markdown report.
- Return a useful CI exit code.
- Preserve artifacts for failed comparisons.

Do not begin with a hosted dashboard, multi-engine support, AI classification, team administration, or a large recording system.

### Possible Free-to-Paid Progression

**Free or inexpensive local plugin:**

- Run tests inside one project
- Capture and compare screenshots
- Generate local reports
- Integrate with one CI system through documentation or scripts

**Paid professional edition or hosted service:**

- Historical trends
- Artifact retention
- Team review and baseline approval
- Cross-platform comparison
- Performance-regression tracking
- Pull-request annotations
- Multiple projects
- Scheduled builds
- Role-based access
- Studio-wide reporting

Only build recurring hosted capabilities after users repeatedly run the local product and request continuity, history, collaboration, or scale.

## Engine Selection

### Unity

**Advantages:**

- Large C# user base
- Direct fit with .NET expertise
- Established commercial asset marketplace
- Broad use across indie, mobile, simulation, and professional projects
- Mature ecosystem for tools and editor extensions

**Challenges:**

- Significant marketplace competition
- Version and rendering-pipeline compatibility burden
- Dependence on Unity's platform policies and reputation
- Customers often expect extensive documentation and ongoing support

Unity is the clearest initial commercial fit if the primary goal is selling tools to C# game developers.

### Godot

**Advantages:**

- Growing open-source community
- Supports C# in addition to GDScript
- Lower platform-governance risk for the engine itself
- Good environment for experiments, education, and open-source reputation

**Challenges:**

- Smaller paid-product ecosystem
- C# is not the only or dominant language for all users
- Marketplace monetization is less established
- Engine evolution can create compatibility work

Godot may be especially suitable for open-source tools, sponsorship, educational products, and independent sales.

### Unreal Engine

**Advantages:**

- Strong commercial and professional ecosystem
- Mature marketplace
- Significant demand for production tooling

**Challenges:**

- C++ and Blueprint reduce the direct advantage of .NET expertise
- Higher learning and production complexity
- Different tooling conventions and customer expectations

Unreal is viable but is not the most direct first move given the current technical brand.

### Recommendation

Start with one engine. Unity offers the strongest alignment for a commercial C# tool, while Godot may be a better fit if open-source contribution and personal enjoyment matter more. Extract engine-neutral analysis logic only after one implementation has real users.

## Building a Commercial Game

### Start With a Toy, Not a Product

Spend one or two weeks implementing only the central interaction. Exclude:

- Accounts
- Large progression systems
- Elaborate narrative
- Extensive content
- Multiplayer unless it is inseparable from the concept
- Production backend infrastructure
- Broad customization
- Premature architecture for hypothetical scale

The first question is:

> Is the central activity enjoyable enough that strangers voluntarily play it again?

AI can accelerate implementation, placeholder content, internal tools, and exploration. It cannot reliably determine whether a mechanic feels good or whether players want the experience.

### Release Tiny Experiments

Suitable formats include:

- Itch.io prototypes
- Game-jam entries
- Browser builds
- Free downloadable demos
- Short videos or GIFs of the mechanic
- Small asynchronous playtests

Measure player behavior:

- Do strangers begin playing?
- Do they finish a session?
- Do they replay?
- Where do they stop?
- Do they ask for more content?
- Do they follow the project or join a mailing list?
- Do they share it without prompting?

Praise from friends is encouraging but weak commercial evidence. Voluntary replay, sharing, wishlisting, and return behavior are stronger.

### Test Commercial Presentation Early

Once a mechanic produces promising behavior:

- Define a clear genre and player fantasy.
- Choose a coherent visual direction.
- Produce a short trailer using real gameplay.
- Publish a storefront page.
- Release a public demo.
- Participate in appropriate festivals or events.
- Track wishlists, demo completion, replay, follows, and feedback.

Do this before producing a large volume of content. A promising game should demonstrate some ability to attract interest before requiring a long production schedule.

There is no universal wishlist threshold that guarantees commercial success. Evaluate the quality and growth of interest relative to the promotional effort required. If every wishlist requires a personal conversation, discovery is unlikely to scale.

## Scope for a First Commercial Game

A sensible first project should generally target:

- One central mechanic
- One platform
- Reusable, commissioned, or purchased art within a fixed budget
- Minimal narrative unless narrative is the product's core appeal
- Approximately 30–120 minutes of initial content
- Six months or less of part-time development
- A fixed budget
- A fixed release target
- No mandatory live service
- No multiplayer unless validated early and essential to the concept

Finishing teaches storefront management, pricing, trailers, festivals, support, reviews, localization, release operations, and post-launch maintenance. These skills are as commercially important as implementation.

## Game Validation Funnel

### Gate 1: Core Interaction

**Experiment:** A one- or two-week prototype.

**Advance when:** Unprompted players understand the activity, finish a session, and some voluntarily replay.

**Stop or redesign when:** The mechanic requires extensive explanation, players consistently abandon it, or enjoyment depends on content that would be prohibitively expensive to produce.

### Gate 2: Audience Response

**Experiment:** Public build, gameplay clips, and a focused description.

**Advance when:** Relevant strangers play, follow, subscribe, share, or ask for more.

**Stop or reposition when:** Only friends and existing personal contacts engage despite meaningful exposure to the target audience.

### Gate 3: Commercial Interest

**Experiment:** Store page, trailer, and polished demo.

**Advance when:** Wishlists and demo engagement grow organically, players return, and feedback consistently supports the central promise.

**Stop, reduce scope, or reposition when:** Presentation is clear and traffic is relevant, but visitors neither wishlist nor meaningfully engage with the demo.

### Gate 4: Production

Create a fixed content plan, schedule, and budget. Track remaining work based on finished content rather than systems implemented.

**Advance to launch when:** The game is complete enough to deliver its promise, test results are acceptable, and the project can be supported after release.

Avoid indefinitely extending production in pursuit of a hypothetical breakout hit.

## Tool Validation Funnel

### Gate 1: Problem Evidence

Look for repeated evidence in:

- Engine issue trackers
- Marketplace reviews
- Reddit, forums, Discord archives, and Stack Overflow
- Studio postmortems
- CI scripts and open-source internal tools
- Requests for features in existing plugins

Record the user's exact problem, current workaround, project context, and consequences.

### Gate 2: Promise Test

Create:

- A focused landing page
- A realistic screenshot or report
- A clear workflow
- A plausible price
- A waitlist, sample request, or early-access purchase

Publish a relevant article or free utility to reach the intended users.

### Gate 3: Smallest Useful Tool

Build one core result and support one engine/version range. Provide:

- Clear installation
- A working example project
- Focused documentation
- Actionable error messages
- A support boundary

### Gate 4: Payment

Charge for one valuable capability. Favor a paid plugin or professional license before assuming a hosted subscription is required.

Build SaaS only if users demonstrate recurring needs such as history, artifact storage, scheduled processing, team approval, or multi-project reporting.

## Hybrid Game-and-Tool Strategy

Games and developer tools can reinforce one another:

1. Develop a very small game.
2. Identify a system that solved a meaningful, repeated development problem.
3. Validate that other developers experience the same problem.
4. Extract and polish the system as a plugin, template, or tool.
5. Use the game as a real demonstration and regression environment.
6. Write technical articles about the underlying problem.
7. Sell the product through a marketplace or independent site.
8. Add hosted capabilities only when recurring demand is demonstrated.

Examples include:

- A game using reliable save migrations that demonstrates a commercial save-system package
- A game using visual regression testing that demonstrates a testing plugin
- A dialogue-heavy prototype that validates a dialogue-consistency tool
- A deterministic simulation game that produces reusable replay and debugging tooling

Do not package every internal system. A commercial developer product requires excellent documentation, example projects, compatibility testing, upgrade handling, and support.

## Introvert-Friendly Distribution

Most discovery and support can be asynchronous:

- Engine marketplaces
- Itch.io and Steam pages
- Search-focused technical articles
- YouTube demonstrations without on-camera presentation
- Documentation and example repositories
- Engine forums and communities where relevant releases are welcome
- Email newsletters
- GitHub issues and discussions
- Structured feedback forms
- Email-based support with published response expectations

Avoid indiscriminate promotion. Demonstrate a useful result, teach the underlying problem, and place the product where users already search.

## Education Opportunities

Game-development education could combine professional engineering practices with engine-specific implementation:

- Automated testing for Unity or Godot projects
- CI/CD for independent game developers
- Maintainable C# architecture for games
- Save compatibility and migration design
- Deterministic simulation and replay systems
- Testing AI-driven NPC behavior
- Performance-regression testing
- Applying production .NET practices without overengineering a game

Start with focused articles, workshops, small paid guides, or compact courses rather than a broad “learn game development” curriculum.

## Other Revenue Models

### Templates and Starter Kits

Sell a coherent starting point for a specific type of project or engineering need. Differentiate through documentation, tests, upgrade support, and production readiness rather than volume of included features.

### Contract Programming

Offer narrowly scoped services such as prototyping, tooling, testing infrastructure, CI setup, performance investigation, or architecture reviews. This is more predictable than game sales but remains time-based income.

### User-Generated Content Platforms

Platforms such as Roblox, Fortnite Creative, and Minecraft provide built-in audiences but introduce platform-specific economics, rules, and discoverability. Treat each as its own market rather than a generic shortcut to game revenue.

### Sponsorship and Membership

Open-source tools, development logs, tutorials, or reusable assets can support sponsorships or memberships. Recurring content expectations can make these less passive than they initially appear.

### Licensing

Tools, educational material, or internal frameworks may be licensed to studios by seat, project, team, or company. Team licensing can be more attractive than low-priced individual sales if the product solves a professional problem.

## Risks and Constraints

### Employment and Intellectual Property

Review employment, moonlighting, conflict-of-interest, and intellectual-property terms. Do not use employer time, equipment, code, assets, confidential information, or customer relationships. Obtain written approval if required.

### Marketplace Dependence

Marketplaces provide discovery but can change policies, rankings, fees, or technical requirements. Own the product domain, documentation, source assets, customer relationship where permitted, and an independent distribution option where practical.

### Support Burden

Engine versions, operating systems, rendering pipelines, export targets, and third-party plugins create a large test matrix. Support only a clearly documented subset initially.

### Asset and Licensing Compliance

Track licenses for art, audio, fonts, models, code, AI-assisted assets, training data implications, and marketplace dependencies. Ensure commercial redistribution is permitted, especially when packaging templates or example projects.

### AI-Generated Content and Code

Treat generated output as untrusted until reviewed. Verify originality, licenses, platform rules, security, performance, and suitability. Avoid building a product whose primary advantage is undifferentiated generated content that competitors can reproduce immediately.

### Protecting the Hobby

Commercial pressure can eliminate the restorative value of a hobby. Maintain at least one game project or activity that is not required to generate revenue. Use fixed time and financial budgets for commercial experiments.

## 90-Day Experiment

### Month 1: Explore

- Review employment and intellectual-property restrictions.
- Select one engine.
- Complete two tiny game prototypes, each limited to approximately one week.
- Publish them on itch.io, as browser builds, or through small playtests.
- Research repeated testing and tooling complaints in the selected engine.
- Select one tool problem with visible demand.

### Month 2: Validate

- Improve only the game prototype with stronger player behavior.
- Create a focused page and short gameplay presentation.
- Build the smallest useful version of the developer tool.
- Release it free or inexpensively.
- Collect game and tool feedback through forms, issues, telemetry where appropriate, and email.
- Measure replay and follows for the game; measure activation and repeat use for the tool.

### Month 3: Test Payment

- Put the stronger game concept through a public demo test.
- Package the tool with professional documentation and an example project.
- Charge for the tool or one premium capability.
- Compare external evidence:
  - Game: completion, replay, wishlists, follows, sharing, and return behavior
  - Tool: installations, successful setup, repeat use, support burden, and purchases
- Continue only the path that demonstrates meaningful behavior, while preserving the other as a hobby if it remains enjoyable.

## Decision Framework

After 90 days, assess each path independently.

### Continue the Game When

- Strangers replay or return.
- Players clearly understand and value the central experience.
- Wishlists or follows grow without constant personal outreach.
- Content production is feasible within the available budget and schedule.
- The project remains enjoyable enough to finish.

### Continue the Tool When

- Developers successfully install and use it.
- Users run it repeatedly on real projects.
- The result saves measurable time or catches meaningful problems.
- Users request professional features.
- Some users pay or attempt to purchase.
- Support demands remain economically manageable.

### Stop or Reposition When

- Relevant strangers encounter the product but do not take meaningful action.
- The core experience or result requires extensive explanation.
- Success depends on an impractical volume of content or support.
- Users praise the concept but do not return or pay.
- The project conflicts with employment obligations or damages enjoyment of the hobby.

## Immediate Checklist

- [ ] Review employment and intellectual-property restrictions
- [ ] Choose one engine for the initial experiments
- [ ] Define a one-week game prototype around one interaction
- [ ] Publish the prototype and measure player behavior
- [ ] Research repeated engine-tooling problems
- [ ] Select one problem aligned with testing, AI, or .NET expertise
- [ ] Create a sample result and focused product page
- [ ] Build one narrow tool capability
- [ ] Release it with clear documentation and an example
- [ ] Measure activation, repeat use, and support cost
- [ ] Test payment before expanding the product
- [ ] Keep game scope, time, and spending explicitly bounded
- [ ] Preserve a non-commercial part of the hobby

The most resilient approach is to use developer tools for the more predictable commercial bet and small games for creative experimentation. If a game begins attracting players organically, increase investment. If it does not, the project can still be enjoyable and can produce real-world insight for useful tools, articles, or educational products.

---

# Honest Assessment vs. the Other Two Streams

**As income, this is the weakest of the three streams — and not by a small margin.**

| Stream | Realistic year-one income | Uses existing advantages? |
| ------ | ------------------------- | ------------------------- |
| Workshops / consulting | ~$12k, reliable | Yes — fully |
| Building (tools, SEO) | $0 to a few hundred/mo | Yes — partially |
| Games | Median near zero, very high variance | **No** |

## Three Problems, and They Multiply

1. **Hit-driven distribution.** Median lifetime earnings for a solo Steam title land in the low thousands
   *gross*, before the 30% revenue share, the $100 Direct fee, and taxes.
2. **Cycle time.** A commercially viable solo game is 1–3 years at 2 hrs/night. This flatly violates the
   rule in [building-plan.md](building-plan.md) — ship in 2–4 weeks so five attempts take a season. One
   attempt per several years is the worst possible shape for a hit-driven market.
3. **Zero asset transfer — the real killer.** The blog, MVP status, user group, email list, and workshop
   reputation all multiply the building track. **None of them help a Steam launch.** A .NET audience will
   not buy a roguelike.

Point 3 is what separates games from building. Building uses the unfair advantages. Games discard them.

## The One Seam Where That Isn't True: Godot + C#

Godot's C# support is real but second-class — GDScript-first docs, thin tutorials, sharp tooling edges.
There is essentially nobody with MVP-level .NET credibility teaching Godot to C# developers.

Already in hand: `project-ideas/godot-planning/`, a configured Godot MCP server, and
`project-ideas/research/godot-csharp-web-export-issue-70796.md`.

This is the testingwithdot.net playbook applied to a second niche, and unlike shipping games it *does* use
existing advantages. It is also exactly the "commercial side" of the barbell described above.

## The Play

- **Games themselves: hobby, not income.** The fastest way to poison the one thing done purely for
  enjoyment is to give it a revenue target. (See the Objective at the top of this document.)
- **Route the value through channels that already monetize.** Devlogs feed the blog. *"C# beyond the
  enterprise: building games in Godot"* is a genuinely fresh conference talk that would get accepted, and
  speaking feeds the workshop funnel. The games produce **content** even when they produce no sales.
- **If money ever comes from this, it comes from tooling and teaching**, not from a title.

---

# "What if AI lets me ship a game every 3–6 months?"

Better odds than one game every three years — but it does not change the binding constraint, and it adds
work that is specifically unwanted.

## What AI Actually Removes

AI collapses **implementation** cost: systems code, boilerplate, editor tooling, level data, dialogue
variants, save/load plumbing, test scaffolding. That is real, and it's the part most suited to existing
strengths.

## What It Doesn't

| Bottleneck | Does AI help? |
| ---------- | ------------- |
| Is the core loop actually fun? | No |
| Art direction and cohesion | Barely, and visible AI art carries real reputational risk with players |
| Game feel, juice, polish | No |
| **Discovery and wishlists** | **No** |

Code was never why most indie games fail.

## The Argument That Actually Matters

**AI increases supply for everyone.** More games shipped means discovery gets *harder*, not easier. Racing
to produce more units in a market whose scarce resource is attention rather than production capacity does
not obviously improve the odds.

Worse, Steam's algorithm rewards **wishlist velocity at launch**, and wishlists take months of marketing
per title — trailers, Next Fest, streamer outreach, community building. Ship every 4 months and marketing
becomes the actual job. That is the exact work being avoided everywhere else in this folder.

## When Volume Does Work

The "many small games" strategy works when the attempts **compound** — the same spine rule from
[building-plan.md](building-plan.md):

- **Same genre and audience every time.** Shared tech, reusable systems, and — critically — players and
  wishlists that carry from one title to the next.
- **A tight, legible hook** that can be communicated in a single GIF.
- **Deliberately small scope**, finished and shipped rather than abandoned.

Four games across four unrelated genres resets to zero four times. Four games in one lane builds something.

## Verdict

Viable as a *learning and content* engine; not as a reliable income plan. Assume the first three titles
earn approximately nothing and are tuition.

**The highest-expected-value output of this experiment is probably not the games.** "I shipped four games
in a year using AI, here's what actually happened" is a strong blog series and a conference talk — feeding
the speaking and workshop funnel that already produces reliable money.

If the games happen to sell, that's upside rather than the plan.
