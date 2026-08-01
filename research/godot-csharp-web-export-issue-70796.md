# Godot Issue #70796: C# Web Export Support — Full Summary

**Generated:** 2026-03-21  
**Source:** https://github.com/godotengine/godot/issues/70796  
**Status:** Open (as of March 2026)

---

## Overview

This issue tracks the long-standing inability to export Godot 4 C# (.NET) projects to the Web (HTML5/WASM) platform. It was opened January 1, 2023, and remains open with 130+ comments. The issue is highly upvoted (80+ 👍 on the original post) and has a community-funded bounty that grew to ~$970+ during the discussion.

---

## The Original Problem (Jan 1, 2023)

User **Kezzo** reported that in Godot 4.0 beta 10 (Mono/.NET), web export templates were simply missing from the template package. Attempting to create a web export preset produced no usable output files.

**Calinou** (core member) quickly explained the root cause:
- C# web exports don't exist because .NET 6/7 don't support building **libraries** for WASM
- Godot's C# integration works as a **library** (C++ is the entry point, calling into C#)
- .NET supports WASM for **applications** (where C# is the entry point, e.g., Blazor) but NOT for libraries
- This was a **missing upstream .NET feature**, not a Godot bug

The issue was briefly closed as "not planned," immediately reopened, relabeled with `platform:web`, `topic:dotnet`, `topic:export`, and moved to the `4.x` milestone. The title was later changed from "Web export templates not downloaded/missing" to the current name.

---

## Why It's So Hard — Technical Deep Dive (Jul 2023)

**raulsntos** (Godot's .NET maintainer) posted a detailed technical explanation:

- The upstream blocker was tracked at [dotnet/runtime#79377](https://github.com/dotnet/runtime/issues/79377): AOT compiler support for library mode
- He estimated .NET 8 (November 2023) might fix it — but couldn't guarantee it
- An alternative — making Godot a library and .NET the entry point — was suggested by some users
- **reduz** (Godot founder) shot this down: on Android and WASM, this won't work due to how those platforms handle entry points

**Key quote from reduz:**
> "WebAssembly itself is still quite broken in this regard and on Android Godot is already a library that Android needs to open from Java."

---

## Three Failed Approaches (Dec 6, 2024 — Major Update by raulsntos)

After 18+ months of exploration, raulsntos posted an exhaustive post-mortem. Three approaches were tried and all failed:

### 1. `dotnet.js` Approach
- Simplest option: publish a C# project with the `browser-wasm` runtime identifier and use `dotnet.js` to load the runtime
- **Why it failed:** Each WASM module runs in isolated memory. The Godot WASM and C# WASM can't share memory or function pointers without being linked together. They can only communicate if linked, and they were built with incompatible flags.

### 2. NativeAOT-LLVM
- An experimental runtime from [dotnet/runtimelab](https://github.com/dotnet/runtimelab/tree/feature/NativeAOT-LLVM) that supports building WASM via NativeAOT
- Very promising: NativeAOT lets you set custom compiler flags, making it possible to match the flags used in Godot's WASM build
- **Why it failed:** Adding `-sSIDE_MODULE=2` to the compilation failed because other pre-built libraries in the NativeAOT-LLVM package weren't compiled with `-fPIC`. Build errors made this unworkable without recompiling the entire .NET runtime.

### 3. Statically Linking Mono
- Try statically linking the Mono runtime directly into the Godot WASM
- Very brittle — hard to maintain across .NET versions, massive duplication of setup
- **Why it failed:** Godot's C# bindings use function pointers. Mono needs to build a table of function pointers at compile time, but this mechanism couldn't be made to work. MonoAOT also failed — GodotSharp is too large to compile with it.

**Conclusion at this point (Dec 2024):**
> "We are sorry to say that web support is still not available for C# projects."

---

## Breakthrough — May 6, 2025 (GodotCon Boston)

Shortly after the December 2024 post, **raulsntos** found a workaround for the Mono static-link function pointer blocker: by declaring **stub C# methods** in the project used to retrieve the Mono runtime, those methods get baked into the generated WASM function table, which is enough to retrieve function pointers at runtime.

### Results:
- **Draft PR [#106125](https://github.com/godotengine/godot/pull/106125)** — "[.NET] Add web export support" — opened as a work in progress
- **Live demo published:** https://lab.godotengine.org/godot-dotnet-web/
- Announced at GodotCon Boston: https://godotengine.org/article/live-from-godotcon-boston-web-dotnet-prototype/

### Known Limitations of the PR #106125 Approach:
| Limitation | Detail |
|---|---|
| TargetFramework lock | C# project must target same .NET version as the Godot templates |
| WASM feature matching | Project must match Godot template's threading model, SIMD, exception handling flags |
| Globalization | Only invariant mode is supported (no ICU globalization data) |
| Missing JS runtime stubs | `dotnet.runtime.js` stub replacements not wired up yet; some browser APIs (e.g., crypto) don't work |
| Build size | Demo was ~114MB (42MB Godot + 60MB Mono/C# runtime) |
| No code trimming | IL code in DLLs is trivially decompilable; full reflection means tree-shaking can't run |

---

## The Debate: Is Statically-Linked Mono the Right Path? (May 2025)

A heated discussion followed the May 2025 announcement:

### Against (Armynator, thygrrr)
- Demo is 114MB — Unity is constantly fighting size limits on web game portals
- No trimming means bloated + decompilable source code
- This is Godot 3-style JIT-in-the-browser, a step backward from the NativeAOT work done for desktop
- The `libgodot` approach (Godot as library, .NET as entry point) is the "correct" long-term solution

### For the Current Approach (raulsntos)
- A runtime is always needed; NativeAOT is also self-contained (just different tradeoffs)
- Mono *does* support trimming — Godot's reflection usage blocks it, not the approach itself
- Goal: get something functional first, then optimize
- Contributor **adamscott** is working on export compression separately

### Microsoft Input (pavelsavara, .NET team)
- Confirmed significant size reduction is possible using:
  - `ILLink.Substitutions.xml` — kills unused runtime C# classes
  - `_MonoRuntimeComponentDontLink` — kills Mono components
  - ICU and libz stripping
- Can get Mono/WASM down to **~2.5MB uncompressed (~810KB brotli)** with aggressive settings
- Offered to help; invited questions at https://github.com/dotnet/runtime/discussions

### Threading
- MT dotnet for WASM is experimental; Microsoft disabled it in .NET 9 due to stability issues
- Single-threaded is the safe default; async/await (Tasks) still works fine on ST and will auto-scale when MT arrives
- .NET 10 made progress on making `dotnet.js` more JS-bundler-friendly

---

## Community PRs and Related Work

| PR / Commit | Author | Status | Notes |
|---|---|---|---|
| [#106125](https://github.com/godotengine/godot/pull/106125) | raulsntos (GodotEngine org) | **Open Draft** | Official effort — statically linked Mono |
| [#99508](https://github.com/godotengine/godot/pull/99508) | mcjill (community) | **Open Draft** | Community attempt; commit says "Fixes #70796" |
| [#115280](https://github.com/godotengine/godot/pull/115280) | Eliene-byte (community) | **Closed** | "Implement C# .NET Integration via Headless Glue Bypass" |

---

## New Angle: Godot 4.6 + LibGodot (Jan 28, 2026)

With the release of Godot 4.6, **LibGodot** shipped — allowing Godot to run as a *library* embedded in another application. This reopens the long-discussed idea of having .NET (or Blazor) be the WASM entry point and initialize Godot as a library.

**zorbathut** (a contributor who worked on LibGodot) attempted this:
- Spent ~1-2 days on it
- Got Godot loading and starting to load a project, then hit a crash related to the virtual filesystem
- Believes it's **viable and arguably better than the Mono static-link approach**
- Left notes and partial source at: https://github.com/zorbathut/libgodot_example/tree/webasm-attempt
- Not actively pursuing it

**thygrrr** (Godot contributor) stated they plan to pick this up as part of their [2dog](https://2dog.dev) project.

---

## Current Status (March 2026)

| Item | Status |
|---|---|
| Issue #70796 | **Open** |
| Official Draft PR #106125 (Mono static link) | **Open Draft — WIP, demo works but not merge-ready** |
| LibGodot WASM approach | **Early community exploration, no official PR** |
| Community Draft PR #99508 | **Open Draft** |
| .NET upstream support | Improved; pavelsavara (MSFT) is engaged and helping |
| WASM multithreading | Still problematic in browsers; disabled by default in .NET 9 |

---

## Timeline Summary

| Date | Event |
|---|---|
| Jan 1, 2023 | Issue opened — web export templates missing in Godot 4.0 beta |
| Jan 2023 | Calinou explains: missing upstream .NET library WASM support |
| Jul 2023 | raulsntos deep-dives the technical barrier; .NET 8 may help |
| Nov 2023 | .NET 8 ships — doesn't fully solve the problem |
| Sep–Nov 2023 | Community comments/pressure mounts; bounty started |
| Dec 6, 2024 | raulsntos posts exhaustive failure report on 3 approaches |
| Nov 2024 | Community draft PR #99508 opened |
| May 6, 2025 | **Breakthrough**: raulsntos finds stub workaround, opens Draft PR #106125 |
| May 6, 2025 | Live demo published at GodotCon Boston |
| May 2025 | Debate on Mono approach; MSFT's pavelsavara joins discussion |
| Jul 2025 | PR #106125 still Draft; more community discussion |
| Dec 2025 | NoctemCat demonstrates cross-WASM-module passing is possible but thread support is extremely difficult |
| Jan 2026 | Godot 4.6 ships LibGodot; community explores new WASM approach |
| Jan 28, 2026 | zorbathut reports partial LibGodot WASM attempt; thygrrr plans to continue |
| Feb 28, 2026 | Last comment (community, minor) |

---

## Notes

- This is one of the most-demanded missing features in Godot 4 for C# users, especially those who participate in game jams (which heavily favor web builds on itch.io)
- The godot-rust ecosystem already has experimental web export support ([gdext#493](https://github.com/godot-rust/gdext/pull/493))
- The Godot priorities page lists `.NET` support at https://godotengine.org/priorities/#dotnet
- The new GDExtension-based .NET binding (raulsntos/godot-dotnet) has the **same fundamental limitation** — it uses the same hosting API approach, so if GodotSharp can't do WASM, neither can the new binding
