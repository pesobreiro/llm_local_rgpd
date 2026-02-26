#!/bin/bash

###############################################################################
# Script de Benchmark - LLM Local RGPD
#
# Descrição: Testa a performance dos modelos instalados e gera relatório
#
# Uso: ./benchmark.sh [modelo]
# Exemplo: ./benchmark.sh llama3.2:8b
###############################################################################

set -e

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configurações
PROMPT_PT="Explique o conceito de Business Intelligence e a sua importância no setor desportivo moderno, focando na análise de dados de performance de atletas."
PROMPT_EN="Explain the concept of machine learning and its three main types: supervised, unsupervised, and reinforcement learning."
PROMPT_CODE="Escreve uma função Python que calcule o Customer Lifetime Value (CLV) dado um array de transações."
MAX_TOKENS=500

MODEL=${1:-"llama3.2:8b"}

# Funções
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[AVISO]${NC} $1"; }
log_error() { echo -e "${RED}[ERRO]${NC} $1"; }

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                   🤖 BENCHMARK LLM LOCAL                      ║
║              Teste de Performance de Modelos                  ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar argumentos
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    echo "Uso: $0 [MODELO]"
    echo ""
    echo "Modelos disponíveis:"
    ollama list 2>/dev/null || echo "Ollama não está em execução"
    exit 0
fi

# Verificar se Ollama está em execução
if ! pgrep -x "ollama" > /dev/null; then
    log_error "Ollama não está em execução. Iniciando..."
    sudo systemctl start ollama
    sleep 3
fi

# Verificar se modelo existe
if ! ollama list | grep -q "$MODEL"; then
    log_warn "Modelo $MODEL não encontrado. Baixando..."
    ollama pull "$MODEL"
fi

log_info "A executar benchmark para: $MODEL"
echo ""

# Criar diretório de resultados
mkdir -p ~/git/llm_local_rgpd/benchmarks
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULT_FILE="~/git/llm_local_rgpd/benchmarks/benchmark_${MODEL//:/_}_${TIMESTAMP}.txt"

# Função para executar teste
run_test() {
    local test_name="$1"
    local prompt="$2"
    local max_tokens="$3"
    
    echo ""
    echo "========================================="
    echo "TESTE: $test_name"
    echo "Modelo: $MODEL"
    echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================="
    echo ""
    
    # Preparar prompt JSON
    local prompt_escaped=$(echo "$prompt" | sed 's/"/\\"/g')
    
    # Executar e medir tempo
    local start_time=$(date +%s.%N)
    
    local output=$(curl -s http://localhost:11434/api/generate \
        -H "Content-Type: application/json" \
        -d "{
            \"model\": \"$MODEL\",
            \"prompt\": \"$prompt_escaped\",
            \"stream\": false,
            \"options\": {
                \"num_predict\": $max_tokens,
                \"temperature\": 0.7
            }
        }" 2>&1)
    
    local end_time=$(date +%s.%N)
    local duration=$(echo "$end_time - $start_time" | bc)
    
    # Extrair resposta e estatísticas
    local response=$(echo "$output" | jq -r '.response' 2>/dev/null || echo "Erro ao processar resposta")
    local eval_count=$(echo "$output" | jq -r '.eval_count' 2>/dev/null || echo "0")
    local load_duration=$(echo "$output" | jq -r '.load_duration' 2>/dev/null || echo "0")
    local prompt_eval_count=$(echo "$output" | jq -r '.prompt_eval_count' 2>/dev/null || echo "0")
    
    # Calcular tokens por segundo
    if (( $(echo "$duration > 0" | bc -l) )) && [[ "$eval_count" -gt 0 ]]; then
        local tps=$(echo "scale=2; $eval_count / $duration" | bc)
    else
        local tps="N/A"
    fi
    
    # Calcular tempo de carregamento em segundos
    local load_seconds=$(echo "scale=3; $load_duration / 1000000000" | bc)
    
    # Mostrar resultados
    echo "--- RESULTADOS ---"
    echo "Duração total: ${duration}s"
    echo "Tokens gerados: $eval_count"
    echo "Tokens/segundo: $tps"
    echo "Tempo de carregamento: ${load_seconds}s"
    echo "Tokens no prompt: $prompt_eval_count"
    echo ""
    echo "--- RESPOSTA (primeiros 300 caracteres) ---"
    echo "${response:0:300}..."
    echo ""
    
    # Retornar estatísticas
    echo "$test_name|$duration|$eval_count|$tps|$load_seconds"
}

