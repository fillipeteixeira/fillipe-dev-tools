#!/bin/bash
# 📅 Cria uma nota diária no Obsidian a partir de um template, com substituição de {{date}}

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$VAULT_PATH" ]; then
  echo "❌ VAULT_PATH não definido. Verifique seu .env."
  exit 1
fi

TEMPLATE_PATH="$VAULT_PATH/Templates/daily-note.md"
DAILY_PATH="$VAULT_PATH/Daily"
TODAY=$(date '+%Y-%m-%d')
NOTE="$DAILY_PATH/$TODAY.md"

mkdir -p "$DAILY_PATH"

if [ -f "$NOTE" ]; then
  echo "📝 Nota de hoje já existe: $NOTE"
else
  # Substitui {{date}} pela data real e salva no arquivo final
  sed "s/{{date}}/$TODAY/g" "$TEMPLATE_PATH" > "$NOTE"
  echo "✅ Nota criada com data: $NOTE"
fi
