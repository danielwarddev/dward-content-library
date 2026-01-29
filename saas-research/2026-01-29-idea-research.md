# SaaS Idea Research - January 29, 2026

## Executive Summary

This research session focused on identifying SaaS opportunities in underserved markets by analyzing Reddit discussions, G2 software categories, and community pain points. The research revealed significant opportunities in enterprise document search (RAG), niche vertical industry software, and B2B operational tools.

**Key Finding**: Enterprise document search ("boring RAG") emerged as the highest-opportunity domain, with projects commanding $20-50K and companies paying $50K+/year for basic search across internal documents.

---

## Selected Domains

Based on research signals, I focused on these 6 domains:

| Domain                         | Signal Strength | Rationale                                                                          |
| ------------------------------ | --------------- | ---------------------------------------------------------------------------------- |
| **Enterprise Document Search** | 🔥 Very High    | Reddit post with 555 upvotes confirming $50K/year revenue from boring RAG projects |
| **Small Business Operations**  | High            | Active r/smallbusiness discussions about missing tools                             |
| **Vertical Industry Software** | High            | G2 shows many niche categories with opportunity                                    |
| **DevOps Tooling**             | Medium-High     | Founder expertise, ongoing automation gaps                                         |
| **Content/SEO Tools**          | Medium          | Complaints about existing tools being incomplete                                   |
| **Healthcare Tech (SMB)**      | Medium          | EHR tools for small practices are terrible                                         |

---

## Validated SaaS Ideas

### Idea 1: Document Findability Index (DFI)

**Problem**: Mid-size companies (100-500 employees) have 10+ years of documents scattered across SharePoint, network drives, and cloud storage. Their search doesn't work. They can't find what they need.

**Validation Evidence**:

> "The real money is in the most boring, obvious problem: companies can't find shit in their own documents... I built three RAG systems for mid-size companies (100-500 employees) in the past year, and all three were basically the same project. Each paid $50k+/year."
> — Reddit r/SaaS, 555 upvotes

**Target Industries**:

- Pharma (regulatory docs)
- Manufacturing (specs, manuals)
- Law firms (contracts, cases)
- Logistics (supplier docs)
- Energy (inspection reports)

**MVP Scope**:

- Connect to SharePoint/Google Drive/Dropbox
- AI-powered semantic search across documents
- "Find documents like this one" feature
- Simple relevance scoring dashboard

**Pricing Hypothesis**: $500-2,000/month based on document volume

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 5 | "Can't find shit" - critical business blocker |
| Market Size | 5 | Every mid-size company has this problem |
| Competition | 3 | Enterprise solutions exist (Glean, Coveo) but expensive |
| Solo-Buildable | 3 | RAG is well-documented, but enterprise integrations complex |
| Domain Fit | 3 | DevOps background helpful for integrations |
| Recurring Value | 5 | Documents grow forever, need grows |
| Willingness to Pay | 5 | Companies paying $50K/year already |
| Well vs Crater | 4 | Ongoing trend, not going away |
| **Total** | **33/40** | **Top Tier Opportunity** |

---

### Idea 2: SEO Content Workbench

**Problem**: SEO content tools like Surfer SEO have great analytics but terrible editing experiences - no tables, fonts, or images. Writers need full formatting but with live SEO scoring.

**Validation Evidence**:

> "I want a decent SEO content editing tool. I tried Surfer SEO recently. Awesome market-leading stats-auto-populator on the right-hand-side panel as you write on the left, but no tables, fonts, images options, making it a trash app"
> — Reddit r/smallbusiness

**MVP Scope**:

- Rich text editor with tables, images, formatting
- Real-time SEO scoring sidebar (word count, keyword density, readability)
- Export to WordPress/Medium/HTML
- Competitor content analysis

**Pricing Hypothesis**: $29-79/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 3 | Annoying but workarounds exist |
| Market Size | 4 | Large content marketing industry |
| Competition | 2 | Surfer, Clearscope, MarketMuse exist |
| Solo-Buildable | 4 | Rich text editors well-documented |
| Domain Fit | 2 | Not core expertise but learnable |
| Recurring Value | 4 | Content creation is ongoing |
| Willingness to Pay | 3 | Already paying for inferior tools |
| Well vs Crater | 3 | Stable market, AI changing landscape |
| **Total** | **25/40** | **Worth Exploring** |

---

### Idea 3: Employee Knowledge Handover

**Problem**: When employees leave, institutional knowledge walks out the door. Training replacements is expensive and time-consuming because knowledge is locked in chats, docs, and people's heads.

