# ✅ Checklist de Conformidade RGPD

## Implementação de LLM Local

---

## Fase 1: Preparação (Antes de Começar)

### [ ] 1.1 Análise de Necessidade
- [ ] Identificar finalidade específica do uso de LLM
- [ ] Justificar porquê processamento local vs cloud
- [ ] Documentar decisão de arquitetura
- [ ] Avaliar volume e sensibilidade dos dados

### [ ] 1.2 Base Legal
- [ ] Definir base legal para o tratamento (Art. 6º)
- [ ] Se dados sensíveis (Art. 9º), definir fundamento específico
- [ ] Documentar análise de interesse legítimo (se aplicável)
- [ ] Preparar informação ao titular (Art. 13º/14º)

### [ ] 1.3 Equipa e Responsabilidades
- [ ] Designar responsável pelo tratamento
- [ ] Identificar Encarregado de Proteção de Dados (EPD)
- [ ] Definir utilizadores autorizados do sistema
- [ ] Estabelecer procedimentos de formação

---

## Fase 2: Implementação Técnica

### [ ] 2.1 Hardware e Infraestrutura
- [ ] Verificar requisitos mínimos de hardware
- [ ] Confirmar encriptação de disco (LUKS/BitLocker)
- [ ] Configurar acesso físico seguro ao equipamento
- [ ] Implementar sistema de backups

### [ ] 2.2 Instalação do Software
- [ ] Instalar Ollama a partir de fonte oficial
- [ ] Verificar integridade dos downloads
- [ ] Configurar variáveis de ambiente seguras
- [ ] Documentar versões instaladas

### [ ] 2.3 Configuração de Segurança
- [ ] Configurar firewall (UFW/iptables)
- [ ] Desativar acesso remoto desnecessário
- [ ] Implementar controlo de acesso ao sistema
- [ ] Configurar logging de auditoria
- [ ] Estabelecer política de passwords

### [ ] 2.4 Configuração do Ollama
- [ ] Definir `OLLAMA_GPU_OVERHEAD` adequado
- [ ] Configurar `OLLAMA_NUM_PARALLEL=1` (evitar sobreposição)
- [ ] Estabelecer `OLLAMA_KEEP_ALIVE` (retenção em memória)
- [ ] Verificar bindings apenas em localhost (127.0.0.1)
- [ ] Confirmar que não há exposição na rede

---

## Fase 3: Modelos e Dados

### [ ] 3.1 Seleção de Modelos
- [ ] Escolher modelos open-source adequados
- [ ] Verificar licenças dos modelos (Apache 2.0, etc.)
- [ ] Documentar modelos instalados e finalidades
- [ ] Avaliar necessidade de fine-tuning

### [ ] 3.2 Gestão de Dados
- [ ] Definir política de retenção de inputs
- [ ] Definir política de retenção de outputs
- [ ] Estabelecer procedimento de eliminação segura
- [ ] Configurar limpeza automática (cron jobs)

### [ ] 3.3 Procedimentos Operacionais
- [ ] Criar guidelines de uso aceitável
- [ ] Definir processo de verificação de outputs
- [ ] Estabelecer procedimento de resposta a incidentes
- [ ] Documentar fluxo de trabalho

---

## Fase 4: Documentação

### [ ] 4.1 Registo de Atividades (RAT)
- [ ] Preencher identificação da atividade
- [ ] Descrever finalidade do tratamento
- [ ] Catalogar categorias de dados pessoais
- [ ] Documentar ausência de transferências internacionais
- [ ] Definir prazos de conservação
- [ ] Listar medidas de segurança implementadas
- [ ] Descrever direitos dos titulares

### [ ] 4.2 Avaliação de Impacto (AIPD) - Se Necessário
- [ ] Verificar se critérios do Art. 35º se aplicam
- [ ] Se aplicável, realizar AIPD completa
- [ ] Documentar medidas de mitigação de riscos
- [ ] Obter autorização da CNPD se necessário

### [ ] 4.3 Políticas e Procedimentos
- [ ] Criar política de uso de IA generativa
- [ ] Documentar procedimento de revisão humana
- [ ] Estabelecer normas de classificação de dados
- [ ] Definir processo de exercício de direitos

