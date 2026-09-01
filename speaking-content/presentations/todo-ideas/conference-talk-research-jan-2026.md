# Conference Talk Research — New Territory Ideas

**Research Date:** January 23, 2026

Based on hot topic research, Gartner trends, and conference landscape analysis, here are new talk ideas that explore territory beyond your existing portfolio.

---

## 🔥 Hot Topic Categories for 2026

### From Gartner Top 10 Strategic Technology Trends

1. **AI-Native Development Platforms** — Building software with AI from the ground up
2. **Multiagent Systems** — Modular AI agents collaborating on complex tasks
3. **Confidential Computing** — Protecting data while in use
4. **Digital Provenance** — Verifying origin/integrity of software, data, AI content
5. **Preemptive Cybersecurity** — Proactive AI-powered threat blocking
6. **AI Security Platforms** — Centralized visibility across AI applications
7. **Domain-Specific Language Models** — Industry-tailored LLMs
8. **Physical AI** — Robots, drones, smart equipment
9. **Geopatriation** — Moving workloads to sovereign/regional cloud providers
10. **AI Supercomputing Platforms** — Model training at scale

### From Developer Conference Trends

- **Platform Engineering** — Internal Developer Platforms, developer experience, "golden paths"
- **AI Agentic Workflows** — Production-ready, autonomous AI systems
- **Hyperautomation** — End-to-end automated workflows beyond RPA
- **Post-Quantum Cryptography** — Preparing for quantum computing threats
- **Observability & Telemetry** — OpenTelemetry, distributed tracing
- **FinOps & Cloud Cost Management** — Optimizing AI and cloud spend

---

## 💡 New Talk Ideas (Exploring New Territory)

### Category 1: AI Trust, Security & Governance

These topics are emerging hot areas with very few developer-focused talks.

#### 1. Digital Provenance for Developers: Trusting What You Build and Deploy

**Format:** 45-60 min | **Level:** Intermediate

**The Problem:** How do you verify the origin and integrity of your code, dependencies, AI models, and generated content? Deepfakes, supply chain attacks, and AI hallucinations make trust harder.

**The Talk:**
- What is digital provenance and why developers should care
- Software Bill of Materials (SBOM) and code signing in practice
- Content authenticity standards (C2PA) for AI-generated content
- Practical demo: Signing and verifying artifacts in a CI/CD pipeline

**Why It Works:**
- Gartner Top 10 trend for 2026
- Very few developer-focused talks exist on this topic
- Timely: Supply chain attacks + AI content concerns
- Practical, demo-able, language-agnostic

---

#### 2. Securing Your AI: What Developers Need to Know About AI Security Platforms

**Format:** 45-60 min | **Level:** Intermediate

**The Problem:** Organizations are deploying AI apps (both third-party and custom) without centralized security visibility. Who's watching the watchers?

**The Talk:**
- The new attack surface: prompt injection, data poisoning, model extraction
- How AI Security Platforms work (visibility, monitoring, guardrails)
- Practical security patterns for developers building AI features
- Demo: Adding guardrails to an LLM-powered app

**Why It Works:**
- Gartner Top 10 trend, but almost no developer-focused content
- Complements your AI/Agent Framework talks from a different angle
- High demand as enterprises roll out AI apps

---

#### 3. Preemptive Cybersecurity: From Reactive to Proactive Defense

**Format:** 45-60 min | **Level:** Intermediate to Advanced

**The Problem:** Traditional security is reactive — we detect and respond. Preemptive security uses AI to predict and block threats before they strike.

**The Talk:**
- The shift from "detect and respond" to "predict and prevent"
- How preemptive security tools work (behavioral analysis, threat intelligence)
- What developers can do: Secure coding practices that enable preemptive defense
- Demo: Integrating security scanning into development workflow

**Why It Works:**
- Gartner trend with clear enterprise interest
- Security is always a conference favorite
- Developer-practical angle differentiates from security-vendor talks

---

### Category 2: Platform Engineering & Developer Experience

Hot area with dedicated conferences (PlatformCon) but room for unique angles.

#### 4. Golden Paths: How Platform Engineering Reduces Cognitive Load

**Format:** 45-60 min | **Level:** Intermediate

**The Problem:** Developers waste time on infrastructure decisions, configuration, and tribal knowledge. Platform teams can create "golden paths" — opinionated, paved roads that make the right thing the easy thing.

