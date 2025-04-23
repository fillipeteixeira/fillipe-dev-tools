#!/bin/bash
# Instalação e configuração inicial

echo "📦 Instalando Fillipe Dev Tools..."

chmod +x *.sh

if [ ! -f .env ]; then
  cp .env.example .env
  echo "✅ Arquivo .env criado a partir de .env.example"
else
  echo "⚠️ Arquivo .env já existe. Não foi sobrescrito."
fi

echo "✅ Scripts prontos para uso."
echo "📌 Verifique sua chave OpenAI no arquivo .env"
