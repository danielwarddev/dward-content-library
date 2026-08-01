# Spec 3: Session Timeline View

**Status**: 📋 Not Started

---

## User Story

**As a developer**, I want to see my Copilot session rendered as a collapsible timeline of turns with tool calls, messages, and LLM usage so that I can understand what happened during the session.

## Description

Build the core visualization layer that takes parsed events, reconstructs the hierarchical session tree, and renders it as an interactive timeline. This is the primary view of the application — a chronological sequence of assistant turns, each containing tool calls, assistant messages, LLM usage badges, and user messages. All nodes are collapsible for navigating large sessions.

The tree-building algorithm converts flat parsed events into a hierarchy using the `parentToolCallId` / `toolCallId` linking mechanism. The rendering then walks this tree and creates DOM elements for each node type.

## Acceptance Criteria

### Tree Building

- [ ] A `buildSessionTree(events)` function converts flat parsed events into a hierarchical tree structure
- [ ] Events are grouped into turns delimited by `assistant.turn_start` and `assistant.turn_end` events
- [ ] Within each turn, events are linked by `toolCallId` — `tool.execution_start` and `tool.execution_complete` events with the same `toolCallId` are paired
- [ ] Events with a `parentToolCallId` are nested as children of the tool call node with the matching `toolCallId`
- [ ] Root-level events (no `parentToolCallId`) appear directly in their turn
- [ ] The tree supports arbitrary nesting depth (subagents spawning subagents)
- [ ] Events within a level are ordered chronologically by timestamp

### Turn Rendering

- [ ] Each turn is rendered as a collapsible block with a header showing the turn number
- [ ] Turn headers display aggregate info: number of tool calls, number of LLM calls within the turn
- [ ] Clicking a turn header toggles its content visibility
- [ ] All turns start collapsed by default (expandable on click)
- [ ] The first turn auto-expands if there is only one turn

### Tool Call Nodes

- [ ] Tool calls display the tool name with a distinguishing icon/emoji (e.g., 🔧)
- [ ] Tool call arguments are shown in a collapsible preview (truncated to ~100 chars by default)
- [ ] Tool call results show success/failure status with a visual indicator (green ✅ / red ❌)
- [ ] Successful tool results display `result.content` in a collapsible block
- [ ] Failed tool calls display the error message
- [ ] Tool call duration is shown when `tool.execution_complete` includes timing data
- [ ] MCP tool calls display the MCP server name when `mcpServerName` is present

### LLM Usage Nodes

- [ ] `assistant.usage` events render as compact badge-style nodes
- [ ] Each badge shows: model name, total input tokens, total output tokens, duration
- [ ] Cache read tokens are shown when non-zero (e.g., "cache: 9,728")
- [ ] The `initiator` field is displayed (e.g., "user" vs "sub-agent")
- [ ] Usage nodes are visually distinct from tool call nodes (different background/border color)

### Message Nodes

- [ ] `assistant.message` events display the message content in a readable block
- [ ] Long message content is truncated with an expand/collapse toggle
- [ ] Messages that include `toolRequests` show a badge listing requested tool names
- [ ] `reasoningText` (chain-of-thought) is rendered in a distinct collapsible block when present
- [ ] `user.message` events display the user's input content

### General UI

- [ ] After loading a log file, the upload zone is hidden and the timeline view is shown
- [ ] A "Load different file" button allows returning to the upload view
- [ ] The timeline scrolls vertically for large sessions
- [ ] Visual indentation shows hierarchy depth (nested events indented from parent)
- [ ] Timestamps are displayed on hover or in a subtle secondary text style

## Out of Scope

- Subagent-specific visualization with per-agent stats (SPEC-04)
- Aggregate session statistics dashboard bar (SPEC-05)
- Search and filtering (SPEC-06)
- Exporting or sharing session views
- Real-time/streaming log visualization

## Technical Notes

- The tree-building algorithm is proven in the prototype's `buildSession()` function (log-viewer.html ~lines 320–400)
- Turn grouping logic is in the prototype's `groupIntoTurns()` function (~lines 615–660)
- DOM rendering should use a simple `document.createElement` approach (no virtual DOM needed) — matches the prototype pattern
- For collapsible sections, use a `<details>/<summary>` pattern or toggle-class approach
- Tool call arguments can be arbitrary JSON — use `JSON.stringify(args, null, 2)` for display with syntax highlighting
- Message content may contain markdown — render as preformatted text initially (markdown rendering is a future enhancement)
- The prototype uses a timestamp-based interleaving approach for ordering events within a subagent scope — preserve this approach

## UI Wireframe Concepts

### Session Timeline (single turn expanded)

```
┌──────────────────────────────────────────────────────┐
│  [Load different file]                                │
├──────────────────────────────────────────────────────┤
│                                                       │
│  ▼ Turn 1 — 3 tool calls, 2 LLM calls               │
│  ┌──────────────────────────────────────────────┐    │
│  │ 📨 User: "Generate a greeting from..."       │    │
│  │                                               │    │
│  │ 🤖 gpt-5-mini │ 14,260 in │ 1,689 out │ 13s │    │
│  │                                               │    │
│  │ 💬 Launching the Verifier subagent to...     │    │
│  │    🏷️ Requests: report_intent, task           │    │
│  │                                               │    │
│  │ 🔧 report_intent ✅ (0.02s)                  │    │
│  │    ▶ args: {"intent": "Launching verifier"}   │    │
│  │                                               │    │
│  │ 🔧 task ✅ (13.3s)                           │    │
│  │    ▶ args: {"description": "Verifier: ..."}   │    │
│  │    ┌─ Subagent content (see SPEC-04) ──┐     │    │
│  │    │  ...nested events...               │     │    │
│  │    └────────────────────────────────────┘     │    │
│  └──────────────────────────────────────────────┘    │
│                                                       │
│  ▶ Turn 2 — 1 tool call, 1 LLM call (collapsed)     │
│                                                       │
└──────────────────────────────────────────────────────┘
```

## Definition of Done

- [ ] All acceptance criteria are met
- [ ] Unit tests cover tree-building logic: flat events → correct hierarchy, parentToolCallId linking, turn grouping
- [ ] Unit tests cover edge cases: empty event list, single turn, events with no parentToolCallId
- [ ] The timeline renders correctly with the test data from `log.txt`
- [ ] Expanding/collapsing works for turns, tool args, message content, and reasoning blocks
- [ ] No TypeScript errors
