# 📖 Fundamentos RGPD + IA Generativa

## Sumário Executivo

Este documento estabelece as bases jurídicas para o uso de **Large Language Models (LLMs) locais** em conformidade com o Regulamento Geral de Proteção de Dados (RGPD) e a Lei de Implementação Portuguesa (Lei n.º 58/2019).

---

## 1. Conceitos Fundamentais

### 1.1 O que é o RGPD?

O **Regulamento (UE) 2016/679** (RGPD) é o diploma jurídico europeu que regula o tratamento de dados pessoais, aplicável desde 25 de maio de 2018.

**Princípios fundamentais (Art. 5º):**

| Princípio | Significado | Implicação para LLMs |
|-----------|-------------|---------------------|
| **Licitude** | Tratamento deve ter base legal | Consentimento ou interesse legítimo |
| **Finalidade** | Determinados, explícitos e legítimos | Não usar dados para treinar modelos sem autorização |
| **Minimização** | Adequados, pertinentes e limitados | Processar apenas dados necessários |
| **Exatidão** | Exatos e atualizados | Verificar outputs de LLMs |
| **Limitação Conservação** | Mantidos pelo tempo necessário | Definir políticas de retenção |
| **Integridade/Confidencialidade** | Segurança do tratamento | Cifragem, controlo de acessos |
| **Accountability** | Responsabilidade pelo cumprimento | Documentar decisões |

### 1.2 Definições Relevantes

**Dados Pessoais (Art. 4º, n.º 1)**
> Qualquer informação relativa a uma pessoa singular identificada ou identificável («titular dos dados»)

**Exemplos em contexto de IA:**
- Nomes de clientes em contratos analisados
- Dados de identificação em processos de M&A
- Informação médica em relatórios clínicos
- Dados de alunos em trabalhos académicos

**Tratamento (Art. 4º, n.º 2)**
> Qualquer operação ou conjunto de operações efetuadas sobre dados pessoais

**LLMs como tratamento:**
- Input de dados = Coleta
- Processamento pelo modelo = Tratamento automatizado
- Output = Potencial nova informação pessoal

---

## 2. LLMs na Cloud vs Local: Análise Jurídica

### 2.1 LLMs em Cloud (API Externa)

**Fluxo de dados:**
```
[Teu Computador] → [Internet] → [Servidores EUA/Estrangeiro] → [Modelo Cloud]
       ↑                                                        ↓
       └───────────────── Resposta ─────────────────────────────┘
```

**Qualificação jurídica:**

| Aspecto | Qualificação RGPD |
|---------|-------------------|
| **Operação** | Subcontratação do tratamento (Art. 28º) |
| **Entidade Cloud** | Subcontratante |
| **Transferência** | Internacional (para fora da UE) |
| **Base legal necessária** | Contrato + CCTs ou Adequacy Decision |

**Requisitos obrigatórios:**

1. **Contrato de Subcontratação** (Art. 28º)
   - Especificar objeto e duração
   - Natureza e finalidade do tratamento
   - Tipo de dados e categorias de titulares
   - Obrigações e direitos do responsável

2. **Transferência Internacional** (Capítulo V)
   - Decisão de adequação (ex: Privacy Shield - INVALIDADO)
   - Cláusulas Contratuais Tipo (CCTs)
   - Regras empresariais vinculativas (BCRs)
   - Código de conduta + certificação

3. **Avaliação de Impacto** (Art. 35º)
   - Se tratamento em larga escala
   - Se dados sensíveis (Art. 9º)
   - Se decisões automatizadas significativas

### 2.2 LLMs Locais (Este Projeto)

**Fluxo de dados:**
```
[Teu Computador] → [Modelo Local] → [Output Local]
        ↑                                    ↓
        └────── Nunca sai do teu hardware ───┘
```

**Qualificação jurídica:**

| Aspecto | Qualificação RGPD |
|---------|-------------------|
| **Operação** | Tratamento pelo próprio responsável |
| **Subcontratação** | **NÃO existe** |
| **Transferência internacional** | **NÃO existe** |
| **Base legal necessária** | Apenas base para o tratamento |

**Vantagens jurídicas:**