**The Talk:**
- What is a golden path (and what it's not)
- Designing golden paths without becoming a bottleneck
- Case studies: What works and what fails
- Demo: Building a simple golden path with templates/scaffolding

**Why It Works:**
- Platform engineering is huge in 2026
- Developer experience angle is relatable to all developers
- Not about specific tools — transferable patterns

---

#### 5. The Metrics That Matter: Measuring Developer Experience Without Surveillance

**Format:** 45-60 min | **Level:** Intermediate

**The Problem:** Organizations want to improve developer productivity but often reach for invasive surveillance metrics. How do you measure developer experience respectfully and effectively?

**The Talk:**
- Why DORA metrics alone aren't enough
- The SPACE framework and DevEx research
- Qualitative + quantitative: Surveys, observability, self-reported data
- What NOT to measure (and why keystroke tracking backfires)
- Practical steps for teams to measure their own experience

**Why It Works:**
- Ties into your existing "Measure Developer Productivity" talk but different angle
- New territory: Developer experience, not just productivity
- Resonates with ICs and leaders alike

---

### Category 3: Multiagent Systems & Agentic AI

This is THE hot topic for AI in 2026 — moving beyond single LLM calls to orchestrated agents.

#### 6. Multiagent Systems 101: Orchestrating AI Agents That Actually Work Together

**Format:** 45-60 min | **Level:** Intermediate

**The Problem:** Single AI agents have limits. Multiagent systems allow specialized agents to collaborate on complex tasks — but how do you build, orchestrate, and debug them?

**The Talk:**
- What are multiagent systems and why they're different from single agents
- Patterns: Supervisor, swarm, hierarchical, and workflow-based
- Challenges: Communication, coordination, error handling
- Demo: Building a simple multiagent system (using AutoGen, CrewAI, or similar)

**Why It Works:**
- Gartner Top 10 trend
- Natural extension of your Agent Framework talk but goes deeper
- Hot topic with practical demo potential
- Few accessible talks exist — mostly academic or vendor-specific

---

#### 7. When AI Agents Go Wrong: Debugging, Observability, and Guardrails

**Format:** 45-60 min | **Level:** Intermediate to Advanced

**The Problem:** AI agents are autonomous, non-deterministic, and hard to debug. How do you trace what an agent did, why it failed, and prevent disasters?

**The Talk:**
- The observability challenge for AI agents
- Tracing agent execution: Tools and patterns
- Guardrails: Preventing agents from going off the rails
- Demo: Adding observability and guardrails to an agent

**Why It Works:**
- Unique angle — most talks are "how to build agents," not "how to debug them"
- Practical, relatable to anyone who's had an AI do something unexpected
- Bridges your testing expertise into the AI space

---

### Category 4: Emerging Infrastructure & Architecture

#### 8. Confidential Computing: Protecting Data While You're Using It

**Format:** 45-60 min | **Level:** Intermediate to Advanced

**The Problem:** We encrypt data at rest and in transit, but what about when it's being processed? Confidential computing creates secure enclaves where data stays encrypted even in use.

**The Talk:**
- The "data in use" gap and why it matters for AI/ML
- How confidential computing works (TEEs, secure enclaves)
- Cloud provider offerings (Azure Confidential Computing, AWS Nitro, etc.)
- When and why to use it — practical use cases
- Demo: Running a simple workload in a secure enclave

**Why It Works:**
- Gartner Top 10 trend, highly technical but accessible angle
- Growing importance with AI processing sensitive data
- Few developer-focused talks exist

---

#### 9. Geopatriation: Navigating Data Sovereignty in a Multi-Cloud World

**Format:** 45-60 min | **Level:** Intermediate

**The Problem:** Geopolitical shifts and regulations (GDPR, data localization laws) are forcing organizations to think about where their data and workloads live. "Geopatriation" is moving workloads to sovereign or regional cloud providers.

**The Talk:**
- What is geopatriation and why it's accelerating
- Regulatory landscape: GDPR, data residency, sovereignty
- Multi-cloud strategies for compliance
- Practical considerations for developers and architects

**Why It Works:**
- Gartner trend — rarely discussed at developer conferences
- Timely with ongoing geopolitical tensions
- Appeals to enterprise architects and senior developers

---

### Category 5: Cross-Cutting / Unique Angles

#### 10. The Hidden Cost of AI: FinOps for LLM-Powered Applications

**Format:** 45-60 min | **Level:** Intermediate

**The Problem:** AI tokens add up fast. Teams often don't realize the cost implications until they get the bill. How do you monitor, optimize, and budget for AI-powered features?

**The Talk:**
- The AI cost problem: Tokens, compute, and surprise bills
- FinOps principles applied to AI workloads
- Monitoring and alerting for LLM costs
- Optimization techniques: Caching, prompt efficiency, model selection
- Demo: Setting up cost tracking for an LLM app

**Why It Works:**
- Very practical, wallet-hitting concern for teams
- Unique angle — not many talks cover this
- Complements your existing AI content from a different perspective

---

#### 11. Post-Quantum Cryptography: Preparing Your Code for Q-Day

**Format:** 45-60 min or Lightning (20 min) | **Level:** Intermediate

**The Problem:** Quantum computers will eventually break current encryption. "Q-Day" is coming. How do you prepare your applications now?

**The Talk:**
- What is post-quantum cryptography (PQC) and why it matters
- NIST PQC standards (recently finalized)
- What developers need to change (and what they don't)
- Practical steps: Inventory, planning, migration paths
- Demo: Using PQC libraries in your code today

**Why It Works:**
- .NET 10 includes post-quantum cryptography support (topical!)
- Few accessible developer talks exist — mostly academic
- Enterprise security teams are starting to ask about this

---

#### 12. The Rise of AI-Native Development: What Changes When AI Writes Your Code?

**Format:** 45-60 min | **Level:** All Levels

**The Problem:** We've gone from AI autocomplete to AI agents writing entire features. What does "AI-native development" look like, and how does it change the developer's role?

**The Talk:**
- The spectrum: Autocomplete → Chat → Agents → AI-Native Platforms
- What AI-native development looks like in practice
- New skills for the AI-native developer (prompting, reviewing, orchestrating)
- The risks: Over-reliance, skill atrophy, security
- Practical advice for navigating the transition

**Why It Works:**
- Gartner Top 10 trend, highly relevant to all developers
- Thought-leadership angle rather than purely technical
- Complements your existing Copilot talks but goes bigger picture

---

## ⚡ Lightning Talk Ideas (15-20 min)

| Title | Hook |
|-------|------|
| **5 AI Agent Failures (And What I Learned)** | Entertaining failure stories with real lessons |
| **Why Your SBOM Matters More Than You Think** | Quick dive into software supply chain security |
| **The $10,000 Mistake: AI Cost Lessons Learned** | Cautionary tale about LLM billing surprises |
| **Post-Quantum Crypto in 5 Minutes** | Quick intro to preparing for quantum threats |
| **Golden Paths: How to Stop Answering the Same Question** | Platform engineering for the uninitiated |

---

## 📊 Priority Assessment

| Talk Idea | Novelty | Demand | Competition | Your Fit | Overall |
|-----------|---------|--------|-------------|----------|---------|
| **Digital Provenance** | 🔥 Very High | High | Very Low | Medium | ⭐⭐⭐⭐⭐ |
| **Multiagent Systems 101** | High | 🔥 Very High | Medium | High | ⭐⭐⭐⭐⭐ |
| **AI Agent Debugging & Guardrails** | 🔥 Very High | High | Very Low | High | ⭐⭐⭐⭐⭐ |
| **Hidden Cost of AI (FinOps)** | High | High | Low | Medium | ⭐⭐⭐⭐ |
| **Confidential Computing** | High | Medium | Low | Medium | ⭐⭐⭐⭐ |
| **Golden Paths / Platform Eng** | Medium | High | Medium | Medium | ⭐⭐⭐⭐ |
| **Post-Quantum Cryptography** | High | Medium | Low | Medium | ⭐⭐⭐⭐ |
| **AI Security Platforms** | High | High | Low | Medium | ⭐⭐⭐⭐ |
| **Preemptive Cybersecurity** | High | Medium | Medium | Low | ⭐⭐⭐ |
| **Geopatriation** | High | Low | Very Low | Low | ⭐⭐⭐ |
| **Measuring DevEx** | Medium | High | Medium | High | ⭐⭐⭐ |
| **AI-Native Development** | Medium | High | High | High | ⭐⭐⭐ |

---

## 🎯 Top Recommendations

Based on **novelty + demand + low competition + your expertise fit**:

### Tier 1: High-Priority New Territory

1. **Multiagent Systems 101** — Natural extension of your AI work, very hot topic, accessible angle
2. **AI Agent Debugging & Guardrails** — Unique testing/quality angle in AI space (your niche!)
3. **Digital Provenance for Developers** — Almost no talks exist, Gartner trend, practical demo potential

### Tier 2: Strong Contenders

4. **The Hidden Cost of AI (FinOps)** — Practical, unique, wallet-hitting topic
5. **Confidential Computing** — Technical deep-dive, growing importance for AI workloads
6. **Golden Paths / Platform Engineering** — Hot area, developer experience angle

### Tier 3: Worth Considering

7. **Post-Quantum Cryptography** — Great lightning talk, ties to .NET 10
8. **AI Security Platforms** — Important but may overlap with vendor-heavy content
9. **Measuring Developer Experience** — Good if you want to evolve your productivity talk

---

## Next Steps

1. **Pick 2-3 ideas** that resonate most
2. **Outline abstracts** for each (I can help with this using the presentation-abstracts skill)
3. **Identify target conferences** that match each topic
4. **Research specific conferences** to tailor abstracts (conference-research skill)

Would you like me to develop any of these ideas further?
