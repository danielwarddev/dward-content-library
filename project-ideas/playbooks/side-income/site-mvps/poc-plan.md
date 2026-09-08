# Consulting Site MVP Comparison Plan

**Generated:** September 3, 2026
**Context:** Build two local proofs of concept for the one-page GitHub Copilot workshop offer defined in [../site-plan.md](../site-plan.md). One POC will use a minimal Astro project with selected capabilities added deliberately; the other will use AstroWind and reduce it to the same offer. The purpose is to compare the resulting UX, visual quality, implementation effort, and maintainability before choosing the production foundation.

---

## Task for the Next Session

Build both POCs in the existing folders:

- `astro-vanilla-test/`
- `astrowind-test/`

Do not publish either version. Do not turn either POC into a general consulting site. Both versions must implement the same one-page offer and use substantially the same copy so the comparison is about the implementation foundation rather than different content decisions.

Read [../site-plan.md](../site-plan.md) before beginning. It is the source of truth for the audience, page structure, required content, exclusions, and conversion goal.

## What We Are Trying to Learn

The POCs should answer these questions:

1. Does AstroWind provide a meaningfully better responsive UX and visual baseline than a minimal Astro build?
2. Can the vanilla version avoid looking generic or obviously AI-generated without requiring disproportionate design work?
3. How much irrelevant code and structure must be removed from AstroWind?
4. Which version is easier to understand, customize, and maintain after the initial build?
5. Which version better supports the actual offer rather than resembling a generic SaaS or agency landing page?

Do not optimize for the fewest lines of code. Optimize for a credible page that can be maintained confidently and finished within the existing one-weekend timebox.

## Shared Product Requirements

Both POCs must present the same single scrolling page in this order:

1. Outcome-led headline and one-line subhead
2. Who the workshop is for
3. What the team gets, expressed as a scannable three-hour agenda
4. Fixed price and logistics
5. Short bio with portrait, Microsoft MVP credential, compressed speaking proof, and a link to daninacan.com
6. One booking CTA, repeated at the bottom

Both versions must also follow these constraints:

- One offer only: the three-hour “Zero to Hero with GitHub Copilot” workshop
- Approximately 15 developers per team
- Remote or on-site delivery
- Fixed price in the approximate $2,500–$3,500 range
- Mobile-first and easy to scan
- Accessible semantic structure, keyboard behavior, focus states, and contrast
- No blog, portfolio, separate About page, services menu, full speaking archive, newsletter signup, or fake social proof
- No testimonials until real workshop testimonials exist
- No generic dashboard mockups, logo clouds, gradient headlines, oversized feature grids, or decorative technology imagery
- One consistent CTA label and destination

Use real content where it is already available. Mark unresolved copy, price, portrait, and booking-link decisions clearly rather than inventing facts.

## POC A: Minimal Astro

Build a small Astro site from a minimal official starter. This version should demonstrate what the site looks like when only the capabilities required by this offer are selected, rather than inheriting a complete theme.

### General Capabilities to Include

| Capability | Desired outcome |
| ---------- | --------------- |
| Production quality | A fast static page with strong PageSpeed/Core Web Vitals results and no unnecessary client-side JavaScript |
| Styling foundation | Tailwind CSS v4 available for a consistent responsive design system |
| Responsive UX | Deliberate desktop and mobile layouts, readable line lengths, stable spacing, and controls that remain usable at narrow widths |
| Accessibility | Semantic landmarks and headings, visible keyboard focus, sufficient contrast, useful image alternatives, and reduced-motion respect |
| Image handling | Optimized, responsive delivery for Daniel’s portrait and any other required local images |
| Search metadata | Unique title and description, canonical URL support, robots directives, and appropriate Open Graph/social-sharing metadata |
| Sitemap | Automatically generated from the site’s routes |
| Analytics readiness | A minimal, privacy-conscious place to add analytics without making analytics necessary for local development |
| Maintainability | A small, understandable structure with shared layout, metadata, and design tokens rather than one large generated page |
| Quality checks | A production build plus responsive, accessibility, metadata, and basic browser checks |

Dark mode, RTL, MDX, RSS, categories, tags, social sharing, and a blog are not required for this offer. Do not add features solely to match AstroWind’s feature list when [../site-plan.md](../site-plan.md) explicitly excludes them.

### Visual Direction

Do not prompt for “a modern consulting landing page.” Use this concrete direction:

- A premium conference workshop listing combined with a concise editorial profile
- Left-aligned typography and a visible content grid rather than a centered SaaS hero
- One distinctive display typeface paired with a highly readable body typeface
- Near-black, warm white, and one strong accent color; no gradients
- The agenda treated as structured program information, not a collection of generic feature cards
- Price and logistics presented as decision-critical facts, not a three-tier pricing component
- One real portrait as the primary visual asset
- Restrained rules, numbering, and spacing inspired by conference schedules
- Minimal purposeful motion, if any

