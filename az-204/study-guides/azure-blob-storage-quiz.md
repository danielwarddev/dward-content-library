# AZ-204 Study Guide: Azure Blob Storage

Generated: March 1, 2026
Source material: `az-204/ms-learn/explore-azure-blob-storage.md`
Difficulty: Mixed (Fundamentals → Tricky Exam-Style)

## How to Use This Guide
1. Cover the answer sections (collapse them or use a sheet of paper)

2. Answer each question yourself FIRST

3. Then reveal the answer, mnemonic, and exam tip

4. Star (⭐) any you got wrong and revisit those before the exam

---

## Section 1: Concept Check

### Question 1: Blob Storage Purpose

**Azure Blob Storage is optimized for storing which type of data?**

A) Relational data with strict schemas

B) Massive amounts of unstructured data

C) Graph data with complex relationships

D) Time-series data exclusively

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Massive amounts of unstructured data**

**Why:** Azure Blob Storage is Microsoft's object storage solution specifically optimized for storing massive amounts of unstructured data — data that doesn't adhere to a particular data model or definition, such as text or binary data. Relational data belongs in SQL databases, graph data in Cosmos DB with Gremlin API, and time-series data has dedicated services too.

**🧠 Memory Hook:** Think "**B**lob = **B**ig **L**ump **O**f **B**ytes." A blob is literally just a shapeless mass — no structure, no schema, just raw data dumped into a bucket. If someone hands you a mystery USB drive full of random files, that's blob territory.

**⚡ Exam Tip:** When you see "unstructured" in a question, your brain should immediately light up "Blob Storage." It's almost always the answer when unstructured data is mentioned.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Explore Azure Blob storage"

</details>

---

### Question 2: Blob Storage Use Cases

**Which of the following is NOT a design purpose of Azure Blob Storage?**

A) Streaming video and audio

B) Storing data for backup and disaster recovery

C) Hosting a relational database engine

D) Serving images or documents directly to a browser

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Hosting a relational database engine**

**Why:** The source material lists Blob Storage's design purposes as: serving images/documents to browsers, storing files for distributed access, streaming video/audio, writing to log files, backup/restore/disaster recovery/archiving, and storing data for analysis. Hosting a relational database engine is the job of Azure SQL Database or SQL Managed Instance, not Blob Storage.

**🧠 Memory Hook:** Blobs are like a giant warehouse — you can store boxes (files), stream music through the speakers, and even show pictures on the walls. But you wouldn't build an office with organized filing cabinets (relational DB) inside a warehouse. Wrong building!

**⚡ Exam Tip:** Elimination works great here. If three options are clearly about "storing stuff" or "serving stuff," the odd one out that requires compute/processing logic is probably wrong.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Explore Azure Blob storage"

</details>

---

### Question 3: Storage Account Namespace

**What does a storage account provide for your Azure Storage data?**

A) A load balancer for distributing traffic

B) A unique namespace accessible over HTTP or HTTPS worldwide

C) A virtual network for isolating storage resources

D) A built-in CDN for caching content at edge locations

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) A unique namespace accessible over HTTP or HTTPS worldwide**

**Why:** An Azure Storage account is the top-level container for all of your Azure Blob storage. It provides a unique namespace for your Azure Storage data that is accessible from anywhere in the world over HTTP or HTTPS. The other options describe different Azure services (Load Balancer, VNet, Azure CDN).

**🧠 Memory Hook:** Think of a storage account like your **street address** on the internet. Just like `123 Main St` is unique to your house and anyone with the address can send you mail, `mystorageaccount.blob.core.windows.net` is unique to your data and anyone with the URL can access it (if permitted). One account = one address = one namespace.

**⚡ Exam Tip:** Remember the URL pattern: `http://<account-name>.blob.core.windows.net`. This shows up in code questions — if you see `.blob.core.windows.net` in a URI, you're looking at a Blob Storage endpoint.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Storage accounts"

</details>

---

### Question 4: Container Naming Rules

**Which of the following is a VALID Azure Blob Storage container name?**

A) `My-Container`

B) `my--container`

C) `my-container-01`

D) `-mycontainer`

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) my-container-01**

