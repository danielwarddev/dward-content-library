# Spec 6: Search, Filter & Navigation

**Status**: 📋 Not Started

---

## User Story

**As a developer**, I want to search and filter session events by type, agent name, tool name, or content so that I can quickly locate specific activity in large sessions without manually expanding every node.

## Description

Large Copilot sessions can have hundreds of events across multiple agents and turns. This spec adds search and filtering capabilities to the session timeline view, allowing developers to narrow the visible events and jump to specific tool calls, messages, or agents. This includes a text search bar, event type filters, agent name filters, and keyboard navigation between results.

## Acceptance Criteria

### Text Search

- [ ] A search input field is visible above the timeline (below the statistics bar)
- [ ] Typing in the search field filters events to those containing the search text in any visible field (tool name, arguments, message content, agent name, result content)
- [ ] Search is case-insensitive
- [ ] Search results are highlighted within the matching text
- [ ] A result count is shown (e.g., "12 matches")
- [ ] Pressing Enter or clicking a "next" button jumps to the next matching event, scrolling it into view
- [ ] Pressing Shift+Enter or a "previous" button jumps to the previous match
- [ ] Clearing the search restores the full timeline

### Event Type Filter

- [ ] A filter control allows toggling visibility of event types: tool calls, LLM usage, messages, reasoning, subagent blocks, hook events
- [ ] Filters are presented as toggle buttons or checkboxes
- [ ] Multiple event types can be visible simultaneously (filters are additive)
- [ ] By default, all event types are visible
- [ ] Filtering updates the timeline immediately (no submit button needed)
- [ ] The result count updates to reflect filtered events

### Agent Filter

- [ ] A dropdown or chip-select lists all agent names found in the session (extracted from `subagent.started` and `subagent.selected` events)
- [ ] Selecting an agent filters the timeline to only show events within that agent's scope (matching `parentToolCallId` chain)
- [ ] "All agents" option shows everything (default)
- [ ] Multiple agents can be selected simultaneously
- [ ] The agent filter works in combination with text search and event type filters

### Tool Name Filter

- [ ] A dropdown or chip-select lists all unique tool names from `tool.execution_start` events
- [ ] Selecting one or more tools filters to only show those tool calls (and their containing context)
- [ ] Works in combination with other filters

### Auto-Expand on Search

- [ ] When a search match is inside a collapsed turn or subagent block, that container auto-expands to reveal the match
- [ ] The matched event is scrolled into view and briefly highlighted (flash animation)
- [ ] Clearing the search does not re-collapse previously expanded containers

### Keyboard Navigation

- [ ] `Ctrl+F` / `Cmd+F` focuses the search input
- [ ] `Escape` clears the search and removes focus from the input
- [ ] `↑` / `↓` keys navigate between matches when the search input is focused

## Out of Scope

- Regex search (plain text only for now)
- Saving/bookmarking search queries
- Search across multiple loaded sessions
- Advanced query language (e.g., `type:tool AND name:task`)
- Search within encrypted/opaque content fields

## Technical Notes

- The search functionality should work on the rendered DOM content as well as the underlying data model for complete coverage
- For efficient filtering, the tree builder should tag each node with metadata: `agentName`, `toolName`, `eventType`, `depth` — so filters don't need to reparse
- The agent name for a subtree can be determined by walking up the `parentToolCallId` chain to the nearest `subagent.started` event
- Consider debouncing the text search input (200–300ms) to avoid re-rendering on every keystroke
- The highlight approach: wrap matched text segments in `<mark>` elements with a CSS highlight style
- For keyboard navigation between matches, maintain an index into a flat array of match positions
- Filter state should be preserved if the user collapses/expands nodes (don't reset filters on UI interaction)

## UI Wireframe Concepts

### Search & Filter Bar

```
┌──────────────────────────────────────────────────────────────────┐
│  🔍 [Search events...________]  ◀ ▶  12 matches                │
│                                                                   │
│  Types: [✓ Tools] [✓ LLM] [✓ Messages] [✓ Reasoning] [✓ Hooks] │
│  Agent: [All ▾]    Tool: [All ▾]                                 │
└──────────────────────────────────────────────────────────────────┘
```

## Definition of Done

- [ ] All acceptance criteria are met
- [ ] Unit tests cover: text search matching, event type filtering, agent scope filtering
- [ ] Unit tests cover edge cases: no matches, search in empty session, special characters in search text
- [ ] Search + filter combination works correctly (AND logic between all active filters)
- [ ] Keyboard shortcuts work on the supported platforms
- [ ] No TypeScript errors
