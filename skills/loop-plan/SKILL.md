---
name: loop-plan
description: Build a repository-grounded implementation plan through a persistent planner and independent critic, revising until approval or a user-selected best-effort stop. Use for review-until-approved planning, iterative plan refinement, or requests that require a saved plan without implementation.
---

# Loop Plan

Produce a plan only. Keep the repository and project files read-only during grounding, drafting, review, and revision. Never implement the plan. Permit exactly one project mutation: save one final plan under `plans/` only after critic approval or an explicit user choice to keep the current best-effort draft.

## Establish the contract

1. Treat the user's latest request as authoritative. Preserve its language in user-facing questions, updates, the saved plan, and the handoff unless the user asks for another language.
2. Identify the requested outcome, constraints, exclusions, acceptance evidence, and unresolved decisions.
3. Verify that `spawn_agent`, `followup_task`, and `wait_agent` are available. Stop and state which tool is unavailable if any is missing; never simulate a second agent or substitute self-review.
4. Perform a read-only repository grounding pass. Read applicable instruction files, repository status, structure, relevant documentation, source, tests, configuration, and dependency declarations. Trace the affected behavior far enough to cite concrete paths and symbols. Do not edit files, install dependencies, run formatters, or invoke commands that can write caches or generated output.
5. Record important facts, assumptions, risks, and evidence gaps for the agents. Mark inference as inference.

## Create the persistent pair

Create exactly two subagents for the entire workflow:

- Spawn exactly one planner agent. Instruct it to draft and revise an implementation plan from the latest request and repository evidence. Require ordered steps, concrete paths or symbols, dependencies, edge cases, tests, validation, rollback considerations when relevant, assumptions, and open questions. Forbid implementation and repository mutation.
- Spawn exactly one critic agent. Instruct it to remain read-only, independently test the plan against the latest request and grounded evidence, and withhold approval when any material correctness, completeness, sequencing, feasibility, risk, or verification issue remains.

Store both returned agent identifiers. Reuse only those identifiers with `followup_task`; never spawn replacement, helper, or per-round agents. Keep planner and critic roles separate. Do not accept the planner's self-approval or the orchestrator's approval as a substitute for critic approval.

## Iterate to a verdict

1. Send the planner the complete brief and grounding packet. Wait with `wait_agent` until it returns a draft.
2. Send the critic the latest draft, latest user request, constraints, and relevant repository evidence. Do not paraphrase away material details. Wait for the review.
3. Require the critic to return this structure:

   ```text
   VERDICT: APPROVE | REVISE
   SUMMARY: <short assessment>
   BLOCKING_FINDINGS:
   - <finding with evidence and impact, or "None">
   REQUIRED_CHANGES:
   - <specific correction, or "None">
   EVIDENCE_GAPS:
   - <missing verification, or "None">
   ```

4. Treat only an exact `VERDICT: APPROVE` from the persistent critic as approval. Reject malformed, conditional, or ambiguous verdicts and ask that critic to restate the review in the required structure.
5. On `REVISE`, send the full review and any newly discovered evidence or user direction to the same planner with `followup_task`. Wait for the revision, then send it to the same critic. Preserve satisfied details while correcting the findings.
6. Count each valid `REVISE` verdict as one unsuccessful review. After every block of five unsuccessful reviews, pause before another revision and ask the user to choose between:
   - Continue for another five-review block.
   - Save the current draft as best-effort.
7. If the user continues, resume with the same two agents and existing context. If the user chooses best-effort, retain all unresolved findings and label the result unapproved. If the user has not chosen, do not save anything and do not continue.

## Save the final artifact

Save exactly one plan only after critic approval or an explicit user choice to keep the current best-effort draft.

1. Create `plans/` only when ready to save.
2. Name the file `plans/YYYYMMDDTHHMMSSZ-<slug>.md`, using the current UTC time and a short lowercase hyphenated slug derived from the request.
3. Include the outcome (`approved` or `best-effort/unapproved`), the final plan, grounded paths and symbols, validation strategy, assumptions, decisions, and any unresolved critic findings.
4. Do not save drafts, review transcripts, scratch notes, or implementation changes.
5. Return the saved path, outcome, review count, and unresolved risks in the user's language.
