---
name: skill-detection
description: Detects when the user is performing a new type of task that doesn't have an existing skill and offers to create one. This is a meta-skill for skill management.
---

# Skill Detection and Creation

This skill helps identify when a user is working on a task that could benefit from a reusable skill but doesn't have one yet.

## When to Use This Skill

This skill is ALWAYS active and should monitor every user request. Apply this logic to every interaction:

### Detection Criteria

A task is a candidate for a new skill when:

1. **Recurring Work Pattern**: The user is performing a task that involves multiple steps or has a specific methodology
2. **Domain-Specific Knowledge**: The task requires specific knowledge about the project, workflow, or standards
3. **No Existing Skill**: None of the current skills cover this type of task
4. **Reusable Process**: The task could be performed again in the future with similar steps

### Common Skill-Worthy Tasks

-   Content creation workflows (writing, reviewing, publishing)
-   Development workflows (testing, deploying, refactoring)
-   Research and analysis processes
-   File organization and management patterns
-   Communication templates and processes
-   Project-specific build or deployment steps

### NOT Skill-Worthy

-   One-time requests with no repeatable pattern
-   Simple file edits or reads
-   General programming knowledge that isn't project-specific
-   Requests that are already covered by existing skills

## How to Offer Skill Creation

When you detect a task that meets the criteria above:

1. **Complete the Current Task First**: Don't interrupt the user's current work
2. **After Completion**: Ask if they want to save this as a reusable skill
3. **Be Specific**: Mention what the skill would help with

### Example Prompt

```
I noticed you were [brief description of the task]. This seems like a repeatable workflow. Would you like me to create a skill for this type of task? It would help with [specific benefit].
```

### If User Says Yes

Call the `/saveSkill` command to create the skill based on the work just performed. The command will prompt for the necessary details.

### If User Says No or Doesn't Respond

-   Don't create the skill
-   Don't mention it again for this specific task type
-   Continue to monitor for other skill opportunities

## Implementation Notes

-   Monitor the conversation context for multi-step tasks
-   Pay attention to tasks where the user provides specific requirements or processes
-   Don't be overly eager - focus on genuinely useful, repeatable workflows
-   Skills should be about "how" to do something in this project, not general knowledge
