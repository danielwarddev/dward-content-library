# Game Review Checklist Prompt

**Generated:** 2026-03-07
**Source:** [Reddit r/gamedev - "We playtested over 400 games, these are the top mistakes they made"](https://www.reddit.com/r/gamedev/comments/1rm9lyw/we_playtested_over_400_games_these_are_the_top/)

---

Use this prompt when reviewing a game you've made. Paste it into your AI tool or use it as a manual checklist. It covers the top 10 issues found across 400+ indie game playtests.

---

## The Prompt

```
You are a game playtesting expert. I'm going to describe or show you a game I've made, and I need you to evaluate it against the top 10 most common mistakes found across 400+ indie game playtests. For each category, give me a rating of PASS, CONCERN, or FAIL, along with specific observations and actionable suggestions.

Review my game against ALL of the following categories:

---

### 1. ONBOARDING (found in 68% of games tested)
Check for:
- Is there a tutorial or early explanation of core mechanics?
- Does the tutorial teach through gameplay rather than walls of text?
- Are core mechanics explained early (not buried later in the game)?
- Is the onboarding short, interactive, and focused?
- Can a brand-new player understand what to do in the first few minutes?
- Are there large text dumps that could be replaced with learn-by-doing?

Best practice: The best onboarding is short, interactive, and teaches mechanics through play rather than text.

---

### 2. GAME-BREAKING BUGS (found in 39% of games tested)
Check for:
- Are there any crashes during normal gameplay?
- Can controls freeze or become unresponsive?
- Are there soft-locks where the player simply can't progress?
- Does the save system work correctly (no failed saves or corruption)?
- Does the game handle unexpected player behavior gracefully (rapid restarts, alt-tabbing, unexpected interactions)?
- Are there edge cases that could break progression?

Key insight: These issues often appear when players do things developers hadn't considered, such as restarting runs quickly, alt-tabbing, or experimenting with unexpected interactions.

---

### 3. UI AT HIGHER RESOLUTIONS
Check for:
- Does the UI look correct at 1080p AND higher resolutions (1440p, 4K)?
- Is text readable at all supported resolutions?
- Are UI elements sharp (not blurry or misaligned) at different resolutions?
- Are there UI scaling options available?
- Has the interface been tested across multiple display configurations?

Key insight: A surprising number of games look fine at 1080p but become difficult to use at higher resolutions.

---

### 4. AUDIO (found in 21% of games tested)
Check for:
- Is the default volume level reasonable when the game first starts (not too loud)?
- Are sound effects present for all important moments and actions?
- Is there audio during all key gameplay moments (no silent gaps)?
- Does audio continue working correctly after alt-tabbing?
- Does audio continue working correctly after restarting a playthrough?
- Are there separate volume controls for music, SFX, and master?

Key insight: Audio problems are easy to overlook during development but they strongly affect how polished a game feels.

---

### 5. FEEDBACK FOR PLAYER ACTIONS
Check for:
- Do items make a sound or show a visual indicator when picked up?
- Do enemies visibly react when they take damage (hit flash, knockback, particles)?
- Do abilities/actions have clear feedback that something happened (sound, animation, UI flash)?
- Is there visual/audio confirmation for successful interactions (doors opening, switches activating, etc.)?
- Can the player always tell whether their action succeeded or failed?

Key insight: Even small cues like sound effects, animations, or UI flashes make a huge difference in helping players understand the game.

---

### 6. CONTROLS (found in ~20% of games tested)
Check for:
- Do controls follow common conventions for the genre (e.g., WASD movement, space to jump)?
- Are important actions mapped to intuitive/expected buttons?
- Is there an option to rebind keys/buttons?
- Does the control scheme fight against player muscle memory from similar games?
- Are controls clearly communicated to the player?
- Is controller support included (if applicable) and does it feel natural?

Key insight: Players are generally happy with familiar control patterns, so deviating from them without a clear reason often causes frustration.

---

### 7. DIFFICULTY CURVE
Check for:
- Is there a dramatic difficulty spike after the tutorial?
- Does the game ramp difficulty gradually rather than all at once?
- Are new mechanics introduced one at a time (not several simultaneously)?
- Does the difficulty feel fair and learnable (not blindsiding)?
- Is there a smooth transition from the tutorial to real gameplay?
- Are difficulty options available for different skill levels?

Key insight: A common pattern is the game starting extremely easy, then suddenly introducing multiple mechanics and challenging enemies all at once, blindsiding the player.

---

### 8. PLAYER NAVIGATION / GETTING LOST
Check for:
- Can the player always tell where to go next?
- Is there a map, waypoint system, or objective markers (if the game needs them)?
- Are level layouts intuitive enough to navigate without explicit markers?
- Could a player mistake being lost for the game being broken?
- Is there clear visual language guiding the player (lighting, color, paths)?
- Are objectives clearly communicated?

Key insight: Without guidance, players will wander in circles or assume the game is broken.

---

### 9. SETTINGS MENU
Check for:
- Does a settings menu exist?
- Can graphics settings be adjusted?
- Can audio settings be adjusted?
- Can control settings be adjusted/rebound?
- Do changed settings actually apply when saved?
- Are settings preserved between play sessions (not reset on relaunch)?
- Is there a fullscreen/windowed toggle?
- Is there a resolution selector?

Key insight: Players expect to be able to adjust graphics, audio, and controls easily. Some games have settings that don't actually apply when changed.

---

### 10. CAMERA (found in ~10% of games tested)
Check for:
- Does the camera ever clip into geometry or walls?
- Does the camera ever point in unhelpful directions (ceiling, floor)?
- Is the camera zoom level appropriate (not too close, not too far)?
- Does the camera give the player a good view of the environment at all times?
- Does the camera feel comfortable during extended play?
- Can camera sensitivity be adjusted?

Key insight: Since the camera is the player's primary view of the world, problems here tend to make the entire experience feel uncomfortable.

---

## META-AWARENESS CHECK

Important context: Almost all of these issues appeared in games that had already been played dozens or even hundreds of times by the developers. They simply weren't noticed because the team had already adapted to the game. As soon as new players tried them, the problems became obvious.

With that in mind, also consider:
- What assumptions am I making because I already know how the game works?
- What would confuse a first-time player who has zero context?
- Am I overlooking things because I've adapted to quirks in my own game?

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

- The percentages come from analysis of 400+ indie game playtests by [weplaytestgames.com](https://weplaytestgames.com/).
- The biggest takeaway is developer blindness — you've adapted to your own game, so fresh-eye testing is critical.
- This prompt can be used with AI (paste along with gameplay footage/description) or as a manual self-review checklist.
