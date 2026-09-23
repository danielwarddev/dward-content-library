# Moving DanInACan.com from WordPress to a Cloudflare Static Site

**Generated:** September 22, 2026
**Context:** Assess whether moving the existing WordPress blog from Cloudways to a Markdown-based static site on Cloudflare will preserve Google Analytics data and SEO, and identify migration risks.

---

## Recommendation

The move is practical and should reduce hosting cost and maintenance. Use Cloudflare Pages (or Cloudflare Workers with static assets), keep `https://daninacan.com` as the canonical origin, reproduce every existing public URL exactly where possible, and continue using the existing GA4 web data stream.

The hosting change itself should not cause lasting SEO harm. The main risk is accidentally changing URLs, metadata, crawlability, structured data, or HTTP behavior while replacing WordPress.

## What Happens to the Cloudways Cloudflare Enterprise Add-on?

The exact $5-per-month Cloudflare Enterprise package is not portable. It is a reseller arrangement managed through Cloudways and depends on keeping the site in the Cloudways platform. Buying Cloudflare Enterprise directly is a custom-priced business contract rather than a comparable $5 add-on.

For this static migration, that is unlikely to be a practical loss. Cloudflare Pages serves static assets from Cloudflare's edge, and its documentation states that static asset requests are free and unlimited. A free Cloudflare deployment also provides the core CDN, managed TLS, caching, and DDoS-protection benefits that matter to a public static blog.

Several features in the Cloudways bundle solve problems created by having a dynamic origin:

- Edge page caching and Argo Tiered Cache reduce requests back to the WordPress server. A fully static Cloudflare site already serves deployable assets at the edge.
- Enterprise WAF and exposed-credential protections help protect WordPress, PHP, plugins, and login endpoints. Those attack surfaces disappear from a static site.
- Polish and Mirage optimize origin images dynamically. A static build can resize, compress, and generate modern image formats before deployment instead.

Features that would not carry over on the Free plan include Enterprise network prioritization, reserved IPs, advanced bot and WAF controls, expanded security analytics retention, enterprise support/SLA, and bundled image optimization. Argo Smart Routing and Cloudflare Images are available separately as usage-based products if measurements later justify them.

The recommended starting point is therefore Cloudflare's Free plan, plus build-time image optimization and Turnstile on any public form. Measure real-user performance and abuse after launch, then pay only for a demonstrated gap. For a read-heavy static technical blog, upgrading solely to recreate the Enterprise badge would usually add little value.

## Is Cloudflare Pages Really Free?

Yes, for a genuinely static site within the platform limits. Cloudflare documents requests to Pages static assets as free and unlimited, with bandwidth included at no charge. A site consisting of generated HTML, CSS, JavaScript, images, and downloads can therefore have a $0 Cloudflare hosting bill even when it uses a custom domain.

The important Free-plan limits are:

- 500 builds per month, one build at a time, with a 20-minute build timeout
- 20,000 files per site
- 25 MiB maximum size for each static asset
- 100 custom domains per Pages project

These are generous for this blog. Even publishing several times per day would remain well below 500 builds, although automated dependency updates and preview deployments also count toward build usage.

Costs can appear when the site stops being purely static or opts into separate products:

- Pages Functions are billed under Workers. The Workers Free plan currently shares a 100,000-request daily allowance across Workers and Pages Functions; choosing Workers Paid starts at $5 per month and then has usage-based charges.
- Files larger than 25 MiB may need R2, which has separate storage and operation pricing after its free allowance.
- Cloudflare Images, image transformations, Argo Smart Routing, Cache Reserve, Stream, and some advanced security products have separate pricing.
- The domain registration still costs money, even though connecting the domain and serving the site do not.
- A hosted form, email, comments, search, or newsletter provider may charge independently.

For predictable $0 hosting, keep all public content as build-generated static files, optimize images during the build, use third-party embeds carefully, and avoid attaching a Function to every route. Cloudflare does not automatically turn the Free Workers plan into Workers Paid; paid usage requires choosing the paid plan.

## Direct Answers

### Can Google Analytics still be used?

Yes. A static page can load the same Google tag as WordPress. Add the existing `G-...` GA4 measurement ID to the shared site layout so it appears on every rendered page.

After deployment, verify collection with GA4 Realtime and DebugView. Also test consent behavior and any custom events currently supplied by a WordPress plugin or Google Tag Manager; copying the base measurement ID preserves ordinary page-view collection, but plugin-specific events do not migrate automatically.

