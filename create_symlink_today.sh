#!/bin/bash
# Cria um symlink do dev-log do dia dentro do projeto

TODAY=$(date '+%Y-%m-%d')
VAULT_LOG_PATH=~/Obsidian/Logs/dev-log
PROJECT_PATH=~/workspace/app-x
LINK_NAME="dev-log-$TODAY.md"
TARGET="$VAULT_LOG_PATH/${TODAY}_app-x.md"

if [ -d "$PROJECT_PATH" ] && [ -f "$TARGET" ]; then
  ln -sf "$TARGET" "$PROJECT_PATH/$LINK_NAME"
  echo "🔗 Symlink criado: $PROJECT_PATH/$LINK_NAME"
else
  echo "⚠️ Projeto ou log não encontrado. Nada feito."
fi
