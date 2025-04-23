#!/bin/bash
# 🔗 Cria symlinks dos dev-logs do dia dentro de múltiplos projetos definidos em ACTIVE_PROJECTS

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
VAULT_LOG_PATH="$VAULT_PATH/Logs/dev-log"

IFS=',' read -ra PROJECTS <<< "$ACTIVE_PROJECTS"

for PROJECT_NAME in "${PROJECTS[@]}"; do
  PROJECT_PATH="../$PROJECT_NAME"
  LINK_NAME="dev-log-$TODAY.md"
  TARGET="$VAULT_LOG_PATH/${TODAY}_${PROJECT_NAME}.md"

  echo "🔗 Processando $PROJECT_NAME..."

  if [ -d "$PROJECT_PATH" ] && [ -f "$TARGET" ]; then
    ln -sf "$TARGET" "$PROJECT_PATH/$LINK_NAME"
    echo "✅ Symlink criado: $PROJECT_PATH/$LINK_NAME"
  else
    echo "⚠️ Projeto ou log não encontrado:"
    [ ! -d "$PROJECT_PATH" ] && echo "   - Diretório do projeto: $PROJECT_PATH não existe"
    [ ! -f "$TARGET" ] && echo "   - Log de hoje: $TARGET não existe"
  fi
done
