---
name: loop-run
description: Implement repository changes through a persistent executor and independent code reviewer, then require a separate final audit before completion. Use for execution from an optional plan or brief when iterative review, revision, testing, and a saved execution report are required.
---

# Loop Run

Implement the requested change, secure independent approval, and save one final execution report.

## Establish the contract

1. Treat the user's latest request as authoritative. Preserve its language in user-facing questions, updates, the report, and the handoff unless the user asks for another language.
2. Accept an optional plan path. Read that plan as immutable input; never edit, replace, move, or annotate it. Fail explicitly if a supplied path cannot be read. When no plan is supplied, use the latest request as the implementation brief.
3. Verify that `spawn_agent`, `followup_task`, and `wait_agent` are available. Stop and identify any missing tool; never simulate independent execution or review.
4. Ground the work in the codebase. Read applicable instructions, repository status, structure, relevant source and tests, configuration, dependency declarations, and the supplied plan when present. Trace affected interfaces and call sites. Preserve unrelated user changes and identify overlap before editing.
5. Define acceptance conditions, authorized scope, likely tests, manual checks, and material risks. Ask only for decisions that would materially change the result or require new authority.

## Create the persistent pair

Create exactly two subagents for the entire workflow:

- Spawn exactly one executor agent. Give it the complete brief, grounded evidence, constraints, and supplied plan. Authorize only this agent to edit implementation files. Require scoped changes, preservation of unrelated work, relevant automated checks, and an accurate change/test summary.
- Spawn exactly one code-reviewer agent. Keep it read-only. Require it to inspect the actual diff and relevant code and test evidence independently. Forbid it from editing, delegating, or treating the executor's claims as proof.

Store both identifiers and reuse them with `followup_task` and `wait_agent`. Never spawn replacement, helper, audit, or per-round agents. Require approval from the persistent reviewer; never accept executor self-approval or orchestrator self-review.

## Implement and review

1. Send the executor the implementation packet and wait with `wait_agent` for completion.
2. Inspect the working state read-only, then send the reviewer the latest request, immutable plan when present, acceptance conditions, actual diff, relevant source context, and test evidence. Wait for its review.
3. Require every normal review to use this structure:

   ```text
   VERDICT: APPROVE | REVISE
   SUMMARY: <short assessment>
   BLOCKING_FINDINGS:
   - <severity, path or symbol, evidence, and impact; or "None">
   REQUIRED_CHANGES:
   - <specific correction, or "None">
   TEST_GAPS:
   - <missing validation, or "None">
   ```

4. Treat only an exact `VERDICT: APPROVE` as normal approval. Ask the same reviewer to restate malformed or ambiguous output.
5. On `REVISE`, send the full review to the same executor with `followup_task`. Require the executor to update the code and tests, report what changed, and preserve unrelated edits. Wait, then return the new diff and evidence to the same reviewer.

## Require a separate final audit

After every normal approval, send a new, separate `followup_task` to the same reviewer. Do not infer audit success from the normal review. Require fresh inspection and this structure:

```text
AUDIT: PASS | FAIL
SECURITY: <finding or "No material issue found">
MAINTAINABILITY: <finding or "No material issue found">
DUPLICATION: <finding or "No material issue found">
TEST_GAPS: <finding or "No material issue found">
MANUAL_CHECKS: <performed, still required, or not applicable with reason>
REQUIRED_CHANGES:
- <specific correction, or "None">
```

Accept completion only on an exact `AUDIT: PASS` with all five audit areas addressed and no required change. On `FAIL`, send the complete audit to the same executor, wait for corrections and validation, run another normal review with the same reviewer, and require another separate audit after approval.

Count each valid normal `REVISE` and each valid audit `FAIL` as one unsuccessful review outcome. After every block of ten unsuccessful outcomes, pause and ask the user to choose between continuing for another ten-outcome block or stopping with the current state as best-effort. Reuse the same agents if the user continues. If the user chooses best-effort, retain all known findings and label completion unapproved. If the user has not chosen, do not continue and do not save a report.

## Save the final report

Save exactly one execution report after an audit pass or an explicit best-effort choice.

1. Create `reports/` only when ready to save.
2. Name the file `reports/YYYYMMDDTHHMMSSZ-<slug>.md`, using the current UTC time and a short lowercase hyphenated slug.
3. Record the outcome (`approved` or `best-effort/unapproved`), brief or plan path, implemented scope, changed files, automated checks and results, manual checks, normal-review result, audit result, and remaining risks or follow-ups.
4. Do not save intermediate reports, review transcripts, plan copies, or scratch artifacts.
5. Return the report path, outcome, concise change summary, validation results, and unresolved risks in the user's language.
