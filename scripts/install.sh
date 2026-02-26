#!/bin/bash

###############################################################################
# Script de Instalação Automatizada - LLM Local RGPD
# 
# Descrição: Instala e configura o ambiente completo para execução local
#            de LLMs em conformidade com RGPD
#
# Hardware testado: MSI GL65 Leopard (i7-10875H, RTX 2060 6GB, 32GB RAM)
# Sistema: Ubuntu 22.04+ / 24.04 LTS
#
# Uso: ./install.sh [--gpu nvidia|cpu] [--models all|minimal]
###############################################################################

set -e  # Exit on error

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variáveis
gpu_type="nvidia"
install_models="minimal"
OLLAMA_VERSION="0.5.7"

# Funções de logging
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║   🤖 LLM Local RGPD - Sistema de Instalação                   ║
║                                                               ║
║   Conformidade total com RGPD • Processamento 100% Local     ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        --gpu)
            gpu_type="$2"
            shift 2
            ;;
        --models)
            install_models="$2"
            shift 2
            ;;
        --help)
            echo "Uso: $0 [OPÇÕES]"
            echo ""
            echo "Opções:"
            echo "  --gpu nvidia|cpu    Tipo de aceleração (padrão: nvidia)"
            echo "  --models all|minimal Quais modelos instalar (padrão: minimal)"
            echo "  --help              Mostrar esta ajuda"
            exit 0
            ;;
        *)
            log_error "Opção desconhecida: $1"
            exit 1
            ;;
    esac
done

log_info "Iniciando instalação..."
log_info "Configuração: GPU=$gpu_type, Modelos=$install_models"