**Validation Evidence**:

> "tool that automates knowledge capture from departing employees, like turning chats/docs into searchable handovers to avoid reinventing the wheel. Cuts down on training time big-time."
> — Reddit r/smallbusiness

**MVP Scope**:

- Connect to Slack/Teams/Email
- AI summarization of key knowledge per employee
- Auto-generate handover documents
- Searchable knowledge base by role/function

**Pricing Hypothesis**: $99-299/month per team

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 4 | Real pain when key people leave |
| Market Size | 4 | Every company with turnover |
| Competition | 3 | Knowledge management tools exist but different angle |
| Solo-Buildable | 3 | Slack/Teams integrations + AI summarization |
| Domain Fit | 3 | DevOps experience with automation |
| Recurring Value | 4 | Turnover is constant |
| Willingness to Pay | 3 | Hard to quantify ROI upfront |
| Well vs Crater | 4 | AI makes this newly possible |
| **Total** | **28/40** | **Good Opportunity** |

---

### Idea 4: SMB Compliance Checklist Manager

**Problem**: Small businesses struggle to track compliance requirements across multiple regulations (HIPAA, SOC2, GDPR, industry-specific). Existing tools are enterprise-focused and expensive.

**Validation Evidence**:

- G2 shows "IT Compliance Software" and "Compliance Copilot for SMBs" as active categories
- Previous research noted compliance as ongoing pain for SMBs

**MVP Scope**:

- Pre-built compliance checklists by industry/regulation
- Task assignment and tracking
- Evidence collection and storage
- Audit-ready reports

**Pricing Hypothesis**: $99-299/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 4 | Compliance failures have real consequences |
| Market Size | 4 | Every regulated SMB |
| Competition | 3 | Drata, Vanta expensive; simpler tools needed |
| Solo-Buildable | 4 | Checklists + file storage |
| Domain Fit | 3 | Some finance/compliance overlap |
| Recurring Value | 5 | Compliance is forever |
| Willingness to Pay | 4 | Avoiding auditors worth paying |
| Well vs Crater | 4 | Regulations increasing |
| **Total** | **31/40** | **Strong Opportunity** |

---

### Idea 5: Equipment Maintenance Scheduler for Small Fleets

**Problem**: Small businesses with 5-50 vehicles or pieces of equipment (landscapers, contractors, plumbers) track maintenance in spreadsheets or not at all. Breakdowns are expensive.

**Validation Evidence**:

- G2 has "Fleet Management Software" and "Equipment Rental Software" categories
- Vertical industry software shows lower competition in niches
- Previous research identified agriculture equipment maintenance as gap

**MVP Scope**:

- Asset inventory with photos
- Maintenance schedule based on hours/miles/date
- Mobile-friendly for field workers
- Parts ordering integration

**Pricing Hypothesis**: $29-99/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 4 | Breakdowns cost real money |
| Market Size | 3 | Niche but many small fleets |
| Competition | 4 | Enterprise tools exist, SMB gap |
| Solo-Buildable | 5 | CRUD app with notifications |
| Domain Fit | 3 | Some agriculture knowledge |
| Recurring Value | 4 | Equipment always needs maintenance |
| Willingness to Pay | 3 | Price sensitive market |
| Well vs Crater | 4 | Stable, growing gig economy |
| **Total** | **30/40** | **Solid Opportunity** |

---

### Idea 6: Visitor Check-In for Professional Services

**Problem**: Small law firms, accounting practices, and consultancies need a professional visitor check-in system but don't want to pay $200+/month for enterprise solutions.

**Validation Evidence**:

- G2 shows "Visitor Management Software" category
- Most solutions target enterprise (Envoy, Proxyclick)

**MVP Scope**:

- iPad kiosk app for visitor sign-in
- Photo capture and badge printing
- Slack/email notifications to hosts
- Visitor log for compliance

**Pricing Hypothesis**: $49-99/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 2 | Nice-to-have for most |
| Market Size | 3 | Professional services firms |
| Competition | 3 | Gap in SMB market |
| Solo-Buildable | 5 | Simple iPad app + web dashboard |
| Domain Fit | 2 | Not core expertise |
| Recurring Value | 4 | Always have visitors |
| Willingness to Pay | 3 | Low priority expense |
| Well vs Crater | 3 | Stable, post-COVID relevant |
| **Total** | **25/40** | **Lower Priority** |

---

### Idea 7: Contractor License Tracker

**Problem**: Construction companies and contractors must track license expirations, insurance certificates, and certifications for themselves and subcontractors. Typically done in spreadsheets.

