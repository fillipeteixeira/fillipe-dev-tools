#!/bin/bash
# 📅 Cria notas diárias e dev-logs para múltiplos projetos com base em ACTIVE_PROJECTS

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Verificação das variáveis
if [ -z "$VAULT_PATH" ] || [ -z "$ACTIVE_PROJECTS" ]; then
  echo "❌ VAULT_PATH ou ACTIVE_PROJECTS não definidos no .env."
  exit 1
fi

TEMPLATE_PATH="$VAULT_PATH/Templates/daily-note.md"
DAILY_PATH="$VAULT_PATH/Daily"
DEV_LOG_PATH="$VAULT_PATH/Logs/dev-log"
TODAY=$(date '+%Y-%m-%d')

mkdir -p "$DAILY_PATH"
mkdir -p "$DEV_LOG_PATH"

IFS=',' read -ra PROJECTS <<< "$ACTIVE_PROJECTS"

for PROJECT_NAME in "${PROJECTS[@]}"; do
  PROJECT_PATH="../$PROJECT_NAME"
  DAILY_NOTE="$DAILY_PATH/${TODAY}_${PROJECT_NAME}.md"
  DEV_LOG="$DEV_LOG_PATH/${TODAY}_${PROJECT_NAME}.md"

  echo "📁 Criando arquivos para $PROJECT_NAME"

  # Criar a nota diária
  if [ -f "$DAILY_NOTE" ]; then
    echo "📝 Nota diária já existe: $DAILY_NOTE"
  else
    sed "s/{{date}}/$TODAY/g; s/{{project}}/$PROJECT_NAME/g" "$TEMPLATE_PATH" > "$DAILY_NOTE"
    echo "✅ Nota diária criada: $DAILY_NOTE"
  fi

  # Criar dev-log
  if [ -f "$DEV_LOG" ]; then
    echo "📝 Dev log já existe: $DEV_LOG"
  else
    echo "# Dev Log – $PROJECT_NAME – $TODAY" > "$DEV_LOG"
    echo "- Início do desenvolvimento." >> "$DEV_LOG"
    echo "✅ Dev log criado: $DEV_LOG"
  fi

done
