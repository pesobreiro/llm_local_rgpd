# Registo de Atividades de Tratamento (RAT)
## Sistema de LLM Local - Conformidade RGPD

---

### 1. Identificação da Atividade

| Campo | Informação |
|-------|------------|
| **Identificação do RAT** | RAT-001-LLM-LOCAL |
| **Data de criação** | 2025-02-26 |
| **Última atualização** | 2025-02-26 |
| **Versão** | 1.0 |
| **Responsável pelo tratamento** | [NOME DA ENTIDADE] |
| **NIF** | [NIF] |
| **Morada** | [MORADA] |
| **Contacto DPO/EPD** | [EMAIL DO ENCARREGADO] |

---

### 2. Descrição da Atividade de Tratamento

#### 2.1 Finalidade do Tratamento

Análise de documentos, geração de conteúdos e assistência em tarefas de processamento de linguagem natural através de **modelos de linguagem executados localmente**, em conformidade com o RGPD e o AI Act.

**Objetivos específicos:**
- Análise e sumarização de documentação empresarial
- Suporte à redação de relatórios e apresentações
- Processamento de dados para consultadoria estratégica
- [ADICIONAR OUTRAS FINALIDADES ESPECÍFICAS]

#### 2.2 Justificação da Finalidade

A utilização de LLMs locais justifica-se pelos seguintes motivos:
1. **Proteção de dados sensíveis:** Eliminação de transferências para terceiros
2. **Conformidade regulamentar:** Cumprimento do RGPD sem subcontratação
3. **Eficiência operacional:** Automação de tarefas repetitivas
4. **Qualidade de serviço:** Melhoria na entrega de serviços aos clientes

---

### 3. Dados Pessoais Tratados

#### 3.1 Categorias de Titulares

| Categoria | Descrição | Fundamento |
|-----------|-----------|------------|
| Clientes de consultadoria | Pessoas singulares e contactos em empresas cliente | Execução de contrato (Art. 6º, 1, b) |
| Alunos | Estudantes no contexto de atividades de ensino | Consentimento (Art. 6º, 1, a) |
| Colaboradores | Funcionários da entidade | Interesse legítimo (Art. 6º, 1, f) |
| Candidatos | Candidatos a vagas de emprego | Consentimento (Art. 6º, 1, a) |

#### 3.2 Categorias de Dados Pessoais

| Categoria | Tipo de Dados | Sensível (Art. 9º)? |
|-----------|---------------|---------------------|
| Dados de identificação | Nome, morada, contactos | Não |
| Dados profissionais | Cargo, empresa, setor de atividade | Não |
| Dados académicos | Curso, instituição, notas (quando aplicável) | Não |
| Dados financeiros | [SE APLICÁVEL - JUSTIFICAR BASE LEGAL] | Não* |
| Dados de saúde | [APENAS SE FUNDAMENTADO NO ART. 9º] | Sim** |

\* Dados financeiros apenas com fundamento legal adequado
\*\* Dados sensíveis apenas com fundamento no Art. 9º (consentimento explícito, interesse vital, etc.)

#### 3.3 Dados NÃO Tratados

- Números de identificação civil (exceto quando estritamente necessário)
- Dados biométricos
- Dados relativos a condenações criminais (exceto quando legalmente autorizado)
- [ADICIONAR OUTROS]

---

### 4. Técnica de Tratamento: LLM Local

#### 4.1 Descrição Técnica

**Arquitetura do Sistema:**
```
┌─────────────────────────────────────────────────────────────┐
│                    HARDWARE LOCAL                          │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   Input      │───▶│  LLM Local   │───▶│   Output     │  │
│  │  (Documento) │    │  (Offline)   │    │  (Análise)   │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│         │                                            │      │
│         └────────────────────────────────────────────┘      │
│                    (NUNCA SAI DO PC)                        │
└─────────────────────────────────────────────────────────────┘
```

**Componentes:**
- Software: Ollama (open-source)
- Modelos: Llama 3.2 8B, Mistral 7B, Qwen 2.5 (todos open-source)
- Hardware: GPU local (RTX 2060 6GB) / CPU
- Armazenamento: Disco local encriptado

#### 4.2 Características RGPD-Relevantes

| Aspeto | Descrição | Benefício RGPD |
|--------|-----------|----------------|
| **Localização** | 100% local, sem cloud | Não há transferência de dados |
| **Conectividade** | Funciona offline | Zero risco de vazamento na rede |
| **Controlo** | Administrador local | Controlo total do processamento |
| **Modelos** | Open-source auditable | Transparência de algoritmos |
| **Retenção** | Definida localmente | Cumprimento do Art. 5º, 1, e) |

#### 4.3 Ausência de Subcontratação