Cloudflare Web Analytics is an optional privacy-oriented second source of traffic data. It is not a replacement for historical GA4 reports or GA4's acquisition and event features.

### Will the move affect SEO?

Some short-term fluctuation is possible whenever a site is redeployed, but changing hosts without changing public URLs is Google's lower-risk migration case. Rankings should generally carry over if the new pages preserve:

- The same `https://daninacan.com/.../` URLs, including trailing-slash behavior
- Page titles, meta descriptions, headings, and visible content
- Self-referencing canonical URLs
- Publication and modified dates where appropriate
- Existing internal links
- Image URLs and meaningful alt text
- Article, person, organization, breadcrumb, and other structured data currently emitted by WordPress or its SEO plugin
- A working XML sitemap and `robots.txt`
- Correct HTTP status codes, including real `404` responses for missing pages

The current sitemap uses clean root-level paths, for example `/how-to-mock-httpclient-in-c-using-moq/`. Configure the static generator to emit those exact paths rather than dated paths, `.html` URLs, or a new `/blog/` prefix.

For every URL that must change, add a direct permanent redirect from the old URL to its closest equivalent. Avoid redirecting unrelated missing pages to the home page, and avoid redirect chains. Google recommends keeping migration redirects for at least one year; leaving them indefinitely is better for old links and bookmarks.

### Will the existing analytics data remain?

Yes, provided the site continues sending data to the same GA4 property and web data stream. Historical data belongs to that Analytics property, not to WordPress or Cloudways. Do not create a new GA4 property merely because the hosting changed.

Use the same measurement ID and keep the stream URL set to `https://daninacan.com`. There may be a short reporting gap during cutover if the tag is omitted or blocked, so validate it on the preview and immediately after DNS changes.

This does not restore old Universal Analytics data; Google deleted standard Universal Analytics property data after its shutdown. Existing GA4 history remains subject to the property's configured retention and reporting rules.

## Important Transfer Considerations

### Export content instead of copying posts by hand

WordPress stores the post data in MySQL or MariaDB, but it does not store uploaded image and document binaries in the database. The important sources are:

| Source | What it contains |
| --- | --- |
| `wp_posts` | Posts, pages, attachments, titles, slugs, publish/modified dates, HTML content, excerpts, and statuses |
| `wp_postmeta` | Featured-image IDs, attachment metadata, alt text, theme settings, and plugin-managed SEO fields |
| `wp_terms`, `wp_term_taxonomy`, `wp_term_relationships` | Categories and tags |
| `wp_comments` and `wp_commentmeta` | Comments, if they need to be preserved |
| `wp_options` | Site-wide plugin and theme settings, which may include SEO defaults |
| `wp-content/uploads` | The actual images, PDFs, and other uploaded files |

The table prefix may not be `wp_` on this installation.

Start by taking two complete backups while Cloudways is still available:

```bash
wp db export wordpress-before-static-migration.sql
wp export --dir=wordpress-wxr-export
```

Also download or archive the complete `wp-content/uploads` directory. The database dump is the authoritative safety copy. The WordPress WXR export is easier to parse and includes posts, pages, comments, custom fields, categories, tags, taxonomies, and attachment records, but it does not replace preserving the upload binaries themselves.

Keep the SQL dump outside this Git repository. It can contain user accounts, password hashes, email addresses, comments, API/plugin settings, and other private data.

For generating the static content, the public WordPress REST API is the easiest starting point. The site's API is currently enabled at `https://daninacan.com/wp-json/wp/v2/`. Its post responses expose the slug, published and modified dates, rendered title, rendered HTML content, excerpt, categories, tags, and featured-media ID. The media endpoint exposes source URLs, dimensions, generated sizes, captions, and alt text.

Fetch all result pages rather than relying on the default page size. Useful endpoints include:

```text
https://daninacan.com/wp-json/wp/v2/posts?per_page=100&page=1&_embed=1
https://daninacan.com/wp-json/wp/v2/pages?per_page=100&page=1&_embed=1
https://daninacan.com/wp-json/wp/v2/media?per_page=100&page=1
https://daninacan.com/wp-json/wp/v2/categories?per_page=100&page=1
https://daninacan.com/wp-json/wp/v2/tags?per_page=100&page=1
```

