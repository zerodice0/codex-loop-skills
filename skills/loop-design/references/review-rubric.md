# Pencil Design Approval Rubric

Apply this rubric to the rendered experience and the document structure. Use screenshots as the primary visual evidence and read-only Pencil queries to confirm node properties, content, and state coverage.

## Contents

- [Decision rule](#decision-rule)
- [Thirteen independent criteria](#thirteen-independent-criteria)
- [Required content audit](#required-content-audit)
- [Required review response](#required-review-response)

## Decision rule

Score every criterion independently with an integer from 0 to 10:

- `9–10`: Demonstrate release-ready quality with, at most, a negligible polish opportunity.
- `7–8`: Work well overall but retain a meaningful defect, inconsistency, or evidence gap.
- `4–6`: Communicate the idea but require substantial correction.
- `0–3`: Fail the intended task, omit essential work, or lack reviewable evidence.

Return `APPROVE` only when all 13 scores are at least 9, the content audit is complete, no required change remains, and exact user-mandated strings are preserved or any unavoidable conflict is declared. Do not use an average to compensate for a weak criterion.

## Thirteen independent criteria

### 1. Task success and audience fit

Verify that the design supports the intended audience, primary job, decisions, and completion path. Check that priorities follow the user's brief rather than a generic pattern.

### 2. Information structure and wayfinding

Verify that grouping, labels, navigation, and page relationships make location and next steps apparent. Check that users can predict where controls lead and recover their place.

### 3. Visual hierarchy and attention flow

Verify that size, weight, placement, contrast, and whitespace direct attention in the intended order. Check that primary content and actions dominate secondary material without visual competition.

### 4. Layout precision and spatial rhythm

Verify alignment, grid behavior, spacing intervals, density, edge treatment, and section balance. Check screenshots for accidental offsets, collisions, awkward voids, and inconsistent padding.

### 5. Typography and reading comfort

Verify type scale, line length, line height, weights, wrapping, truncation, and numeric presentation. Check that text remains readable and scannable at its intended size and context.

### 6. Color, contrast, and semantic signaling

Verify legibility and distinguishability across backgrounds and states. Check that color communicates meaning consistently and is not the sole carrier of critical information.

### 7. Component and interaction consistency

Verify that repeated controls share anatomy, states, naming, hit areas, and behavior. Check affordances for click, tap, typing, selection, dismissal, focus, and disabled conditions.

### 8. Flow efficiency and decision load

Verify that users can finish key flows with proportionate effort. Check for redundant steps, premature choices, hidden dependencies, distracting options, and unclear commitments.

### 9. Accessibility and inclusive use

Verify keyboard and focus implications, target sizes, reading order, text alternatives or accessible naming, zoom or text growth tolerance, non-color cues, motion sensitivity, and language that avoids exclusion or blame.

### 10. UX writing and product language

Verify that every visible string helps the intended user understand, decide, or act. Check voice, tone, grammar, naturalness, terminology, CTA specificity, brevity, and locale conventions through the required content audit below.

### 11. State behavior and recovery design

Verify that the experience represents relevant empty, loading, success, error, permission, confirmation, and recovery conditions. Check that each state explains what happened, protects user work, and offers a credible next step.

### 12. Adaptation and content resilience

Verify that layouts tolerate realistic long and short content, localization expansion, dynamic data, missing values, and relevant viewport or device changes. Check that reflow preserves hierarchy and operability.

### 13. Craft coherence and handoff readiness

Verify that the whole result feels intentional and internally coherent. Check reusable patterns, naming, node organization, visual finish, complete flow coverage, and sufficient evidence for implementation or stakeholder review.

## Required content audit

Audit every applicable item and return `PASS`, `FAIL`, or `N/A — <reason>` for each. Cite representative strings and locations without rewriting locked strings.

1. Confirm the intended audience and locale; flag unsupported assumptions or mixed locales.
2. Confirm one appropriate voice and tone across screens and states.
3. Confirm grammatical correctness, natural phrasing, punctuation, capitalization, and number or date formatting.
4. Confirm canonical product terms and consistent naming for the same object, status, or action.
5. Confirm action-specific CTAs that predict the immediate result; flag vague controls when context does not remove ambiguity.
6. Confirm concise copy without losing essential instructions, consequences, or reassurance.
7. Review empty, loading, success, error, permission, confirmation, and recovery copy whenever each state is relevant; require a useful next step and mark truly irrelevant states with reasons.
8. Confirm inclusive, respectful, accessible language that avoids unnecessary idiom, blame, stigma, and ability assumptions.
9. For Korean content, confirm spacing, particles, endings, punctuation, natural word order, and consistent honorific or speech level. Mark this item not applicable with a reason when Korean is absent.
10. Confirm that every exact user-mandated string remains unchanged. List conflicts with usability, accessibility, locale, layout, or product terminology rather than silently correcting them.

## Required review response

Return this structure:

```text
VERDICT: APPROVE | REVISE
SUMMARY: <short assessment>

SCORES:
1. Task success and audience fit — <0-10>: <evidence>
2. Information structure and wayfinding — <0-10>: <evidence>
3. Visual hierarchy and attention flow — <0-10>: <evidence>
4. Layout precision and spatial rhythm — <0-10>: <evidence>
5. Typography and reading comfort — <0-10>: <evidence>
6. Color, contrast, and semantic signaling — <0-10>: <evidence>
7. Component and interaction consistency — <0-10>: <evidence>
8. Flow efficiency and decision load — <0-10>: <evidence>
9. Accessibility and inclusive use — <0-10>: <evidence>
10. UX writing and product language — <0-10>: <evidence>
11. State behavior and recovery design — <0-10>: <evidence>
12. Adaptation and content resilience — <0-10>: <evidence>
13. Craft coherence and handoff readiness — <0-10>: <evidence>

CONTENT_AUDIT:
- Audience and locale — PASS | FAIL | N/A: <evidence or reason>
- Voice and tone — PASS | FAIL | N/A: <evidence or reason>
- Grammar and naturalness — PASS | FAIL | N/A: <evidence or reason>
- Canonical product terms — PASS | FAIL | N/A: <evidence or reason>
- Action-specific CTAs — PASS | FAIL | N/A: <evidence or reason>
- Concision — PASS | FAIL | N/A: <evidence or reason>
- State copy — PASS | FAIL | N/A: <evidence or reason>
- Inclusive and accessible language — PASS | FAIL | N/A: <evidence or reason>
- Korean language quality — PASS | FAIL | N/A: <evidence or reason>
- Exact mandated strings — PASS | FAIL | N/A: <evidence, conflict, or reason>

LOCKED_STRING_CONFLICTS:
- <string, location, and conflict; or "None">
BLOCKERS:
- <evidence and impact; or "None">
REQUIRED_CHANGES:
- <criterion number, location, and concrete correction; or "None">
MANUAL_CHECKS:
- <check still needed, or "None">
```