**Declaração importante:**
> Não existe subcontratação do tratamento (Art. 28º RGPD). Todo o processamento é efetuado no hardware próprio da entidade responsável, sem recurso a serviços de cloud ou terceiros.

**Fundamentação:**
- O modelo de IA é executado localmente
- Não há transmissão de dados para servidores externos
- Não há entidade externa com acesso aos dados
- A manutenção técnica é efetuada internamente

---

### 5. Transferências Internacionais

#### 5.1 Declaração

**NÃO EXISTEM TRANSFERÊNCIAS INTERNACIONAIS.**

Todos os dados pessoais são processados exclusivamente no hardware local situado em território nacional/português.

#### 5.2 Justificação

| Questão | Resposta |
|---------|----------|
| Dados saem do hardware local? | NÃO |
| Existe cloud envolvida? | NÃO |
| Modelos são descarregados de onde? | Hugging Face / Ollama Registry (apenas o modelo, não os dados) |
| Atualizações requerem internet? | SIM, mas apenas para download do software/modelo |
| Processamento requer internet? | NÃO |

**Nota:** O download de modelos open-source (pesos do modelo) não constitui transferência de dados pessoais ao abrigo do RGPD, pois:
1. Os modelos não contêm dados pessoais identificáveis
2. O download é de software/modelo, não de dados de titulares
3. Os modelos são pré-treinados e públicos

---

### 6. Prazos de Conservação

| Tipo de Dado | Prazo | Fundamento |
|--------------|-------|------------|
| **Inputs** (documentos submetidos) | 30 dias após processamento | Minimização (Art. 5º, 1, c) |
| **Outputs** (resultados gerados) | 90 dias ou período legal específico | Finalidade do contrato |
| **Logs de sistema** | 1 ano | Segurança e accountability |
| **Backups** | 30 dias | Recuperação de desastres |

#### 6.1 Procedimento de Eliminação

```bash
# Comando para limpeza de inputs antigos
find /path/to/inputs -type f -mtime +30 -delete

# Comando para limpeza de outputs antigos  
find /path/to/outputs -type f -mtime +90 -delete

# Limpeza de logs (mantendo 1 ano)
journalctl --vacuum-time=1year
```

#### 6.2 Rotina Automatizada

[CRIAR CRON JOB OU SCRIPT AUTOMÁTICO]

---

### 7. Medidas de Segurança (Art. 32º)

#### 7.1 Medidas Técnicas

| Medida | Implementação | Estado |
|--------|--------------|--------|
| Encriptação em repouso | LUKS (Linux Unified Key Setup) | ✅ Implementado |
| Encriptação em trânsito | N/A (tudo local) | ✅ Não aplicável |
| Controlo de acesso | Autenticação do sistema operativo | ✅ Implementado |
| Logs de auditoria | Systemd journal + logs de aplicação | ✅ Implementado |
| Backups | Backups regulares para disco externo | ✅ Implementado |
| Atualizações de segurança | Atualizações automáticas do SO | ✅ Implementado |
| Firewall | UFW (Uncomplicated Firewall) | ✅ Implementado |
| Antivírus | ClamAV / integrado no SO | ✅ Implementado |

#### 7.2 Medidas Organizacionais

| Medida | Descrição | Responsável |
|--------|-----------|-------------|
| Política de uso aceitável | Documento definindo uso permitido | [NOME] |
| Formação de utilizadores | Sessões de sensibilização para RGPD | [NOME] |
| Gestão de incidentes | Procedimento de resposta a incidentes | [NOME] |
| Auditorias periódicas | Revisão trimestral de logs e acessos | [NOME] |

---

### 8. Direitos dos Titulares

#### 8.1 Procedimentos

| Direito | Procedimento | Prazo de Resposta |
|---------|--------------|-------------------|
| **Acesso** (Art. 15º) | Consulta de logs e outputs | 30 dias |
| **Retificação** (Art. 16º) | Correção manual se aplicável | 30 dias |
| **Apagamento** (Art. 17º) | Eliminação de inputs/outputs | 30 dias |
| **Limitação** (Art. 18º) | Suspensão temporária | Imediata |
| **Portabilidade** (Art. 20º) | Exportação em formato legível | 30 dias |
| **Oposição** (Art. 21º) | Cessação de processamento | Imediata |

#### 8.2 Contacto para Exercício de Direitos

**Email:** [EMAIL DO DPO/EPD]  
**Morada:** [MORADA PARA CORRESPONDÊNCIA]  
**Telefone:** [TELEFONE]  
**Horário:** [HORÁRIO DE ATENDIMENTO]

---

### 9. Decisões Automatizadas (Art. 22º)

#### 9.1 Avaliação

