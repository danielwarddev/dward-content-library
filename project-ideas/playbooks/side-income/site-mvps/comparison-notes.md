# Consulting Site POC Comparison

**Reviewed:** September 3, 2026  
**AstroWind source revision:** `8d0090f933b71439c02956f7e8d30d41de804832`

## Result

Use the minimal Astro implementation as the production foundation.

Both versions present the offer clearly and produce a credible, responsive workshop page. AstroWind supplies useful metadata and image infrastructure, but it did not produce a materially better result for this one-page site. Reaching the final page required removing demo routes, posts, blog components, content collections, scripts, theme behavior, navigation, and bundled sample images. The vanilla project expresses the same product with much less inherited structure and a smaller production output.

## Scorecard

| Criterion | Minimal Astro | AstroWind | Notes |
| --- | ---: | ---: | --- |
| Offer clarity | 5/5 | 5/5 | Same copy, order, facts, and CTA destination. |
| Visual credibility | 5/5 | 5/5 | Both use an authored conference-program/editorial direction rather than template sections. |
| Mobile UX | 5/5 | 5/5 | No horizontal overflow at the 300 px narrow browser viewport. |
| Accessibility | 4/5 | 4/5 | Semantic landmarks, one H1, labelled regions, skip link, focus styles, contrast, and reduced-motion handling are present. No automated screen-reader audit was run. |
| Performance baseline | 5/5 | 4/5 | Vanilla emits 44 KB/7 files; AstroWind emits 217 KB/14 files, mostly from its retained font, broader CSS, metadata, compression, favicon, and 404 infrastructure. |
| Cleanup burden | 5/5 | 2/5 | Vanilla needed only selected capabilities. AstroWind initially built 36 routes and demo assets before reduction. |
| Maintainability | 5/5 | 3/5 | Vanilla has one direct page, layout, and stylesheet. AstroWind retains a larger component/config abstraction layer. |
| Time to acceptable result | 5/5 | 3/5 | Agent-assisted elapsed work was approximately 6 minutes for vanilla and 18 minutes for AstroWind, excluding shared source inspection. |

## Validation

| Check | Minimal Astro | AstroWind |
| --- | --- | --- |
| Production build | Pass, 1 route in 1.67 s | Pass, 2 routes in 1.21 s |
| Project checks | Build pass | Astro check: 0 errors/warnings/hints; ESLint and Prettier pass |
| Browser console | No errors | No errors |
| Horizontal overflow | None at 300 px or 1140 px | None at 300 px or 1140 px |
| Heading structure | One H1 with ordered section headings | One H1 with ordered section headings |
| CTA consistency | Both links use the same label and mailto target | Both links use the same label and mailto target |
| Generated sitemap | Yes | Yes |

Build times are local measurements and should be treated as directional. No Lighthouse run or network-throttled performance test was included.

## Screenshots

- [Vanilla, narrow](screenshots/vanilla-mobile.png)
- [Vanilla, wide](screenshots/vanilla-desktop.png)
- [AstroWind, narrow](screenshots/astrowind-mobile.png)
- [AstroWind, wide](screenshots/astrowind-desktop.png)

The integrated browser honored equivalent widths for both implementations, although its panel constrained the requested 390 px and 1440 px viewports to effective 300 px and 1140 px content widths.

## Implementation Notes

### Minimal Astro

- Added Tailwind CSS v4, static sitemap generation, canonical/robots/Open Graph/Twitter metadata, and local-image support through Astro and Sharp.
- Kept the implementation to one route, one shared layout, and one global design stylesheet.
- Uses no client-side JavaScript for the page experience.
- Compromise: metadata is direct and intentionally smaller than AstroWind's configurable SEO layer; analytics remains an integration point rather than an installed provider.

### AstroWind

- Reused the shared layout, metadata, favicon, font, sitemap, compression, image, and configuration foundations.
- Replaced the startup composition and visual tokens, disabled dark mode and demo runtime behavior, and removed all non-offer routes and blog content.
- Removed the empty content collection, blog-only utilities/components/types, and four demo images captured by AstroWind's image glob.
- Updated the TypeScript alias configuration for compatibility with the editor's TypeScript 6 diagnostics.
- Compromise: many generic AstroWind components and configuration abstractions remain even though this page does not use them; removing all of them would become a framework extraction exercise rather than a useful POC.

## Before Publishing

- Replace the portrait placeholder with an approved local portrait and verify its crop at both widths.
- Confirm the `$3,000` fixed price and remove the visible POC note.
- Replace the temporary `mailto:hello@danielward.dev` booking target with the real booking flow.
- Confirm the final production domain in canonical, sitemap, and robots configuration.
- Run Lighthouse and a focused accessibility audit against the deployed production build.
