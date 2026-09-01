# Running LLMs on Azure: Service Options & Use Case Mapping

**Generated:** 2026-03-20
**Context:** Evaluating Azure services for running open-source LLMs (e.g., from Hugging Face) for two use cases: (1) AI coding assistant in VS Code on a personal machine with no GPU, and (2) running OpenClaw on Azure using Visual Studio Enterprise credits ($150/mo).

---

## TL;DR

| Approach | Best For | Monthly Cost Estimate | Complexity |
|---|---|---|---|
| Azure OpenAI Service | Coding assistant + OpenClaw LLM backend | Pay-per-token (~$5-50/mo for personal use) | Low |
| Azure AI Foundry (Serverless) | Experimenting with open-source models | Pay-per-token (varies by model) | Low |
| Azure AI Foundry (Managed Compute) | Dedicated open-source model hosting | $300-800/mo (GPU VM) | Medium |
| Azure GPU VM + Ollama/vLLM | Full control, Hugging Face models | $127-380/mo (depending on uptime) | High |
| Azure VM (no GPU) for OpenClaw itself | Running OpenClaw agent 24/7 | ~$15-40/mo | Low-Medium |

---

## Understanding Your Two Use Cases

### Use Case 1: AI Coding Assistant in VS Code

Since your personal machine has **no dedicated GPU**, running large models locally will be extremely slow. The practical approach is:

