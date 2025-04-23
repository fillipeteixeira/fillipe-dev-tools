#!/bin/bash
# Cria uma nota diária com base no template

VAULT_PATH=~/Obsidian
TEMPLATE_PATH="$VAULT_PATH/Templates/daily-note.md"
DAILY_PATH="$VAULT_PATH/Daily"
TODAY=$(date '+%Y-%m-%d')
NOTE="$DAILY_PATH/$TODAY.md"

mkdir -p "$DAILY_PATH"

if [ -f "$NOTE" ]; then
  echo "📝 Nota de hoje já existe: $NOTE"
else
  cp "$TEMPLATE_PATH" "$NOTE"
  echo "✅ Nota criada: $NOTE"
fi
