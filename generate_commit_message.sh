#!/bin/bash
# Gera sugestão de mensagem de commit com GPT baseada nos arquivos staged (robusto)

# Carrega variáveis do .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$OPENAI_API_KEY" ]; then
  echo "❌ OPENAI_API_KEY não definida. Verifique seu .env."
  exit 1
fi

FILES=$(git diff --cached --name-only)

if [ -z "$FILES" ]; then
  echo "⚠️ Nenhum arquivo adicionado com git add. Adicione arquivos primeiro."
  exit 1
fi

PROMPT="Com base nos arquivos modificados abaixo, gere uma mensagem de commit no estilo Conventional Commits (feat, fix, chore, refactor), com escopo opcional e uma descrição curta e clara. Arquivos:\n\n$FILES"

# Monta JSON de forma segura com jq
JSON=$(jq -n --arg prompt "$PROMPT" '{
  model: "gpt-3.5-turbo",
  messages: [
    { "role": "user", "content": $prompt }
  ],
  temperature: 0.5
}')

RESPONSE=$(curl https://api.openai.com/v1/chat/completions \
  -s -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d "$JSON")

echo "💬 Resposta bruta da API:"
echo "$RESPONSE"

# Extrai mensagem
MESSAGE=$(echo "$RESPONSE" | jq -r '.choices[0].message.content')

if [ "$MESSAGE" = "null" ] || [ -z "$MESSAGE" ]; then
  echo "❌ Erro ao obter mensagem. Verifique a resposta da OpenAI."
  exit 1
fi

echo -e "\n✅ Sugestão de commit:"
echo "$MESSAGE"
