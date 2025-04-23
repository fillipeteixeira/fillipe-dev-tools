#!/bin/bash
# 📅 Cria uma nota diária e o dev-log do projeto no Obsidian

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$VAULT_PATH" ] || [ -z "$PROJECT_PATH" ]; then
  echo "❌ VAULT_PATH ou PROJECT_PATH não definidos no .env."
  exit 1
fi

TEMPLATE_PATH="$VAULT_PATH/Templates/daily-note.md"
DAILY_PATH="$VAULT_PATH/Daily"
DEV_LOG_PATH="$VAULT_PATH/Logs/dev-log"
TODAY=$(date '+%Y-%m-%d')
PROJECT_NAME=$(basename "$PROJECT_PATH")

DAILY_NOTE="$DAILY_PATH/$TODAY.md"
DEV_LOG="$DEV_LOG_PATH/${TODAY}_${PROJECT_NAME}.md"

mkdir -p "$DAILY_PATH"
mkdir -p "$DEV_LOG_PATH"

# Substitui {{date}} e {{project}} no template
if [ -f "$DAILY_NOTE" ]; then
  echo "📝 Nota diária já existe: $DAILY_NOTE"
else
  sed "s/{{date}}/$TODAY/g; s/{{project}}/$PROJECT_NAME/g" "$TEMPLATE_PATH" > "$DAILY_NOTE"
  echo "✅ Nota diária criada: $DAILY_NOTE"
fi

# Cria o dev-log do projeto
if [ -f "$DEV_LOG" ]; then
  echo "📝 Dev log do projeto $PROJECT_NAME já existe: $DEV_LOG"
else
  echo "# Dev Log – $PROJECT_NAME – $TODAY" > "$DEV_LOG"
  echo "- Início do desenvolvimento." >> "$DEV_LOG"
  echo "✅ Dev log criado: $DEV_LOG"
fi