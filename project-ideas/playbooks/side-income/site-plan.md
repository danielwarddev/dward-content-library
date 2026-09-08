# danielward.dev: Personal Consulting Site Plan

**Revised:** September 3, 2026
**Purpose:** Establish Daniel Ward's professional home for solo consulting, with concrete services, credible proof, and a direct path to start a conversation.

---

## Product Direction

`danielward.dev` is a website for Daniel Ward, not a microsite for one workshop. Daniel's name, expertise, and point of view are the primary identity. The GitHub Copilot workshop is the first productized offer within a broader consulting practice.

The site should help an engineering leader quickly answer:

1. Who is Daniel?
2. What problems can he help my team solve?
3. Why should I trust him?
4. What is the most useful next step?

The site may begin with a small number of offers. It must not imply client results, availability, testimonials, or finalized commercial terms that have not been verified.

## Audience

Primary audiences:

- Engineering leaders evaluating practical AI adoption for software teams
- .NET teams seeking stronger testing, architecture, or delivery practices
- Conference and meetup organizers looking for an experienced technical speaker
- Peers and prospective clients following Daniel's writing and community work

## Information Architecture

| Route | Purpose |
| ----- | ------- |
| `/` | Introduce Daniel, his consulting focus, selected services, and evidence of expertise. |
| `/services` | Explain the ways Daniel can help, led by the GitHub Copilot workshop. |
| `/about` | Provide the relevant professional history, working perspective, credentials, and community involvement. |
| `/speaking` | Present selected talks and speaking topics, then link to the full archive. |
| `/contact` | Give prospective clients and organizers a direct, low-friction way to start a conversation. |

The primary navigation uses **Home**, **Services**, **About**, **Speaking**, and **Contact** in that order.

## Shared Site Requirements

Every page must include:

- A consistent header with Daniel Ward as the visible site identity
- Current-page navigation state and keyboard-visible focus
- A concise footer with direct links to writing, GitHub, and LinkedIn
- Unique page title, description, canonical URL, and Open Graph metadata
- Responsive, semantic layouts with no unnecessary client-side JavaScript
- One clear next action appropriate to the page

## Page Requirements

### Home `/`

The home page establishes Daniel before presenting an offer.

Required content:

- Daniel Ward as the primary heading and first-viewport identity
- A concise positioning statement focused on AI-assisted development and reliable .NET delivery
- A short introduction grounded in verified experience
- A restrained overview of services, with the GitHub Copilot workshop first
- Credibility signals: Microsoft .NET MVP, roughly 12 years of experience, consulting and coaching experience, speaking, and .NET community leadership
- Links to Services, About, Speaking, and Contact
- A link to Daniel's established writing at `daninacan.com`

### Services `/services`

The services page describes concrete ways to work together without pretending the practice is more mature than it is.

Initial service areas:

1. **GitHub Copilot workshops** - the existing three-hour, hands-on team workshop is the flagship offer. Include audience, agenda, delivery format, approximate team size, and a clear enquiry action. Keep the price marked for confirmation until finalized.
2. **.NET engineering coaching** - describe support around testing, architecture, delivery practices, and working in a team's real codebase. Do not publish a fixed package or price until defined.
3. **Technical speaking** - direct event organizers to the Speaking page for topics and prior appearances.

Do not add generic service cards merely to fill space. Each listed service must be supported by real experience or source material.

### About `/about`

The About page should make Daniel legible as a practitioner and collaborator, not reproduce a full resume.

Include:

- Microsoft .NET MVP credential
- Approximately 12 years of software experience
- Experience as a software developer, consultant, technical coach, agile coach, and tech lead
- Primary focus on C# and .NET, software testing, delivery practices, and effective AI-assisted development
- Community involvement with the San Antonio and Austin .NET user groups
- JetBrains Community Contributor and Pulumi Puluminary recognition
- Personal context such as writing and hobby game development, kept brief
- Links to the MVP profile, `daninacan.com`, GitHub, and LinkedIn

### Speaking `/speaking`

The Speaking page establishes practical teaching experience without becoming an exhaustive archive.

Include:

- A short statement about Daniel's speaking themes
- A selected list of verified appearances such as NDC Oslo, NDC Porto, DevOpsDays, O'Reilly Software Development Superstream, Nebraska.Code(), and JetBrains .NET Day Online
- Representative topic areas: software testing, team communication, .NET engineering, and AI-assisted development
- A link to the complete speaking archive at `daninacan.com/speaking/`
- A direct route to Contact for event enquiries

Do not claim unverified appearances. In particular, do not use KCDC as delivered speaking proof until verified.

### Contact `/contact`

The Contact page should feel direct and personal.

Include:

- A short invitation for consulting, workshop, and speaking enquiries
- The verified email address `danielwarddev@gmail.com`
- Helpful prompts for an enquiry: organization, problem or event, desired outcome, team or audience size, location, and timing
- Links to LinkedIn and the existing contact page at `daninacan.com/contact/`

Do not add a contact form until there is a clear delivery and spam-handling plan.

## Content Boundaries

- No fabricated testimonials, logos, client outcomes, or case studies
- No inflated agency language such as "we" or "our team"
- No broad service claims unsupported by Daniel's existing work
- No embedded blog feed in the first version; link to `daninacan.com`
- No newsletter signup in the first version
- No MDX or RSS until publishing original content on this domain becomes a requirement
- No finalized workshop price until Daniel confirms it
- No publication before employer approval for public consulting marketing is resolved

## Visual Direction

The site should feel like a personal professional publication: direct, calm, precise, and recognizably made for one person.

- Use a restrained neutral palette with one functional accent color
- Prefer one strong type family or a disciplined serif/sans pairing
- Keep text left-aligned with comfortable reading measures
- Use rules, whitespace, and typography for hierarchy rather than card grids
- Keep corners square or subtly rounded and avoid decorative shadows
- Avoid gradients, glass effects, glowing shapes, oversized slogans, logo clouds, and generic feature icon grids
- Use a real portrait as the primary visual asset when available
- Use selected speaking imagery only when it shows Daniel or a real event clearly
- Keep motion minimal and respect reduced-motion preferences

The home page must not resemble a SaaS landing page, an agency template, or a workshop flyer. The workshop agenda may retain a structured program treatment within Services.

## Technical Direction

- Vanilla Astro 7 with Tailwind CSS 4
- Static output deployed through Cloudflare Workers Static Assets
- Shared Astro components for the header, footer, page introductions, links, and repeated service/speaking structures
- Astro Assets for local responsive images
- Sitemap and per-page canonical/Open Graph metadata
- Minimal, privacy-conscious analytics added after deployment
- No client-side framework unless a later interaction genuinely requires one

## Launch Requirements

- Confirm public consulting activity is permitted by Daniel's employer
- Confirm final positioning language and service boundaries
- Confirm the workshop price or remove it until settled
- Replace portrait placeholders with an approved image
- Confirm the production email or forwarding address
- Add a social-sharing image
- Test all five routes on mobile and desktop
- Run a deployed accessibility and PageSpeed review

## Later, When Earned

- Testimonials and client logos after real engagements
- Case studies with permission and measurable outcomes
- Additional productized services after demand is demonstrated
- Original articles, MDX, RSS, tags, and a local content archive
- A contact form or scheduling integration when enquiry volume justifies it

---

## Notes

The original September 1 plan intentionally scoped `danielward.dev` to one workshop conversion page. That constraint was useful for comparing Astro foundations, but it no longer represents the intended product. The workshop POC remains valuable source material for the Services page.
