#!/usr/bin/env bash
set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
codex_root="${CODEX_HOME:-${HOME}/.codex}"
target_root="${codex_root}/skills"

for skill_name in loop-plan loop-run loop-design; do
  source_dir="${repository_root}/skills/${skill_name}"
  target_dir="${target_root}/${skill_name}"

  if [[ ! -f "${source_dir}/SKILL.md" ]]; then
    printf 'Missing skill source: %s\n' "${source_dir}" >&2
    exit 1
  fi

  mkdir -p "${target_dir}"
  cp -R "${source_dir}/." "${target_dir}/"
  printf 'Installed %s -> %s\n' "${skill_name}" "${target_dir}"
done
