-- 1. Selecione as peças produzidas na última semana.
SELECT fk_partsId, DATE_FORMAT(endDate, '%d/%m/%y'), DATEDIFF(NOW(),endDate) as qtd_dias
FROM productionOrder
HAVING qtd_dias < 8;

-- 2. Encontre a quantidade total de peças produzidas por cada máquina.

SELECT fk_machineId, SUM(amount)
FROM productionSchedule
JOIN productionOrder ON fk_productionOrderId = pk_productionOrderId
GROUP BY fk_machineId
ORDER BY fk_machineId;

-- 3. Liste todas as manutenções programadas para este mês.

SELECT fk_machineId, date
FROM scheduledMaintenance
WHERE DATE_FORMAT(date,"%m%Y") = DATE_FORMAT(NOW(),"%m%Y");

-- 4. Encontre os operadores que estiveram envolvidos na produção de uma peça específica.

SELECT fk_partsId, fk_operatorId
FROM productionSchedule
JOIN productionOrder ON fk_productionOrderId = pk_productionOrderId
WHERE fk_partsId = 1;

-- 5. Classifique as peças por peso em ordem decrescente.

SELECT pk_partsId, weight
FROM parts
ORDER BY weight DESC;

-- 6. Encontre a quantidade total de peças rejeitadas em um determinado período.

SELECT SUM(amount)
FROM rejection as r
JOIN inspection as i ON i.pk_inspectionId = r.pk_inspectionId
JOIN productionOrder ON pk_productionOrderId = fk_productionOrderId
WHERE YEAR(r.date) = YEAR(NOW());

-- 7. Liste os fornecedores de matérias-primas em ordem alfabética.
SELECT pk_provider, name
FROM provider 
ORDER BY name ASC;

-- 8. Encontre o número total de peças produzidas por tipo de material.

SELECT rm.name, SUM(pd.amount) as qtd_materiais_feitos
FROM rawMaterial as rm
JOIN parts ON rm.pk_rawMaterialId = fk_rawMaterialId
JOIN productionOrder as pd ON pk_partsId = pd.fk_partsId 
GROUP BY rm.pk_rawMaterialId
ORDER BY qtd_materiais_feitos DESC;

-- 9. Selecione as peças que estão abaixo do nível mínimo de estoque.

SELECT fk_partsId, SUM(amount)
FROM productionOrder
WHERE amount < 15
GROUP BY fk_partsId;

-- 10. Liste as máquinas que não passaram por manutenção nos últimos três meses.


SELECT pk_machineId, lastMaintenance
FROM machine
WHERE DATEDIFF(NOW(),lastMaintenance) > 90;

-- 11. Encontre a média de tempo de produção por tipo de peça.

SELECT fk_partsId, ROUND(AVG(DATEDIFF(endDate,startDate)) / 30) as meses_aproximados
FROM productionOrder
GROUP BY fk_partsId
ORDER BY meses_aproximados ASC;

-- 12. Identifique as peças que passaram por inspeção nos últimos sete dias.

SELECT fk_partsId, date
FROM inspection
JOIN productionOrder ON fk_productionOrderId = pk_productionorderId
WHERE DATEDIFF(NOW(), date) < 8;

-- 13. Encontre os operadores mais produtivos com base na quantidade de peças produzidas.

SELECT fk_operatorId, SUM(amount) as qtd_pecas_produzidas
FROM productionSchedule 
JOIN productionOrder ON fk_productionOrderId = pk_productionOrderId
GROUP BY fk_operatorId
ORDER BY qtd_pecas_produzidas DESC
LIMIT 10;

-- 14. Liste as peças produzidas em um determinado período com detalhes de data e quantidade.

SELECT fk_partsId, endDate, amount
FROM productionOrder
WHERE endDate BETWEEN SUBDATE(CURRENT_DATE, INTERVAL 90 DAY) AND CURRENT_DATE
ORDER BY endDate DESC;

-- 15. Identifique os fornecedores com as entregas mais frequentes de matérias-primas.

SELECT fk_provider, dateLastBuy
FROM rawMaterial
WHERE fk_provider = 1;

-- 16. Encontre o número total de peças produzidas por cada operador.

SELECT fk_operatorId, SUM(amount) as qtd_pecas_produzidas
FROM productionSchedule
JOIN productionOrder ON pk_productionOrderId = fk_productionOrderId
GROUP BY fk_operatorId
ORDER BY qtd_pecas_produzidas;

-- 17. Liste as peças que passaram por inspeção e foram aceitas.

SELECT fk_partsId, fk_productionOrderId , result
FROM inspection
JOIN productionOrder ON fk_productionOrderId = pk_productionOrderId
WHERE result = 'APROVADO';

-- 18. Encontre as manutenções programadas para as máquinas no próximo mês.

SELECT pk_scheduledMaintenanceId, date
FROM scheduledMaintenance 
WHERE DATE_FORMAT(date,"%m%Y") = DATE_FORMAT(NOW(),"%m%Y");

-- 19. Calcule o custo total das manutenções realizadas no último trimestre.

SELECT SUM(costs)
FROM maintenanceHistory
WHERE date 
BETWEEN SUBDATE(CURRENT_DATE, INTERVAL 90 DAY) 
AND CURRENT_DATE;

-- 20. Identifique as peças produzidas com mais de 10% de rejeições nos últimos dois meses.
                    
SELECT fk_partsId, COUNT(i.pk_inspectionId) as qtd_inspecinada, COUNT(r.pk_inspectionId) as qtd_rejeitada
FROM inspection as i
LEFT JOIN rejection as r ON i.pk_inspectionId = r.pk_inspectionId
JOIN productionOrder ON pk_productionOrderId = fk_productionOrderId
WHERE DATEDIFF(NOW(),r.date) <= 60 
GROUP BY fk_partsId
HAVING qtd_rejeitada > qtd_inspecinada * 0.1;