---
name: createImplementationSteps
description: Break down a design document or concept into bite-sized implementation steps.
argument-hint: The design document or concept to break down, plus optional context about experience level, time budget, and priorities
---

You are helping a developer break down a design document or project concept into small, actionable implementation steps.

## Default Context

Unless specified otherwise, assume:

-   **Engine:** Godot 4.x with C#
-   **Experience:** Advanced beginner with Godot, expert with C#
-   **Time budget:** 2-5 hours/week
-   **Scope:** MVP/Prototype
-   **Art:** Placeholder art initially
-   **New project:** The user will start with a fresh project (they know how to set it up — include setup steps briefly but don't over-detail)
-   **Prior Godot experience:** First project of this type in Godot (include Phase 0 for relevant Godot fundamentals)

## Instructions

1. Review the provided design document or concept
2. Ask clarifying questions before creating the plan:

    - Priority areas to focus on first
    - Areas to explicitly exclude

3. Based on the answers, create a markdown implementation plan with:

    - **Phases** grouping related work
    - **Small steps** (30-60 min each) with checkboxes
    - **"Done when"** criteria for each step
    - Clear progression from foundation to features to polish
    - A milestone checklist summarizing the end state
    - Tips for staying on track
    - Next steps for post-prototype/MVP expansion

4. Size steps appropriately for the stated experience level and time budget
5. Exclude areas the user doesn't want to tackle yet
6. Use placeholder approaches where the user indicated
7. Focus on the priority areas first in the phase ordering
8. Include a Phase 0 for learning prerequisites if the user is newer to the technology

## Output Format

Create a new markdown file with:

-   **Header block** with metadata (engine, time budget, focus areas, estimated duration)
-   **Phase 0** for learning prerequisites (if user is new to the tech)
-   **Phases** with week estimates in the heading (e.g., "Phase 2: Feature X (Weeks 3-4)")
-   **Numbered steps** using hierarchical format (1.1, 1.2, 2.1, etc.) with checkboxes
-   **Time estimates** per step (e.g., "**Time:** ~1-2 hours")
-   **"Done when"** criteria for each step
-   **Milestone checkpoints** at key phases (not just at the end)
-   **Tips section** for staying on track
-   **Resources section** with relevant documentation links
-   **Next steps** for post-prototype expansion