The public API returns rendered HTML, which already matches the raw HTML-body format currently used under `blog-migration/content`. Access to draft posts and raw editor content requires authenticated REST requests or a database/WXR export.

Do not rely on the public REST response alone for SEO descriptions. WordPress custom fields are exposed through REST only when their registration enables `show_in_rest`, and the live sample response exposes Astra metadata but not an obvious The SEO Framework description field. Preserve SEO using both of these sources:

1. Keep the full `wp_postmeta` export so no plugin data is lost.
2. Crawl each current public URL and capture the final rendered `<title>`, meta description, canonical link, Open Graph/Twitter tags, and JSON-LD. These rendered values are the authoritative output search engines currently see and avoid coupling the importer to version-specific plugin field names.

A live audit of all 79 published posts and pages found that every URL currently returns a title, meta description, canonical URL, robots directive, Open Graph metadata, Twitter Card metadata, and JSON-LD. The rendered metadata also exposes useful migration inputs such as language, publication and modified dates, author, breadcrumbs, site/organization identity, social-image URLs and dimensions, locale, and Twitter account. Capture the exact values with a throttled crawler before changing DNS; the server began returning `429` responses during an immediate repeat crawl.

An importer can then create one content file per post with front matter such as title, slug, canonical URL, publish date, modified date, description, categories, tags, featured image, and draft status, followed by the REST API's rendered HTML body. Copy uploads to the same `/wp-content/uploads/YYYY/MM/...` paths to avoid changing image and document URLs.

Before bulk conversion, run one representative post through the importer and compare it with the live page. The check should compare the URL, title, description, canonical, dates, headings, image URLs and alt text, code blocks, links, and structured data. That sample will quickly reveal whether REST data is sufficient or a field must be recovered from the database or rendered page.

#### Audit of the September 22, 2026 WXR export

The supplied `daninacan.WordPress.2026-09-22.xml` parses successfully and contains:

- 75 published posts and 38 draft posts
- 4 published pages and 1 draft page
- 125 attachment records
- 23 comments
- Categories, post relationships, publish/modified dates, slugs, and complete content bodies for all 79 published posts and pages
- 3 old-slug records that should become permanent redirects

It is sufficient to automate the core post and page files, but it is not the entire migration package:

- The 125 attachment URLs and metadata records are present, but the image and PDF binaries are not. The `wp-content/uploads` directory must still be downloaded or the importer must download each attachment URL before Cloudways is retired.
- Only 5 explicit `_genesis_description` values are stored. Most final meta descriptions are generated by The SEO Framework and should be captured from each rendered live page.
- Only 3 attachment-level alt-text records are stored. Preserve any `alt` attributes already embedded in post HTML and review missing alt text separately.
- No `_thumbnail_id` records are present, and the live REST audit reports `featured_media: 0` for all 79 published posts and pages, so the site does not currently use standard WordPress featured images. This is separate from generated attachment thumbnail sizes, which are recorded in attachment metadata.
- The WXR is not a database backup and does not include all `wp_options` data or complete plugin configuration.

The WXR includes author and commenter email addresses and commenter IP addresses. It is intentionally ignored by Git and should remain a local migration input rather than repository content.

#### Downloaded media audit

The `download-wordpress-media.ps1` script uses URLs embedded in each post or page as the primary ownership signal, then uses attachment parent IDs as a fallback. This is more reliable than attachment parents alone because WordPress attachments may be unattached or reused. Files are stored under `media/by-post/<status>/<slug>/`, while site-level and unattached files are stored separately.

The September 22, 2026 download produced 578 non-empty files with no failed URLs: 150 originals or files referenced by content, plus 428 generated image sizes recovered from attachment metadata. The generated `media/manifest.csv` preserves each source URL and its local destination.

One file cannot be deployed directly to Cloudflare Pages because it exceeds the 25 MiB per-file limit:

- `Hearing-and-Being-Heard-St-Marys.pptx` is 53.3 MiB, belongs to the St Mary's Business Week Experience 2025 post, and should be hosted in R2 or another download service.

### Preserve a complete URL inventory

Export URLs from the WordPress sitemap, Google Search Console, GA4 landing-page reports, and a crawler. Search Console and GA4 may reveal valuable URLs that are no longer in the current sitemap. Include pages, posts, category/tag archives that receive traffic, author archives, feed URLs, downloadable files, and image/media URLs.

