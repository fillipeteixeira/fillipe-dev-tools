# 🛠️ Fillipe Dev Tools

Scripts de automação e produtividade integrados ao Obsidian, Cursor IDE, Git, Jira e OpenAI GPT.

## 📦 Conteúdo

| Script                        | Descrição                                                 |
|------------------------------|-----------------------------------------------------------|
| `create_daily_note.sh`       | Cria nota diária no Obsidian a partir de um template      |
| `create_symlink_today.sh`    | Cria symlink do dev-log do dia no projeto                 |
| `summarize_git_log.sh`       | Usa GPT para resumir os últimos commits do Git            |
| `sync_obsidian.sh`           | Faz commit e push do vault do Obsidian                    |

---

## 🚀 Instalação

```bash
git clone https://github.com/seu-usuario/fillipe-dev-tools.git ~/fillipe-dev-tools
cd ~/fillipe-dev-tools
chmod +x *.sh
cp .env.example .env
```

Edite o `.env` e insira sua chave da OpenAI.

---

## 🧪 Dependências

- `curl`
- `jq`
- `git`
- Acesso ao GPT-3.5 via OpenAI API

---

## 🔐 .env

```env
OPENAI_API_KEY=sk-...
```

---

## 💡 Sugestão de uso com cron

```bash
# Cria nota diária todo dia às 08h
0 8 * * * /caminho/para/create_daily_note.sh

# Faz sync do vault às 19h
0 19 * * * /caminho/para/sync_obsidian.sh
```
# fillipe-dev-tools
