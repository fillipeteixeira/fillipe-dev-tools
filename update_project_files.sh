#!/bin/bash
# 🔄 Atualiza os campos "Última alteração" e "Dev Logs Recentes" nos arquivos da pasta Projects/

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$VAULT_PATH" ]; then
  echo "❌ VAULT_PATH não definido no .env."
  exit 1
fi

PROJECTS_DIR="$VAULT_PATH/Projects"
DEV_LOG_DIR="$VAULT_PATH/Logs/dev-log"

for file in "$PROJECTS_DIR"/*.md; do
  PROJECT_NAME=$(basename "$file" .md)

  # Pega os dois últimos logs
  LOGS=($(ls "$DEV_LOG_DIR" | grep "_$PROJECT_NAME.md" | sort -r))
  LAST_LOG=${LOGS[0]}
  SECOND_LOG=${LOGS[1]}

  if [ -z "$LAST_LOG" ]; then
    echo "⚠️ Nenhum log encontrado para $PROJECT_NAME"
    continue
  fi

  # Monta nova linha de última alteração
  ULTIMA_ALTERACAO_LINE="- Última alteração: [[Logs/dev-log/${LAST_LOG%.md}]]"

  # Atualiza a linha de "Última alteração" na seção de status
  awk -v nova="$ULTIMA_ALTERACAO_LINE" '
    BEGIN { status=0 }
    {
      if ($0 ~ /^## 📌 Status/) {
        print
        status=1
        next
      }
      if (status == 1 && $0 ~ /^- Última alteração:/) {
        print nova
        status=2
        next
      }
      print
    }' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"

  # Atualiza a seção "Dev Logs Recentes"
  awk -v l1="[[Logs/dev-log/${LAST_LOG%.md}]]" -v l2="[[Logs/dev-log/${SECOND_LOG%.md}]]" '
    BEGIN { section_found=0 }
    {
      if ($0 ~ /^## 🔄 Dev Logs Recentes/) {
        print
        print "- " l1
        if (l2 != "[[Logs/dev-log/]]") print "- " l2
        section_found=1
        # Skip old entries
        getline; while ($0 ~ /^- \[\[Logs\/dev-log\/.*\]\]/) getline;
      }
      if (!section_found || $0 !~ /^- \[\[Logs\/dev-log\/.*\]\]/) print
    }' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"

  echo "✅ Atualizado: $file"
done
