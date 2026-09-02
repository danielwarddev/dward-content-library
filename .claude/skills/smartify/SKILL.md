---
name: smartify
description: Turn a goal into a SMART goal, splitting it into multiple goals if it's too large.
user-invocable: true
disable-model-invocation: false
---

# Smartify

Transform a rough goal into one or more SMART goals.

## Process

1. **Check for a goal.** If the user has not provided one, ask for it and then **stop** — do not proceed until a goal is given in a follow-up message.
2. **Ask questions.** Use the rubric in [references/writing-rubric.md](references/writing-rubric.md) to interrogate the goal. The answers make the result actually attainable.
3. **Apply the 30-minute rule.** Estimate whether the goal can realistically be completed in 30 minutes or less.
   - If **yes**, proceed normally.
   - If **no**, extract exactly ONE concrete sub-task that *can* be completed in 30 minutes or less, and write the SMART goal around that sub-task instead. Note that the larger goal exists and explain what was extracted.
4. **Split if needed.** If the goal is too large or broad, split it into multiple focused SMART goals.
5. **Output.** For each SMART goal, produce:
   - A finished SMART goal statement (1–3 sentences)
   - Any key milestones or deadlines, if applicable

## SMART Definitions

| Letter | Attribute | Description |
|--------|-----------|-------------|
| **S** | **Specific** | Define exactly what you want to accomplish. What will be accomplished? What actions will you take? |
| **M** | **Measurable** | A goal needs a metric or indicator to determine success. This makes the goal tangible and allows tracking progress through data or milestones. |
| **A** | **Achievable** | How will the goal be achieved, and is it doable? Do you have the necessary skills, resources, and a clear action plan? |
| **R** | **Relevant** | Challenging but not impossible. How does it align with broader goals? Why is the result important? |
| **T** | **Time-bound** | A target date or deadline. Creates urgency and a timeframe to monitor progress. |

## References

| File | Read it when |
| ---- | ------------ |
| [references/writing-rubric.md](references/writing-rubric.md) | Interrogating the goal — the question rubric and helpful prioritization techniques |
| [references/examples.md](references/examples.md) | Wanting before/after examples, including the 30-minute extraction |
