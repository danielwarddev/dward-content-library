# Site: Next Steps

**Generated:** September 5, 2026
**Context:** The POC comparison in [site-mvps/comparison-notes.md](site-mvps/comparison-notes.md) is
complete — minimal Astro won. These are the SMART goals to get from "two local POCs" to "one published
page." Scoped from that document's *Before Publishing* list.

**Blocked by:** Goal 0 in [workshop-on-ramp-plan.md](workshop-on-ramp-plan.md) — written employer
sign-off on public marketing. **Do not deploy publicly before that lands.** Everything below except S3
can proceed regardless.

---

## 30-Minute Rule: Do This First

Publishing is too large for 30 minutes. Extracted sub-task: **make the two decisions that are blocking
the copy** — the price and the booking mechanism. Both are currently placeholders
(`$3,000` POC note, `mailto:hello@danielward.dev`), and both are decisions rather than work.

> **SMART Goal S0 — Lock price and booking**
>
> Decide and write down the final workshop price and the booking mechanism (scheduling link vs. short
> form vs. email) by **end of day Sunday, September 6, 2026**, recording both in
> [site-plan.md](site-plan.md) — so the remaining site work is execution rather than deliberation.
>
> - **Measure:** Both decisions recorded in site-plan.md.
> - **Time cost:** ~30 minutes. No building.
> - **Default if undecided:** $3,000 and a scheduling link. Pick the default rather than deferring.

## The Sequence After That

> **SMART Goal S1 — Promote the winner**
>
> Move `site-mvps/astro-vanilla-test/` into its own repository as the production project and delete
> `astrowind-test/` by **Sunday, September 13, 2026** — so the site stops living inside the content
> library and the losing POC stops being a maintenance question.
>
> - **Measure:** New repo exists and builds; `astrowind-test/` deleted; POC notes kept for the record.

> **SMART Goal S2 — Clear the punch list**
>
> Complete the five *Before Publishing* items from
> [site-mvps/comparison-notes.md](site-mvps/comparison-notes.md) — real portrait, final price, real
> booking target, production domain in canonical/sitemap/robots, and a Lighthouse plus accessibility
> pass — by **Sunday, September 20, 2026**.
>
> - **Measure:** All five checked off; Lighthouse run against a production build.
> - **Depends on:** S0.

> **SMART Goal S3 — Publish**
>
> Deploy the page to `danielward.dev` on a static host by **Sunday, September 27, 2026**, matching
> Goal 2 in [workshop-on-ramp-plan.md](workshop-on-ramp-plan.md).
>
> - **Measure:** Live at the domain, loads over HTTPS, booking CTA works end to end.
> - **Gated by:** employer sign-off (Goal 0).

> **SMART Goal S4 — Point everything at it**
>
> Update the closing slide of the standard talk deck, conference and social bios, the daninacan.com
> "Work with me" page, and the user group intro to link to danielward.dev by
> **Sunday, October 4, 2026** — because an unlinked page collects nobody.
>
> - **Measure:** All four updated.
> - **Note:** This is the step that converts ~25 past talks' worth of audience into traffic. It matters
>   more than any remaining polish on the page itself.

---

## Notes

- **The page is nearly done; the plan is not.** Do not let further site refinement substitute for
  Goal 1 (the named list) in [workshop-on-ramp-plan.md](workshop-on-ramp-plan.md). That remains the
  actual bottleneck.
- S4 is the highest-value item here and the easiest to skip.
