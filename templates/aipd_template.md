# Avaliação de Impacto à Proteção de Dados (AIPD)
## Sistema de LLM Local - Art. 35º RGPD

---

> ⚠️ **Nota:** Este template é fornecido como ponto de partida. A AIPD deve ser adaptada à realidade específica de cada entidade e tratamento. Obrigatória quando aplicável o Art. 35º do RGPD.

---

## 1. Informações Gerais

| Campo | Informação |
|-------|------------|
| **Identificação da AIPD** | AIPD-001-LLM |
| **Data de elaboração** | [DATA] |
| **Entidade responsável** | [NOME DA ENTIDADE] |
| **Responsável pela AIPD** | [NOME DO RESPONSÁVEL] |
| **Versão** | 1.0 |

---

## 2. Descrição do Tratamento

### 2.1 Natureza do Tratamento

**Tipo de sistema:** Processamento local de linguagem natural via LLM (Large Language Model)

**Descrição técnica:**
```
Sistema de IA generativa executado 100% em hardware local, sem 
transmissão de dados para servidores externos. Utiliza modelos 
open-source (Llama, Mistral, Qwen) para análise de documentos 
e geração de conteúdos.
```

**Diferencial RGPD-relevante:**
> **Processamento exclusivamente local** - Dados pessoais nunca saem do hardware da entidade.

### 2.2 Âmbito do Tratamento

| Aspeto | Descrição |
|--------|-----------|
| **Finalidade principal** | Análise de documentação e geração de conteúdos |
| **Categorias de dados** | [ESPECIFICAR: dados de identificação, profissionais, etc.] |
| **Categorias de titulares** | [ESPECIFICAR: clientes, colaboradores, etc.] |
| **Volume estimado** | [NÚMERO] tratamentos/anuais |
| **Dados sensíveis (Art. 9º)?** | [SIM/NÃO - Se sim, justificar base legal] |

### 2.3 Justificação da Necessidade de AIPD

A AIPD é obrigatória quando (Art. 35º, nº1 e 3):

| Critério | Aplicável? | Justificação |
|----------|-----------|--------------|
| Avaliação sistemática de aspetos pessoais? | [ ] Sim [ ] Não | [JUSTIFICAR] |
| Tratamento em larga escala de dados sensíveis? | [ ] Sim [ ] Não | [JUSTIFICAR] |
| Monitorização sistemática de área pública? | [ ] Sim [ ] Não | [JUSTIFICAR] |

**Se nenhum critério se aplicar:** AIPD não é obrigatória (mas pode ser realizada voluntariamente).

---

## 3. Análise de Necessidade e Proporcionalidade

### 3.1 Fundamentação da Finalidade

Porque é necessário o tratamento?
- [ ] Execução de contrato (Art. 6º, 1, b)
- [ ] Obrigação legal (Art. 6º, 1, c)
- [ ] Interesse vital (Art. 6º, 1, d)
- [ ] Interesse público (Art. 6º, 1, e)
- [ ] Interesse legítimo (Art. 6º, 1, f)
- [ ] Consentimento (Art. 6º, 1, a)

**Fundamentação detalhada:**
```
[EXPLICAR PORQUE O TRATAMENTO É NECESSÁRIO E PROPORCIONAL]
```

### 3.2 Análise de Alternativas

| Alternativa Considerada | Viável? | Porquê? |
|------------------------|---------|---------|
| Processamento manual | [ ] Sim [ ] Não | [JUSTIFICAR] |
| Software tradicional (sem IA) | [ ] Sim [ ] Não | [JUSTIFICAR] |
| IA em cloud (OpenAI, etc.) | [ ] Sim [ ] Não | [JUSTIFICAR] |
| LLM local (opção escolhida) | [X] Sim | Preservação da soberania de dados, conformidade RGPD |

**Conclusão:** O LLM local é a alternativa mais adequada para garantir:
1. Conformidade com RGPD (sem subcontratação)
2. Proteção de dados sensíveis
3. Controlo total sobre o tratamento

---

## 4. Análise de Riscos

### 4.1 Identificação de Riscos

| Risco | Probabilidade | Impacto | Nível |
|-------|--------------|---------|-------|
| **R1: Acesso não autorizado** | [Baixa/Média/Alta] | [Baixo/Médio/Alto] | [ ] |
| **R2: Vazamento de dados** | [ ] | [ ] | [ ] |
| **R3: Hallucination do modelo** | [ ] | [ ] | [ ] |
| **R4: Violação de integridade** | [ ] | [ ] | [ ] |
| **R5: Indisponibilidade do sistema** | [ ] | [ ] | [ ] |
| **R6: [ADICIONAR OUTROS]** | [ ] | [ ] | [ ] |

### 4.2 Descrição dos Riscos Principais

#### R1: Acesso não autorizado ao hardware
- **Descrição:** Terceiros acedem ao computador onde o LLM processa dados
- **Consequência:** Acesso a documentos sensíveis em processamento
- **Mitigação:** Encriptação de disco, autenticação forte, acesso físico restrito

#### R2: Vazamento de dados (network)
- **Descrição:** Dados serem transmitidos acidentalmente pela rede
- **Consequência:** Transferência internacional não autorizada
- **Mitigação:** Funcionamento offline, firewall, monitorização de tráfego

