#!/bin/bash
# 🔗 Cria um symlink do dev-log do dia dentro do projeto

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Verifica se variáveis estão definidas
if [ -z "$VAULT_PATH" ] || [ -z "$PROJECT_PATH" ]; then
  echo "❌ VAULT_PATH ou PROJECT_PATH não definidos no .env"
  exit 1
fi

TODAY=$(date '+%Y-%m-%d')

# Extrai o nome do projeto a partir do caminho
PROJECT_NAME=$(basename "$PROJECT_PATH")

VAULT_LOG_PATH="$VAULT_PATH/Logs/dev-log"
LINK_NAME="dev-log-$TODAY.md"
TARGET="$VAULT_LOG_PATH/${TODAY}_${PROJECT_NAME}.md"

# Verifica se diretório do projeto e o arquivo do log existem
if [ -d "$PROJECT_PATH" ] && [ -f "$TARGET" ]; then
  ln -sf "$TARGET" "$PROJECT_PATH/$LINK_NAME"
  echo "🔗 Symlink criado com sucesso: $PROJECT_PATH/$LINK_NAME"
else
  echo "⚠️ Projeto ou log não encontrado:"
  [ ! -d "$PROJECT_PATH" ] && echo "   - Diretório do projeto: $PROJECT_PATH não existe"
  [ ! -f "$TARGET" ] && echo "   - Log de hoje: $TARGET não existe"
fi
