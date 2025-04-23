#!/bin/bash
# 🚀 Sincroniza o vault do Obsidian com GitHub (usando caminho relativo)

VAULT_PATH="../fillipe-vault-starter"
cd "$VAULT_PATH" || { echo "❌ Caminho inválido: $VAULT_PATH"; exit 1; }

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
