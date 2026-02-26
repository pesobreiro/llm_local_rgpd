# 🤝 Guia de Contribuição

Obrigado pelo teu interesse em contribuir para o projeto **LLM Local RGPD**! 

Este documento fornece as diretrizes para contribuir de forma eficaz.

---

## 📋 Índice

- [Código de Conduta](#código-de-conduta)
- [Como Contribuir](#como-contribuir)
- [Reportar Problemas](#reportar-problemas)
- [Sugerir Funcionalidades](#sugerir-funcionalidades)
- [Pull Requests](#pull-requests)
- [Desenvolvimento Local](#desenvolvimento-local)
- [Contacto](#contacto)

---

## 📜 Código de Conduta

Este projeto segue princípios de respeito mútuo, inclusão e colaboração construtiva. 
Espera-se que todos os participantes:

- Sejam respeitosos e profissionais
- Aceitem críticas construtivas
- Foquem-se no que é melhor para a comunidade
- Mostem empatia com outros membros

---

## 🚀 Como Contribuir

Existem várias formas de contribuir:

### 1. Partilhar Experiência
- Usa o [GitHub Discussions](https://github.com/pesobreiro/llm_local_rgpd/discussions) para partilhar:
  - Casos de uso implementados
  - Configurações otimizadas para diferentes hardwares
  - Lições aprendidas em auditorias RGPD
  - Boas práticas de conformidade

### 2. Reportar Bugs
- Usa o [GitHub Issues](https://github.com/pesobreiro/llm_local_rgpd/issues)
- Verifica primeiro se o problema já foi reportado
- Inclui o máximo de detalhe possível

### 3. Sugerir Funcionalidades
- Abre uma discussão primeiro para validar a ideia
- Depois cria uma Issue detalhada

### 4. Contribuir com Código
- Faz fork do repositório
- Cria um branch para a tua feature
- Submete um Pull Request

---

## 🐛 Reportar Problemas

Ao reportar um problema, inclui:

```markdown
**Descrição do problema**
Descrição clara do que está a acontecer.

**Ambiente**
- Sistema operativo: [ex: Ubuntu 24.04]
- GPU: [ex: RTX 2060 6GB]
- RAM: [ex: 32GB]
- Versão do Ollama: [ex: 0.5.7]
- Modelo usado: [ex: llama3.2:8b]

**Passos para reproduzir**
1. Comando executado: '...'
2. Erro obtido: '...'

**Comportamento esperado**
O que esperavas que acontecesse.

**Logs**
```
[Colar logs relevantes aqui]
```
```

---

## 💡 Sugerir Funcionalidades

Para sugerir novas funcionalidades:

1. **Discussão primeiro**: Abre uma discussão na categoria "Ideas"
2. **Descreve o contexto**: Qual o problema que isto resolve?
3. **Propõe solução**: Como implementarias?
4. **Considera impacto**: Afeta conformidade RGPD? Performance?

---

## 🔄 Pull Requests

### Processo

1. **Fork** o repositório
2. **Cria um branch** descritivo:
   ```bash
   git checkout -b feature/nome-da-feature
   # ou
   git checkout -b fix/descrição-do-bug
   ```
3. **Faz commit** com mensagens claras:
   ```bash
   git commit -m "feat: adicionar suporte para modelo X"
   git commit -m "fix: corrigir erro de VRAM no script"
   git commit -m "docs: atualizar guia de instalação"
   ```
4. **Push** para o teu fork:
   ```bash
   git push origin feature/nome-da-feature
   ```
5. **Abre um Pull Request** com descrição detalhada

### Convenções de Commit

Seguimos uma convenção simples de commits:

| Prefixo | Uso |
|---------|-----|
| `feat:` | Nova funcionalidade |
| `fix:` | Correção de bug |
| `docs:` | Alteração à documentação |
| `config:` | Alteração a configurações |
| `refactor:` | Refatoração de código |
| `test:` | Adicionar ou corrigir testes |

### Checklist de Pull Request

- [ ] Código testado localmente
- [ ] Documentação atualizada (se necessário)
- [ ] Sem dados pessoais ou sensíveis
- [ ] Commits com mensagens claras
- [ ] Descrição do PR explica o "porquê" e o "quê"

---

## 💻 Desenvolvimento Local

### Setup

```bash
# Clonar o repositório
git clone https://github.com/pesobreiro/llm_local_rgpd.git
cd llm_local_rgpd

# Criar branch para desenvolvimento
git checkout -b feature/minha-feature

# Fazer alterações
# ...

# Testar scripts
shellcheck scripts/*.sh
bash scripts/benchmark.sh

# Commit
git add .
git commit -m "feat: descrição da alteração"
git push origin feature/minha-feature
```

### Estrutura de Diretórios

```
llm_local_rgpd/
├── configs/          # Ficheiros de configuração
├── docs/             # Documentação
├── scripts/          # Scripts de automação
├── templates/        # Templates RGPD
├── tests/            # Testes (a criar)
├── README.md
├── CONTRIBUTING.md   # Este ficheiro
└── LICENSE
```

---

## 📞 Contacto

Para questões sobre o projeto:

| Canal | Uso |
|-------|-----|
| [💬 Discussions](https://github.com/pesobreiro/llm_local_rgpd/discussions) | Dúvidas gerais, partilha de experiências |
| [🐛 Issues](https://github.com/pesobreiro/llm_local_rgpd/issues) | Reportar bugs, solicitar funcionalidades |
| [🔒 Security](https://github.com/pesobreiro/llm_local_rgpd/security/advisories) | Vulnerabilidades de segurança (privado) |

**Nota importante:** Este projeto não fornece aconselhamento jurídico. Questões específicas sobre interpretação do RGPD devem ser dirigidas a um Encarregado de Proteção de Dados (EPD) ou advogado especializado.

---

## 🏆 Reconhecimento

Contribuidores serão reconhecidos no README do projeto.

Obrigado por ajudares a tornar a IA mais segura e conforme! 🛡️
