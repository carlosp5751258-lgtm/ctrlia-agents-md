# AGENTS.md vs CLAUDE.md in Claude Code

[Leer en español](README.md) · The Spanish version is at the repo root and in [README.md](README.md); the English files are in `en/`.

Since 2.1.277 Claude Code reads `AGENTS.md` when the project has no `CLAUDE.md`. But if there's a `CLAUDE.md` or a `CLAUDE.local.md` in your folder or above, it ignores it without warning. This repo brings the most robust setup to use a single file with all your AI tools (Claude Code, Codex, Cursor…) and a test to check it on your machine.

The full reference (what it reads in each case, the four Project instructions values, subfolders, migrating from Codex or Cursor) is at:

- English: https://ctrlia.dev/en/recetas/agents-md.html
- Español: https://ctrlia.dev/recetas/agents-md.html

## What's included

| File | What for |
| --- | --- |
| `en/template/AGENTS.md` | Template for the source of truth for every agent: commands, conventions, structure |
| `en/template/CLAUDE.md` | Imports `@AGENTS.md` and adds Claude Code-specific content below |
| `en/settings-instructions.json` | Project instructions set to `claude-md-and-agents-md` (always read both). Only works in `~/.claude/settings.json`, `--settings` or managed settings |
| `en/test-agents.sh` | Repeats the APPLE / NONE test in a temp folder (3 `claude -p` calls with Haiku) |

## How to use it

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-agents-md.git
# At your project's root (without overwriting what you already have):
cp -n ctrlia-agents-md/en/template/AGENTS.md ctrlia-agents-md/en/template/CLAUDE.md .
```

Fill in `AGENTS.md` with your commands and conventions, and keep only Claude-specific things in `CLAUDE.md`. In the next session, check with `/memory` or `/context` ("Memory files") that they loaded.

To check the behavior on your version (uses a little of your plan):

```bash
./ctrlia-agents-md/en/test-agents.sh
# OK   1) AGENTS.md only → APPLE
# OK   2) AGENTS.md + CLAUDE.local.md → NONE
# OK   3) CLAUDE.md with @AGENTS.md → APPLE
```

## What was tested

With Claude Code **2.1.316** on Linux, `claude -p --model haiku` gave the expected keyword, "none" and the keyword in the three cases (Spanish version of the script). The English `en/test-agents.sh` was checked with `bash -n` and by running it against a mock `claude`; `en/settings-instructions.json` is valid JSON, but the `/config` > Project instructions panel wasn't tested (it comes from the official docs).

## License

MIT. See [LICENSE](LICENSE).

---
Part of **[Ctrl+IA](https://ctrlia.dev/)**: code with Claude Code like a pro. Made by Carlos P.
