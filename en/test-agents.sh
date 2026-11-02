#!/usr/bin/env bash
# Checks when Claude Code reads your AGENTS.md and when it doesn't (3 claude -p calls with Haiku).
# Works in a fresh temp folder: it doesn't touch your project.
set -euo pipefail
command -v claude > /dev/null || { echo "claude not found: install Claude Code first" >&2; exit 1; }
MODEL="${MODEL:-haiku}"
DIR="$(mktemp -d)"
trap 'rm -rf "$DIR"' EXIT
cd "$DIR"
git init -q
printf '# Project rules\nThe project keyword is APPLE.\n' > AGENTS.md
P="Reply only with the project keyword according to your project instructions, or NONE if you have none."

ask() {  # $1 = case, $2 = expected answer
  local r
  r="$(claude -p --model "$MODEL" "$P" < /dev/null)"
  if [[ "$r" == *"$2"* ]]; then echo "OK   $1 → $r"; else echo "DIFFERENT  $1 → $r (expected $2)"; fi
}

ask "1) AGENTS.md only" APPLE
echo 'I prefer short answers.' > CLAUDE.local.md
ask "2) AGENTS.md + CLAUDE.local.md" NONE
rm CLAUDE.local.md
printf '@AGENTS.md\n\n## Claude Code\nUse plan mode for big changes.\n' > CLAUDE.md
ask "3) CLAUDE.md with @AGENTS.md" APPLE
