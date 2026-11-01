#!/usr/bin/env bash
# Comprueba cuándo lee Claude Code tu AGENTS.md y cuándo no (3 llamadas a claude -p con Haiku).
# Trabaja en una carpeta temporal nueva: no toca tu proyecto.
set -euo pipefail
command -v claude > /dev/null || { echo "Falta claude: instala Claude Code primero" >&2; exit 1; }
MODELO="${MODELO:-haiku}"
DIR="$(mktemp -d)"
trap 'rm -rf "$DIR"' EXIT
cd "$DIR"
git init -q
printf '# Reglas del proyecto\nLa palabra clave del proyecto es MANZANA.\n' > AGENTS.md
P="Responde solo con la palabra clave del proyecto según tus instrucciones de proyecto, o NINGUNA si no tienes."

preguntar() {  # $1 = caso, $2 = respuesta esperada
  local r
  r="$(claude -p --model "$MODELO" "$P" < /dev/null)"
  if [[ "$r" == *"$2"* ]]; then echo "OK   $1 → $r"; else echo "DIFERENTE  $1 → $r (esperaba $2)"; fi
}

preguntar "1) solo AGENTS.md" MANZANA
echo 'Prefiero respuestas cortas.' > CLAUDE.local.md
preguntar "2) AGENTS.md + CLAUDE.local.md" NINGUNA
rm CLAUDE.local.md
printf '@AGENTS.md\n\n## Claude Code\nUsa plan mode para cambios grandes.\n' > CLAUDE.md
preguntar "3) CLAUDE.md con @AGENTS.md" MANZANA
