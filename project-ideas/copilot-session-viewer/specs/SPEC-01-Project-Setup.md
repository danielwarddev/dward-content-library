# Spec 1: Project Setup & Architecture

**Status**: 📋 Not Started

---

## User Story

**As a developer**, I want a scaffolded TypeScript web project with dev tooling so that I can start building the session viewer on a solid foundation.

## Description

Initialize the Copilot Session Viewer as a standalone Vite + TypeScript project. This spec covers the project skeleton, build configuration, CSS theme foundation (dark mode with CSS custom properties ported from the prototype), basic HTML shell, and dev/test tooling. No functional features — just the frame everything else builds on.

## Acceptance Criteria

### Project Initialization

- [ ] A `session-viewer/` directory exists at the repo root with a valid `package.json`
- [ ] `npm install` completes without errors
- [ ] `npm run dev` starts a Vite dev server that serves `index.html`
- [ ] `npm run build` produces a production bundle in `dist/`
- [ ] TypeScript strict mode is enabled in `tsconfig.json`

### HTML Shell

- [ ] `index.html` contains a minimal layout: header area, main content area, and a file-input/upload zone
- [ ] The page renders with the dark theme by default

### CSS Theme

- [ ] CSS custom properties are defined for the color palette (background, surface, text, accent, borders) matching the prototype's dark theme
- [ ] A base stylesheet provides typography, spacing, and layout primitives
- [ ] The upload/drop zone is styled and visible on page load

### Dev Tooling

- [ ] Vitest is configured and `npm test` runs successfully (even with zero tests)
- [ ] A sample test file exists to validate the test runner works
- [ ] ESLint is configured for TypeScript with sensible defaults

### Source Structure

- [ ] The `src/` directory contains placeholder modules matching the planned architecture: `models/`, `parsing/`, `tree/`, `rendering/`, `search/`, `utils/`
- [ ] Each placeholder module has an empty barrel export (`index.ts`) so imports resolve

## Out of Scope

- Log parsing logic (SPEC-02)
- Any rendering of session data (SPEC-03+)
- File reading/upload functionality beyond the styled drop zone shell (SPEC-03)
- Server-side components — this is a fully client-side app

## Technical Notes

- Use Vite's vanilla-ts template as the starting point: `npm create vite@latest session-viewer -- --template vanilla-ts`
- Port CSS custom properties from `log-viewer.html` lines 14–55 (`:root` block)
- The prototype's color scheme: `#1e1e2e` background, `#2a2a3e` surface, `#e0e0e0` text, `#7aa2f7` accent
- Keep the HTML shell simple — a `<div id="app">` root with the upload zone and an empty `<div id="session-content">` for later rendering

## Definition of Done

- [ ] All acceptance criteria are met
- [ ] `npm install && npm run build` succeeds cleanly
- [ ] `npm test` runs the sample test and passes
- [ ] Dev server shows the dark-themed page with upload zone
- [ ] No TypeScript or ESLint errors