✅ **Não há figura de subcontratante**
- O modelo corre no teu hardware
- Não há terceiro a aceder aos dados

✅ **Não há transferência internacional**
- Dados nunca saem da tua jurisdição
- Não aplicáveis CCTs ou adequacy decisions

✅ **Maior controlo de segurança**
- Tu defines as medidas técnicas
- Possibilidade de air-gapped (sem internet)
- Auditoria totalmente transparente

✅ **Simplificação do consentimento**
- Não necessário informar sobre transferências
- Mais fácil explicar ao titular dos dados

---

## 3. Fundamentação do Uso Local

### 3.1 Bases Legais (Art. 6º)

Para tratamento de dados pessoais com LLMs locais:

| Base Legal | Aplicabilidade | Exemplo |
|------------|---------------|---------|
| **Consentimento** (a) | Titular concorda | Análise de documento pessoal |
| **Contrato** (b) | Necessário para contrato | Análise contratual com cliente |
| **Obrigação legal** (c) | Cumprimento de lei | Relatórios regulamentares |
| **Interesse vital** (d) | Proteção de vida | Emergências médicas |
| **Interesse público** (e) | Função pública | Administração pública |
| **Interesse legítimo** (f) | Legítimo e proporcional | Consultadoria empresarial |

### 3.2 Interesse Legítimo (Art. 6º, f)

**Teste de três passos:**

1. **Interesse legítimo perseguido**
   - Melhoria da qualidade de serviços de consultadoria
   - Eficiência na análise documental
   - Inovação em serviços de BI

2. **Necessidade do tratamento**
   - O LLM é necessário para o objetivo?
   - Não existem meios menos invasivos?
   - O processamento local minimiza riscos

3. **Equilíbrio de interesses**
   - Direitos e liberdades do titular não prevalecem?
   - Expectativas razoáveis do titular?
   - Medidas de salvaguarda implementadas

**Documentação necessária:**
- Análise de interesse legítimo (AIL)
- Medidas de salvaguarda técnicas
- Política de retenção de dados

---

## 4. Medidas Técnicas e Organizativas (Art. 32º)

### 4.1 Medidas Implementadas pelo Projeto

| Medida | Implementação | Justificação |
|--------|--------------|--------------|
| **Cifragem em repouso** | Disco encriptado (LUKS) | Proteção contra acesso físico |
| **Cifragem em trânsito** | N/A (tudo local) | Não há trânsito de rede |
| **Confidencialidade** | Modelo local, sem cloud | Elimina risco de vazamento externo |
| **Integridade** | Checksums de modelos | Garantir integridade dos ficheiros |
| **Resiliência** | Backups regulares | Recuperação em caso de falha |
| **Testes regulares** | Auditorias de segurança | Verificar eficácia das medidas |

### 4.2 Gestão de Riscos

**Riscos identificados e mitigação:**

| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|---------|-----------|
| Acesso físico ao computador | Média | Alto | Encriptação disco, screen lock |
| Malware/Ransomware | Baixa | Alto | Antivírus, backups offline |
| Vazamento por rede | Baixa | Alto | Firewall, sem cloud |
| Uso indevido por utilizador | Média | Médio | Políticas de uso, logging |
| Hallucination do modelo | Alta | Médio | Verificação humana obrigatória |

---

## 5. Direitos dos Titulares (Art. 15º-22º)

### 5.1 Implicações para Uso de LLMs

| Direito | Implicação | Medida |
|---------|-----------|--------|
| **Acesso** (Art. 15º) | Titular pode pedir que dados são processados | Logging de inputs/outputs |
| **Retificação** (Art. 16º) | Corrigir dados inexatos | Procedimento de correção |
| **Apagamento** (Art. 17º) | "Direito a ser esquecido" | Política de retenção definida |
| **Limitação** (Art. 18º) | Bloquear tratamento | Possibilidade de suspensão |
| **Portabilidade** (Art. 20º) | Receber dados em formato legível | Exportação de histórico |
| **Oposição** (Art. 21º) | Opor-se ao tratamento | Procedimento de oposição |

### 5.2 Decisões Automatizadas (Art. 22º)

⚠️ **ATENÇÃO:** LLMs podem tomar decisões automatizadas significativas.

