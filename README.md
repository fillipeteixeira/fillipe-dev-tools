# 🛠️ Fillipe Dev Tools

Conjunto de scripts de automação e produtividade pessoal integrados ao **Obsidian**, **Cursor IDE**, **Git**, **Jira** e **OpenAI GPT**, com foco em documentação de código, organização de tarefas e aprendizado contínuo.

---

## 📦 Funcionalidades

| Script                        | Descrição                                                                 |
|------------------------------|---------------------------------------------------------------------------|
| `install.sh`                 | Instala e prepara o ambiente, gera `.env` se não existir                  |
| `create_daily_note.sh`       | Cria uma nota diária no Obsidian com tarefas e dev-logs por projeto       |
| `create_symlink_today.sh`    | Cria symlinks no projeto para `dev-log` e `daily` do dia                  |
| `generate_commit_message.sh` | Gera sugestão de mensagem de commit com GPT, baseado nos arquivos staged |
| `summarize_git_log.sh`       | Resume os últimos commits do Git com GPT                                 |
| `sync_obsidian.sh`           | Faz commit e push do vault do Obsidian para GitHub                        |
| `update_project_files.sh`    | Atualiza campos "Última alteração" e "Dev Logs Recentes" nos projetos     |

---

## 🧠 Prompts para Cursor

| Prompt                                    | Uso                                                                                     |
|------------------------------------------|------------------------------------------------------------------------------------------|
| `cursor_prompt_dev_log_daily.md`         | Preenche `dev-log` do dia e atualiza tarefas na `daily` com base no que foi feito       |
| `cursor_prompt_reflexao.md`              | Gera seção de reflexão técnica + ajustes no final do `daily`, baseado no chat atual     |

---

## 🔄 Estrutura esperada no Obsidian

```
Obsidian/
├── Daily/
│   └── 2025-04-25.md
├── Logs/
│   └── dev-log/
│       ├── hummingbird/
│       │   └── 2025-04-25_hummingbird.md
│       └── duck/
│           └── 2025-04-25_duck.md
├── Projects/
│   └── hummingbird.md
└── Templates/
    └── daily-note.md
```

---

## 🔐 Exemplo de `.env`

```env
VAULT_PATH=../fillipe-vault-starter
ACTIVE_PROJECTS=hummingbird,duck
OPENAI_API_KEY=sk-...
```

---

## 🚀 Instalação

```bash
git clone https://github.com/seu-usuario/fillipe-dev-tools.git ~/fillipe-dev-tools
cd ~/fillipe-dev-tools
chmod +x *.sh
./install.sh
```

---

## 🧪 Dependências

- `git`
- `curl`
- `jq`
- `ln` (symlink)
- OpenAI API key (GPT-3.5 ou superior)

---

## 💡 Sugestão de uso com cron

```bash
# Cria nota diária todo dia às 08h
0 8 * * * /caminho/para/create_daily_note.sh

# Cria symlinks no projeto todo dia às 08h10
10 8 * * * /caminho/para/create_symlink_today.sh

# Faz sync do vault às 19h
0 19 * * * /caminho/para/sync_obsidian.sh
```

---

## 📘 Exemplo de fluxo diário

1. Execute `create_daily_note.sh`
2. Execute `create_symlink_today.sh`
3. Trabalhe normalmente com seu projeto e Obsidian
4. Use o **Cursor IDE** com os prompts fornecidos para:
   - Preencher dev-logs
   - Atualizar tarefas no `daily`
   - Gerar reflexões técnicas e sugestões de aprendizado
5. Ao final do dia, execute `sync_obsidian.sh`

---

## ✅ Organização, Clareza e Aprendizado contínuo

Este repositório é um sistema de produtividade técnica pessoal que prioriza:

- **Documentação viva** por projeto
- **Automação de rotinas**
- **Reflexões orientadas por IA**
- **Integração mínima e poderosa com ferramentas do dia a dia**

---

**Siga construindo e registrando. Seu conhecimento merece ser bem documentado.**