**Why:** Container names must: be 3–63 characters long, start with a letter or number, contain only lowercase letters, numbers, and dashes, and NOT have two or more consecutive dashes. Option A fails because of uppercase letters. Option B fails because of consecutive dashes (`--`). Option D fails because it starts with a dash. Only C follows all rules.

**🧠 Memory Hook:** Container names are like a **shy, lowercase librarian** — they whisper (lowercase only), they hate stuttering (no double dashes), and they always introduce themselves properly (start with a letter or number, never a dash). "H-hi, I'm m-my-container-01" ✅ vs. "--SHUT UP!" ❌

**⚡ Exam Tip:** Container naming questions love to test consecutive dashes and uppercase letters. Scan each option for these two traps FIRST — they eliminate most wrong answers instantly.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Containers"

</details>

---

### Question 5: Types of Blobs

**Which blob type is specifically optimized for append operations and ideal for logging scenarios?**

A) Block blobs

B) Page blobs

C) Append blobs

D) File blobs

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Append blobs**

**Why:** Append blobs are made up of blocks like block blobs, but are specifically optimized for append operations. They're ideal for scenarios such as logging data from virtual machines. Block blobs store general text and binary data. Page blobs store random access files like VHDs. "File blobs" don't exist as a blob type.

**🧠 Memory Hook:** **A**ppend blobs are for **A**dding to the end — like a diary. You never go back and edit Tuesday's entry; you just keep writing new entries at the bottom. Logs work the same way: append, append, append, never modify.

**⚡ Exam Tip:** The three blob types are Block, Append, and Page. If you see a fourth option like "File blobs" or "Table blobs," it's always a trap — eliminate it immediately.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Blobs"

</details>

---

### Question 6: Page Blob Use Case

**Page blobs store random access files up to what size, and what is their primary use case?**

A) 190.7 TiB — storing virtual hard drives (VHDs)

B) 8 TB — serving as disks for Azure virtual machines

C) 4.75 TiB — streaming large media files

D) 512 GB — storing database backup files

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) 8 TB — serving as disks for Azure virtual machines**

**Why:** Page blobs store random access files up to 8 TB in size. They store virtual hard drive (VHD) files and serve as disks for Azure virtual machines. The 190.7 TiB figure belongs to block blobs. The other sizes are fabricated.

**🧠 Memory Hook:** **P**age blobs are for **P**ages of a hard drive — like flipping to any **P**age in a book (random access). VMs need disks, disks need page blobs. Think: "My VM's **P**assport photo is stored on a **P**age blob" — VMs carry page blobs as their identity (their disk).

**⚡ Exam Tip:** The size trap is real: 190.7 TiB = Block blobs, 8 TB = Page blobs. If a question mentions VHDs or VM disks, the answer is always Page blobs.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Blobs"

</details>

---

### Question 7: Block Blob Max Size

**What is the maximum size a block blob can store?**

A) 8 TB

B) 4.75 TiB

C) 190.7 TiB

D) 100 TB

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) 190.7 TiB**

**Why:** Block blobs can store up to about 190.7 TiB. They are made up of blocks of data that can be managed individually. The 8 TB figure is for page blobs. The other values are distractors.

**🧠 Memory Hook:** 190.7 is a weird, ugly number — that's what makes it memorable. Think "**190** episodes of a TV show, each **0.7** hours long" — that's a LOT of content, just like a block blob holds a LOT of data. Block blobs are the big boys.

**⚡ Exam Tip:** Microsoft loves testing exact numbers. Drill these two: Block = ~190.7 TiB, Page = 8 TB. If you remember nothing else, remember Block is way bigger than Page.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Blobs"

</details>

---

## Section 2: Code & Configuration

### Question 8: Blob Storage Endpoint URL

**A developer creates a storage account named `contosodocs` and wants to access a blob named `report.pdf` inside a container named `finance`. What is the correct URL to access this blob?**

A) `https://contosodocs.blob.core.windows.net/report.pdf/finance`

B) `https://contosodocs.blob.core.windows.net/finance/report.pdf`

C) `https://finance.blob.core.windows.net/contosodocs/report.pdf`

D) `https://blob.core.windows.net/contosodocs/finance/report.pdf`

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) `https://contosodocs.blob.core.windows.net/finance/report.pdf`**