**Se o LLM:**
- Avalia perfis de clientes
- Decide sobre contratos
- Determina admissão de alunos

**Então:**
- Informação obrigatória ao titular
- Direito a intervenção humana
- Direito a expressar opinião
- Direito a contestar decisão

**Recomendação:**
> Sempre incluir revisão humana em decisões significativas. O LLM é ferramenta de apoio, não decisor final.

---

## 6. Registo de Atividades de Tratamento (RAT)

### 6.1 Obrigatoriedade

**Art. 30º RGPD:** O responsável pelo tratamento mantém um registo das atividades de tratamento.

**Simplificação para tratamento local:**

```
┌────────────────────────────────────────────────────────┐
│ REGISTO DE ATIVIDADES DE TRATAMENTO                    │
├────────────────────────────────────────────────────────┤
│ Identificação: RAT-001-LLM                             │
│ Responsável: [Nome da entidade]                        │
│ Data: 2025-02-26                                       │
├────────────────────────────────────────────────────────┤
│ FINALIDADE DO TRATAMENTO                               │
│ Análise de documentos e geração de conteúdos com       │
│ recurso a modelos de linguagem executados localmente.  │
├────────────────────────────────────────────────────────┤
│ CATEGORIAS DE TITULARES                                │
│ - Clientes de consultadoria                            │
│ - Alunos (no contexto de ensino)                       │
│ - Colaboradores                                        │
├────────────────────────────────────────────────────────┤
│ CATEGORIAS DE DADOS PESSOAIS                           │
│ - Dados de identificação (nomes, contactos)            │
│ - Dados profissionais                                  │
│ - Dados académicos (quando aplicável)                  │
├────────────────────────────────────────────────────────┤
│ CATEGORIAS DE DESTINATÁRIOS                            │
│ N/A - Tratamento exclusivamente local. Sem transferência│
│ para terceiros ou para fora da UE.                     │
├────────────────────────────────────────────────────────┤
│ TRANSFERÊNCIAS INTERNACIONAIS                          │
│ NÃO EXISTEM - O processamento é efetuado 100% no       │
│ hardware local, sem transmissão de dados pela rede.    │
├────────────────────────────────────────────────────────┤
│ PRAZOS DE ELIMINAÇÃO                                   │
│ Inputs: 30 dias após processamento                     │
│ Outputs: 90 dias ou conforme período legal específico  │
│ Logs: 1 ano                                            │
├────────────────────────────────────────────────────────┤
│ MEDIDAS DE SEGURANÇA                                   │
│ - Encriptação do disco (LUKS)                          │
│ - Acesso autenticado                                   │
│ - Logging de acessos                                   │
│ - Backups encriptados                                  │
└────────────────────────────────────────────────────────┘
```

---

## 7. AI Act Europeu (Regulamento IA)

### 7.1 Enquadramento

O **Regulamento (UE) 2024/1689** (AI Act) é o primeiro quadro jurídico mundial para regulamentação da inteligência artificial, oficialmente adotado em 13 de junho de 2024.

**Calendário de Aplicação (Faseado):**

| Data | Disposições Aplicáveis |
|------|------------------------|
| **1 agosto 2024** | Entrada em vigor do regulamento |
| **2 fevereiro 2025** | Aplicação dos Capítulos I e II (definições, princípios gerais) |
| **2 agosto 2025** | Obrigações para modelos GPAI; Estrutura de governação; Sanções |
| **2 agosto 2026** | Aplicação das restantes matérias (exceto Art. 6º nº1) |
| **2 agosto 2027** | Aplicação do Art. 6º nº1 (sistemas de IA de risco elevado) |

**Classificação de Risco:**

| Categoria | Definição | Exemplo | Requisitos |
|-----------|-----------|---------|------------|
| **Inaceitável** | Proibidos | Sistemas de pontuação social, manipulação subliminar | Proibido |
| **Alto Risco** | Setores críticos | IA médica, recrutamento, justiça | Conformidade rigorosa (Art. 6º) |
| **Risco Limitado** | Transparência obrigatória | Chatbots, IA generativa | Informação ao utilizador |
| **Mínimo/Nulo** | Voluntário | Filtros spam, recomendações | Boas práticas |

