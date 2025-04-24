#!/bin/bash
# 🔗 Cria symlinks dos dev-logs e da nota diária dentro de múltiplos projetos definidos em ACTIVE_PROJECTS

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Verifica se variáveis estão definidas
if [ -z "$VAULT_PATH" ] || [ -z "$ACTIVE_PROJECTS" ]; then
  echo "❌ VAULT_PATH ou ACTIVE_PROJECTS não definidos no .env"
  exit 1
fi

TODAY=$(date '+%Y-%m-%d')
VAULT_LOG_BASE="$VAULT_PATH/Logs/dev-log"
DAILY_NOTE="$VAULT_PATH/Daily/$TODAY.md"

IFS=',' read -ra PROJECTS <<< "$ACTIVE_PROJECTS"

for PROJECT_NAME in "${PROJECTS[@]}"; do
  PROJECT_PATH="../$PROJECT_NAME"
  DEV_LOG_TARGET="$VAULT_LOG_BASE/$PROJECT_NAME/${TODAY}_${PROJECT_NAME}.md"
  DEV_LOG_LINK_NAME="dev-log-$TODAY.md"
  DAILY_LINK_NAME="daily-$TODAY.md"

  echo "🔗 Processando $PROJECT_NAME..."

  if [ -d "$PROJECT_PATH" ]; then
    # Link do dev-log
    if [ -f "$DEV_LOG_TARGET" ]; then
      ln -sf "$DEV_LOG_TARGET" "$PROJECT_PATH/$DEV_LOG_LINK_NAME"
      echo "✅ Symlink de dev-log criado: $PROJECT_PATH/$DEV_LOG_LINK_NAME"
    else
      echo "⚠️ Log de hoje não encontrado para $PROJECT_NAME: $DEV_LOG_TARGET"
    fi

    # Link da daily
    if [ -f "$DAILY_NOTE" ]; then
      ln -sf "$DAILY_NOTE" "$PROJECT_PATH/$DAILY_LINK_NAME"
      echo "✅ Symlink da nota diária criado: $PROJECT_PATH/$DAILY_LINK_NAME"
    else
      echo "⚠️ Nota diária não encontrada: $DAILY_NOTE"
    fi
  else
    echo "⚠️ Diretório do projeto não encontrado: $PROJECT_PATH"
  fi
done
