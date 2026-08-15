# Codex Loop Skills

Approval-gated Codex workflows for planning, implementation, and Pencil UI design.

## Skills

| Skill | Purpose |
| --- | --- |
| `loop-plan` | Build and review implementation plans until approval |
| `loop-run` | Execute approved work with iterative code review and a final audit |
| `loop-design` | Create and refine Pencil UI with UI/UX and UX Writing approval gates |

## Install

```bash
./scripts/install.sh
```

The installer copies all three skills into `${CODEX_HOME:-$HOME/.codex}/skills`. Start a new Codex session after updating installed skills.

## Source of truth

Edit skills under `skills/`, validate each skill with Codex's `skill-creator` validator, commit the changes, and then run the installer on each machine. Do not edit the installed copies under `~/.codex/skills` as the primary workflow.

## Provenance

The skill instructions in this repository are maintained from independently authored functional specifications. Do not copy text from private or internal implementations. When replacing behavior that may overlap with non-public material, use an isolated clean-room author and an independent reviewer.
