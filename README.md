# 🤖 LLM Local RGPD

> **Sistema de IA Local conforme RGPD para Consultadoria e Ensino Superior**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![RGPD Compliant](https://img.shields.io/badge/RGPD-Compliant-green.svg)](./docs/RGPD.md)
[![GPU: RTX 2060](https://img.shields.io/badge/GPU-RTX%202060%206GB-blue.svg)](./docs/hardware.md)

---

## 📋 Índice

- [Visão Geral](#-visão-geral)
- [Porquê Local?](#-porquê-local)
- [Hardware Suportado](#-hardware-suportado)
- [Instalação Rápida](#-instalação-rápida)
- [Modelos Aprovados](#-modelos-aprovados-rgpd)
- [Configurações](#-configurações)
- [Documentação RGPD](#-documentação-rgpd)
- [Uso](#-uso)

---

## 🎯 Visão Geral

Este projeto fornece um **sistema completo para execução local de Large Language Models (LLMs)** em conformidade com o Regulamento Geral de Proteção de Dados (RGPD/GDPR).

### Casos de Uso

- 📊 **Consultadoria empresarial** com dados sensíveis (M&A, due diligence)
- 🎓 **Ensino superior** com informação de alunos
- 🏥 **Setor da saúde** com dados clínicos
- 🏦 **Instituições financeiras** com dados bancários
- 🏛️ **Administração pública** com dados pessoais

### Princípios Fundamentais

```
🔒 Dados NUNCA saem do teu computador
🔒 Zero chamadas à API de terceiros  
🔒 Controlo total sobre o processamento
🔒 Conformidade total com RGPD/AI Act
```

---

## 🛡️ Porquê Local?

### Problema: LLMs na Cloud = Risco RGPD

| Aspecto | Cloud (OpenAI, Claude, etc.) | Local (Este Projeto) |
|---------|------------------------------|----------------------|
| **Dados** | Enviados para servidores externos | Ficam no teu disco |
| **Processamento** | Nos EUA ou outras jurisdições | No teu hardware |
| **Retenção** | Políticas opacas do fornecedor | Tu decides |
| **Auditoria** | Impossível verificar | Totalmente transparente |
| **Subcontratação** | Qualificada como "subcontratante" | Não aplica |
| **Consentimento** | Necessário informar destino | Simplificado |

### Fundamentação Jurídica

> **Artigo 28º do RGPD** - Tratamento por conta do responsável
> 
> Ao usar LLMs na cloud, o fornecedor qualifica-se como "subcontratante", exigindo:
> - Contrato de subcontratação formal
> - Avaliação de impacto à proteção de dados (AIPD)
> - Garantias de transferência internacional (CCT)
> 
> **Solução:** Processamento local elimina a figura de subcontratante.

---

## 💻 Hardware Suportado

### Configuração Mínima

```yaml
CPU: 4 cores (8 threads)
RAM: 16 GB
GPU: 4 GB VRAM (opcional mas recomendado)
Disco: 50 GB livres (SSD recomendado)
Sistema: Linux (Ubuntu 22.04+), macOS, Windows WSL2
```

### Configuração Recomendada

```yaml
CPU: 8+ cores (16+ threads)
RAM: 32 GB
GPU: 8+ GB VRAM (RTX 3060, RTX 4060, etc.)
Disco: 200 GB SSD NVMe
Sistema: Linux Ubuntu 24.04 LTS
```

### Hardware de Desenvolvimento

Este projeto foi testado e otimizado para:

```
MSI GL65 Leopard
├── CPU: Intel i7-10875H (8C/16T)
├── RAM: 32 GB DDR4
├── GPU: NVIDIA RTX 2060 Mobile (6GB VRAM)
├── Disco: NVMe 512GB
└── OS: Ubuntu 24.04 LTS
```

---

## ⚡ Instalação Rápida

```bash
# 1. Clonar o repositório
git clone https://github.com/[USER]/llm_local_rgpd.git
cd llm_local_rgpd

# 2. Executar script de instalação automatizada
chmod +x scripts/install.sh
./scripts/install.sh

# 3. Verificar instalação
ollama --version
nvidia-smi

# 4. Baixar modelos aprovados
ollama pull llama3.2:8b
ollama pull mistral:7b
ollama pull qwen2.5-coder:7b
```

📖 Ver [guia detalhado de instalação](./docs/instalacao.md)

---

## ✅ Modelos Aprovados RGPD

### Modelos Locais Recomendados (6GB VRAM)

| Modelo | Tamanho | Uso Ideal | Licença | VRAM |
|--------|---------|-----------|---------|------|
| **Llama 3.2 8B** | 8B params | Geral, apresentações | Llama 3.2 | ~5GB |
| **Mistral 7B** | 7B params | Análise, PT-PT excelente | Apache 2.0 | ~4.5GB |
| **Qwen 2.5 7B** | 7B params | Código, STEM | Apache 2.0 | ~4.5GB |
| **Gemma 2 9B** | 9B params | Pesquisa académica | Gemma | ~5.5GB |
| **Phi-4 14B** | 14B params | Raciocínio complexo | MIT | ~7GB* |

\* *Phi-4 14B requer CPU offload parcial com 6GB VRAM*

### Modelos com CPU Offload (32GB RAM necessários)

| Modelo | Tamanho | Uso | Estratégia |
|--------|---------|-----|------------|
| **Llama 3.3 70B** | 70B | Análise profunda | GPU: 6GB + RAM: 20GB |
| **Qwen 2.5 32B** | 32B | Especialista | GPU: 6GB + RAM: 15GB |
| **Mixtral 8x7B** | 47B | Tarefas diversas | GPU: 6GB + RAM: 25GB |

### ⚠️ Modelos a EVITAR (Cloud-only)

- ❌ GPT-4, GPT-3.5 (OpenAI) - Cloud obrigatória
- ❌ Claude (Anthropic) - Cloud obrigatória
- ❌ Gemini Pro (Google) - Cloud obrigatória
- ❌ Mistral Large 2 (123B) - Requer 62GB+ VRAM

---

## ⚙️ Configurações

### Otimizado para RTX 2060 6GB

Ver [`configs/rtx2060_6gb.conf`](./configs/rtx2060_6gb.conf)

```bash
# Copiar configuração otimizada
cp configs/rtx2060_6gb.conf ~/.ollama/config.toml

# Reiniciar serviço
sudo systemctl restart ollama
```

### Variáveis de Ambiente

```bash
# Adicionar ao ~/.bashrc ou ~/.zshrc

# Limitar VRAM usada (deixa margem para sistema)
export OLLAMA_GPU_OVERHEAD=512MB

# Número de requisições paralelas
export OLLAMA_NUM_PARALLEL=1

# Máximo de modelos carregados simultaneamente
export OLLAMA_MAX_LOADED_MODELS=1

# Visible CUDA devices
export CUDA_VISIBLE_DEVICES=0
```

---

## 📚 Documentação RGPD

### Guias Disponíveis

- [📖 Fundamentos RGPD + IA](./docs/RGPD.md)
- [🔒 Checklist de Conformidade](./docs/checklist_rgpd.md)
- [📋 Registo de Atividades de Tratamento (RAT)](./templates/rat_llm_local.md)
- [⚖️ Avaliação de Impacto à Proteção de Dados (AIPD)](./templates/aipd_template.md)
- [📝 Contrato de Subcontratação (para casos híbridos)](./templates/contrato_subcontratacao.md)

### Decisões RGPD Documentadas

```
┌─────────────────────────────────────────────────────────┐
│  DECISÃO: Uso de LLM Local vs Cloud                     │
├─────────────────────────────────────────────────────────┤
│  Data: 2025-02-26                                       │
│  Responsável: [Nome do Responsável pelo Tratamento]     │
│  Fundamentação:                                         │
│    ✓ Art. 28º RGPD - Não há subcontratação             │
│    ✓ Art. 32º RGPD - Medidas técnicas implementadas    │
│    ✓ Art. 25º RGPD - Privacy by Design                 │
│  Modelo escolhido: Processamento 100% local             │
└─────────────────────────────────────────────────────────┘
```

---

## 🚀 Uso

### Interface de Linha de Comandos

```bash
# Modo interativo
ollama run llama3.2:8b

# Comando único
echo "Resume este contrato: $(cat contrato.txt)" | ollama run llama3.2:8b

# API local (para integração)
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2:8b",
  "prompt": "Analise este contrato de trabalho...",
  "stream": false
}'
```

### Integração com Python

```python
import requests

# Consulta totalmente local
response = requests.post('http://localhost:11434/api/generate', json={
    'model': 'llama3.2:8b',
    'prompt': 'Analise este texto: ...',
    'options': {
        'temperature': 0.7,
        'num_ctx': 8192
    }
})

result = response.json()
print(result['response'])
```

### Interface Web (Open WebUI)

```bash
# Instalar interface web opcional
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

Aceder em: `http://localhost:3000`

---

## 📊 Benchmarks no Hardware de Referência

| Modelo | Tokens/seg | Latência (TTFT) | Uso VRAM | Qualidade |
|--------|-----------|-----------------|----------|-----------|
| Llama 3.2 8B Q4 | 28-35 | 1.2s | 5.0GB | ⭐⭐⭐⭐⭐ |
| Mistral 7B Q4 | 25-32 | 1.1s | 4.5GB | ⭐⭐⭐⭐⭐ |
| Qwen 2.5 7B Q4 | 26-33 | 1.0s | 4.5GB | ⭐⭐⭐⭐☆ |
| Gemma 2 9B Q4 | 20-28 | 1.5s | 5.5GB | ⭐⭐⭐⭐☆ |

*Testado em MSI GL65 (i7-10875H, RTX 2060 6GB, 32GB RAM)*

---

## 🤝 Contribuição

```bash
# Fazer fork do projeto
# Criar branch
git checkout -b feature/nova-feature

# Commit
git commit -m "feat: adicionar suporte para [modelo]"

# Push
git push origin feature/nova-feature

# Abrir Pull Request
```

---

## 📜 Licença

Este projeto é licenciado sob MIT License - ver [LICENSE](LICENSE) para detalhes.

**Nota importante:** Os modelos LLM têm as suas próprias licenças (Apache 2.0, Llama, etc.). Verificar compatibilidade com o uso pretendido.

---

## ⚠️ Disclaimer Legal

> Este projeto fornece **ferramentas técnicas** para conformidade RGPD, mas **não constitui aconselhamento jurídico**. 
>
> Para implementação em contexto empresarial, consultar um **Encarregado de Proteção de Dados (EPD)** ou advogado especializado em proteção de dados.

---

## 📞 Suporte

- 📧 Email: [teu-email]
- 💬 Issues: [GitHub Issues]
- 📖 Wiki: [GitHub Wiki]

---

<p align="center">
  <strong>🛡️ Protege os dados dos teus clientes. Mantém o controlo. Cumpre o RGPD.</strong>
</p>
