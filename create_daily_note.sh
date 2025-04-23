#!/bin/bash
# 📅 Cria uma nota diária no Obsidian a partir de um template

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

# Cria a pasta Daily se não existir
mkdir -p "$DAILY_PATH"

# Verifica se a nota já existe
if [ -f "$NOTE" ]; then
  echo "📝 Nota de hoje já existe: $NOTE"
else
  cp "$TEMPLATE_PATH" "$NOTE"
  echo "✅ Nota criada: $NOTE"
fi