Create a mapping with one outcome per old URL:

| Old URL outcome | Required behavior |
| --- | --- |
| Same content and URL | Return `200` at the identical path |
| Moved content | Return a direct `301` or `308` to the new URL |
| Intentionally removed with no replacement | Return `404` or `410` |

Cloudflare Pages supports redirects through a `_redirects` file. Generate this file from the migration map rather than maintaining a large list by hand.

There are no manually maintained redirect rules to export. The generated `_redirects` file should still include the 3 historical slugs found in the WXR and any URL changes discovered during the crawl.

### Preserve WordPress media paths

Existing posts and external sites may link directly to `/wp-content/uploads/...`. The safest option is to copy those files into the static output at the same paths. If image processing changes filenames or folders, redirect every indexed old media URL and update internal references.

Check Cloudflare's per-file size and total-file limits before moving presentation downloads, videos, or unusually large images. Cloudflare's documentation currently lists a 25 MiB maximum per Pages asset and 20,000 files per site on the Free plan. Larger downloads can live in R2 behind a custom domain.

### Replace dynamic WordPress features deliberately

Static hosting removes PHP, the WordPress database, and plugin behavior. Inventory and replace anything that matters:

- Contact forms: use a Pages Function, Worker, or hosted form service, with spam protection
- Site search: use a generated client-side index such as Pagefind or an external search provider
- Comments: preserve old comments in rendered HTML and choose a static-compatible service if new comments are needed
- RSS/Atom: generate the existing feed path and redirect old WordPress feed variants if necessary
- Redirects: export rules from WordPress, Cloudways, and SEO/redirect plugins
- Scheduled publishing: use repository automation or the static host's build pipeline
- Related posts, syntax highlighting, social cards, and table of contents: reproduce build-time behavior

#### Current plugin replacements

The WordPress plugins do not move to a static site, but their user-visible output can be reproduced:

| WordPress plugin | Migration approach |
| --- | --- |
| The SEO Framework | Generate equivalent tags in every statically rendered page: title, description, canonical, robots, Open Graph, Twitter Card, and JSON-LD. Do this at build time or through server rendering, not client-only React. Preserve the live rendered output as the authority because TSF generates most values and the WXR contains only a small number of explicit overrides. |
| Shortcodes Ultimate | Convert the 10 `[su_box]` instances found across 6 content items into a semantic callout component with note and warning variants. The importer must fail or report if any unconverted `[su_*]` shortcode remains. |
| Prismatic | Preserve the existing `<pre><code class="language-*">` and inline `<code>` markup, then use a static highlighter such as Shiki or Prism during the build. Preserve line-number classes where present and compare representative code-heavy posts visually. |
| Ko-fi Button | Add the Ko-fi overlay once in the shared site layout using account `danielwarddev` and the current floating Donate button colors, or replace it with an ordinary link/button. Per-post WXR metadata contains no meaningful custom value to migrate. |
| Akismet Anti-spam | Akismet can still be called through its API, but a static site needs a server-side comment endpoint, storage, moderation UI, and notifications. Do not expose the Akismet API key in browser code. |

The WXR contains 23 approved comments. Render those as historical comments even if a different service handles new comments. It contains no pending or spam comments, so a database backup is the only reliable way to retain anything WordPress omitted from the export.

For new comments, the closest managed replacement for the current WordPress workflow is Hyvor Talk. It supports static sites and React, moderation, data export, and spam detection through Akismet or its FortGuard system; its Personal plan is currently EUR 5 per month when billed annually. Giscus is a free alternative backed by GitHub Discussions, but readers need GitHub authentication and the existing WordPress comments would need a custom import or remain read-only historical content. A fully custom option is Pages Functions plus Turnstile, D1 storage, and the Akismet API, but that also means building and maintaining moderation, notification, abuse, and privacy workflows.

#### Analytics and search data

The live site currently loads Google tag `GT-PJWKQLD`. Reusing the same Google Analytics property and tag on the new site preserves the existing analytics history; changing hosts does not reset it. A GA4 landing-page report is useful for prioritizing URL validation, but it is not required to retain the history.

Google Search Console is separate from Google Analytics. Analytics reports what visitors do on the site, while Search Console reports Google Search queries, impressions, clicks, indexed URLs, crawl problems, structured-data problems, and external links. Before migration, export these Search Console reports if available:

