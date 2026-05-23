# Game Review Checklist Prompt (Vol. 2)

**Generated:** 2026-03-29
**Source:** [Reddit r/gamedev - "What I've learned from playtesting 22+ indie games"](https://www.reddit.com/r/gamedev/comments/1s6x2m7/what_ive_learned_from_playtesting_22_indie_games/)

---

Use this prompt when reviewing a game you've made. Paste it into your AI tool or use it as a manual checklist. It covers 10 lessons observed across 22+ indie game playtests, plus insights from community discussion.

---

## The Prompt

```
You are a game playtesting expert. I'm going to describe or show you a game I've made, and I need you to evaluate it against 10 lessons learned from playtesting 22+ indie games. For each category, give me a rating of PASS, CONCERN, or FAIL, along with specific observations and actionable suggestions.

Review my game against ALL of the following categories:

---

### 1. MAIN MENU FIRST IMPRESSION
Check for:
- Is there any animation on the main menu (particles, floating elements, looping backgrounds)?
- Does the game's name/logo appear prominently on the main menu?
- Does the menu feel alive vs. static and unfinished?
- Are button interactions responsive with hover/click feedback?
- If currency or quest UI is visible from the main menu, could it be mistaken for pay-to-win or aggressive monetization?

Key insight: A static main menu signals "unfinished" before the player has pressed a single button. Even a looping particle system or a subtly animated logo sets a professional tone. The main menu is also where players form their first impression of your monetization — don't surface currency or quest systems there unless the context is immediately clear.

---

### 2. INPUT SUPPORT CONSISTENCY
Check for:
- If both controller and keyboard/mouse are supported, does the tutorial show prompts for BOTH?
- Do on-screen prompts update dynamically when the player switches input mid-game?
- Has the game been tested end-to-end with each supported input method?
- Are there any menus or UI elements that only work with one input type?

Key insight: Games that advertise full controller and keyboard support but only show one set of bindings in the tutorial are setting players up to fail. If you support it, test it — and show it.

---

### 3. DEMO / BUILD STABILITY
Check for:
- Are there any known unstable or unfinished levels included in the public build?
- Does every included level complete without crashes or soft-locks?
- Has the build been playtested by someone outside the development team?
- Is the demo shorter-but-polished rather than longer-but-broken?
- Is the demo length appropriate for its context (home download vs. convention booth)?

Key insight: Players remember the broken experience more than anything good that came before it. A shorter, polished demo always beats a longer, unstable one. For convention demos especially, ensure the experience can be completed within a few minutes by a stranger.

---

### 4. MAJOR BUG TOLERANCE
Check for:
- Are there known major bugs that have been left in because "players probably won't hit them"?
- Has the game been playtested by people unfamiliar with it (friends, family, strangers)?
- Are there edge-case paths through the game that haven't been tested?
- Is there a process for catching bugs before public release?

Key insight: Developer blindness is real — you've adapted to your own game. Fresh eyes will find things you've stopped seeing. If you know something is broken, fix it. Players will notice, and they will remember.

---

### 5. CONTENT BALANCE
Check for:
- Is there enough content to keep a new player engaged beyond the first few minutes?
- Is there so much content that a new player feels overwhelmed before they understand the core loop?
- Is the demo/early game scoped to show the best of the game without exhausting it?
- Does the content ramp gradually rather than front-loading or stretching thin?

Key insight: Too little content makes players feel there's nothing to do. Too much makes them quit from overwhelm. Both kill retention. The goal is to leave players wanting more, not feeling like they've seen everything.

---

### 6. FAIR DIFFICULTY AND PUNISHING MECHANICS
Check for:
- Are there any mechanics that punish the player in ways that feel arbitrary or unexplained?
- Is every "instant-fail" or severe-penalty mechanic introduced to the player before it kills them?
- Does the player always feel like failure was their fault, not the game's?
- Are new punishing mechanics introduced in low-stakes situations before being used against the player?
- Does the difficulty ramp feel learnable and fair rather than blindsiding?

Key insight: Difficulty is good. Arbitrary punishment is not. The difference is whether the player had the information and opportunity to avoid the outcome. Follow the principle of "introduce in safety, then escalate" — show the player what a mechanic does before it costs them.

---

### 7. MECHANIC FUN-FACTOR
Check for:
- Can you, as the developer, enjoy every core mechanic for a full play session without feeling bored or frustrated?
- Is every included mechanic pulling its weight in terms of player enjoyment?
- Are there mechanics that are intellectually interesting but tedious or unpleasant in practice?
- Have mechanics been tested with players who didn't design them?

Key insight: A mechanic that sounds clever in a design doc can be miserable to actually play. If a mechanic isn't fun to execute for 20 straight minutes, your players will quit before they get there. Cut or rework mechanics that don't survive sustained playtime.

---

### 8. TUTORIAL QUALITY
Check for:
- Does the game have some form of tutorial or guided early experience?
- Does the tutorial teach through play rather than walls of text?
- Is each mechanic introduced one at a time in a low-stakes environment?
- Is the tutorial short enough that players don't disengage before the core loop begins?
- Could a first-time player understand the core loop without any external help?
- Is there an in-game reference (keybindings, log, hint system) players can consult after the tutorial?

Key insight: What feels obvious after months of development is invisible to a first-time player. Every mechanic needs at least a brief introduction. The best tutorials are nearly invisible — they teach through designed play, not instruction. Avoid both extremes: zero tutorial and over-tutorialized hand-holding. Aim for "show, don't tell, then let go."

Community nuance: Some players are frustrated by excessive hand-holding. The goal is not to walk players through every action, but to ensure no one hits a blocker because they lacked basic context. A good tutorial teaches the minimum needed, then trusts the player.

---

### 9. TUTORIAL CONCISENESS
Check for:
- Is any single tutorial explanation longer than 1-2 sentences?
- Are there "walls of text" that could be replaced with a short interactive moment?
- Are mechanics introduced gradually through play rather than explained all at once upfront?
- Would a player who skips reading still be able to figure out what to do?

Key insight: Wall-of-text tutorials are just as harmful as no tutorial. Players stop reading after the first sentence if there are too many. Each explanation should be as short as possible, and paired with an immediate opportunity to do the thing being described.

---

### 10. DEVELOPER BLINDNESS CHECK
Check for:
- Has anyone outside the development team playtested a recent build?
- Have you documented every assumption you're making about what players "obviously" know?
- Are there mechanics, UI elements, or flows that you've stopped questioning because you've seen them hundreds of times?
- Have you watched a new player attempt your game without coaching them?

Key insight: Almost every issue in this list becomes invisible to developers who've played their own game too many times. You have adapted to your own quirks. The single most effective thing you can do is put the game in front of someone who has never seen it and watch silently as they play.

---

## META-AWARENESS CHECK

Before finalizing your evaluation, consider:
- What do I assume players will know that isn't explicitly shown in the game?
- What would a player think if they saw my main menu for the first time without knowing what the game is?
- Have I shipped things I know are broken because I was hoping no one would notice?
- Am I including content because it's done, or because it makes the experience better?

---

## OUTPUT FORMAT

For each of the 10 categories, provide:
1. **Rating**: PASS / CONCERN / FAIL
2. **Observations**: What you noticed (specific examples)
3. **Suggestions**: Actionable fixes if rating is CONCERN or FAIL
4. **Priority**: HIGH / MEDIUM / LOW (based on player impact)

Then provide an overall summary with your top 3 recommended fixes.
```

---

## Notes

- Lessons sourced from one playtester's observations across 22+ indie games (u/Odd_Can707 on Reddit).
- Top community-highlighted points: mechanic fun-factor (#7 / #8) and the tutorial quality debate (#8 / #9).
- Notable community insight (u/PhilippTheProgrammer): Don't build your tutorial until your core mechanics are locked — otherwise you'll revise it constantly. Treat private/internal playtest builds differently from public demos; internal testers can RTFM, public players won't.
- Demo length context (u/RatKingJosh): A demo designed for home play is too long for a convention booth. Scope for the environment.
- Pairs well with: [game-review-checklist.md](game-review-checklist.md) (400+ playtest findings).
