/**
 * TypeScript interfaces for parsing GitHub Copilot chat replay JSON files
 * Schema derived from analyzing exported .chatreplay.json files
 */

// =============================================================================
// TOP-LEVEL STRUCTURE
// =============================================================================

/**
 * Root structure of a .chatreplay.json export file
 */
export interface ChatReplayLog {
    /** Original user prompt that started the conversation */
    prompt: string;

    /** Whether the user has viewed this log in the debug view */
    hasSeen: boolean;

    /** Total number of log entries */
    logCount: number;

    /** Array of request and tool call entries */
    logs: LogEntry[];
}

// =============================================================================
// LOG ENTRY TYPES
// =============================================================================

/**
 * Discriminated union of log entry types
 */
export type LogEntry = RequestLog | ToolCallLog;

/**
 * A request/response cycle with the LLM
 */
export interface RequestLog {
    /** Unique identifier (e.g., "a4b08e38") */
    id: string;

    /** Discriminator for log type */
    kind: "request";

    /** Response type (usually "ChatMLSuccess") */
    type: "ChatMLSuccess" | string;

    /** Agent/handler name (e.g., "panel/editAgent") */
    name: string;

    /** Rich metadata including token usage and timing */
    metadata: RequestMetadata;

    /** The messages sent to the LLM */
    requestMessages: RequestMessages;

    /** The LLM's response */
    response: Response;

    /** Optional thinking/reasoning content (for models that expose it) */
    thinking?: ThinkingContent;
}

/**
 * A tool call made during the conversation
 */
export interface ToolCallLog {
    /** Unique tool call ID (e.g., "toolu_vrtx_01MM4FtN3qs1k4PboNVotDbK__vscode-1769896508703") */
    id: string;

    /** Discriminator for log type */
    kind: "toolCall";

    /** Tool name (e.g., "mcp_microsoft_pla_browser_navigate", "read_file", "create_file") */
    tool: string;

    /** JSON string of tool arguments */
    args: string;

    /** Timestamp string */
    time: string;

    /** Tool response (structure varies by tool) */
    response: unknown[];

    /** Optional thinking content associated with this tool call */
    thinking?: ThinkingContent;
}

// =============================================================================
// METADATA & TOKEN USAGE
// =============================================================================

/**
 * Metadata for a request, including token usage and timing
 */
export interface RequestMetadata {
    /** Request type (usually "ChatCompletions") */
    requestType: "ChatCompletions" | string;

    /** Model name (e.g., "claude-opus-4.5", "gpt-4o") */
    model: string;

    /** Maximum allowed prompt tokens */
    maxPromptTokens: number;

    /** Maximum allowed response tokens */
    maxResponseTokens: number;

    /** Location identifier (purpose unclear, possibly internal) */
    location: number;

    /** ISO timestamp when request started */
    startTime: string;

    /** ISO timestamp when request completed */
    endTime: string;

    /** Total duration in milliseconds */
    duration: number;

    /** Our request ID (matches across related entries) */
    ourRequestId: string;

    /** Request ID */
    requestId: string;

    /** Server-side request ID */
    serverRequestId: string;

    /** Time to first token in milliseconds */
    timeToFirstToken: number;

    /** Token usage breakdown */
    usage: TokenUsage;

    /** Tools available for this request */
    tools: ToolDefinition[];
}

/**
 * Token usage details for a request
 */
export interface TokenUsage {
    /** Tokens in the completion/response */
    completion_tokens: number;

    /** Tokens in the prompt/request */
    prompt_tokens: number;

    /** Additional prompt token details */
    prompt_tokens_details: {
        /** Number of tokens served from cache */
        cached_tokens: number;
    };

    /** Total tokens (prompt + completion) */
    total_tokens: number;
}

/**
 * A tool definition available to the LLM
 */
export interface ToolDefinition {
    type: "function";
    function: {
        /** Tool name */
        name: string;
        /** Tool description */
        description: string;
        /** JSON Schema for parameters */
        parameters: Record<string, unknown>;
    };
}

// =============================================================================
// MESSAGES & CONTENT
// =============================================================================

/**
 * Container for request messages
 */
export interface RequestMessages {
    messages: Message[];
}

/**
 * A message in the conversation
 */
export interface Message {
    /** Role: 0 = system/user, 1 = assistant (needs verification) */
    role: 0 | 1;

    /** Content items within the message */
    content: ContentItem[];
}

/**
 * A content item within a message
 */
export interface ContentItem {
    /** Content type: 1 = text, 3 = ? (needs more investigation) */
    type: number;

    /** Text content (for type 1) */
    text?: string;

    /** Cache type information */
    cacheType?: string;
}

/**
 * LLM response structure
 */
export interface Response {
    type: "success" | string;

    /** Response message content */
    message: string[];
}

/**
 * Thinking/reasoning content from the model
 */
export interface ThinkingContent {
    /** Thinking block ID */
    id?: string;

    /** The model's reasoning/thinking text */
    text?: string;
}

// =============================================================================
// UTILITY TYPES
// =============================================================================

/**
 * Type guard to check if a log entry is a request
 */
export function isRequestLog(entry: LogEntry): entry is RequestLog {
    return entry.kind === "request";
}

/**
 * Type guard to check if a log entry is a tool call
 */
export function isToolCallLog(entry: LogEntry): entry is ToolCallLog {
    return entry.kind === "toolCall";
}

// =============================================================================
// VISUALIZATION TYPES (for the extension)
// =============================================================================

/**
 * A node in the conversation visualization
 */
export interface ConversationNode {
    id: string;
    type: "request" | "toolCall";

    /** For display in the graph */
    label: string;

    /** Short summary for node display */
    summary: string;

    /** Full details for the details panel */
    details: NodeDetails;
}

/**
 * Details for expanding a node
 */
export interface NodeDetails {
    /** For requests: the full prompt/response text */
    text?: string;

    /** For tool calls: the parsed arguments */
    toolArgs?: Record<string, unknown>;

    /** For tool calls: the response */
    toolResponse?: unknown;

    /** Token usage (for requests only) */
    tokenUsage?: TokenUsage;

    /** Timing information */
    timing?: {
        startTime: string;
        endTime: string;
        duration: number;
        timeToFirstToken?: number;
    };

    /** Model used */
    model?: string;

    /** Thinking content if available */
    thinking?: string;
}

/**
 * Summary statistics for a conversation
 */
export interface ConversationSummary {
    /** Total number of LLM requests */
    requestCount: number;

    /** Total number of tool calls */
    toolCallCount: number;

    /** Total tokens used across all requests */
    totalTokens: number;

    /** Total cached tokens */
    totalCachedTokens: number;

    /** Cache hit rate (cached / prompt tokens) */
    cacheHitRate: number;

    /** Total duration in seconds */
    totalDurationSeconds: number;

    /** Unique tools used */
    uniqueToolsUsed: string[];

    /** Model(s) used */
    modelsUsed: string[];
}
