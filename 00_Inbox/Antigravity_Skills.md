
# Antigravity Skills for AI Studio – Markdown Version

This file was generated from the JSON summary provided in the conversation.

---

## Overview
Google Antigravity is an agentic development platform powered by Gemini 3 Pro. It uses modular skills to enable autonomous planning, coding, testing, and more.

---

## Skills
- Over 1700 skills in the repository.
- Organized as .md files with YAML frontmatter.
- Categorized by domains such as frontend, backend, security, devops, product, SaaS.

---

## Usage in Google AI Studio
- Copy skills into System Instructions.
- Supports multiple skills concatenated.
- Ideal combo: 3–5 skills.
- Scripts in skills are not executable in AI Studio.

---

## Usage in Antigravity
- Install skills in `.agent/skills/` (recommended) or globally.
- Antigravity auto-selects relevant skills using semantic search.
- Executes scripts and automates development.

---

## MVP Planning
The @brainstorming skill is ideal for MVP planning using Lean Startup logic.

---

## Multi-Agent Workflow
- C1: Architect — Product + Strategy + Structure
- C2: Engineer — Technical translation
- AG: Executor — Coding + Testing + Automation

---

## Token Efficiency
- Gemini 1.5 Pro supports 2M tokens, but optimal operation occurs at 200k–300k.

---

## Installation Recommendation
Use Workspace installation:
```
.agent/skills/
```

---

End of File.
