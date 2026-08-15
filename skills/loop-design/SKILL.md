---
name: loop-design
description: Refine the active Pencil document through a persistent designer and independent read-only reviewer until visual and UX-writing quality gates pass. Use for iterative Pencil UI, screen, dashboard, form, landing-page, wireframe, mobile-layout, or web-app design with scored approval.
---

# Loop Design

Refine the active Pencil document until every design and content criterion earns at least 9/10 and the independent reviewer approves.

## Prepare the review contract

1. Read [references/review-rubric.md](references/review-rubric.md) completely before creating agents or changing the document.
2. Verify that `spawn_agent`, `followup_task`, and `wait_agent` are available. Verify that Pencil provides `get_app_state`, `execute`, screenshot capture, and read-only document queries. Stop and name any unavailable capability; never simulate a separate reviewer or an approval.
3. Before any design work, call Pencil `get_app_state` with both schema and design flags enabled. Confirm the active document, selected context, document schema, existing design system, relevant screens, and editable scope. Stop explicitly if no active Pencil document is available.
4. Treat the user's latest request as authoritative. Preserve its language in user-facing questions, updates, and the handoff unless the user requests another language.
5. Build a locked-string register from every exact user-mandated string. Preserve each string byte-for-byte. When a locked string conflicts with clarity, accessibility, locale, layout, or consistency, report the conflict instead of silently rewriting it.
6. Identify audience, locale, product terminology, target tasks, required states, constraints, and acceptance evidence. Mark unknown facts and assumptions.

## Create the persistent pair

Create exactly two subagents for the entire workflow:

- Spawn exactly one designer agent. Give it the brief, active-document state, schema, design context, locked strings, and rubric. Authorize only this agent to mutate the Pencil document, and only through Pencil `execute`. Require it to inspect before editing, make coherent changes, and report affected screens or nodes plus unresolved constraints.
- Spawn exactly one reviewer agent. Keep it strictly read-only. Require fresh screenshots and read-only Pencil queries for every review. Forbid Pencil `execute`, document mutation, delegation, and approval based only on the designer's summary.

Store both identifiers. Reuse only those identifiers with `followup_task` and `wait_agent`; never spawn replacement, helper, or per-round agents. Do not mutate the document from the orchestrator or reviewer. Do not accept designer self-approval or orchestrator self-review.

## Iterate without lowering the bar

1. Send the designer the complete design packet. Wait with `wait_agent` for its first pass.
2. Ask the same reviewer to capture current screenshots, inspect relevant nodes with read-only queries, and apply the complete rubric. Wait for its response.
3. Require the reviewer to return the exact sections defined in the rubric, including:
   - `VERDICT: APPROVE` or `VERDICT: REVISE`.
   - One integer score from 0 through 10 for each of all 13 criteria.
   - Evidence for each score and specific corrections for every score below 9.
   - The complete content audit, including explicit not-applicable rationales.
   - Locked-string conflicts, blockers, and required changes.
4. Accept approval only when the persistent reviewer returns `VERDICT: APPROVE`, all 13 scores are at least 9/10, the content audit is complete, no blocking change remains, and locked strings are preserved or their conflicts are explicitly reported. Treat any inconsistent, conditional, or malformed approval as `REVISE` and ask the same reviewer to restate it.
5. On `REVISE`, send the full review, screenshots or node evidence, and current locked-string register to the same designer with `followup_task`. Wait for Pencil `execute` changes, then request a fresh review from the same reviewer. Preserve already-successful details while fixing weak areas.
6. Continue without an arbitrary round cap. Never average scores, waive a criterion, lower the 9/10 threshold, or replace the reviewer to obtain approval.
7. Surface a hard blocker as soon as it prevents safe progress. If the same blocker persists across three consecutive review cycles or revisions stop producing material progress, summarize the evidence, impact, attempted remedies, and decision needed for the user. Pause only when user input or an external state change is genuinely required; otherwise continue with the same agents.

## Complete the handoff

After approval, report the approved screens or flows, review rounds, all 13 final scores, content-audit outcome, manual checks still needed, and any declared locked-string conflicts. Keep the report in the user's language. Do not claim approval without the persistent reviewer's qualifying verdict.