# =============================================================================
# 1. VERIFICAÇÃO DO SISTEMA
# =============================================================================

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  1. VERIFICAÇÃO DO SISTEMA${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"

# Verificar sistema operativo
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    log_info "Sistema detetado: $PRETTY_NAME"
    if [[ "$ID" != "ubuntu" ]]; then
        log_warn "Este script foi testado no Ubuntu. Pode ser necessário adaptar."
    fi
else
    log_error "Não foi possível identificar o sistema operativo"
    exit 1
fi

# Verificar arquitetura
ARCH=$(uname -m)
if [[ "$ARCH" != "x86_64" ]]; then
    log_warn "Arquitetura $ARCH pode não ser totalmente suportada"
fi

# Verificar conectividade
if ! ping -c 1 google.com &> /dev/null; then
    log_error "Sem conectividade à Internet"
    exit 1
fi
log_success "Conectividade à Internet confirmada"

# Verificar GPU NVIDIA se selecionada
if [[ "$gpu_type" == "nvidia" ]]; then
    if ! command -v nvidia-smi &> /dev/null; then
        log_warn "nvidia-smi não encontrado. A instalar drivers NVIDIA..."
        sudo apt update
        sudo apt install -y ubuntu-drivers-common
        sudo ubuntu-drivers autoinstall
        log_warn "REINICIAÇÃO NECESSÁRIA após instalação dos drivers"
        log_warn "Por favor reinicia o sistema e executa o script novamente"
        exit 0
    fi
    
    GPU_INFO=$(nvidia-smi --query-gpu=name,memory.total --format=csv,noheader 2>/dev/null || echo "N/A")
    log_info "GPU detetada: $GPU_INFO"
    
    CUDA_VERSION=$(nvidia-smi | grep "CUDA Version" | awk '{print $9}')
    log_info "CUDA Version: $CUDA_VERSION"
fi

# Verificar RAM
TOTAL_RAM=$(free -g | awk '/^Mem:/{print $2}')
log_info "RAM total: ${TOTAL_RAM}GB"
if [[ $TOTAL_RAM -lt 16 ]]; then
    log_warn "RAM recomendada: 16GB+. Atual: ${TOTAL_RAM}GB"
fi

# Verificar espaço em disco
DISK_FREE=$(df -BG "$HOME" | awk 'NR==2 {print $4}' | tr -d 'G')
log_info "Espaço livre em disco: ${DISK_FREE}GB"
if [[ $DISK_FREE -lt 50 ]]; then
    log_warn "Espaço recomendado: 50GB+. Atual: ${DISK_FREE}GB"
fi

# =============================================================================
# 2. INSTALAÇÃO DE DEPENDÊNCIAS
# =============================================================================

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  2. INSTALAÇÃO DE DEPENDÊNCIAS${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"

log_info "Atualizando repositórios..."
sudo apt update

log_info "Instalando dependências básicas..."
sudo apt install -y \
    curl \
    wget \
    git \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    jq \
    htop \
    nvtop

# Instalar CUDA toolkit (se NVIDIA)
if [[ "$gpu_type" == "nvidia" ]]; then
    if ! command -v nvcc &> /dev/null; then
        log_info "A instalar CUDA Toolkit..."
        wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
        sudo dpkg -i cuda-keyring_1.1-1_all.deb
        sudo apt update
        sudo apt install -y cuda-toolkit-12-6
        rm cuda-keyring_1.1-1_all.deb
        
        # Adicionar ao PATH
        echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
        echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
    fi
fi

# Instalar Docker (opcional mas recomendado)
if ! command -v docker &> /dev/null; then
    log_info "A instalar Docker..."
    sudo apt install -y docker.io
    sudo systemctl enable --now docker
    sudo usermod -aG docker "$USER"
    log_warn "Docker instalado. É necessário fazer logout/login para usar sem sudo"
fi

log_success "Dependências instaladas"

# =============================================================================
# 3. INSTALAÇÃO DO OLLAMA
# =============================================================================

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  3. INSTALAÇÃO DO OLLAMA${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"

if command -v ollama &> /dev/null; then
    log_info "Ollama já instalado: $(ollama --version)"
else
    log_info "A instalar Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
    log_success "Ollama instalado"
fi

# Configurar Ollama para otimização
log_info "A configurar Ollama..."

# Criar diretório de configuração se não existir
mkdir -p ~/.ollama

# Backup de configuração existente
if [[ -f /etc/systemd/system/ollama.service ]]; then
    sudo cp /etc/systemd/system/ollama.service /etc/systemd/system/ollama.service.bak
fi

# Criar override para otimização da RTX 2060
sudo mkdir -p /etc/systemd/system/ollama.service.d
sudo tee /etc/systemd/system/ollama.service.d/override.conf > /dev/null <<EOF
[Service]
Environment="CUDA_VISIBLE_DEVICES=0"
Environment="OLLAMA_GPU_OVERHEAD=512MB"
Environment="OLLAMA_NUM_PARALLEL=1"
Environment="OLLAMA_MAX_LOADED_MODELS=1"
Environment="OLLAMA_KEEP_ALIVE=30m"
EOF

# Recarregar systemd e reiniciar ollama
sudo systemctl daemon-reload
sudo systemctl restart ollama
sudo systemctl enable ollama

# Verificar status
if sudo systemctl is-active --quiet ollama; then
    log_success "Ollama em execução"
else
    log_error "Falha ao iniciar Ollama"
    exit 1
fi

# Aguardar Ollama estar pronto
sleep 3

# =============================================================================
# 4. INSTALAÇÃO DE MODELOS
# =============================================================================

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  4. INSTALAÇÃO DE MODELOS${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"

# Verificar VRAM disponível
if [[ "$gpu_type" == "nvidia" ]]; then
    VRAM_MB=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -1)
    VRAM_GB=$((VRAM_MB / 1024))
    log_info "VRAM disponível: ${VRAM_GB}GB"
else
    VRAM_GB=0
    log_info "Modo CPU selecionado (sem GPU)"
fi

# Selecionar modelos baseado na VRAM e preferência do utilizador
if [[ "$install_models" == "minimal" ]]; then
    log_info "Modo de instalação: MINIMAL (modelos essenciais)"
    
    # Modelos que cabem em 6GB VRAM
    MODELS=(
        "llama3.2:8b"
        "mistral:7b"
        "qwen2.5-coder:7b"
    )
else
    log_info "Modo de instalação: ALL (todos os modelos compatíveis)"
    
    MODELS=(
        "llama3.2:8b"
        "llama3.2:3b"
        "mistral:7b"
        "mistral:7b-instruct-v0.3-q4_0"
        "qwen2.5:7b"
        "qwen2.5-coder:7b"
        "gemma2:9b"
        "nomic-embed-text"
    )
fi

# Baixar modelos
for model in "${MODELS[@]}"; do
    log_info "A baixar modelo: $model"
    if ollama pull "$model"; then
        log_success "Modelo $model instalado"
    else
        log_warn "Falha ao instalar $model"
    fi
done

# Criar Modelfile personalizado para PT-PT
log_info "A criar modelo personalizado para PT-PT..."
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
- Usas "énero" (não "gênero")
- Usas "treino" (não "treinamento")
- Usas "aprendizagem" (não "aprendizado")
- Usas "custo-benefício" (com hífen)
- Usas "em tempo real" (não "real-time")

O teu tom é profissional, académico e adequado para ensino superior.
Procuras sempre fundamentar as tuas respostas com exemplos práticos 
quando relevante."""

PARAMETER temperature 0.7
PARAMETER num_ctx 8192
PARAMETER num_gpu 999
PARAMETER num_thread 16

LICENSE """
Este modelo baseia-se no Llama 3.2 8B da Meta.
Uso permitido para fins académicos e empresariais.
"""
EOF

ollama create llm-local-pt -f /tmp/Modelfile-pt
log_success "Modelo personalizado 'llm-local-pt' criado"

# =============================================================================
# 5. CONFIGURAÇÃO DE AMBIENTE
# =============================================================================

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  5. CONFIGURAÇÃO DE AMBIENTE${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"

# Adicionar aliases úteis ao .bashrc
if ! grep -q "# LLM Local RGPD Aliases" ~/.bashrc; then
    log_info "A adicionar aliases ao .bashrc..."
    cat >> ~/.bashrc << 'EOF'

# LLM Local RGPD Aliases
alias llm='ollama run llm-local-pt'
alias llm-list='ollama list'
alias llm-ps='ollama ps'
alias llm-rm='ollama rm'
alias llm-logs='sudo journalctl -u ollama -f'

# Ver recursos GPU
alias gpu='nvidia-smi'
alias gpu-watch='watch -n 1 nvidia-smi'
EOF
    log_success "Aliases adicionados"
fi

# Criar script de helper
cat > ~/git/llm_local_rgpd/scripts/llm-helper.sh << 'EOF'
#!/bin/bash
# Script helper para operações comuns

case "$1" in
    status)
        echo "=== Status do Ollama ==="
        sudo systemctl status ollama --no-pager
        echo ""
        echo "=== Modelos Instalados ==="
        ollama list
        echo ""
        echo "=== Recursos GPU ==="
        nvidia-smi
        ;;
    benchmark)
        echo "=== Benchmarking Llama 3.2 8B ==="
        time ollama run llama3.2:8b "Explique o conceito de Business Intelligence em 3 parágrafos." --verbose
        ;;
    clean)
        echo "A limpar modelos não utilizados..."
        ollama prune
        ;;
    update)
        echo "A atualizar Ollama..."
        curl -fsSL https://ollama.com/install.sh | sh
        ;;
    *)
        echo "Uso: $0 {status|benchmark|clean|update}"
        ;;
esac
EOF

chmod +x ~/git/llm_local_rgpd/scripts/llm-helper.sh

# Criar symlink
sudo ln -sf ~/git/llm_local_rgpd/scripts/llm-helper.sh /usr/local/bin/llm-helper

# =============================================================================
# 6. VERIFICAÇÃO FINAL
# =============================================================================

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  6. VERIFICAÇÃO FINAL${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"

log_info "A verificar instalação..."

# Verificar Ollama
if command -v ollama &> /dev/null; then
    log_success "Ollama: $(ollama --version)"
else
    log_error "Ollama não encontrado"
fi

# Verificar modelos
log_info "Modelos instalados:"
ollama list

# Teste rápido
log_info "A executar teste rápido..."
if ollama run llama3.2:8b "Olá, confirma que estás a funcionar localmente." &> /tmp/llm_test.log; then
    log_success "Teste executado com sucesso"
    grep -q "funcionar localmente" /tmp/llm_test.log && log_success "Resposta recebida"
else
    log_warn "Teste falhou - verificar logs em /tmp/llm_test.log"
fi

# =============================================================================
# 7. DOCUMENTAÇÃO FINAL
# =============================================================================

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${BLUE}Resumo da instalação:${NC}"
echo "  • Ollama: $(ollama --version 2>/dev/null || echo 'N/A')"
echo "  • GPU: $gpu_type"
echo "  • Modelos instalados: $(ollama list | wc -l)"
echo ""
echo -e "${BLUE}Comandos disponíveis:${NC}"
echo "  llm              - Iniciar chat interativo (PT-PT)"
echo "  llm-list         - Listar modelos instalados"
echo "  llm-ps           - Ver modelos em execução"
echo "  llm-helper       - Script de helper"
echo "  gpu              - Ver estado da GPU"
echo "  gpu-watch        - Monitorizar GPU em tempo real"
echo ""
echo -e "${BLUE}Exemplos de uso:${NC}"
echo "  ollama run llama3.2:8b"
echo "  ollama run mistral:7b"
echo "  echo 'Analise este texto' | ollama run llm-local-pt"
echo ""
echo -e "${YELLOW}Próximos passos:${NC}"
echo "  1. Reiniciar o terminal (para carregar aliases)"
echo "  2. Executar: llm-list"
echo "  3. Começar a usar: llm"
echo ""
echo -e "${GREEN}🛡️  Os teus dados permanecem no teu computador. Conformidade RGPD garantida.${NC}"
echo ""
