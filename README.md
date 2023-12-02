# Projeto de banco de dados para uma empresa de Usinagem

A empresa de usinagem Meteor, especializada na produção de peças de precisão para a indústria aeroespacial, enfrenta desafios relacionados à otimização da produção e ao controle de qualidade. A demanda por peças está aumentando, e a empresa enfrenta **problemas de manutenção de equipamentos e controle de qualidade das peças produzidas**.
Além disso, a empresa está lidando com **desafios de gerenciamento de estoque de matérias-primas**
, pois a disponibilidade oportuna de matérias-primas de alta qualidade é essencial para atender à demanda do mercado.
Os problemas específicos que precisam ser abordados incluem:

A **má utilização das máquinas**, resultando em tempos de inatividade e atrasos na produção.
Incapacidade de manter um controle eficiente sobre as manutenções programadas, levando a falhas inesperadas das máquinas.
Inconsistências na qualidade das peças produzidas, resultando em um aumento no número de peças rejeitadas.
Desafios no gerenciamento do estoque de matérias-primas, resultando em atrasos na produção devido à falta de matéria-prima adequada.
Sua missão é desenvolver um sistema de banco de dados abrangente que aborde esses desafios, com foco na otimização da produção, no controle eficaz da qualidade das peças e na gestão eficiente do estoque de matérias-primas. Além disso, você deve propor soluções práticas para minimizar o tempo de inatividade das máquinas, melhorar os processos de manutenção e implementar práticas de controle de qualidade robustas para reduzir as taxas de rejeição das peças produzidas.

## Estrutura das tabelas


###  Gerenciamento de Estoque de Matérias-Primas:

**Tabela de Matérias-Primas:** 
- ID da Matéria-Prima (Chave Primária)
- Descrição da Matéria-Prima
- Fornecedor
- Quantidade em Estoque
- Data de Última Compra

**Tabela de Fornecedores:**
- ID do Fornecedor (Chave Primária)
- Nome do Fornecedor
- Endereço
- Contato
- Avaliação do Fornecedor

### Controle de Produção de Peças:

**Tabela de Peças:**
- ID da Peça (Chave Primária)
- Descrição da Peça
- Material
- Peso
- Dimensões

**Tabela de Máquinas:**
- ID da Máquina (Chave Primária)
- Nome da Máquina
- Descrição
- Capacidade Máxima
- Última Manutenção

**Tabela de Ordens de Produção:**
- ID da Ordem (Chave Primária)
- ID da Peça Relacionada
- Quantidade a Ser Produzida
- Data de Início
- Data de Conclusão
- Status da Ordem

**Tabela de Operadores:**
- ID do Operador (Chave Primária)
- Nome do Operador
- Especialização
- Disponibilidade
- Histórico de Produção

### Manutenção de Equipamentos:

**Tabela de Equipamentos:**
- ID do Equipamento (Chave Primária)
- Nome do Equipamento
- Descrição
- Data de Aquisição
- Vida Útil Restante

**Tabela de Manutenções Programadas:**
- ID da Manutenção (Chave Primária)
- ID do Equipamento Relacionado
- Tipo de Manutenção
- Data Programada
- Responsável pela Manutenção

**Tabela de Histórico de Manutenção:**
- ID da Manutenção (Chave Primária)
- ID do Equipamento Relacionado
- Tipo de Manutenção Realizada
- Data da Manutenção
- Custos da Manutenção

### Controle de Qualidade de Peças:

**Tabela de Inspeções:**
- ID da Inspeção (Chave Primária)
- ID da Peça Inspecionada
- Data da Inspeção
- Resultado da Inspeção
- Observações

**Tabela de Rejeições:**
- ID da Rejeição (Chave Primária)
- ID da Peça Rejeitada
- Motivo da Rejeição
- Data da Rejeição
- Ações Corretivas

**Tabela de Aceitações:**
- ID da Aceitação (Chave Primária)
- ID da Peça Aceita
- Data da Aceitação
- Destino da Peça
- Observações



## Consultas

1. Selecione todas as peças produzidas na última semana.

2. Encontre a quantidade total de peças produzidas por cada máquina.

3. Liste todas as manutenções programadas para este mês.

4. Encontre os operadores que estiveram envolvidos na produção de uma peça específica.

5. Classifique as peças por peso em ordem decrescente.

6. Encontre a quantidade total de peças rejeitadas em um determinado período.

7. Liste os fornecedores de matérias-primas em ordem alfabética.

8. Encontre o número total de peças produzidas por tipo de material.

9. Selecione as peças que estão abaixo do nível mínimo de estoque.

10. Liste as máquinas que não passaram por manutenção nos últimos três meses.

11. Encontre a média de tempo de produção por tipo de peça.

12. Identifique as peças que passaram por inspeção nos últimos sete dias.

13. Encontre os operadores mais produtivos com base na quantidade de peças produzidas.

14. Liste as peças produzidas em um determinado período com detalhes de data e quantidade.

15. Identifique os fornecedores com as entregas mais frequentes de matérias-primas.

16. Encontre o número total de peças produzidas por cada operador.

17. Liste as peças que passaram por inspeção e foram aceitas.

18. Encontre as manutenções programadas para as máquinas no próximo mês.

19. Calcule o custo total das manutenções realizadas no último trimestre.

20. Identifique as peças produzidas com mais de 10% de rejeições nos últimos dois meses.