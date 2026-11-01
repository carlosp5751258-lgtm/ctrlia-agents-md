# AGENTS.md vs CLAUDE.md en Claude Code

[Read in English](README.en.md)

Desde la 2.1.277 Claude Code lee `AGENTS.md` cuando el proyecto no tiene `CLAUDE.md`. Pero si hay un `CLAUDE.md` o un `CLAUDE.local.md` en tu carpeta o por encima, lo ignora sin avisar. Este repo trae la configuración más robusta para usar un solo archivo con todas tus IAs (Claude Code, Codex, Cursor…) y una prueba para comprobarlo en tu equipo.

La referencia completa (qué lee en cada caso, los cuatro valores de Project instructions, subcarpetas, migrar desde Codex o Cursor) está en:

- Español: https://ctrlia.dev/recetas/agents-md.html
- English: https://ctrlia.dev/en/recetas/agents-md.html

## Qué incluye

| Archivo | Para qué |
| --- | --- |
| `plantilla/AGENTS.md` | Plantilla de la fuente de verdad para todos los agentes: comandos, convenciones, estructura |
| `plantilla/CLAUDE.md` | Importa `@AGENTS.md` y añade debajo lo propio de Claude Code |
| `settings-instrucciones.json` | Project instructions en `claude-md-and-agents-md` (leer siempre ambos). Solo funciona en `~/.claude/settings.json`, `--settings` o la configuración gestionada |
| `prueba-agents.sh` | Repite la prueba MANZANA / NINGUNA en una carpeta temporal (3 llamadas a `claude -p` con Haiku) |

## Cómo usarlo

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-agents-md.git
# En la raíz de tu proyecto (sin sobrescribir lo que ya tengas):
cp -n ctrlia-agents-md/plantilla/AGENTS.md ctrlia-agents-md/plantilla/CLAUDE.md .
```

Rellena `AGENTS.md` con tus comandos y convenciones, y deja en `CLAUDE.md` solo lo específico de Claude. En la siguiente sesión, comprueba con `/memory` o `/context` («Memory files») que se cargaron.

Para comprobar el comportamiento en tu versión (gasta un poco de tu plan):

```bash
./ctrlia-agents-md/prueba-agents.sh
# OK   1) solo AGENTS.md → MANZANA
# OK   2) AGENTS.md + CLAUDE.local.md → NINGUNA
# OK   3) CLAUDE.md con @AGENTS.md → MANZANA
```

## Qué se probó

Con Claude Code **2.1.316** en Linux, `claude -p --model haiku` dio MANZANA, NINGUNA y MANZANA en los tres casos. El script `prueba-agents.sh` se comprobó con `bash -n` y ejecutándolo con un `claude` simulado; `settings-instrucciones.json` es JSON válido, pero el panel `/config` > Project instructions no se probó (sale de la doc oficial).

## Licencia

MIT. Ver [LICENSE](LICENSE).

---
Parte de **[Ctrl+IA](https://ctrlia.dev/)**: programa con Claude Code como un pro, en español. Hecho por Carlos P.