**Why:** The URL pattern for a blob is: `https://<account-name>.blob.core.windows.net/<container>/<blob>`. The storage account name is the subdomain, followed by the container, then the blob name. Option A reverses container and blob. Option C uses the container as the account name. Option D omits the account from the subdomain.

**🧠 Memory Hook:** Think of it like a postal address read **backwards**: Country (blob.core.windows.net) → City (account name) → Street (container) → House number (blob). Or more simply: **A**ccount → **C**ontainer → **B**lob = **ACB** — Always Container Before blob.

**⚡ Exam Tip:** For code questions, focus on the URL structure. The account name is ALWAYS the subdomain (before `.blob.core.windows.net`). If you see the account name anywhere else in the path, it's wrong.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Blobs"

</details>

---

### Question 9: SDK Connection Code

**A developer writes the following C# code to interact with Azure Blob Storage. What is the purpose of the `BlobServiceClient` class?**

```csharp
string connectionString = "DefaultEndpointsProtocol=https;AccountName=mystorage;...";
BlobServiceClient blobServiceClient = new BlobServiceClient(connectionString);
BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient("images");
BlobClient blobClient = containerClient.GetBlobClient("photo.jpg");
```

A) It represents a single blob and allows upload/download operations

B) It represents a container and manages blobs within it

C) It represents the storage account and is the entry point for interacting with the Blob service

D) It represents the Azure subscription and manages all storage accounts

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) It represents the storage account and is the entry point for interacting with the Blob service**

**Why:** The SDK mirrors the resource hierarchy: `BlobServiceClient` → storage account level, `BlobContainerClient` → container level, `BlobClient` → individual blob level. The code shows the chain: service client creates container client, container client creates blob client. This matches the resource hierarchy: Account → Container → Blob.

**🧠 Memory Hook:** Think of the SDK class names as a **Russian nesting doll**: The biggest doll is `BlobServiceClient` (the whole account). Open it and inside is `BlobContainerClient` (a container). Open that and inside is `BlobClient` (one blob). You always start with the biggest doll and work inward.

**⚡ Exam Tip:** On code questions, focus on the METHOD NAMES and class hierarchy. `GetBlobContainerClient` tells you the service client gets containers. `GetBlobClient` tells you the container client gets blobs. The naming literally tells you the hierarchy.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Discover Azure Blob storage resource types"

</details>

---

### Question 10: Encryption Configuration

**Your team wants to use customer-managed encryption keys for both Blob Storage and Azure Files. Where must these keys be stored?**

A) In the application's `appsettings.json` file

B) In Azure Key Vault or Azure Key Vault Managed HSM

C) In the storage account's access keys section

D) In an Azure Active Directory application registration

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) In Azure Key Vault or Azure Key Vault Managed HSM**

**Why:** Customer-managed keys must be stored in Azure Key Vault or Azure Key Vault Managed Hardware Security Model (HSM). This is a hard requirement — you can't store them in app config, storage account settings, or AAD app registrations. Customer-managed keys support Blob Storage and Azure Files (not all services).

**🧠 Memory Hook:** Think "**C**ustomer-**M**anaged keys live in the **K**ey **V**ault" — CMK → KV. It's like having your own safety deposit box at the bank (Key Vault). You own the key, but the bank (Azure) provides the secure vault to keep it in.

**⚡ Exam Tip:** Don't confuse customer-managed keys with customer-provided keys. Customer-**managed** = stored in Key Vault, works with Blobs + Files. Customer-**provided** = you bring the key per-request, works with Blobs ONLY.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Encryption key management"

</details>

---

### Question 11: What's Wrong With This Code?

**A developer wants to create a container named `Report-Archive-2026` using the Azure SDK. What will happen?**

```csharp
BlobServiceClient client = new BlobServiceClient(connectionString);
BlobContainerClient container = client.CreateBlobContainer("Report-Archive-2026");
```

A) The container will be created successfully

B) It will fail because container names cannot contain uppercase letters

C) It will fail because the container name is too long

D) It will fail because numbers aren't allowed in container names

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) It will fail because container names cannot contain uppercase letters**

