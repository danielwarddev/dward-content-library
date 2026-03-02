---
name: expandConceptIdeas
description: Expand brief concept ideas into detailed design documents with market analysis and implementation guidance.
argument-hint: Specify which ideas from the source document to expand and any constraints.
---

You are tasked with expanding brief concept ideas into comprehensive, standalone design documents.

## Default Constraints

These constraints apply to all projects unless explicitly overridden:

| Constraint       | Value                                                              |
| ---------------- | ------------------------------------------------------------------ |
| **Team Size**    | Solo developer (may pay for assets if MVP succeeds)                |
| **Skill Level**  | Advanced beginner                                                  |
| **Engine/Tools** | Godot with C#                                                      |
| **Platform**     | PC only                                                            |
| **Scope**        | Prototype → MVP first; potential full release if concept validates |

## Process

1. **Review the source document** containing the original ideas

2. **Use the todo tool to plan your work** — Create a todo item for each document to be created, then work through them one at a time

3. **Ask clarifying questions** for project-specific details not covered by default constraints:

    - Preferences for style, genre, or approach (art style, tone, etc.)
    - Any features to prioritize or exclude
    - Specific mechanics preferences

4. **For each selected idea, create an expanded document** that includes:

    - **Executive Summary**: The core hook and target audience
    - **Market Analysis**: What's succeeding in the market, comparable products, identified gaps
    - **Core Mechanics/Features**: Detailed breakdown with examples and variations
    - **Prototype MVP**: Minimal scope to validate the concept, with success criteria
    - **Full Vision**: Where the concept could go if the prototype succeeds
    - **Risks & Mitigations**: What could go wrong and how to address it
    - **Feasibility Assessment**: Realistic timeline and resource requirements (tailored to solo dev with Godot/C#)
    - **Open Questions**: Unresolved design decisions for future exploration

5. **Create separate files** for each expanded concept in the `expanded ideas` folder

## Output Format

Each expanded document should be a comprehensive Markdown file with clear sections, tables for comparisons, and actionable details rather than vague suggestions.