#### R3: Hallucination (alucinação do modelo)
- **Descrição:** Modelo gera informação incorreta/falsa
- **Consequência:** Decisões baseadas em dados errados
- **Mitigação:** Verificação humana obrigatória, validação cruzada

### 4.3 Matriz de Riscos Residual

Após mitigação:

| Risco | Probabilidade Residual | Impacto Residual | Aceitável? |
|-------|----------------------|------------------|------------|
| R1 | Baixa | Baixo | [ ] Sim |
| R2 | Muito Baixa | Médio | [ ] Sim |
| R3 | Média | Médio | [ ] Sim (com controlo) |

---

## 5. Medidas de Mitigação

### 5.1 Medidas Técnicas

| Medida | Implementada? | Descrição |
|--------|--------------|-----------|
| Encriptação de disco (LUKS) | [ ] Sim [ ] Não | [DETALHAR] |
| Controlo de acesso ao SO | [ ] Sim [ ] Não | [DETALHAR] |
| Firewall (UFW) | [ ] Sim [ ] Não | [DETALHAR] |
| Logs de auditoria | [ ] Sim [ ] Não | [DETALHAR] |
| Backups encriptados | [ ] Sim [ ] Não | [DETALHAR] |
| Funcionamento offline | [ ] Sim [ ] Não | [DETALHAR] |

### 5.2 Medidas Organizacionais

| Medida | Implementada? | Descrição |
|--------|--------------|-----------|
| Política de uso aceitável | [ ] Sim [ ] Não | [DETALHAR] |
| Formação de utilizadores | [ ] Sim [ ] Não | [DETALHAR] |
| Procedimento de revisão humana | [ ] Sim [ ] Não | [DETALHAR] |
| Gestão de incidentes | [ ] Sim [ ] Não | [DETALHAR] |

---

## 6. Consulta à CNPD (se necessário)

### 6.1 Necessidade de Consulta Prévia

Conforme Art. 36º do RGPD, a consulta prévia à CNPD é obrigatória quando:

| Situação | Aplicável? |
|----------|-----------|
| AIPD indica alto risco que não pode ser mitigado | [ ] Sim [ ] Não |
| Tratamento sistemático em grande escala de categorias especiais (Art. 9º) | [ ] Sim [ ] Não |
| Monitorização sistemática de áreas acessíveis ao público | [ ] Sim [ ] Não |

**Se aplicável:** Enviar AIPD para a CNPD com antecedência mínima de 8 semanas.

### 6.2 Decisão sobre Consulta

- [ ] **Não aplicável** - Não há alto risco residual
- [ ] **Consulta realizada** - Parecer CNPD: [ANEXAR]
- [ ] **Consulta a realizar** - Data prevista: [DATA]

---

## 7. Conclusão e Decisão

### 7.1 Resumo da Avaliação

```
[RESUMIR PRINCIPAIS CONCLUSÕES DA AIPD]

Exemplo:
O tratamento de dados pessoais via LLM local apresenta riscos 
moderados, principalmente relacionados com controlo de acesso e 
qualidade dos outputs. As medidas de mitigação implementadas 
(encriptação, autenticação, revisão humana) são adequadas para 
garantir a conformidade com o RGPD.
```

### 7.2 Decisão

- [ ] **Tratamento pode prosseguir** - Riscos aceitáveis
- [ ] **Tratamento pode prosseguir com condições** - Ver recomendações
- [ ] **Tratamento não pode prosseguir** - Riscos inaceitáveis

### 7.3 Recomendações

1. [RECOMENDAÇÃO 1]
2. [RECOMENDAÇÃO 2]
3. [RECOMENDAÇÃO 3]

---

## 8. Revisão e Acompanhamento

| Data | Evento | Responsável |
|------|--------|-------------|
| [DATA] | Revisão anual | [NOME] |
| [DATA] | Após alteração significativa | [NOME] |
| [DATA] | Após incidente | [NOME] |

---

## 9. Anexos

- [ ] Cópia do RAT
- [ ] Documentação técnica do sistema
- [ ] Parecer da CNPD (se aplicável)
- [ ] Política de uso aceitável
- [ ] Outros: [ESPECIFICAR]

---

## 10. Assinaturas

**Responsável pelo Tratamento:**

```
Nome: _______________________________
Cargo: ______________________________
Assinatura: _________________________
Data: _______________________________
```

**Encarregado de Proteção de Dados:**

```
Nome: _______________________________
Assinatura: _________________________
Data: _______________________________
```

---

## Referências

- [CNPD - Avaliação de Impacto](https://www.cnpd.pt/organizacoes/outras-obrigacoes/avaliacao-de-impacto/)
- [EDPB - Guidelines on DPIA](https://www.edpb.europa.eu/our-work-tools/general-guidance/guidelines-data-protection-impact-assessment-dpia_en)
- [Art. 35º RGPD](https://eur-lex.europa.eu/legal-content/PT/TXT/?uri=CELEX:32016R0679#d1e3349-1-1)

---

**Template versão:** 1.0  
**Baseado em:** CNPD e EDPB guidelines  
**Licença:** MIT
