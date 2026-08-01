# Spec 5: Session Statistics Dashboard

**Status**: 📋 Not Started

---

## User Story

**As a developer**, I want a summary dashboard at the top of the session view showing aggregate metrics so that I can quickly assess the session's cost, duration, and complexity at a glance.

## Description

Add a persistent statistics bar above the session timeline that displays key aggregate metrics computed from the parsed events. This includes total token usage (input, output, cache), total LLM calls, total duration, model(s) used, number of tool calls, number of subagents, and the root agent identity. The dashboard gives an instant high-level picture before diving into the timeline details.

## Acceptance Criteria

### Metrics Computation

- [ ] Total input tokens: sum of all `assistant.usage` events' `inputTokens`
- [ ] Total output tokens: sum of all `assistant.usage` events' `outputTokens`
- [ ] Total cache read tokens: sum of all `assistant.usage` events' `cacheReadTokens`
- [ ] Total cache write tokens: sum of all `assistant.usage` events' `cacheWriteTokens`
- [ ] Total LLM calls: count of all `assistant.usage` events
- [ ] Total LLM duration: sum of all `assistant.usage` events' `duration` (in milliseconds, display as seconds)
- [ ] Wall-clock session duration: time from first event's timestamp to last event's timestamp
- [ ] Total tool calls: count of distinct `toolCallId` values in `tool.execution_start` events
- [ ] Total subagent calls: count of `subagent.started` events
- [ ] Unique models used: distinct set of `model` values from `assistant.usage` events
- [ ] Root agent: extracted from the `subagent.selected` event (the first one, or the top-level agent name)
- [ ] Total events: count of all parsed events

### Dashboard Rendering

- [ ] A statistics bar is rendered above the session timeline, always visible (not scrollable with the timeline)
- [ ] The bar displays metrics in a compact horizontal layout with labeled values
- [ ] Token counts are formatted with thousand separators (e.g., "14,260")
- [ ] Duration is formatted as human-readable (e.g., "13.1s", "1m 23s")
- [ ] The root agent name is displayed prominently
- [ ] Model names are shown as pills/badges when multiple models are used
- [ ] The bar uses a subtle background to distinguish it from the timeline content

### Breakdown View

- [ ] Clicking or hovering on the token total reveals a tooltip/popover with the breakdown: input, output, cache read, cache write
- [ ] Per-agent token breakdown is available: each subagent's total tokens shown in a mini-table or list
- [ ] The cost field from `assistant.usage` is shown when non-zero (currently always 0, but future-proof)

### Session Info

- [ ] If a `session.start` event is present, display the session creation time
- [ ] If a `session.usage_info` event is present, display the token limit and current usage (e.g., "16,070 / 128,000 tokens")
- [ ] If `session.shutdown` data is available, show the shutdown type (routine vs error)

## Out of Scope

- Historical session comparison or trending
- Cost estimation or billing analysis
- Exporting statistics as CSV/JSON
- Real-time updating of statistics during live sessions

## Technical Notes

- The prototype computes these stats in `renderSession()` (~log-viewer.html lines 660–720) by walking the events array and accumulating sums
- Token formatting helper already exists in the prototype: `formatTokens(n)` returns comma-separated thousands
- Duration formatting: `(ms / 1000).toFixed(1) + 's'` for sub-minute, `Math.floor(ms/60000) + 'm ' + ((ms%60000)/1000).toFixed(0) + 's'` for longer
- The `session.usage_info` event contains `tokenLimit` and `currentTokens` which indicate context window utilization
- Root agent detection: the first `subagent.selected` event in the session typically identifies the root agent (e.g., "Orchestrator")
- CSS: the prototype uses a `session-meta` container with flexbox and gap for the horizontal metric layout

## UI Wireframe Concepts

### Statistics Bar

```
┌──────────────────────────────────────────────────────────────────┐
│  🤖 Orchestrator  │  gpt-5-mini  │  4 LLM calls  │  6 tools   │
│  📊 Tokens: 44,954 in / 6,727 out (cache: 41,984)              │
│  ⏱️ LLM: 47.7s │ Wall: 52.8s │ 91 events │ 3 subagents        │
│  📈 Context: 16,070 / 128,000 tokens                            │
└──────────────────────────────────────────────────────────────────┘
```

### Token Breakdown Popover

```
┌─────────────────────────────────┐
│  Token Breakdown                │
│  ─────────────────────────────  │
│  Input:       44,954            │
│  Output:       6,727            │
│  Cache Read:  41,984            │
│  Cache Write:      0            │
│  ─────────────────────────────  │
│  Per Agent:                     │
│  Orchestrator  14,260 / 1,689   │
│  Verifier       9,857 / 1,978  │
│  Verifier       9,812 /   995  │
│  Verifier       9,855 / 1,105  │
└─────────────────────────────────┘
```

## Definition of Done

- [ ] All acceptance criteria are met
- [ ] Unit tests cover metrics computation: token sums, LLM call count, duration calculations
- [ ] Unit tests verify formatting helpers (thousand separators, duration format)
- [ ] Statistics bar renders correctly for the test data in `log.txt`
- [ ] Token breakdown popover/tooltip works on click/hover
- [ ] No TypeScript errors