| Questão | Resposta |
|---------|----------|
| O sistema toma decisões automatizadas? | NÃO |
| O sistema perfila titulares? | NÃO |
| O sistema avalia candidatos automaticamente? | NÃO |
| O sistema determina acesso a serviços? | NÃO |

#### 9.2 Natureza do Sistema

O LLM local funciona como **ferramenta de apoio à decisão humana**, não como decisor autónomo.

**Fluxo de trabalho:**
```
Input → LLM Local → Sugestão/Análise → Revisão Humana → Decisão Final
              ↑                              ↓
              └────── Não vinculativo ──────┘
```

**Salvaguardas:**
- Todos os outputs são revistos por pessoa antes de uso externo
- O LLM não tem capacidade de execução automática
- Não existe integração com sistemas de decisão automatizada

---

### 10. Avaliação de Impacto à Proteção de Dados (AIPD)

#### 10.1 Necessidade de AIPD

| Critério | Aplicável? | Justificação |
|----------|-----------|--------------|
| Avaliação sistemática de aspetos pessoais? | NÃO | Não há perfilação |
| Tratamento em larga escala de categorias especiais? | NÃO | Não tratamos dados Art. 9º |
| Monitorização sistemática de área acessível ao público? | NÃO | Não há vigilância |

**Conclusão:** AIPD **NÃO É OBRIGATÓRIA** para esta atividade.

#### 10.2 AIPD Voluntária

[SE REALIZADA, ANEXAR DOCUMENTO AIPD]

---

### 11. Informação ao Titular (Art. 13º/14º)

#### 11.1 Campos de Informação

| Informação | Onde é Fornecida |
|------------|------------------|
| Identidade do responsável | Contrato / Termos de serviço |
| Contacto do EPD | Política de privacidade |
| Finalidades do tratamento | Contrato / Informação prévia |
| Base legal | Contrato / Informação prévia |
| Destinatários | [Ver ponto 5 - não existem] |
| Transferências internacionais | [Ver ponto 5 - não existem] |
| Prazos de conservação | [Ver ponto 6] |
| Direitos do titular | [Ver ponto 8] |
| Direito de reclamar à CNPD | Informação prévia |
| Existência de decisões automatizadas | [Ver ponto 9] |

#### 11.2 Forma de Informação

- [ ] Informação escrita (contrato)
- [ ] Política de privacidade no website
- [ ] Informação verbal em reunião inicial
- [ ] Documento específico para o serviço

---

### 12. Revisão e Atualização

#### 12.1 Periodicidade de Revisão

| Tipo | Frequência | Próxima Revisão |
|------|-----------|-----------------|
| Revisão regular | Anual | 2026-02-26 |
| Revisão após incidente | Imediata | N/A |
| Revisão após alteração significativa | Imediata | N/A |

#### 12.2 Registo de Alterações

| Versão | Data | Alteração | Responsável |
|--------|------|-----------|-------------|
| 1.0 | 2025-02-26 | Criação inicial | [NOME] |
| | | | |

---

### 13. Anexos

#### Anexo A: Especificação Técnica do Sistema
- [Link para documentação técnica](../docs/technical_spec.md)

#### Anexo B: Política de Uso Aceitável
- [Link para política](../templates/politica_uso.md)

#### Anexo C: Procedimento de Resposta a Incidentes
- [Link para procedimento](../docs/incident_response.md)

#### Anexo D: Logs de Auditoria (Exemplo)
```
2025-02-26 10:30:15 - User admin - Acesso ao sistema
2025-02-26 10:31:22 - User admin - Modelo llama3.2:8b carregado
2025-02-26 10:35:45 - User admin - Processamento de documento [ID_HASH]
2025-02-26 10:36:12 - User admin - Output gerado e guardado
```

---

### 14. Assinaturas

**Responsável pelo Tratamento:**

Nome: _______________________________

Cargo: ______________________________

Assinatura: _________________________

Data: _______________________________

---

**Encarregado de Proteção de Dados (EPD):**

Nome: _______________________________

Assinatura: _________________________

Data: _______________________________

---

## 📋 Checklist de Validação do RAT

- [ ] Todas as categorias de dados estão identificadas
- [ ] Base legal está corretamente fundamentada
- [ ] Prazos de conservação estão definidos
- [ ] Medidas de segurança estão implementadas
- [ ] Não existem transferências internacionais (ou estão documentadas)
- [ ] Direitos dos titulares estão garantidos
- [ ] Informação ao titular está disponível
- [ ] Decisões automatizadas estão avaliadas
- [ ] Necessidade de AIPD foi verificada
- [ ] Procedimentos de resposta a incidentes existem

---

**Documento gerado pelo projeto LLM Local RGPD**  
**Template versão 1.0**  
**Licença: MIT**