**Why:** Container names can contain only lowercase letters, numbers, and the dash character. `Report-Archive-2026` contains uppercase R and A, which violates the naming rules. The name length (20 chars) is fine (3–63 allowed), and numbers are permitted.

**🧠 Memory Hook:** Remember the shy librarian from Question 4 — containers WHISPER. They're always lowercase. `report-archive-2026` ✅ but `Report-Archive-2026` ❌. If you see ANY uppercase letter in a container name, alarm bells should ring.

**⚡ Exam Tip:** On "what's wrong" code questions, check naming rules FIRST. They're the most common gotcha. Scan for: uppercase letters, consecutive dashes, starting with a dash, and length (3–63 chars).

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Containers"

</details>

---

### Question 12: Client-Side Encryption Version

**Your team needs to implement client-side encryption for Blob Storage using the .NET SDK. Which encryption mode does version 2 of client-side encryption use?**

A) CBC (Cipher Block Chaining) mode with AES

B) GCM (Galois/Counter Mode) mode with AES

C) RSA-OAEP with 2048-bit keys

D) ECB (Electronic Codebook) mode with AES

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) GCM (Galois/Counter Mode) mode with AES**

**Why:** Version 2 of client-side encryption uses Galois/Counter Mode (GCM) with AES. Version 1 (the older version) uses Cipher Block Chaining (CBC) mode with AES. RSA-OAEP and ECB are not used for Azure Storage client-side encryption.

**🧠 Memory Hook:** **V2 = GCM** — think "**G**ot **C**ool **M**ode" for version 2 (the newer, cooler version). **V1 = CBC** — think "**C**rusty **B**oring **C**lassic" (the old way). V2 is always the upgrade.

**⚡ Exam Tip:** V1 vs V2 is a detail question. Also remember: V2 (GCM) is supported for Blob and Queue SDKs only. V1 (CBC) also supports Table Storage. Newer doesn't always mean broader support.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Client-side encryption"

</details>

---

## Section 3: Scenario-Based

### Question 13: Choosing the Right Blob Type

**Your company needs to store diagnostic logs from 500 Azure virtual machines. New log entries are constantly added to the files, but existing entries are never modified. Which blob type should you use?**

A) Block blobs

B) Page blobs

C) Append blobs

D) File shares

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Append blobs**

**Why:** Append blobs are optimized for append operations and are ideal for logging scenarios — exactly what's described here. Data is constantly appended (new log entries) but never modified (existing entries untouched). Block blobs could work but aren't optimized for this pattern. Page blobs are for VHDs/random access. File shares aren't a blob type.

**🧠 Memory Hook:** Logs = the **diary** pattern. You write new entries at the end, you never erase or change old ones. **A**ppend blobs for **A**dding-only workloads. If the question says "never modified" + "constantly added," it's screaming append blob.

**⚡ Exam Tip:** Read the ACTUAL QUESTION first (last 1-2 sentences). The scenario about 500 VMs is filler — the key detail is "new entries added, never modified." That's the append blob signal. Don't get distracted by the VM count.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Blobs"

</details>

---

### Question 14: Access Tier Selection

**Your company has regulatory compliance data that must be retained for 7 years. The data is accessed approximately once every 2-3 years during audits. You need the MOST cost-effective storage solution. Which access tier should you use?**

A) Hot

B) Cool

C) Cold

D) Archive

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: D) Archive**

**Why:** The Archive tier is the most cost-effective option for storing data and is optimized for data that can tolerate several hours of retrieval latency and remains in the tier for a minimum of 180 days. Since the data is accessed only once every 2-3 years (extremely infrequently) and must be retained for 7 years, Archive is the most cost-effective choice. The hours-long retrieval time is acceptable for audit scenarios where you can plan ahead.

**🧠 Memory Hook:** Remember the storage unit analogy: Archive = your **storage unit across town** (cheap rent, but you need 24 hours notice and a truck to get your stuff). An audit every 2-3 years? You've got plenty of time to drive across town and rent that truck. Hot/Cool/Cold are like paying for a kitchen counter, garage, or basement you barely ever visit.

**⚡ Exam Tip:** Watch for "MOST cost-effective" — this is a signal that the simplest/cheapest correct answer wins. Archive is always cheapest for storage costs. Only eliminate it if the question says "must be accessed within seconds" or "minimum latency required."

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Access tiers for block blob data"

