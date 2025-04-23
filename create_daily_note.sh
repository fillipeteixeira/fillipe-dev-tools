#!/bin/bash
# 📅 Cria nota diária com tarefas + dev-logs separados por projeto com base em ACTIVE_PROJECTS

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Verifica variáveis obrigatórias
if [ -z "$VAULT_PATH" ] || [ -z "$ACTIVE_PROJECTS" ]; then
  echo "❌ VAULT_PATH ou ACTIVE_PROJECTS não definidos no .env."
  exit 1
fi

DAILY_PATH="$VAULT_PATH/Daily"
DEV_LOG_BASE="$VAULT_PATH/Logs/dev-log"
TODAY=$(date '+%Y-%m-%d')
DAILY_NOTE="$DAILY_PATH/$TODAY.md"

mkdir -p "$DAILY_PATH"

# Cria nota diária com seções padrão, se ainda não existir
if [ ! -f "$DAILY_NOTE" ]; then
  echo "# Diário – $TODAY" > "$DAILY_NOTE"
  echo -e "\n## 📌 Tarefas do Dia\n- [ ] " >> "$DAILY_NOTE"
  echo -e "\n## 📂 Dev Logs do Dia" >> "$DAILY_NOTE"
  echo "✅ Nota diária criada com seções: $DAILY_NOTE"
fi

IFS=',' read -ra PROJECTS <<< "$ACTIVE_PROJECTS"

for PROJECT_NAME in "${PROJECTS[@]}"; do
  DEV_LOG_PATH="$DEV_LOG_BASE/$PROJECT_NAME"
  DEV_LOG="$DEV_LOG_PATH/${TODAY}_${PROJECT_NAME}.md"

  echo "📁 Criando dev-log para $PROJECT_NAME"
  mkdir -p "$DEV_LOG_PATH"

  if [ -f "$DEV_LOG" ]; then
    echo "📝 Dev log já existe: $DEV_LOG"
  else
    echo "# Dev Log – $PROJECT_NAME – $TODAY" > "$DEV_LOG"
    echo "✅ Dev log criado: $DEV_LOG"
  fi

  # Adiciona link ao dev-log na nota diária se ainda não estiver presente
  LINK="[[Logs/dev-log/$PROJECT_NAME/${TODAY}_${PROJECT_NAME}]]"
  grep -qF "$LINK" "$DAILY_NOTE" || echo "- $LINK" >> "$DAILY_NOTE"
done
