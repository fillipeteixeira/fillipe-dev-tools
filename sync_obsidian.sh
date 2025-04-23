#!/bin/bash
# Faz commit e push do vault do Obsidian

VAULT_PATH=~/Obsidian
cd "$VAULT_PATH"

git add .
git commit -m "🧠 Sync $(date '+%Y-%m-%d %H:%M')"
git push origin main
echo "🚀 Vault sincronizado com GitHub"