**Validation Evidence**:

- G2 shows "Construction Software" with many subcategories
- r/smallbusiness shows contractor-related pain points

**MVP Scope**:

- License/certification database
- Expiration alerts via email/SMS
- Document storage with OCR for dates
- Subcontractor portal for self-service updates

**Pricing Hypothesis**: $79-199/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 4 | Expired licenses = no work |
| Market Size | 3 | Construction industry specific |
| Competition | 3 | Some construction management tools have this |
| Solo-Buildable | 4 | Document storage + notifications |
| Domain Fit | 2 | Not core expertise |
| Recurring Value | 5 | Licenses always expire |
| Willingness to Pay | 4 | Compliance-driven |
| Well vs Crater | 4 | Regulations increasing |
| **Total** | **29/40** | **Good Niche** |

---

### Idea 8: Quote Request Aggregator for Small Manufacturers

**Problem**: Small manufacturers receive quote requests via email, phone, and web forms. They're scattered and easy to lose. No simple way to track win/loss rates.

**Validation Evidence**:

- G2 shows "Quote Management Software" category
- Manufacturing mentioned as document search pain point

**MVP Scope**:

- Email forwarding to capture quote requests
- Kanban board for quote status
- Win/loss tracking with reasons
- Simple analytics dashboard

**Pricing Hypothesis**: $99-199/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 4 | Lost quotes = lost revenue |
| Market Size | 3 | Small/medium manufacturers |
| Competition | 3 | CRM tools don't fit manufacturing well |
| Solo-Buildable | 4 | Email parsing + kanban |
| Domain Fit | 2 | Not core expertise |
| Recurring Value | 4 | Always getting quotes |
| Willingness to Pay | 4 | Direct revenue impact |
| Well vs Crater | 4 | Manufacturing steady |
| **Total** | **28/40** | **Good Opportunity** |

---

### Idea 9: Pet Services Booking Platform

**Problem**: Pet groomers, dog walkers, and pet sitters use generic scheduling tools or paper. Need pet-specific features like pet profiles, vaccination tracking, and grooming history.

**Validation Evidence**:

- G2 shows "Pet Care Software" category
- Vertical industry with specific needs

**MVP Scope**:

- Pet profiles with photos, breeds, special needs
- Vaccination/medical record tracking
- Online booking with breed-specific time slots
- Client communication (reminders, photos)

**Pricing Hypothesis**: $49-149/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 3 | Workable with generic tools |
| Market Size | 3 | Growing pet industry |
| Competition | 3 | Gingr, Time To Pet exist |
| Solo-Buildable | 4 | Booking + profiles |
| Domain Fit | 1 | No pet industry experience |
| Recurring Value | 4 | Ongoing bookings |
| Willingness to Pay | 3 | Small businesses price sensitive |
| Well vs Crater | 4 | Pet spending growing |
| **Total** | **25/40** | **Lower Priority** |

---

### Idea 10: Terraform Module Registry (Private)

**Problem**: Companies building IaC with Terraform need a private registry for their internal modules. HashiCorp's solution is enterprise-only.

**Validation Evidence**:

- Previous research identified DevOps gaps
- Personal experience with Terraform

**MVP Scope**:

- Private Terraform module registry
- GitHub/GitLab integration
- Version management
- Usage analytics

**Pricing Hypothesis**: $99-299/month per team

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 3 | Workarounds exist (S3, Git) |
| Market Size | 3 | DevOps teams using Terraform |
| Competition | 3 | Terraform Cloud, Spacelift |
| Solo-Buildable | 4 | API + storage |
| Domain Fit | 5 | Core DevOps expertise |
| Recurring Value | 4 | Infrastructure is ongoing |
| Willingness to Pay | 3 | DevOps teams have budget |
| Well vs Crater | 3 | HashiCorp could crush this |
| **Total** | **28/40** | **Good but Risky** |

---

### Idea 11: Client Portal for Accountants

**Problem**: Small accounting firms need a secure way to exchange documents with clients. Generic file sharing doesn't have accounting-specific workflows (tax organizers, signature requests).

**Validation Evidence**:

- G2 shows "Accounting Software" with client communication gaps
- Tax season creates annual surge in document exchange

**MVP Scope**:

- Branded client portal
- Secure document upload/download
- Tax organizer templates
- E-signature integration