1. **Host the LLM on Azure** (via any service below)
2. **Connect VS Code to it** using the [Continue](https://continue.dev/) extension, which supports OpenAI-compatible APIs and gives you a Copilot-like experience (tab-completion, inline chat, etc.)

Continue can point to Azure OpenAI, a self-hosted Ollama instance, or any OpenAI-compatible API endpoint.

### Use Case 2: OpenClaw on Azure

OpenClaw is an **open-source personal AI assistant** (by Peter Steinberger) that runs as a Node.js app on a dedicated machine. It connects to chat apps (Telegram, Discord, WhatsApp, etc.) and can browse the web, run shell commands, manage files, and more.

**Key insight:** OpenClaw itself does NOT need a GPU. It just needs Node.js and an API key for a model provider (Anthropic, OpenAI, Google, Azure OpenAI, or a local model endpoint). So you'd need:

- **A regular Azure VM** to run OpenClaw (~$15-40/mo)
- **An LLM provider** — either a cloud API (cheapest, simplest) OR a self-hosted model on a separate GPU VM

---

## Azure Services for Running LLMs

### 1. Azure OpenAI Service

**What it is:** Managed API access to OpenAI models (GPT-4o, GPT-4.1, o3-mini, etc.) hosted by Microsoft.

| Pros | Cons |
|---|---|
| Zero infrastructure management | Only OpenAI models (no Hugging Face/open-source) |
| Pay-per-token, scales to zero | Requires Azure OpenAI access approval |
| OpenAI-compatible API (works with Continue, OpenClaw) | Not "self-hosted" in the traditional sense |
| Enterprise-grade SLA and compliance | Token costs can add up with heavy use |

**Cost:** ~$0.15-$5 per 1M input tokens depending on model. Personal coding use would likely be $5-50/mo.

**Best for:** Quickest path to a working coding assistant + OpenClaw backend. Not what you'd use if you specifically want to run Hugging Face models.

### 2. Azure AI Foundry — Model Catalog (Serverless API)

**What it is:** Azure's model marketplace (formerly Azure Machine Learning) that lets you deploy models from a catalog with a serverless, pay-per-token API. Includes models from Meta (Llama 3.x), Mistral, Cohere, Microsoft (Phi), and some Hugging Face models.

| Pros | Cons |
|---|---|
| No GPU management, pay-per-token | Not all Hugging Face models available |
| Access to open-source models (Llama, Mistral, Phi) | Some models have minimum throughput charges |
| OpenAI-compatible API format | Model selection more limited than self-hosting |
| Can experiment with multiple models cheaply | |

**Cost:** Varies by model. Phi-4 and smaller models are very cheap. Llama 3.3 70B is mid-range. Good for experimentation within $150/mo.

**Best for:** Experimenting with open-source models without managing infrastructure. Good middle ground between Azure OpenAI and full self-hosting.

### 3. Azure AI Foundry — Managed Compute Endpoints

**What it is:** Deploy any model from the catalog (or your own Hugging Face model) to a dedicated GPU-backed managed endpoint.

| Pros | Cons |
|---|---|
| Can deploy any Hugging Face model | Expensive — dedicated GPU VM running 24/7 |
| Managed scaling, health checks, logging | Likely exceeds $150/mo budget for most GPU SKUs |
| More control over model configuration | More setup than serverless |

**Cost:** Depends on VM SKU. A Standard_NC4as_T4_v3 (1x T4 GPU, 16GB VRAM) is ~$0.53/hr = ~$380/mo always-on. Likely too expensive unless you carefully manage uptime.

**Best for:** Production-grade deployment of specific Hugging Face models. Probably overkill for personal experimentation.

### 4. Azure GPU Virtual Machine + Self-Hosted Inference

**What it is:** Rent a GPU VM directly and install your own inference stack (Ollama, vLLM, text-generation-inference, llama.cpp server, etc.). Full control.

| Pros | Cons |
|---|---|
| Run ANY Hugging Face model | You manage everything (OS, drivers, updates) |
| Full control over quantization, parameters | GPU VMs are expensive |
| Can run Ollama (easy) or vLLM (performant) | Must manually start/stop to save money |
| Exposes OpenAI-compatible API | CUDA driver setup can be finicky |

**Recommended VM SKUs:**

| SKU | GPU | VRAM | ~$/hr | ~$/mo (24/7) | ~$/mo (8hr/day) | Models that fit |
|---|---|---|---|---|---|---|
| NC4as_T4_v3 | 1x T4 | 16 GB | $0.53 | $380 | $127 | 7B-13B (quantized) |
| NC24ads_A100_v4 | 1x A100 | 80 GB | $3.67 | $2,640 | $880 | 70B+ | 
| NC8as_T4_v3 | 1x T4 | 16 GB | $0.75 | $540 | $180 | 7B-13B (quantized) |

**Budget reality with $150/mo:** You could run an NC4as_T4_v3 for about 8 hours/day and stay within budget. Use Azure auto-shutdown or a script to start/stop the VM. Spot instances can save 60-80% but may be evicted.

**Best for:** Maximum flexibility and learning. The "real" self-hosting experience. Best if you want to run specific Hugging Face models and learn the infrastructure side.

### 5. GitHub Models (Free Tier)

**What it is:** Free API access to various models (Llama, Mistral, Phi, GPT-4o-mini, etc.) through GitHub's model marketplace, backed by Azure AI infrastructure.

| Pros | Cons |
|---|---|
| Free for experimentation | Rate-limited |
| Many open-source models available | Not suitable for always-on/production use |
| OpenAI-compatible API | May have usage caps |

**Best for:** Initial experimentation before committing to a paid service. Try different models to find what works for your coding workflow.

---

## Hugging Face's Role

Hugging Face is a **model repository** (like GitHub but for ML models), not a hosting service in itself (though they offer Inference Endpoints). Here's how HF models get onto Azure:

| Method | How it works |
|---|---|
| **Azure AI Foundry Catalog** | Many popular HF models (Llama, Mistral, Phi) are already in the catalog. Deploy with a few clicks. |
| **Azure GPU VM** | Download models from HF (`huggingface-cli download`) and run them with Ollama, vLLM, or llama.cpp. |
| **Hugging Face Inference Endpoints** | HF's own hosting service (not Azure). Deploys to AWS/GCP. Alternative to Azure but doesn't use your Azure credits. |

---

## Recommended Setup for Your Situation

### Recommended: Hybrid Approach

Given $150/mo in Azure credits and your two use cases:

#### For the Coding Assistant (Use Case 1)

**Option A — Simplest:** Use **Azure OpenAI Service** with GPT-4o-mini or GPT-4.1-mini. Install the **Continue** extension in VS Code. Cost: ~$5-20/mo for personal coding use.

**Option B — Open-source models:** Use **Azure AI Foundry serverless** to deploy Phi-4 or Llama 3.3. Still uses Continue in VS Code. Cost: Pay-per-token, likely $5-30/mo.

**Option C — Self-hosted:** Spin up an NC4as_T4_v3 GPU VM, install Ollama, pull a coding-focused model like `deepseek-coder-v2:16b` or `codellama:13b`. Expose the API and point Continue at it. Cost: ~$0.53/hr, run on-demand only.

#### For OpenClaw (Use Case 2)

1. **OpenClaw VM:** Deploy a **B2s or B2ms** Azure VM (Linux). Install Node.js and OpenClaw. Cost: ~$15-40/mo.
2. **LLM for OpenClaw:** Point OpenClaw at your Azure OpenAI endpoint, Azure AI Foundry endpoint, or Ollama instance (if running a GPU VM). OpenClaw supports any OpenAI-compatible API.
3. **Optional:** If you go the GPU VM route for the coding assistant, OpenClaw can share that same LLM endpoint.

#### Budget Breakdown (Example)

| Component | Monthly Cost |
|---|---|
| B2s VM for OpenClaw | ~$15 |
| Azure OpenAI (GPT-4o-mini for both use cases) | ~$10-30 |
| **Total** | **~$25-45** |

OR if self-hosting a model:

| Component | Monthly Cost |
|---|---|
| B2s VM for OpenClaw | ~$15 |
| NC4as_T4_v3 GPU VM (8hr/day) | ~$127 |
| **Total** | **~$142** (tight but fits) |

---

## Model Size Guidance

Since you're unsure about model sizes:

| Size | Examples | Quality | What fits on T4 (16GB VRAM) |
|---|---|---|---|
| **Small (7B-8B)** | Llama 3.1 8B, Phi-4-mini, DeepSeek-Coder 6.7B | Good for simple tasks, fast | Yes (even at FP16) |
| **Medium (13B-14B)** | CodeLlama 13B, Phi-4 14B | Better reasoning, coding | Yes (quantized Q4/Q5) |
| **Large (30B-34B)** | DeepSeek-Coder-V2 33B, CodeLlama 34B | Strong coding ability | Tight (Q4 quantization) |
| **XL (70B+)** | Llama 3.3 70B, DeepSeek-R1 | Near-GPT-4 quality | No — needs A100 80GB |

**For coding assistance**, a 13B-14B model (like Phi-4 or CodeLlama 13B) quantized to Q5 is a solid sweet spot that fits on a T4 GPU and produces good code completions.

---

## Getting Started Steps

1. **Try GitHub Models** (free) — experiment with different models to find ones you like for coding
2. **Set up Azure OpenAI** — deploy GPT-4o-mini for a quick, cheap coding assistant via Continue
3. **Deploy OpenClaw** on a small Azure VM pointing at the Azure OpenAI endpoint
4. **Later (optional):** Spin up a GPU VM with Ollama to self-host an open-source model if you want more control or to use Hugging Face models directly

---

## Notes

- Azure GPU VM availability varies by region. East US, West US 2, and West Europe tend to have the best availability for NC-series.
- The T4 GPU is NVIDIA's entry-level data center GPU — good for inference but limited VRAM (16GB).
- Spot instances on GPU VMs can save significant money but will be deallocated if Azure needs the capacity.
- Azure auto-shutdown can be scheduled (e.g., turn off at midnight, use a Logic App or cron to start in the morning).
- OpenClaw has a Docker install option which simplifies deployment on Azure VMs.