</details>

---

### Question 15: Encryption Key Strategy

**Your company's security policy requires that encryption keys for Blob Storage be rotated by the company's own security team, not by Microsoft. The keys must be centrally managed and auditable. However, Azure Files also needs to use the same key management approach. Which key management option should you use?**

A) Microsoft-managed keys

B) Customer-provided keys

C) Customer-managed keys stored in Azure Key Vault

D) Customer-managed keys stored in the application configuration

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Customer-managed keys stored in Azure Key Vault**

**Why:** Customer-managed keys (CMK) meet all requirements: the customer controls key rotation, keys are centrally managed in Azure Key Vault (auditable), and CMK supports BOTH Blob Storage and Azure Files. Microsoft-managed keys don't give the company rotation control. Customer-provided keys only support Blob Storage (not Azure Files). Keys can't be stored in app config for CMK — they must be in Key Vault or Key Vault HSM.

**🧠 Memory Hook:** Think of it as a **Venn diagram**: Customer-managed keys = the overlap between Blob Storage AND Azure Files. Customer-provided keys = Blob Storage ONLY circle. Need both services? You MUST go customer-managed in Key Vault.

**⚡ Exam Tip:** When a scenario mentions BOTH Blob Storage and Azure Files needing encryption, customer-provided keys are immediately eliminated (Blob only). This is an eliminate-first question — cross out the obvious wrong answers.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Encryption key management"

</details>

---

### Question 16: Storage Account Type Selection

**A fintech startup needs blob storage with consistently low latency and high transaction rates for their real-time trading platform. They process millions of small objects per second. Which storage account type should they choose?**

A) Standard general-purpose v2

B) Premium block blobs

C) Premium page blobs

D) Premium file shares

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Premium block blobs**

**Why:** Premium block blobs are recommended for scenarios with high transaction rates, smaller objects, or consistently low storage latency — which perfectly matches this scenario. Standard general-purpose v2 would work but doesn't provide the performance guarantee needed. Premium page blobs are for VHD/VM disk scenarios. Premium file shares are for Azure Files only.

**🧠 Memory Hook:** Premium block blobs are the **sports car** of blob storage — fast, expensive, built for speed (low latency) and volume (high transactions). Standard v2 is the reliable sedan — it gets you there, but not at racing speed. If the question screams "FAST" + "LOTS of small things," it's premium block blobs.

**⚡ Exam Tip:** Trigger words for Premium block blobs: "low latency," "high transaction rates," "smaller objects." These three phrases appear directly in the Microsoft documentation. If you see any of them, Premium block blobs is your answer.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Types of storage accounts"

</details>

---

### Question 17: Access Tier Minimum Retention

**A developer moves a blob to the Cool access tier on January 1st and then moves it to the Hot tier on January 20th. What happens?**

A) The move succeeds with no additional charges

B) The move succeeds but incurs an early deletion charge for 10 days

C) The move is blocked until the 30-day minimum is met

D) The blob is automatically moved to Archive tier instead

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) The move succeeds but incurs an early deletion charge for 10 days**

**Why:** The Cool tier has a minimum storage duration of 30 days. You CAN move data out before 30 days, but you'll be charged for the remaining days (30 - 20 = 10 days of early deletion charges). Azure doesn't block the move — it just charges you. The tier minimums are: Cool = 30 days, Cold = 90 days, Archive = 180 days.

**🧠 Memory Hook:** Think of access tiers like **apartment leases**: Cool = 30-day lease, Cold = 90-day lease, Archive = 180-day lease. You CAN break the lease early, but you pay a penalty for the remaining days. Nobody locks you in the apartment — they just send you a bill.

**⚡ Exam Tip:** Memorize the minimum retention days: Cool = **30**, Cold = **90**, Archive = **180**. Notice the pattern: each is roughly 3× the previous (30 → 90 → 180). "**30-90-180**" — say it three times.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Access tiers for block blob data"

</details>

---

### Question 18: Compliance Encryption Scenario

**An auditor asks your team: "Is encryption enabled on your Azure Storage account?" Your team never configured any encryption settings during setup. What should you tell the auditor?**

