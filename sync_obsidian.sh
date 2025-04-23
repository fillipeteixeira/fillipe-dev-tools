#!/bin/bash
# 🚀 Sincroniza o vault do Obsidian com GitHub (usando caminho relativo)

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$VAULT_PATH" ]; then
  echo "❌ VAULT_PATH não definido. Verifique seu .env."
  exit 1
fi

# Verifica se há alterações
if git diff --quiet && git diff --cached --quiet; then
  echo "✅ Nada para sincronizar. Seu vault está atualizado."
  exit 0
fi

# Adiciona, comita e envia
git add .
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
git commit -m "🧠 Sync $TIMESTAMP"

if git push origin main; then
  echo "🚀 Vault sincronizado com sucesso!"
else
  echo "⚠️ Falha ao enviar para o GitHub. Verifique conflitos ou necessidade de pull."
fi