**Pricing Hypothesis**: $79-199/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 4 | Tax season chaos is real |
| Market Size | 4 | Many small accounting firms |
| Competition | 3 | Liscio, Karbon exist |
| Solo-Buildable | 4 | File sharing + templates |
| Domain Fit | 3 | Some finance background |
| Recurring Value | 5 | Tax season every year |
| Willingness to Pay | 4 | Firms have budget, hate chaos |
| Well vs Crater | 4 | Stable market |
| **Total** | **31/40** | **Strong Opportunity** |

---

### Idea 12: Proposal Templates for Freelancers

**Problem**: Freelancers spend hours writing proposals. They need templates that are proven to win work, not generic documents.

**Validation Evidence**:

- r/smallbusiness discussions about client acquisition
- Freelancer market is large and growing

**MVP Scope**:

- Winning proposal templates by industry
- Customizable sections
- Send and track opens
- Win/loss tracking

**Pricing Hypothesis**: $19-49/month

**Scoring**:
| Dimension | Score | Notes |
|-----------|-------|-------|
| Pain Severity | 3 | Time suck but manageable |
| Market Size | 4 | Large freelancer market |
| Competition | 4 | Proposify, Better Proposals, PandaDoc |
| Solo-Buildable | 5 | Templates + basic tracking |
| Domain Fit | 2 | Not core expertise |
| Recurring Value | 4 | Always sending proposals |
| Willingness to Pay | 2 | Freelancers price sensitive |
| Well vs Crater | 3 | Stable market |
| **Total** | **27/40** | **Moderate Opportunity** |

---

## Summary Rankings

| Rank | Idea                                       | Score | Domain Fit | Quick Win? |
| ---- | ------------------------------------------ | ----- | ---------- | ---------- |
| 1    | Document Findability Index                 | 33/40 | ⭐⭐⭐     | No         |
| 2    | SMB Compliance Checklist Manager           | 31/40 | ⭐⭐⭐     | Yes        |
| 3    | Client Portal for Accountants              | 31/40 | ⭐⭐⭐     | Yes        |
| 4    | Equipment Maintenance Scheduler            | 30/40 | ⭐⭐⭐     | Yes        |
| 5    | Contractor License Tracker                 | 29/40 | ⭐⭐       | Yes        |
| 6    | Employee Knowledge Handover                | 28/40 | ⭐⭐⭐     | No         |
| 7    | Quote Request Aggregator                   | 28/40 | ⭐⭐       | Yes        |
| 8    | Terraform Module Registry                  | 28/40 | ⭐⭐⭐⭐⭐ | Yes        |
| 9    | Proposal Templates for Freelancers         | 27/40 | ⭐⭐       | Yes        |
| 10   | SEO Content Workbench                      | 25/40 | ⭐⭐       | Yes        |
| 11   | Visitor Check-In for Professional Services | 25/40 | ⭐⭐       | Yes        |
| 12   | Pet Services Booking Platform              | 25/40 | ⭐         | Yes        |

---

## Top 3 Recommendations

### 1. 🥇 Document Findability Index (DFI)

**Why**: Highest-validated opportunity with clear willingness to pay ($50K/year documented). Solves a universal enterprise pain point. AI/RAG technology is mature enough to build.

**Risk**: Enterprise sales cycle is long. Competition from Glean, Coveo could crush. Need to find SMB angle.

**Next Step**: Interview 3-5 mid-size company knowledge workers about document search pain.

---

### 2. 🥈 SMB Compliance Checklist Manager

**Why**: Compliance is non-negotiable spending. Existing tools are enterprise-focused and expensive. Simple MVP could work.

**Risk**: Regulations vary by industry, building templates is research-heavy.

**Next Step**: Pick one vertical (HIPAA for healthcare or SOC2 for tech) and validate with 5 prospects.

---

### 3. 🥉 Client Portal for Accountants

**Why**: Seasonal pain point (tax season) creates urgency. Clear vertical with identifiable buyers. Competition exists but differentiation possible.

**Risk**: Seasonal revenue spikes. Accountants are conservative buyers.

**Next Step**: Partner with one small accounting firm to build and validate before tax season 2027.

---

## Next Steps

1. **Validation Calls**: Schedule 5 discovery calls for top idea (Document Findability)
2. **Competitive Analysis**: Deep dive into Glean, Coveo pricing and positioning
3. **Landing Page Test**: Create landing page for SMB Compliance to test interest
4. **Update Previous Research**: Add these 12 ideas to previous-research.md

---

## Research Sources

- Reddit r/SaaS - "Boring RAG" thread (555 upvotes)
- Reddit r/smallbusiness - Software wish list discussions
- G2.com - Software category analysis
- Previous research sessions (2026-01-27, 2026-01-28)