A) "No, encryption must be manually enabled after account creation."

B) "Yes, all data is automatically encrypted using 256-bit AES encryption and it cannot be disabled."

C) "Only blobs are encrypted by default; tables and queues require manual setup."

D) "Encryption is only enabled if we chose the Premium tier."

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) "Yes, all data is automatically encrypted using 256-bit AES encryption and it cannot be disabled."**

**Why:** Azure Storage automatically encrypts your data when persisting it to the cloud using 256-bit AES encryption (FIPS 140-2 compliant). Encryption is enabled for ALL storage accounts and CANNOT be disabled. All resources are encrypted: blobs, disks, files, queues, and tables. All metadata is also encrypted. There is no extra cost.

**🧠 Memory Hook:** Azure Storage encryption is like **gravity** — it's always on, you can't turn it off, it affects everything, and it costs nothing extra. You don't "enable" gravity when you build a house; it just works. Same with Azure Storage encryption.

**⚡ Exam Tip:** This is a free point on the exam. The answer to "Is Azure Storage encrypted?" is ALWAYS yes. The nuance is in WHO manages the keys (Microsoft vs. customer), not WHETHER encryption exists.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Azure Storage encryption for data at rest"

</details>

---

## Section 4: Tier & Service Comparison

### Question 19: Access Tier Cost Tradeoff

**Which statement correctly describes the cost relationship between Azure Blob Storage access tiers?**

A) Hot tier has the lowest storage costs and the lowest access costs

B) Archive tier has the highest storage costs but the lowest access costs

C) Hot tier has the highest storage costs but the lowest access costs

D) Cool tier has the highest storage costs but lower access costs than Hot

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Hot tier has the highest storage costs but the lowest access costs**

**Why:** There's an inverse relationship: Hot = expensive to store, cheap to access. Archive = cheap to store, expensive to access. It's a seesaw — storage cost goes down as access cost goes up. Hot has the highest storage costs but lowest access costs. The cool and cold tiers fall in between.

**🧠 Memory Hook:** Think of a **seesaw**: 🔥 Hot is UP on storage cost and DOWN on access cost. 🧊 Archive is DOWN on storage cost and UP on access cost. They're always opposite. "The hotter your data, the more it costs to keep it warm — but at least you don't pay much to look at it."

**⚡ Exam Tip:** Any answer that says a tier is cheap for BOTH storage and access is wrong. It's always a tradeoff. The exam loves to test this inverse relationship.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Access tiers for block blob data"

</details>

---

### Question 20: Premium Account Redundancy

**You're deploying a Premium block blobs storage account. Which redundancy options are available?**

A) LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS

B) LRS and ZRS only

C) LRS only

D) ZRS, GZRS, and RA-GZRS only

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) LRS and ZRS only**

**Why:** ALL three Premium account types (block blobs, page blobs, file shares) only support LRS and ZRS redundancy. The full range of redundancy options (LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS) is only available with Standard general-purpose v2 accounts. Premium = faster but fewer redundancy choices.

**🧠 Memory Hook:** Premium accounts are like a **luxury sports car** — incredibly fast, but it only comes in two colors (LRS and ZRS). The Standard v2 is like a Honda Civic — comes in every color imaginable (all six redundancy options) because it's built for everyone.

**⚡ Exam Tip:** This is a HIGH-frequency exam question. Memorize: **Premium = only LRS + ZRS**. If a question asks about geo-redundancy (GRS, GZRS, RA-GRS, RA-GZRS) with Premium accounts, the answer is "not available — use Standard."

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Types of storage accounts"

</details>

---

### Question 21: Storage Account Type Comparison

**Which Premium storage account type supports BOTH Blob Storage and Data Lake Storage?**

A) Premium page blobs

B) Premium file shares

C) Premium block blobs

D) Standard general-purpose v2

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Premium block blobs**

**Why:** Premium block blobs supports "Blob Storage (including Data Lake Storage)." Premium page blobs only supports page blobs. Premium file shares only supports Azure Files. Standard general-purpose v2 supports all services but isn't a Premium type. Note: Standard general-purpose v2 also supports Data Lake Storage, but the question asks specifically about Premium account types.

