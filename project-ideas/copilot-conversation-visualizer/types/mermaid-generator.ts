/**
 * Mermaid diagram generator for chat replay logs
 * Converts ChatReplayLog to Mermaid flowchart syntax
 */

import {
    ChatReplayLog,
    LogEntry,
    RequestLog,
    ToolCallLog,
    isRequestLog,
    isToolCallLog,
    ConversationSummary,
} from "./chatreplay";

export interface MermaidGeneratorOptions {
    /** Include token usage in node labels */
    showTokens: boolean;

    /** Include duration in node labels */
    showDuration: boolean;

    /** Group consecutive tool calls into a single node */
    groupToolCalls: boolean;

    /** Maximum label length before truncating */
    maxLabelLength: number;

    /** Direction of the flowchart */
    direction: "TD" | "LR";
}

const defaultOptions: MermaidGeneratorOptions = {
    showTokens: true,
    showDuration: true,
    groupToolCalls: true,
    maxLabelLength: 40,
    direction: "TD",
};

/**
 * Generate a Mermaid flowchart from a chat replay log
 */
export function generateMermaidDiagram(
    log: ChatReplayLog,
    options: Partial<MermaidGeneratorOptions> = {},
): string {
    const opts = { ...defaultOptions, ...options };
    const lines: string[] = [`flowchart ${opts.direction}`];

    // Add subgraph for the conversation
    lines.push("    subgraph Conversation");

    let prevNodeId: string | null = null;
    let toolGroup: ToolCallLog[] = [];
    let nodeCounter = 0;

    const flushToolGroup = () => {
        if (toolGroup.length === 0) return;

        nodeCounter++;
        const nodeId = `TG${nodeCounter}`;

        if (toolGroup.length === 1) {
            // Single tool call - show tool name
            const tool = toolGroup[0];
            const toolName = formatToolName(tool.tool);
            lines.push(`        ${nodeId}[/"🔧 ${toolName}"/]`);
        } else {
            // Multiple tool calls - show count and names
            const toolNames = [
                ...new Set(toolGroup.map((t) => formatToolName(t.tool))),
            ];
            const label = `🔧 ${toolGroup.length} tools: ${toolNames.slice(0, 3).join(", ")}${toolNames.length > 3 ? "..." : ""}`;
            lines.push(
                `        ${nodeId}[/"${truncate(label, opts.maxLabelLength)}"/]`,
            );
        }

        if (prevNodeId) {
            lines.push(`        ${prevNodeId} --> ${nodeId}`);
        }
        prevNodeId = nodeId;
        toolGroup = [];
    };

    for (const entry of log.logs) {
        if (isToolCallLog(entry)) {
            if (opts.groupToolCalls) {
                toolGroup.push(entry);
            } else {
                // Output individual tool call
                nodeCounter++;
                const nodeId = `T${nodeCounter}`;
                const toolName = formatToolName(entry.tool);
                lines.push(`        ${nodeId}[/"🔧 ${toolName}"/]`);
                if (prevNodeId) {
                    lines.push(`        ${prevNodeId} --> ${nodeId}`);
                }
                prevNodeId = nodeId;
            }
        } else if (isRequestLog(entry)) {
            // Flush any pending tool group before the response
            if (opts.groupToolCalls) {
                flushToolGroup();
            }

            // Add response node
            nodeCounter++;
            const nodeId = `R${nodeCounter}`;
            const label = formatRequestLabel(entry, opts);
            lines.push(`        ${nodeId}["${label}"]`);

            if (prevNodeId) {
                lines.push(`        ${prevNodeId} --> ${nodeId}`);
            }
            prevNodeId = nodeId;
        }
    }

    // Flush any remaining tool calls
    if (opts.groupToolCalls) {
        flushToolGroup();
    }

    lines.push("    end");

    return lines.join("\n");
}

/**
 * Format a tool name for display (remove prefixes, shorten)
 */
function formatToolName(tool: string): string {
    return tool
        .replace("mcp_microsoft_pla_", "")
        .replace("mcp_pylance_mcp_s_", "")
        .replace("browser_", "")
        .replace(/_/g, " ");
}

