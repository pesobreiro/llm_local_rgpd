# 🚀 Guia Rápido - LLM Local RGPD

> Começar a usar em 5 minutos

---

## ⚡ Comandos Essenciais

### Iniciar o sistema
```bash
# Verificar se está tudo a funcionar
ollama ps          # Modelos ativos
llm-list           # Modelos instalados
gpu                # Estado da GPU
```

### Usar o LLM
```bash
# Modo interativo (recomendado)
llm

# Comando único
echo "Resume este texto" | ollama run llama3.2:8b

# Com arquivo
ollama run llama3.2:8b < documento.txt
```

### Gerir modelos
```bash
ollama pull llama3.2:8b    # Baixar modelo
ollama rm llama3.2:8b      # Remover modelo  
ollama prune               # Limpar cache
```

---

## 📋 Tarefas Comuns

### Analisar um documento
```bash
# Criar script de análise
cat > analisar.sh << 'EOF'
#!/bin/bash
DOCUMENTO="$1"
prompt="Analise o seguinte documento e forneça:\
1. Resumo executivo (3 frases)\
2. Pontos-chave identificados\
3. Recomendações\
\nDocumento:\n$(cat $DOCUMENTO)"

echo "$prompt" | ollama run llm-local-pt
EOF

chmod +x analisar.sh
./analisar.sh contrato.txt
```

### Gerar apresentação
```bash
ollama run llama3.2:8b "Cria uma estrutura de apresentação sobre \
Business Intelligence no setor desportivo, com 5 slides principais"
```

### Traduzir documento
```bash
ollama run mistral:7b "Traduza o seguinte texto para inglês técnico: \
$(cat texto_pt.txt)"
```

---

## 🔧 Resolução Rápida de Problemas

| Problema | Solução |
|----------|---------|
| Ollama não responde | `sudo systemctl restart ollama` |
| Sem memória GPU | Usar `llama3.2:3b` em vez de `8b` |
| Demasiado lento | Verificar `nvidia-smi` se GPU está a ser usada |
| Modelo não aparece | `ollama list` para verificar instalação |

---

## 🛡️ Checklist RGPD Diário

- [ ] Verificar que não há dados pessoais desnecessários nos inputs
- [ ] Validar outputs antes de enviar a terceiros
- [ ] Confirmar que estou em modo local (sem ícone de cloud)

---

## 📊 Monitorização

```bash
# Ver recursos em tempo real
htop          # CPU e RAM
nvtop         # GPU (se instalado)
gpu-watch     # GPU nvidia-smi contínuo

# Logs do sistema
llm-logs      # Logs do Ollama
```

---

**Para documentação completa ver [README.md](README.md)**