**🧠 Memory Hook:** Data Lake is basically blobs in a trenchcoat — it's built ON TOP of Blob Storage with a hierarchical namespace. So wherever you see "Blob Storage (including Data Lake Storage)," they're bundled together. Premium block blobs = the premium version of this bundle.

**⚡ Exam Tip:** Data Lake Storage is always paired with Blob Storage in the account type descriptions. If a question mentions Data Lake + Premium, the answer is Premium block blobs. Period.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Types of storage accounts"

</details>

---

### Question 22: Encryption Key Scope Comparison

**Which encryption key management option does NOT support scoping the key to a specific container or blob?**

A) Microsoft-managed keys

B) Customer-managed keys

C) Customer-provided keys

D) Both A and B support container/blob scoping

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Customer-provided keys**

**Why:** Microsoft-managed keys and customer-managed keys both support key scoping at the account (default), container, or blob level. Customer-provided keys have "N/A" for key scope — they don't support this granularity because the key is provided per-request rather than configured at a scope level.

**🧠 Memory Hook:** Customer-**provided** keys are like **BYOB (Bring Your Own Bottle)** at a restaurant — you bring a different bottle each time, so there's no "scope" to set. It's per-visit (per-request). Customer-**managed** keys are like your **wine cellar at home** — you organize bottles by room (account), shelf (container), or slot (blob).

**⚡ Exam Tip:** Whenever you see "customer-provided keys" as an option, remember its limitations: Blob Storage ONLY, no key scope, customer stores the key. It's the most restrictive of the three options.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Encryption key management"

</details>

---

### Question 23: Access Tier Minimum Retention Comparison

**Match each access tier with its correct minimum storage duration:**

| Tier | Minimum Duration |
|------|-----------------|
| Cool | ??? |
| Cold | ??? |
| Archive | ??? |

A) Cool = 30 days, Cold = 60 days, Archive = 120 days

B) Cool = 30 days, Cold = 90 days, Archive = 180 days

C) Cool = 60 days, Cold = 120 days, Archive = 365 days

D) Cool = 7 days, Cold = 30 days, Archive = 90 days

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: B) Cool = 30 days, Cold = 90 days, Archive = 180 days**

**Why:** These are the exact minimum storage durations from the Microsoft documentation. Cool = 30 days minimum. Cold = 90 days minimum. Archive = 180 days minimum. Hot has no minimum duration.

**🧠 Memory Hook:** The "**30-90-180**" rule — each tier roughly triples/doubles:
- **Cool** = **30** days (a month — like a "cool-down" period after a breakup)
- **Cold** = **90** days (a quarter — like winter lasting a full season)
- **Archive** = **180** days (half a year — like forgetting something exists in your attic)

Another way: **Cool** = 1 month, **Cold** = 1 quarter, **Archive** = ½ year. Each jump is ~3×.

**⚡ Exam Tip:** This exact question appears on the AZ-204 frequently. Write "30-90-180" on your scratch paper the moment the exam starts. It's free points.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Access tiers for block blob data"

</details>

---

### Question 24: Archive Tier Limitations

**Which statement about the Archive access tier is TRUE?**

A) Archive tier can be set at the storage account level

B) Archive tier is available for all blob types (block, append, and page)

C) Archive tier is available only for individual block blobs

D) Archive tier data can be read immediately without rehydration

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Archive tier is available only for individual block blobs**

**Why:** The Archive tier is explicitly stated as available "only for individual block blobs." It can't be set at the account or container level (only Hot, Cool, and Cold can be default tiers). It doesn't apply to append or page blobs. And archived data requires rehydration (several hours of retrieval latency) before it can be read.

**🧠 Memory Hook:** Archive is the **diva** of access tiers — it's picky (only block blobs), slow (hours to retrieve), and demands individual attention (per-blob only, no account-level setting). "The Archive blob is too special to share a tier setting with anyone else."

**⚡ Exam Tip:** "Only for individual block blobs" is the key phrase to remember about Archive. If a question suggests setting Archive at the account level or using it with page/append blobs, it's wrong.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Access tiers for block blob data"

</details>

---

### Question 25: Encryption Services Support Matrix

**A developer needs to use customer-provided encryption keys. Which Azure Storage service(s) support this option?**

A) Blob Storage, Azure Files, Queue Storage, and Table Storage