/**
 * Format a request log entry as a node label
 */
function formatRequestLabel(
    entry: RequestLog,
    opts: MermaidGeneratorOptions,
): string {
    const parts: string[] = ["🤖 Response"];

    if (opts.showTokens && entry.metadata?.usage) {
        const usage = entry.metadata.usage;
        const cached = usage.prompt_tokens_details?.cached_tokens || 0;
        const cachePercent =
            usage.prompt_tokens > 0
                ? Math.round((cached / usage.prompt_tokens) * 100)
                : 0;
        parts.push(
            `📊 ${formatNumber(usage.total_tokens)} tok (${cachePercent}% cached)`,
        );
    }

    if (opts.showDuration && entry.metadata?.duration) {
        const seconds = (entry.metadata.duration / 1000).toFixed(1);
        parts.push(`⏱️ ${seconds}s`);
    }

    return parts.join("<br/>");
}

/**
 * Format a number with K suffix for thousands
 */
function formatNumber(n: number): string {
    if (n >= 1000) {
        return `${(n / 1000).toFixed(1)}K`;
    }
    return n.toString();
}

/**
 * Truncate a string to a maximum length
 */
function truncate(s: string, maxLength: number): string {
    if (s.length <= maxLength) return s;
    return s.substring(0, maxLength - 3) + "...";
}

/**
 * Calculate summary statistics for a conversation
 */
export function calculateSummary(log: ChatReplayLog): ConversationSummary {
    let requestCount = 0;
    let toolCallCount = 0;
    let totalTokens = 0;
    let totalCachedTokens = 0;
    let totalPromptTokens = 0;
    let totalDurationMs = 0;
    const toolsUsed = new Set<string>();
    const modelsUsed = new Set<string>();

    for (const entry of log.logs) {
        if (isRequestLog(entry)) {
            requestCount++;

            if (entry.metadata) {
                totalDurationMs += entry.metadata.duration || 0;

                if (entry.metadata.model) {
                    modelsUsed.add(entry.metadata.model);
                }

                if (entry.metadata.usage) {
                    totalTokens += entry.metadata.usage.total_tokens || 0;
                    totalPromptTokens +=
                        entry.metadata.usage.prompt_tokens || 0;
                    totalCachedTokens +=
                        entry.metadata.usage.prompt_tokens_details
                            ?.cached_tokens || 0;
                }
            }
        } else if (isToolCallLog(entry)) {
            toolCallCount++;
            toolsUsed.add(entry.tool);
        }
    }

    return {
        requestCount,
        toolCallCount,
        totalTokens,
        totalCachedTokens,
        cacheHitRate:
            totalPromptTokens > 0 ? totalCachedTokens / totalPromptTokens : 0,
        totalDurationSeconds: totalDurationMs / 1000,
        uniqueToolsUsed: Array.from(toolsUsed),
        modelsUsed: Array.from(modelsUsed),
    };
}

/**
 * Generate a summary markdown section
 */
export function generateSummaryMarkdown(summary: ConversationSummary): string {
    const lines: string[] = [
        "## Conversation Summary",
        "",
        `| Metric | Value |`,
        `|--------|-------|`,
        `| **Requests** | ${summary.requestCount} |`,
        `| **Tool Calls** | ${summary.toolCallCount} |`,
        `| **Total Tokens** | ${formatNumber(summary.totalTokens)} |`,
        `| **Cache Hit Rate** | ${(summary.cacheHitRate * 100).toFixed(1)}% |`,
        `| **Total Duration** | ${summary.totalDurationSeconds.toFixed(1)}s |`,
        `| **Unique Tools** | ${summary.uniqueToolsUsed.length} |`,
        `| **Model(s)** | ${summary.modelsUsed.join(", ")} |`,
        "",
    ];

    if (summary.uniqueToolsUsed.length > 0) {
        lines.push("### Tools Used");
        lines.push("");
        for (const tool of summary.uniqueToolsUsed) {
            lines.push(`- \`${tool}\``);
        }
        lines.push("");
    }

    return lines.join("\n");
}