### 7.2 LLMs Locais e o AI Act

**Sistemas de Propósito Geral (GPAI):**

Os LLMs deste projeto (Llama, Mistral, Qwen) qualificam-se como **GPAI** (General Purpose AI) - modelos treinados com grandes volumes de dados capazes de executar uma vasta gama de tarefas.

**Obrigações para GPAI (a partir de 2 agosto 2025):**
- **Transparência:** Indicar que conteúdos foram gerados por IA
- **Documentação técnica:** Manter registos do sistema
- **Respeito por direitos de autor:** Documentar dados de treino
- **Política de uso responsável:** Informar sobre limitações

**GPAI com Risco Sistémico (não aplicável a este projeto):**
Modelos com capacidade computacional superior a 10^25 FLOPs têm obrigações adicionais de gestão de riscos e cibersegurança. Os modelos open-source locais deste projeto estão abaixo deste limiar.

**Isenções Relevantes:**
- Sistemas de IA utilizados **exclusivamente para fins pessoais** (isenção)
- Sistemas para **investigação e desenvolvimento científico** (isenção)
- Modelos open-source **não monetizados** (obrigações reduzidas)

---

## 8. Checklist de Conformidade

### 8.1 Antes de Começar

- [ ] Identificar base legal para o tratamento
- [ ] Criar/atualizar Registo de Atividades de Tratamento (RAT)
- [ ] Definir política de retenção de dados
- [ ] Implementar medidas de segurança técnicas
- [ ] Documentar decisão de usar processamento local

### 8.2 Durante o Uso

- [ ] Verificar se inputs contêm dados pessoais desnecessários
- [ ] Validar outputs antes de uso externo (hallucinations)
- [ ] Manter logs de acesso e processamento
- [ ] Garantir backups regulares
- [ ] Atualizar modelos quando necessário

### 8.3 Revisão Periódica

- [ ] Rever RAT anualmente
- [ ] Avaliar necessidade de AIPD
- [ ] Testar medidas de segurança
- [ ] Atualizar documentação

---

## 9. Templates e Documentos

Este projeto inclui os seguintes templates:

| Documento | Localização | Finalidade |
|-----------|-------------|------------|
| Registo de Atividades (RAT) | `templates/rat_llm_local.md` | Cumprir Art. 30º |
| Avaliação de Impacto (AIPD) | `templates/aipd_template.md` | Se necessário (Art. 35º) |
| Contrato de Subcontratação | `templates/contrato_subcontratacao.md` | Se alguma vez usar cloud |
| Política de Uso | `templates/politica_uso.md` | Regras internas |
| Informação ao Titular | `templates/informacao_titular.md` | Cumprir Art. 13º/14º |

---

## 10. Referências e Links Úteis

### Legislação
- [Regulamento (UE) 2016/679 (RGPD)](https://eur-lex.europa.eu/eli/reg/2016/679)
- [Lei n.º 58/2019 (Portugal)](https://diariodarepublica.pt/dr/legislacao-consolidada/lei/2019-34546475)
- [Regulamento (UE) 2024/1689 (AI Act)](https://eur-lex.europa.eu/legal-content/PT/TXT/?uri=CELEX:32024R1689)

### Autoridades
- [Comissão Nacional de Proteção de Dados (CNPD)](https://www.cnpd.pt/)
- [European Data Protection Board (EDPB)](https://www.edpb.europa.eu/)

### Guias
- [Orientações EDPB sobre IA](https://www.edpb.europa.eu/our-work-tools/general-guidance/guidelines-artificial-intelligence_en)
- [Guia CNPD para Empresas](https://www.cnpd.pt/cidadanos/guia-do-cidadao/)

---

## ⚠️ Disclaimer

> Este documento tem caráter **informativo e educativo**. Não substitui aconselhamento jurídico especializado.
> 
> Para implementação em contexto empresarial, consultar um **Encarregado de Proteção de Dados (EPD)** ou advogado especializado em proteção de dados e propriedade intelectual.

---

**Última atualização:** 2025-02-26  
**Referências verificadas:** AI Act datas conforme digital.gov.pt e Consilium.europa.eu
