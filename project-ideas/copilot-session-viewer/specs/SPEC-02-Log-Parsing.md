# Spec 2: Log Parsing & Event Model

**Status**: 📋 Not Started

---

## User Story

**As a developer**, I want to load a Serilog log file and have it parsed into typed event objects so that the rest of the app can work with structured session data.

## Description

Implement the log parsing pipeline that transforms raw Serilog text lines into typed TypeScript event objects. This includes regex-based line splitting, JSON data extraction, event type discrimination, and the file input mechanism (upload, drag-drop, paste). The parser must handle both standard event lines and hook lines which use a different format.

The Serilog format is:
```
TIMESTAMP [VRB] [COPILOT][EVENT_TYPE] id="GUID", data={JSON}
```

Hook lines use:
```
TIMESTAMP [VRB] [COPILOT][Pre/Post tool use hook] session=... tool=... args={JSON}
```

## Acceptance Criteria

### Event Type Model

- [ ] TypeScript interfaces/types exist for all "Must Have" event types from the implementation plan: `assistant.turn_start`, `assistant.turn_end`, `assistant.message`, `assistant.usage`, `tool.execution_start`, `tool.execution_complete`, `user.message`, `subagent.started`, `subagent.completed`, `subagent.failed`, `session.usage_info`
- [ ] TypeScript interfaces exist for "Should Have" types: `assistant.reasoning`, `subagent.selected`, `skill.invoked`, `session.start`, `session.shutdown`, `session.error`
- [ ] Each event type has the common fields: `id` (string), `timestamp` (Date), `type` (string discriminator)
- [ ] Event-specific data types match the shapes from `SessionEvent_Decompiled.cs` (e.g., `AssistantUsageData` has `model`, `inputTokens`, `outputTokens`, `cacheReadTokens`, `duration`, `initiator`, `parentToolCallId`)
- [ ] A catch-all `UnknownEvent` type exists for unrecognized event types so parsing never fails

### Line Parser

- [ ] A `parseLine(line: string)` function accepts a single Serilog line and returns a parsed event or null (for non-event lines)
- [ ] The parser extracts: timestamp, log level, event type, event id, and raw JSON data string
- [ ] Standard event lines matching `[COPILOT][event.type] id="...", data={...}` are parsed correctly
- [ ] Hook lines matching `[COPILOT][Pre/Post tool use hook] session=... tool=... args={...}` are parsed into a `HookEvent` type
- [ ] Lines that don't match either pattern return null (graceful skip)
- [ ] The JSON data string is deserialized into the appropriate typed event data object based on the event type discriminator

### Batch Parser

- [ ] A `parseLog(text: string)` function accepts the full log file text and returns an array of parsed events
- [ ] Events are returned in chronological order (by timestamp)
- [ ] Malformed lines are skipped without throwing; a count of skipped lines is available
- [ ] Empty input returns an empty array

### File Input

- [ ] Users can upload a `.txt` or `.log` file via a file input button
- [ ] Users can drag-and-drop a file onto the upload zone
- [ ] Users can paste log text into a textarea
- [ ] After loading, the raw text is passed to `parseLog()` and the resulting events are available for downstream consumers
- [ ] A loading indicator shows while parsing large files
- [ ] Parse errors or empty results display a user-friendly message

### Key Data Fields

- [ ] `parentToolCallId` is preserved on events that have it (assistant.usage, assistant.message, tool.execution_start/complete)
- [ ] `toolCallId` is preserved on tool execution and subagent events
- [ ] `AssistantMessageData.toolRequests` array is parsed with each item's `toolCallId`, `name`, and `arguments`
- [ ] `ToolExecutionCompleteData.result.content` and `result.detailedContent` are preserved
- [ ] `AssistantUsageData` preserves all token fields: `inputTokens`, `outputTokens`, `cacheReadTokens`, `cacheWriteTokens`, `cost`, `duration`

## Out of Scope

- Tree building / hierarchy reconstruction (SPEC-03)
- Rendering parsed events to the UI (SPEC-03)
- Native JSON event format support (future — only Serilog text format for now)
- Streaming/incremental parsing of live log files

## Technical Notes

- The prototype's regex patterns in `log-viewer.html` are proven and should be ported:
  - `EVENT_REGEX`: `/\[COPILOT\]\[([^\]]+)\]/` — extracts event type
  - `ID_DATA_REGEX`: `/id="([^"]+)",\s*data=(.+)$/` — extracts id and JSON data
  - `HOOK_REGEX`: `/\[COPILOT\]\[(Pre|Post) tool use hook\] session=(\S+) tool=(\S+) args=(.+)$/` — hook events
- JSON data can contain deeply nested objects (e.g., `toolRequests[].arguments` is arbitrary JSON)
- Some events have encrypted/opaque fields (`encryptedContent`, `reasoningOpaque`) — preserve as strings, don't try to decode
- The `data=` portion runs to end-of-line, so the regex captures everything after `data=`
- Reference: `SessionEvent_Decompiled.cs` for all field names and types, `CopilotLogging.cs` for which events include data

## Definition of Done

- [ ] All acceptance criteria are met
- [ ] Unit tests cover: standard line parsing, hook line parsing, malformed line handling, batch parsing, empty input
- [ ] Unit tests verify key data field extraction (parentToolCallId, toolCallId, token fields)
- [ ] Tests use fixture data from `log.txt` (real session log)
- [ ] No TypeScript errors