---

## Fase 5: Verificação e Testes

### [ ] 5.1 Testes Técnicos
- [ ] Verificar funcionamento offline
- [ ] Confirmar que não há chamadas externas (wireshark/tcpdump)
- [ ] Testar recuperação de backups
- [ ] Validar procedimentos de eliminação

### [ ] 5.2 Testes de Segurança
- [ ] Verificar encriptação do disco
- [ ] Testar controles de acesso
- [ ] Validar logging de auditoria
- [ ] Simular cenário de incidente

### [ ] 5.3 Validação de Processos
- [ ] Testar exercício de direito de acesso
- [ ] Simular pedido de apagamento
- [ ] Verificar procedimento de retificação
- [ ] Validar portabilidade de dados

---

## Fase 6: Manutenção

### [ ] 6.1 Monitorização Contínua
- [ ] Revisar logs semanalmente
- [ ] Monitorizar uso de recursos
- [ ] Verificar atualizações de segurança
- [ ] Auditar acessos ao sistema

### [ ] 6.2 Atualizações
- [ ] Estabelecer calendário de atualizações
- [ ] Testar atualizações em ambiente de teste
- [ ] Documentar alterações realizadas
- [ ] Manter registo de versões

### [ ] 6.3 Revisões Periódicas
- [ ] Revisar RAT anualmente
- [ ] Atualizar análise de riscos
- [ ] Rever políticas de uso
- [ ] Formação de utilizadores

---

## Checklist Específica por Cenário

### Consultadoria Empresarial

- [ ] Contrato com cliente define uso de IA
- [ ] Clausula de confidencialidade abrange processamento automatizado
- [ ] Procedimento para dados de M&A e due diligence
- [ ] Política de retenção de documentos de cliente
- [ ] Processo de devolução/eliminação após projeto

### Ensino Superior

- [ ] Consentimento dos alunos para processamento de trabalhos
- [ ] Informação sobre uso de IA na avaliação
- [ ] Procedimento para dados de pesquisa
- [ ] Conformidade com política da instituição
- [ ] Retenção de dados de acordo com regulamentação académica

### Saúde

- [ ] Dados clínicos apenas com base no Art. 9º (consentimento explícito)
- [ ] Avaliação de impacto obrigatória
- [ ] Medidas de pseudonimização implementadas
- [ ] Consulta prévia com EPD médico
- [ ] Registo específico na CNPD

### Setor Público

- [ ] Conformidade com Lei de Proteção de Dados do setor público
- [ ] Avaliação prévia da CNPD se necessário
- [ ] Registo no inventário de tratamentos
- [ ] Conformidade com EMAG (administração eletrónica)

---

## Validação Final

Antes de colocar em produção:

- [ ] Toda a documentação está completa
- [ ] Medidas técnicas estão implementadas
- [ ] Formação dos utilizadores foi realizada
- [ ] Procedimentos de resposta a incidentes estão definidos
- [ ] EPD foi consultado e aprovou a implementação
- [ ] Testes de conformidade foram realizados com sucesso

---

## Documentos a Manter

| Documento | Localização | Periodicidade de Revisão |
|-----------|-------------|--------------------------|
| RAT | `templates/rat_llm_local.md` | Anual |
| AIPD (se aplicável) | `templates/aipd_template.md` | Após alterações significativas |
| Política de Uso | `templates/politica_uso.md` | Anual |
| Procedimento Incidentes | `docs/incident_response.md` | Anual |
| Logs de Auditoria | Sistema (journald) | 1 ano |
| Backups | Local seguro | Conforme política |

---

## Assinaturas de Validação

**Responsável pelo Tratamento:**
```
Nome: _______________________________
Assinatura: _________________________
Data: _______________________________
```

**EPD:**
```
Nome: _______________________________
Assinatura: _________________________
Data: _______________________________
```

**Técnico Responsável:**
```
Nome: _______________________________
Assinatura: _________________________
Data: _______________________________
```

---

**Documento gerado pelo projeto LLM Local RGPD**