B) Blob Storage and Azure Files only

C) Blob Storage only

D) All Azure Storage services

<details>
<summary>🔑 Reveal Answer</summary>

**Answer: C) Blob Storage only**

**Why:** The encryption key management comparison table shows clearly: Microsoft-managed keys support ALL services. Customer-managed keys support Blob Storage and Azure Files. Customer-provided keys support Blob Storage ONLY. Each key type has progressively narrower service support.

**🧠 Memory Hook:** Think of it as a **funnel** getting narrower:
- **M**icrosoft-managed = **M**assive support (ALL services) 🔵🔵🔵🔵
- **C**ustomer-managed = **C**ouple of services (Blob + Files) 🔵🔵
- Customer-**P**rovided = **P**inpoint focus (Blob only) 🔵

**⚡ Exam Tip:** The funnel pattern: Microsoft-managed → Customer-managed → Customer-provided = broader → narrower service support. More customer control = fewer services supported.

**📖 Source:** az-204/ms-learn/explore-azure-blob-storage.md → "Encryption key management"

</details>

---

## 📅 Spaced Repetition Plan
- **Today:** Complete this quiz. Star (⭐) every question you got wrong.
- **Tomorrow:** Re-do ONLY the starred questions.
- **Day 3:** Re-do starred questions again. Unstar any you now get right.
- **Day 7:** Full quiz again. Re-star any you miss.
- **Day 14:** Final full review. Anything still starred = write it on a cheat sheet for exam-day morning review.

---

## 🗣️ Teach-It-Back Challenges
Explain these out loud (or in writing) as if teaching a junior developer. If you can't explain it simply, you don't know it well enough:

1. **Explain the three blob types (Block, Append, Page) and when you'd use each one.** Give a real-world example for each.
2. **Explain how Azure Storage encryption works by default and the three key management options.** Draw the funnel: which services does each option support?
3. **Explain the four access tiers (Hot, Cool, Cold, Archive) using the kitchen/garage/basement/storage-unit analogy.** Include the minimum retention days and the cost seesaw concept.
4. **Explain the URL structure for a blob** — account → container → blob — and why it matters for the SDK class hierarchy (`BlobServiceClient` → `BlobContainerClient` → `BlobClient`).

---

## 📊 Quick-Reference: Azure Blob Storage at a Glance

### Storage Account Types

| Feature | Standard general-purpose v2 | Premium block blobs | Premium file shares | Premium page blobs |
|---|---|---|---|---|
| **Services** | Blob, Queue, Table, Files, Data Lake | Blob, Data Lake | Azure Files only | Page blobs only |
| **Redundancy** | LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS | LRS, ZRS | LRS, ZRS | LRS, ZRS |
| **Best for** | Most scenarios | High transactions, low latency, small objects | Enterprise file shares | VHD / VM disks |

### Access Tiers

| Feature | Hot | Cool | Cold | Archive |
|---|---|---|---|---|
| **Optimized for** | Frequent access | Infrequent access | Infrequent access | Rare access |
| **Min retention** | None | 30 days | 90 days | 180 days |
| **Storage cost** | Highest | Lower | Lower still | Lowest |
| **Access cost** | Lowest | Higher | Higher still | Highest |
| **Retrieval time** | Immediate | Immediate | Immediate | Hours |
| **Scope** | Account/container/blob | Account/container/blob | Account/container/blob | Individual block blobs only |

### Blob Types

| Feature | Block Blobs | Append Blobs | Page Blobs |
|---|---|---|---|
| **Max size** | ~190.7 TiB | N/A | 8 TB |
| **Best for** | Text, binary, general files | Logging, append-only workloads | VHD files, VM disks |
| **Key trait** | Blocks managed individually | Optimized for append operations | Random access |

### Encryption Key Management

| Feature | Microsoft-managed | Customer-managed | Customer-provided |
|---|---|---|---|
| **Services supported** | All | Blob + Azure Files | Blob only |
| **Key storage** | Microsoft key store | Azure Key Vault / HSM | Customer's own store |
| **Key rotation** | Microsoft | Customer | Customer |
| **Key scope** | Account, container, or blob | Account, container, or blob | N/A (per-request) |
