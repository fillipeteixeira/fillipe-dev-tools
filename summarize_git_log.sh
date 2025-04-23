#!/bin/bash
# Resume os últimos 10 commits com OpenAI GPT

LOG=$(git log --pretty=format:"%h %s" -n 10)
API_KEY=$(cat ~/.openai_key)
RESPONSE=$(curl https://api.openai.com/v1/chat/completions \
  -s -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "Resuma esses commits:
'"$LOG"'"}]
  }' | jq -r '.choices[0].message.content')

echo "📋 Resumo dos últimos commits:"
echo "$RESPONSE"