The design should feel authored for this workshop. It should not look like an unmodified component-library demo or an AI-generated startup template.

## POC B: AstroWind

Start from the current official AstroWind repository or starter at a reviewed revision. Preserve the MIT license and record the source revision used.

Use AstroWind as a responsive component and configuration foundation, not as permission to keep its demo site architecture.

### Keep and Reuse

Retain the pieces that provide direct value to this page:

- Current Astro and Tailwind foundation
- Shared layout and metadata handling
- Responsive navigation or header behavior, simplified for this one-page site
- Accessible button and link treatments
- Image optimization
- Sitemap and Open Graph support
- Analytics integration point
- Useful responsive section primitives
- Existing performance-conscious defaults

### Remove or Disable

Delete or disable anything that does not serve the one-page workshop offer:

- Blog routes, content, categories, tags, RSS, and MDX-specific blog machinery
- Sample landing pages and alternate homepage variants
- Services, pricing tiers, portfolio, team, contact, and About pages
- Theme-demo content, placeholder assets, fake logos, and fake testimonials
- Multiple CTA variants and generic “learn more” paths
- Unused integrations, widgets, components, navigation entries, and configuration
- Dark mode or RTL support if retaining them creates visible complexity without serving the target audience

The result should not feel like AstroWind with Daniel’s text pasted into it. Change the default typography, color palette, section composition, and decorative treatment enough to establish a specific identity while preserving useful underlying behavior.

### Content Adaptation

Replace AstroWind’s startup-oriented page composition with the exact shared section order above. In particular:

- Do not use a generic feature grid for the agenda.
- Do not use SaaS pricing cards for the fixed workshop price.
- Do not add customer logos or testimonials as visual filler.
- Do not turn credibility into a portfolio or résumé section.
- Do not retain secondary calls to action merely because the components exist.

## Fair Comparison Rules

Keep these variables aligned between the two POCs:

- Same substantive copy and section order
- Same portrait and factual credentials
- Same CTA wording and placeholder destination
- Same target viewport sizes
- Same browser checks
- Similar visual direction, while allowing each foundation to express it naturally

Do not deliberately make the vanilla version plain or preserve AstroWind’s demo styling untouched. Each version should receive a serious but timeboxed attempt.

Track approximate hands-on time separately for each POC, including setup, implementation, debugging, removal of unused code, and visual refinement.

## Evaluation

After both versions run locally, compare them using this scorecard:

| Criterion | What to examine |
| --------- | --------------- |
| Offer clarity | Can an engineering manager quickly understand the outcome, audience, agenda, price, logistics, credibility, and next action? |
| Visual credibility | Does the page feel intentional and specific rather than generic, templated, or obviously AI-generated? |
| Mobile UX | Is the entire decision path comfortable to read and use on a phone without awkward wrapping, overflow, or oversized sections? |
| Accessibility | Do semantic structure, keyboard use, focus visibility, contrast, and motion behavior hold up? |
| Performance | Does the production build remain lightweight and score well without avoidable client JavaScript or layout shifts? |
| Cleanup burden | How much generated or inherited structure had to be removed or overridden? |
| Maintainability | Can the remaining structure be understood and changed without learning a large abstraction layer? |
| Time to acceptable result | How long did it take to reach a version that could plausibly be published after final copy and assets? |

Capture desktop and mobile screenshots of both versions at equivalent viewport sizes. Also record production-build results, any browser-console errors, and a short list of compromises made in each implementation.

## Completion Criteria

The POC task is complete when:

- Both folders contain working local Astro projects.
- Both projects build successfully for production.
- Both render the complete shared one-page offer on desktop and mobile.
- Browser checks show no obvious overflow, overlap, broken assets, or console errors.
- Each has been reviewed against the shared exclusions.
- Equivalent screenshots and brief implementation notes exist for comparison.
- A short recommendation identifies the stronger production foundation and explains the tradeoff.

Do not deploy, purchase a theme, configure a production domain, or expand the offer during this task.

---

## Notes

AstroWind was active on Astro 7 and Tailwind 4 when reviewed on September 2, 2026. Its ownership transfer is not currently a reason to reject it; the POC should focus on whether its UX foundation justifies the cleanup and customization cost.

The minimal Astro POC can reproduce the relevant production capabilities, but they are not all preconfigured by a bare starter. The purpose of the comparison is to measure whether selecting those capabilities deliberately produces a better long-term result than reducing AstroWind.
