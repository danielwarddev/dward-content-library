---
name: deal-flow
description: Navigate and close consulting and workshop deals using the Four Conversations model. Use this skill when preparing for a sales conversation, debriefing after one, deciding whether to pursue an opportunity, setting pricing, or writing a proposal.
user-invocable: true
disable-model-invocation: false
---

# Deal Flow

Coach the user through winning consulting and workshop engagements using Blair Enns' **Four
Conversations** model, adapted to their specific situation: a Microsoft MVP selling a fixed-scope
GitHub Copilot workshop and .NET testing coaching, part-time, alongside a full-time job.

**Source:** Blair Enns, *The Four Conversations: A New Model for Selling Expertise* (2023), and his
earlier *The Win Without Pitching Manifesto* and *Pricing Creativity*. This skill encodes the
framework's structure plus operational guidance for this user's context — it is not a substitute for
reading the books, which contain the actual language and scripts.

## Seller Context

Read [../../../project-ideas/playbooks/side-income/README.md](../../../project-ideas/playbooks/side-income/README.md)
and `workshop-on-ramp-plan.md` for the full picture. The short version:

- **Offer:** 3-hour GitHub Copilot workshop, one team (~15 devs), fixed price ~$2,500–3,500.
  Secondary: .NET testing coaching. The 6-week program is the upsell, never the first sale.
- **Buyer:** an engineering manager whose company bought Copilot licenses in the last 6–12 months and
  can't tell if they're working. Single approver, discretionary budget, no procurement.
- **Advantages:** Microsoft MVP, ~25 conference talks, runs a .NET user group, established blog.
- **Constraint:** ~2 hrs/night. Target is $12k/year — roughly four workshops.
- **Employer:** side work approved with conditions. Never pursue a current employer client.

## The Core Reframe

Selling expertise is **not** pitching. It is a sequence of four conversations, each with one job.
The expert leads; the expert asks the questions. A practitioner who answers questions all meeting has
become a vendor.

Two rules that do most of the work:

1. **Never skip ahead.** Pricing before value, or value before qualification, is what produces
   free consulting and lost deals.
2. **Disqualify early and cheerfully.** At 2 hrs/night, a bad-fit deal is more expensive than no deal.
   Saying "I don't think I'm the right fit" *increases* authority.

## Workflow

Ask the user which conversation they are in, then read that reference. If they don't know, work it out
from [references/four-conversations.md](references/four-conversations.md).

| Phase | Reference | Use when |
| ----- | --------- | -------- |
| Overview & diagnosis | [references/four-conversations.md](references/four-conversations.md) | Identifying which conversation this is, and what must be true to advance |
| 1. Probative | [references/probative.md](references/probative.md) | Building demand before an opportunity exists — talks, blog, user group, referral asks |
| 2. Qualifying | [references/qualifying.md](references/qualifying.md) | Deciding whether an opportunity is real and worth pursuing |
| 3. Value | [references/value.md](references/value.md) | Exploring the desired outcome and what it's worth; anchoring price |
| 4. Closing | [references/closing.md](references/closing.md) | Presenting options, handling objections, getting a decision |

Track every live opportunity using [references/deal-log.md](references/deal-log.md).

## How to Coach

- **Before a conversation:** prepare questions, not answers. Produce a short list the user can hold in
  their hand, plus the one thing that must be true to advance.
- **After a conversation:** debrief. What did they learn about the desired outcome? What is still
  unknown? Did they accidentally give away consulting? Update the deal log.
- **Be blunt about bad deals.** Recommending "walk away" is a valid and frequent output.
- **Watch for the recurring failure mode:** this user's instinct is to be helpful and teach. That is
  excellent in the Probative conversation and expensive in the Value conversation.

## Related Skills

- **smartify** — turn a deal-related intention into a SMART goal
- **document-output** — persist longer analyses to a markdown file