- Performance by page and query for the longest available period
- Page indexing results
- Core Web Vitals
- Links, especially top externally linked pages
- Submitted sitemap details and any manual actions or security issues

Keep the existing Search Console domain property and submit the new sitemap after cutover. DNS-based verification should survive when its TXT record is copied to Cloudflare; other verification methods must be reproduced.

#### Database backup

A database backup is strongly recommended before Cloudways is cancelled, even though it is not required to begin building the static site. The WXR is sufficient for the main post/page conversion, but a SQL backup is the fallback for complete plugin settings, generated SEO fields, comment moderation state, users, and data omitted by WXR. Store it privately and do not commit it because it contains personal data and credentials or credential-derived values.

### Preserve DNS records, not only the website records

Moving the apex domain to Cloudflare may involve changing nameservers. Copy and verify all existing DNS records first, especially email-related `MX`, SPF, DKIM, and DMARC records, plus domain-verification records. A website migration should not accidentally interrupt email.

Lower the relevant DNS TTL before cutover, keep Cloudways running during propagation, and retain a rollback path until the new site has served reliably for several days.

### Maintain security, privacy, and ownership details

- Configure TLS and force one canonical host, either apex or `www`, with a permanent redirect from the other
- Keep the Google Analytics consent mechanism required for the site's visitors and privacy policy
- Add appropriate security headers without blocking analytics, images, fonts, or embedded content
- Exclude preview deployments from indexing and preferably protect them with Cloudflare Access
- Back up the WordPress database, media library, redirects, plugin settings, and a static crawl before cancellation
- Retain the WordPress backup after migration because Markdown exports may omit comments, attachment metadata, redirects, and plugin-managed SEO fields

## Low-Risk Migration Sequence

1. Export WordPress posts, pages, media, redirects, SEO fields, and database backups.
2. Build the static site with production-equivalent URLs, metadata, structured data, sitemap, feed, and `robots.txt`.
3. Add the existing GA4 measurement ID and consent behavior.
4. Crawl both sites and compare every important URL's status, canonical, title, description, headings, structured data, images, and internal links.
5. Test the Cloudflare preview without allowing it to be indexed.
6. Lower DNS TTL, attach the custom domain, and switch DNS while Cloudways remains available.
7. Verify the canonical host, redirects, TLS, GA4 Realtime, forms, feeds, downloads, and representative posts.
8. Submit the new sitemap in the existing Search Console domain property and monitor indexing, crawl errors, Core Web Vitals, rankings, and GA4 traffic.
9. Keep the old host and rollback option briefly, then cancel Cloudways only after DNS traffic and critical checks are clean.
10. Retain redirects for at least one year and keep migration backups indefinitely.

## Go-Live Acceptance Checks

- A sample of high-traffic URLs returns `200` at the exact old paths
- Every changed URL returns one direct permanent redirect
- No production page contains `noindex`, preview canonicals, or blocked assets
- `robots.txt`, sitemap, RSS, images, downloads, and the custom `404` behave correctly
- GA4 Realtime records page views under the existing property
- Search Console can inspect and fetch representative URLs
- Social previews and structured-data validation match or improve on the WordPress versions
- Mobile rendering, Core Web Vitals, forms, and email delivery work
- Both `www` and apex requests resolve to one canonical HTTPS host

## Sources

- [Cloudflare Pages documentation](https://developers.cloudflare.com/pages/)
- [Cloudflare Pages limits](https://developers.cloudflare.com/pages/platform/limits/)
- [Cloudflare Pages redirects](https://developers.cloudflare.com/pages/configuration/redirects/)
- [Google: Site moves with no URL changes](https://developers.google.com/search/docs/crawling-indexing/site-move-no-url-changes)
- [Google: Site moves with URL changes](https://developers.google.com/search/docs/crawling-indexing/site-move-with-url-changes)
- [Google: Redirects and Google Search](https://developers.google.com/search/docs/crawling-indexing/301-redirects)
- [Google: Canonical URLs](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls)
- [Google Analytics: GA4 measurement IDs](https://support.google.com/analytics/answer/12270356)
- [DanInACan.com sitemap](https://daninacan.com/sitemap_index.xml)

---

## Notes

The framework choice is secondary to URL fidelity. Astro, Eleventy, Hugo, and similar generators can all work; select one that can reproduce the current permalink format and generate the metadata and feeds above without manual per-post maintenance.