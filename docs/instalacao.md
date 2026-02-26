# 📥 Guia de Instalação Detalhado

Este guia explica passo a passo a instalação do sistema LLM Local RGPD.

---

## Índice

1. [Pré-requisitos](#1-pré-requisitos)
2. [Instalação Automatizada](#2-instalação-automatizada-recomendada)
3. [Instalação Manual](#3-instalação-manual)
4. [Configuração Pós-Instalação](#4-configuração-pós-instalação)
5. [Instalação de Modelos](#5-instalação-de-modelos)
6. [Verificação](#6-verificação)
7. [Resolução de Problemas](#7-resolução-de-problemas)

---

## 1. Pré-requisitos

### 1.1 Hardware Mínimo

```yaml
CPU: 4 cores (8 threads) - Intel i5/AMD Ryzen 5 ou superior
RAM: 16 GB DDR4
Disco: 50 GB livres em SSD
GPU: Opcional (4GB+ VRAM recomendado)
```

### 1.2 Hardware Recomendado (Testado)

```yaml
CPU: Intel i7-10875H (8C/16T) ou equivalente
RAM: 32 GB DDR4
Disco: 200 GB SSD NVMe
GPU: NVIDIA RTX 2060 (6GB VRAM) ou superior
```

### 1.3 Software Necessário

- **Sistema Operativo:** Ubuntu 22.04 LTS ou 24.04 LTS
- **Kernel:** 5.15+ (com suporte para drivers NVIDIA recentes)
- **Internet:** Conexão para download inicial (posteriormente funciona offline)

### 1.4 Verificação Prévia

Execute estes comandos para verificar o sistema:

```bash
# Verificar versão do Ubuntu
lsb_release -a

# Verificar CPU
lscpu | grep "Model name"

# Verificar RAM
free -h

# Verificar espaço em disco
df -h

# Verificar GPU (se NVIDIA)
nvidia-smi
```

---

## 2. Instalação Automatizada (Recomendada)

### 2.1 Download do Projeto

```bash
# Criar diretório git se não existir
mkdir -p ~/git
cd ~/git

# Clonar o repositório
git clone https://github.com/[USER]/llm_local_rgpd.git
cd llm_local_rgpd
```

### 2.2 Executar Script de Instalação

```bash
# Dar permissões de execução
chmod +x scripts/install.sh

# Executar instalação (modo GPU NVIDIA)
./scripts/install.sh --gpu nvidia --models minimal

# Ou para instalação CPU apenas
./scripts/install.sh --gpu cpu --models minimal

# Ou instalação completa (todos os modelos)
./scripts/install.sh --gpu nvidia --models all
```

### 2.3 O que o Script Faz

1. ✅ Atualiza repositórios do sistema
2. ✅ Instala dependências (curl, git, docker, etc.)
3. ✅ Instala CUDA Toolkit (se GPU NVIDIA)
4. ✅ Instala Ollama
5. ✅ Configura Ollama para hardware específico
6. ✅ Baixa modelos selecionados
7. ✅ Cria modelo personalizado PT-PT
8. ✅ Configura aliases e helpers
9. ✅ Executa testes de verificação

### 2.4 Tempo de Instalação

| Componente | Tempo Estimado |
|------------|---------------|
| Dependências do sistema | 5-10 minutos |
| CUDA Toolkit | 10-15 minutos |
| Ollama | 2-3 minutos |
| Modelo Llama 3.2 8B | 5-10 minutos (download) |
| Modelo Mistral 7B | 4-8 minutos (download) |
| Configuração | 2-3 minutos |
| **Total** | **30-50 minutos** |

---

## 3. Instalação Manual

Se preferires controlo total ou o script automatizado falhar.

### 3.1 Instalar Dependências

```bash
sudo apt update
sudo apt install -y curl wget git software-properties-common \
    apt-transport-https ca-certificates gnupg lsb-release jq htop
```

### 3.2 Instalar Drivers NVIDIA (se aplicável)

```bash
# Verificar se drivers já estão instalados
nvidia-smi

# Se não, instalar
sudo apt install -y ubuntu-drivers-common
sudo ubuntu-drivers autoinstall

# Reiniciar após instalação
sudo reboot
```

### 3.3 Instalar CUDA Toolkit (Opcional mas Recomendado)

```bash
# Ubuntu 24.04
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install -y cuda-toolkit-12-6

# Adicionar ao PATH
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

### 3.4 Instalar Ollama

```bash
# Método oficial (recomendado)
curl -fsSL https://ollama.com/install.sh | sh

# Verificar instalação
ollama --version
```

### 3.5 Configurar Ollama para RTX 2060 6GB

```bash
# Criar diretório de override do systemd
sudo mkdir -p /etc/systemd/system/ollama.service.d

# Criar ficheiro de configuração
sudo tee /etc/systemd/system/ollama.service.d/override.conf > /dev/null <<EOF
[Service]
Environment="CUDA_VISIBLE_DEVICES=0"
Environment="OLLAMA_GPU_OVERHEAD=512MB"
Environment="OLLAMA_NUM_PARALLEL=1"
Environment="OLLAMA_MAX_LOADED_MODELS=1"
Environment="OLLAMA_KEEP_ALIVE=30m"
EOF

# Recarregar e reiniciar
sudo systemctl daemon-reload
sudo systemctl restart ollama
sudo systemctl enable ollama

# Verificar estado
sudo systemctl status ollama --no-pager
```

---

## 4. Configuração Pós-Instalação

### 4.1 Configurar Variáveis de Ambiente

Adicionar ao `~/.bashrc`:

```bash
# Ollama settings
export OLLAMA_GPU_OVERHEAD=512MB
export OLLAMA_NUM_PARALLEL=1
export OLLAMA_MAX_LOADED_MODELS=1

# CUDA settings
export CUDA_VISIBLE_DEVICES=0

# Aliases úteis
alias llm='ollama run llm-local-pt'
alias llm-list='ollama list'
alias llm-ps='ollama ps'
alias gpu='nvidia-smi'
alias gpu-watch='watch -n 1 nvidia-smi'
```

Aplicar alterações:
```bash
source ~/.bashrc
```

### 4.2 Configurar Docker (Opcional)

Para usar containers ou Open WebUI:

```bash
# Instalar Docker
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Verificar (requer logout/login)
docker --version
```

### 4.3 Configurar Firewall

```bash
# Instalar UFW
sudo apt install -y ufw

# Política padrão: negar tudo
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Permitir SSH (cuidado para não te fechares fora!)
sudo ufw allow ssh

# Permitir acesso local ao Ollama (apenas localhost)
# NÃO abrir 11434 para a rede sem autenticação!

# Ativar firewall
sudo ufw enable

# Verificar estado
sudo ufw status verbose
```

---

## 5. Instalação de Modelos

### 5.1 Modelos Essenciais (Recomendado)

```bash
# Llama 3.2 8B - Melhor equilíbrio qualidade/velocidade
ollama pull llama3.2:8b

# Mistral 7B - Excelente em português
ollama pull mistral:7b

# Qwen 2.5 Coder - Para programação
ollama pull qwen2.5-coder:7b
```

### 5.2 Modelos Opcionais

```bash
# Versão mais pequena do Llama (mais rápida)
ollama pull llama3.2:3b

# Gemma 2 9B (Google)
ollama pull gemma2:9b

# Modelo de embeddings para RAG
ollama pull nomic-embed-text

# Phi-4 14B (requer CPU offload)
ollama pull phi4:14b
```

### 5.3 Criar Modelo Personalizado PT-PT

```bash
# Criar ficheiro Modelfile
cat > /tmp/Modelfile-pt << 'EOF'
FROM llama3.2:8b

SYSTEM """És um assistente de IA especializado em gestão empresarial, 
desporto e business intelligence. Respondes sempre em Português de Portugal (PT-PT).

Regras de terminologia:
- Usas "base de dados" (não "banco de dados")
- Usas "modelação" (não "modelagem") 
- Usas "recolha" (não "coleta")
- Usas "controlo" (não "controle")
- Usas "golos" (não "gols")
- Usas "género" (não "gênero")
- Usas "treino" (não "treinamento")
- Usas "aprendizagem" (não "aprendizado")

O teu tom é profissional, académico e adequado para ensino superior."""

PARAMETER temperature 0.7
PARAMETER num_ctx 8192
PARAMETER num_gpu 999
PARAMETER num_thread 16
EOF

# Criar modelo
ollama create llm-local-pt -f /tmp/Modelfile-pt

# Testar
ollama run llm-local-pt "Olá, confirma que estás a funcionar em português de Portugal."
```

---

## 6. Verificação

### 6.1 Verificar Ollama

```bash
# Versão
ollama --version

# Serviço ativo
sudo systemctl is-active ollama

# Logs
sudo journalctl -u ollama --no-pager -n 50
```

### 6.2 Verificar Modelos

```bash
# Listar modelos instalados
ollama list

# Deve mostrar algo como:
# NAME                    ID              SIZE      MODIFIED
# llm-local-pt:latest     xxxxxxxx        4.9 GB    2 minutes ago
# llama3.2:8b             xxxxxxxx        4.9 GB    5 minutes ago
# mistral:7b              xxxxxxxx        4.1 GB    5 minutes ago
```

### 6.3 Verificar GPU

```bash
# Informação da GPU
nvidia-smi

# Deve mostrar:
# - Nome da GPU (RTX 2060)
# - Driver Version
# - CUDA Version
# - Processos em execução (incluindo ollama quando ativo)
```

### 6.4 Teste Funcional

```bash
# Teste simples
echo "Explique o RGPD em 3 frases." | ollama run llama3.2:8b

# Teste com timing
time ollama run llama3.2:8b "Qual é a capital de Portugal?"

# Verificar uso de GPU durante execução
# (num terminal separado)
nvidia-smi
```

### 6.5 Benchmark Rápido

```bash
# Teste de performance
python3 << 'EOF'
import subprocess
import time

model = "llama3.2:8b"
prompt = "Explique o conceito de Business Intelligence em 3 parágrafos detalhados."

start = time.time()
result = subprocess.run(
    ["ollama", "run", model, prompt],
    capture_output=True,
    text=True
)
end = time.time()

output = result.stdout
num_tokens = len(output.split())
elapsed = end - start
tokens_per_sec = num_tokens / elapsed

print(f"Modelo: {model}")
print(f"Tempo total: {elapsed:.2f}s")
print(f"Tokens gerados: {num_tokens}")
print(f"Tokens/segundo: {tokens_per_sec:.2f}")
print(f"\nPrimeiros 200 caracteres:\n{output[:200]}...")
EOF
```

---

## 7. Resolução de Problemas

### 7.1 Ollama não inicia

```bash
# Verificar logs
sudo journalctl -u ollama -n 100 --no-pager

# Verificar portas
sudo netstat -tlnp | grep 11434

# Verificar permissões
ls -la /usr/local/bin/ollama

# Reinstalar se necessário
curl -fsSL https://ollama.com/install.sh | sh
```

### 7.2 GPU não é detetada

```bash
# Verificar drivers
nvidia-smi

# Verificar CUDA
nvcc --version

# Verificar permissões do dispositivo
ls -la /dev/nvidia*

# Adicionar utilizador ao grupo video
sudo usermod -aG video $USER
# Fazer logout/login após
```

### 7.3 Erro de memória (OOM)

```bash
# Reduzir overhead no Ollama
export OLLAMA_GPU_OVERHEAD=1024MB

# Usar modelo mais pequeno
ollama run llama3.2:3b

# Usar apenas CPU
export CUDA_VISIBLE_DEVICES=""
ollama run llama3.2:8b
```

### 7.4 Modelo demora muito a carregar

```bash
# Verificar espaço em disco
df -h

# Verificar velocidade do disco
sudo hdparm -t /dev/nvme0n1

# Modelos ficam em:
ls -la ~/.ollama/models/

# Limpar modelos não usados
ollama prune
```

### 7.5 Problemas de conectividade

```bash
# Ollama funciona offline, mas verificar se serviço está a escutar
curl http://localhost:11434/api/tags

# Deve retornar lista de modelos em JSON
```

### 7.6 Recuperação de Desastres

```bash
# Backup dos modelos
tar -czf ~/ollama-backup-$(date +%Y%m%d).tar.gz ~/.ollama/

# Restaurar modelos
tar -xzf ~/ollama-backup-YYYYMMDD.tar.gz -C ~/
sudo systemctl restart ollama

# Reinstalar tudo do zero
sudo systemctl stop ollama
rm -rf ~/.ollama
sudo rm -f /usr/local/bin/ollama
curl -fsSL https://ollama.com/install.sh | sh
```

---

## 📞 Suporte

Se encontrares problemas não cobertos neste guia:

1. Consultar logs: `sudo journalctl -u ollama -f`
2. Verificar issues no [GitHub do projeto](https://github.com/[USER]/llm_local_rgpd/issues)
3. Comunidade Ollama: https://github.com/ollama/ollama
4. Documentação oficial: https://ollama.com/docs

---

**Última atualização:** 2025-02-26
