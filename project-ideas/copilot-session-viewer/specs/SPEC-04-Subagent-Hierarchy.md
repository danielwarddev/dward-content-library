# Spec 4: Subagent Hierarchy Visualization

**Status**: 📋 Not Started

---

## User Story

**As a developer**, I want subagent calls visually distinguished from regular tool calls with their own nested timeline and per-agent statistics so that I can trace multi-agent delegation chains and understand each agent's contribution.

## Description

When a `task` tool call spawns a subagent, the session viewer should render a distinct "subagent block" instead of a plain tool call node. This block contains the subagent's own timeline (LLM usage, messages, nested tool calls, and even deeper subagents) and displays per-agent metadata (agent name, total tokens, duration). The hierarchy can be arbitrarily deep — the test data shows 3 levels: Orchestrator → Verifier → Verifier → Verifier.

This spec builds on the tree structure from SPEC-03 and adds subagent-aware rendering.

## Acceptance Criteria

### Subagent Detection

- [ ] Tool calls where `toolName === "task"` and a corresponding `subagent.started` event exists are identified as subagent calls
- [ ] The subagent's `agentName` and `agentDisplayName` from the `subagent.started` event are extracted and associated with the tool call node
- [ ] `subagent.completed` and `subagent.failed` events are linked to their subagent by `toolCallId`

### Subagent Block Rendering

- [ ] Subagent tool calls render as a visually distinct block (different border color, background) instead of a plain tool call node
- [ ] The subagent block header shows: agent name/display name, total input/output tokens, total duration
- [ ] The block header is collapsible (click to expand/collapse the subagent's contents)
- [ ] Failed subagents (`subagent.failed`) display an error indicator and the failure message in the header
- [ ] Subagent blocks use a left border accent to visually communicate nesting depth

### Nested Content

- [ ] Within a subagent block, events are rendered in chronological order: LLM usage, assistant messages, tool calls (including nested subagents)
- [ ] The same rendering rules from SPEC-03 apply recursively inside subagent blocks (tool nodes, usage badges, message nodes)
- [ ] Subagents within subagents render as nested subagent blocks (recursive structure)
- [ ] Indentation increases with each nesting level to visually convey depth

### Per-Agent Statistics

- [ ] Each subagent block header shows aggregated token usage: sum of all `assistant.usage` events with matching `parentToolCallId`
- [ ] Duration is computed from the first event to the last event within the subagent's scope
- [ ] The number of LLM calls made by the subagent is shown in the header
- [ ] The number of tool calls made by the subagent (excluding the spawning `task` call itself) is shown

### Nesting Depth Indicator

- [ ] A visual indicator shows the current nesting depth (e.g., breadcrumb-style "Orchestrator > Verifier > Verifier" or colored left borders)
- [ ] Different nesting levels use distinguishable border colors or increasing indentation
- [ ] The root agent (top-level, no `parentToolCallId`) is identifiable from the `subagent.selected` event

### Collapse Behavior

- [ ] Subagent blocks are collapsed by default
- [ ] Expanding a subagent block reveals its full nested timeline
- [ ] A "Expand all" / "Collapse all" control exists for quickly navigating deep hierarchies
- [ ] Collapsing a parent also visually collapses all descendants

## Out of Scope

- Cross-session subagent comparison
- Agent performance benchmarking / ranking
- Modifying or replaying subagent calls
- Visualizing the subagent's system prompt or configuration

## Technical Notes

- The prototype identifies subagents by checking if a tool call's `toolName` is `"task"` and grouping child events by `parentToolCallId` matching the tool's `toolCallId`
- The prototype's `renderSubagentContents()` function (~log-viewer.html lines 510–575) interleaves usage, messages, and child tool calls by timestamp — this pattern should be preserved
- `subagent.started` fires when the subagent begins; `subagent.completed` fires when it returns. The time between these is the subagent's wall-clock duration
- `toolTelemetry.metrics.numberOfToolCallsMadeByAgent` in `tool.execution_complete` for `task` calls provides a server-side count of tool calls — can be cross-referenced with the client-side count
- Border color scheme from prototype: subagent blocks use `#7aa2f7` (blue), nested subagents could use a rotating palette
- In the test data (`log.txt`), the hierarchy is: Orchestrator → calls `task` (Verifier) → Verifier calls `task` (Verifier) → deepest Verifier calls `task` (Verifier) + other tools

## UI Wireframe Concepts

### Subagent Block (expanded)

```
 🔧 task ✅ (34.7s)
 ┌─── 🤖 Verifier ─── 9,857 in │ 1,978 out │ 2 LLM │ 3 tools ──┐
 │                                                                  │
 │  🤖 gpt-5-mini │ 9,857 in │ 1,978 out │ 13.1s │ sub-agent     │
 │                                                                  │
 │  💬 (empty content — tool requests only)                        │
 │     🏷️ Requests: report_intent, task                            │
 │                                                                  │
 │  🔧 report_intent ✅ (0.01s)                                   │
 │                                                                  │
 │  🔧 task ✅ (21.3s)                                            │
 │  ┌─── 🤖 Verifier ─── 9,812 in │ 995 out │ ... ──────────┐   │
 │  │                                                          │   │
 │  │  (deeper nested subagent content...)                     │   │
 │  │                                                          │   │
 │  └──────────────────────────────────────────────────────────┘   │
 │                                                                  │
 └──────────────────────────────────────────────────────────────────┘
```

## Definition of Done

- [ ] All acceptance criteria are met
- [ ] Unit tests verify subagent detection logic (task tool call + subagent.started pairing)
- [ ] Unit tests verify per-agent statistics aggregation (token sums, duration, call counts)
- [ ] The test log (`log.txt`) renders with correct 3-level subagent nesting
- [ ] Expand/collapse works at all nesting levels
- [ ] No TypeScript errors