# Teste 1: Português (contexto BI)
log_info "Teste 1: Geração em Português"
RESULT_PT=$(run_test "Português_PT" "$PROMPT_PT" $MAX_TOKENS)

# Pequena pausa entre testes
sleep 2

# Teste 2: Inglês (contexto técnico)
log_info "Teste 2: Geração em Inglês"
RESULT_EN=$(run_test "Inglês_Técnico" "$PROMPT_EN" $MAX_TOKENS)

# Pequena pausa
sleep 2

# Teste 3: Código
log_info "Teste 3: Geração de Código"
RESULT_CODE=$(run_test "Código_Python" "$PROMPT_CODE" $MAX_TOKENS)

# Resumo
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}                    RESUMO DO BENCHMARK                        ${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo "Modelo: $MODEL"
echo "Data: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Hardware: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)"
echo "GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null || echo 'N/A')"
echo ""
echo "Teste                    | Duração | Tokens | TPS   | Load"
echo "-------------------------|---------|--------|-------|-------"
echo "$RESULT_PT" | awk -F'|' '{printf "%-24s | %7ss | %6s | %5s | %5ss\n", $1, $2, $3, $4, $5}'
echo "$RESULT_EN" | awk -F'|' '{printf "%-24s | %7ss | %6s | %5s | %5ss\n", $1, $2, $3, $4, $5}'
echo "$RESULT_CODE" | awk -F'|' '{printf "%-24s | %7ss | %6s | %5s | %5ss\n", $1, $2, $3, $4, $5}'

# Calcular médias
echo ""
AVG_TPS_PT=$(echo "$RESULT_PT" | cut -d'|' -f4)
AVG_TPS_EN=$(echo "$RESULT_EN" | cut -d'|' -f4)
AVG_TPS_CODE=$(echo "$RESULT_CODE" | cut -d'|' -f4)

if [[ "$AVG_TPS_PT" != "N/A" ]] && [[ "$AVG_TPS_EN" != "N/A" ]] && [[ "$AVG_TPS_CODE" != "N/A" ]]; then
    AVG_TPS=$(echo "scale=2; ($AVG_TPS_PT + $AVG_TPS_EN + $AVG_TPS_CODE) / 3" | bc)
    echo -e "${BLUE}Média de Tokens/segundo: $AVG_TPS${NC}"
fi

# Informação contextual
echo ""
echo "Classificação de Performance:"
if [[ "$AVG_TPS" != "" ]]; then
    if (( $(echo "$AVG_TPS > 30" | bc -l) )); then
        echo -e "${GREEN}🟢 Excelente (>30 TPS)${NC}"
    elif (( $(echo "$AVG_TPS > 15" | bc -l) )); then
        echo -e "${GREEN}🟢 Bom (15-30 TPS)${NC}"
    elif (( $(echo "$AVG_TPS > 5" | bc -l) )); then
        echo -e "${YELLOW}🟡 Aceitável (5-15 TPS)${NC}"
    else
        echo -e "${RED}🔴 Lento (<5 TPS)${NC} - Considerar modelo mais pequeno ou otimizações"
    fi
fi

# Guardar resultados
echo ""
echo "A guardar resultados em: $RESULT_FILE"
{
    echo "Benchmark LLM Local RGPD"
    echo "========================"
    echo "Modelo: $MODEL"
    echo "Data: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    echo "Hardware:"
    echo "  CPU: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)"
    echo "  RAM: $(free -h | awk '/^Mem:/ {print $2}')"
    echo "  GPU: $(nvidia-smi --query-gpu=name,memory.total --format=csv,noheader 2>/dev/null || echo 'N/A')"
    echo ""
    echo "Resultados:"
    echo "$RESULT_PT"
    echo "$RESULT_EN"
    echo "$RESULT_CODE"
} > "$RESULT_FILE"

log_success "Benchmark concluído! Resultados guardados em: $RESULT_FILE"
