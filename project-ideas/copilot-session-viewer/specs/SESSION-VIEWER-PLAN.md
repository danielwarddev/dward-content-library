# Copilot Session Viewer — Implementation Plan

## Vision

A standalone web application that visualizes Copilot SDK session logs. It parses Serilog-formatted log files and renders an interactive hierarchical view of agent turns, tool calls, subagent delegation, LLM usage, and assistant messages — giving developers full observability into what happened during a Copilot session.

A working prototype already exists at `log-viewer.html` (1,071 lines, single self-contained HTML file). This plan formalizes and expands that prototype into a proper standalone application.

## Tech Stack

| Layer | Choice | Rationale |
|-------|--------|-----------|
| **Framework** | Vanilla TypeScript | The prototype is already vanilla JS — adding TypeScript gives type safety without framework overhead. The event model is complex enough to benefit from static types. |
| **Bundler** | Vite | Fast dev server, native TS support, zero-config for vanilla TS projects. |
| **Styling** | CSS (custom properties) | Prototype's dark theme with CSS variables works well. No CSS framework needed. |
| **Testing** | Vitest | Pairs naturally with Vite. Covers unit tests for parsing and tree building. |
| **Package** | npm | Standard Node.js tooling. |

## Project Structure

```
session-viewer/
├── index.html
├── package.json
├── tsconfig.json
├── vite.config.ts
├── src/
│   ├── main.ts                  # Entry point, wires up file input → parse → render
│   ├── styles/
│   │   ├── main.css             # Global styles, CSS variables, dark theme
│   │   ├── timeline.css         # Turn blocks, event nodes
│   │   └── dashboard.css        # Stats bar, metadata
│   ├── models/
│   │   ├── events.ts            # TypeScript types for all session event data
│   │   └── session-tree.ts      # Tree node types (Turn, ToolCall, Subagent, etc.)
│   ├── parsing/
│   │   ├── log-parser.ts        # Serilog line regex, extract id/type/data
│   │   └── event-deserializer.ts # JSON data → typed event objects
│   ├── tree/
│   │   └── tree-builder.ts      # Flat events → hierarchical session tree
│   ├── rendering/
│   │   ├── session-renderer.ts  # Top-level: metadata bar + turn list
│   │   ├── turn-renderer.ts     # Individual turn blocks
│   │   ├── tool-renderer.ts     # Tool call nodes (plain + subagent)
│   │   ├── message-renderer.ts  # Assistant message nodes
│   │   ├── usage-renderer.ts    # LLM usage badge nodes
│   │   └── stats-renderer.ts    # Aggregate statistics dashboard
│   ├── search/
│   │   └── search-engine.ts     # Filter/search across events
│   └── utils/
│       ├── formatting.ts        # Token counts, durations, timestamps
│       └── dom.ts               # DOM helper utilities
├── test/
│   ├── parsing/
│   │   └── log-parser.test.ts
│   ├── tree/
│   │   └── tree-builder.test.ts
│   └── fixtures/
│       └── sample-log.txt       # Test log data
└── public/
    └── (static assets if any)
```

## Feature Breakdown & Spec Mapping

### Phase 1: Foundation

| Spec | Feature | Description |
|------|---------|-------------|
| SPEC-01 | Project Setup & Architecture | Initialize Vite + TS project, basic HTML shell, CSS theme, dev tooling |
| SPEC-02 | Log Parsing & Event Model | Parse Serilog lines into typed event objects; handle both standard events and hook lines |

### Phase 2: Core Visualization

| Spec | Feature | Description |
|------|---------|-------------|
| SPEC-03 | Session Timeline View | Render parsed events as collapsible turn blocks with tool/message/usage nodes; file input UI |
| SPEC-04 | Subagent Hierarchy | Nested subagent blocks with visual hierarchy, per-agent stats, recursive rendering |

### Phase 3: Analytics & Discovery

| Spec | Feature | Description |
|------|---------|-------------|
| SPEC-05 | Session Statistics Dashboard | Aggregate metrics bar (total tokens, LLM calls, duration, model, tools used) |
| SPEC-06 | Search, Filter & Navigation | Filter by event type, agent name, tool name; text search across event content |

## Key Data Flow

```
Log File (text)
    │
    ▼
┌──────────────┐
│  Log Parser   │  Regex splits lines → { id, type, timestamp, data (JSON string) }
└──────┬───────┘
       │
       ▼
┌──────────────────┐
│ Event Deserializer│  JSON.parse(data) → typed event objects
└──────┬───────────┘
       │
       ▼
┌──────────────┐
│ Tree Builder  │  Flat events → hierarchical tree using parentToolCallId/toolCallId
└──────┬───────┘               linking mechanism
       │
       ▼
┌──────────────┐
│   Renderers   │  Tree → DOM nodes (turns → tools → subagents → nested content)
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Dashboard    │  Aggregate stats computed from tree + rendered as metadata bar
└──────────────┘
```

## Event Linking Mechanism

The core challenge is reconstructing the agent hierarchy from flat log lines. The linking works through two fields:

- **`parentToolCallId`**: Present on events that occur *inside* a subagent's scope. Links back to the `task` tool call that spawned the subagent.
- **`toolCallId`**: Present on `tool.execution_start`, `tool.execution_complete`, `subagent.started`, `subagent.completed`. Pairs start/complete events and connects subagent lifecycle to the spawning tool call.

**Hierarchy reconstruction algorithm** (proven in prototype):
1. Index all events by `toolCallId` (where present)
2. Group events by `parentToolCallId` → children of that tool call
3. Root-level events have no `parentToolCallId`
4. Walk root events chronologically, recursively nest children

## Event Types to Support

Based on `SessionEvent_Decompiled.cs`, prioritized by frequency in real logs:

### Must Have (appear in every session)
- `assistant.turn_start` / `assistant.turn_end` — Turn boundaries
- `assistant.message` — Model responses, tool requests
- `assistant.usage` — Token counts, model, duration, cost
- `tool.execution_start` / `tool.execution_complete` — Tool calls with args/results
- `user.message` — User input with attachments
- `subagent.started` / `subagent.completed` / `subagent.failed` — Agent delegation
- `session.usage_info` — Token budget snapshots

### Should Have
- `assistant.reasoning` — Chain-of-thought blocks
- `subagent.selected` / `subagent.deselected` — Agent selection events
- `skill.invoked` — Skill usage
- `session.start` / `session.shutdown` — Session lifecycle
- `session.error` / `session.warning` — Error/warning events
- Hook events (`Pre/Post tool use hook`) — Tool intercepts

### Nice to Have
- `assistant.intent` — Intent classification
- `session.compaction_start` / `session.compaction_complete` — Context compaction
- `session.truncation` — Token truncation events
- `session.plan_changed` — Plan modifications
- `session.workspace_file_changed` — File changes
- `pending_messages.modified` — Queue changes

## Reference Materials

- **Working prototype**: `log-viewer.html` — All parsing, tree-building, and rendering logic
- **Event type system**: `SessionEvent_Decompiled.cs` — Complete C# types for all ~70 event types
- **Logging code**: `PocGenerator/Copilot/CopilotLogging.cs` — How events are serialized to Serilog
- **Test data**: `log.txt` — Real 91-line session log with nested subagents (3 levels deep)
