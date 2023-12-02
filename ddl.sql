CREATE DATABASE IF NOT EXISTS usinagem_meteor;

USE usinagem_meteor;

-- GERENCIAMENTO DE ESTOQUE DE MATÉRIA-PRIMA
CREATE TABLE IF NOT EXISTS provider(
	pk_provider			INT AUTO_INCREMENT, 
    name				VARCHAR(100) NOT NULL,
    address 			VARCHAR(150) NOT NULL,
    contact				DECIMAL(11) UNIQUE NOT NULL,
    grade    			INT NOT NULL,
    
    PRIMARY KEY (pk_provider)
);

CREATE TABLE IF NOT EXISTS rawMaterial(
	pk_rawMaterialId	INT AUTO_INCREMENT,
    name				VARCHAR(100) NOT NULL,
    amount				INT NOT NULL,
    dateLastBuy			DATE NOT NULL,
    fk_provider			INT NOT NULL,
    
    PRIMARY KEY (pk_rawMaterialId),
    FOREIGN KEY (fk_provider) REFERENCES provider (pk_provider) ON DELETE CASCADE
);

-- CONTROLE DE PRODUÇÃO

CREATE TABLE IF NOT EXISTS parts(
	pk_partsId 			INT AUTO_INCREMENT, 
    description			VARCHAR(200) NOT NULL,
    weight				DECIMAL(10,2) NOT NULL,			
    height				DECIMAL(10,2) NOT NULL,
    len					DECIMAL(10,2) NOT NULL,
    measurement         ENUM('metro','milimetro','centimetro'),
    fk_rawMaterialId	INT NOT NULL,
    width				DECIMAL(10,2) NOT NULL,
    
    PRIMARY KEY (pk_partsId),
    FOREIGN KEY (fk_rawMaterialId) REFERENCES rawMaterial (pk_rawMaterialId) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS operator(
	pk_operatorId 		INT AUTO_INCREMENT, 
    name				VARCHAR(100) NOT NULL,
    cpf 				DECIMAL(11) NOT NULL,
    specialization 		VARCHAR(50) NOT NULL,			
    avaliability		ENUM('Manhã','Tarde','Noite') NOT NULL,
    weeklyWorkingDays	INT NOT NULL,
    
    PRIMARY KEY (pk_operatorId)
);



CREATE TABLE IF NOT EXISTS machine(
	pk_machineId		INT AUTO_INCREMENT, 
    name				VARCHAR(100),
    description 		VARCHAR(200) NOT NULL,			
    max_capacity		INT NOT NULL,
    lastMaintenance		DATE NOT NULL,
    status 				ENUM('funcionando','quebrada'),
    
    PRIMARY KEY (pk_machineId)
);

CREATE TABLE IF NOT EXISTS productionOrder(
	pk_productionOrderId 	INT AUTO_INCREMENT,
	fk_partsID				INT,
	amount					INT NOT NULL,
	startDate				DATETIME NOT NULL,
	endDate					DATETIME NOT NULL,
	status					VARCHAR(30) DEFAULT 'FAZER',
	lote					VARCHAR(100) NOT NULL,
    
    PRIMARY KEY (pk_productionOrderId),
    FOREIGN KEY (fk_partsID) REFERENCES parts(pk_partsID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS productionSchedule(
	pk_productionScheduleId INT AUTO_INCREMENT,
	fk_operatorId			INT,
	fk_productionOrderId	INT,	
	fk_machineId			INT,
	startDateTime			DATETIME,
	endDateTime				DATETIME,
    
    PRIMARY KEY (pk_productionScheduleId),
    FOREIGN KEY (fk_operatorId) REFERENCES operator(pk_operatorId) ON DELETE CASCADE,
    FOREIGN KEY (fk_productionOrderId) REFERENCES productionOrder(pk_productionOrderId) ON DELETE CASCADE,
    FOREIGN KEY (fk_machineId) REFERENCES machine(pk_machineId) ON DELETE CASCADE
);

-- MANUTENÇÃO DE EQUIPAMENTOS


CREATE TABLE IF NOT EXISTS equipment(
	pk_euipmentId           INT AUTO_INCREMENT,
	name			        VARCHAR(100),
	description	            VARCHAR(200),	
	acquisitionDate			DATE,
	usefulLife			    DATE,
	fk_machineId			INT,
    
    PRIMARY KEY (pk_euipmentId),
    FOREIGN KEY (fk_machineId) REFERENCES machine(pk_machineId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS scheduledMaintenance(
	pk_scheduledMaintenanceId       INT AUTO_INCREMENT,
	fk_machineId	                INT,	
	date			            	DATETIME,
	type			            	ENUM('preventiva', 'preditiva','corretiva','parada','baesada no tempo'),
	responsible				    	VARCHAR(100),
    
    PRIMARY KEY (pk_scheduledMaintenanceId),
	FOREIGN KEY (fk_machineId) REFERENCES machine(pk_machineId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS maintenanceHistory(
	pk_maintenanceHistoryId         INT AUTO_INCREMENT,
	fk_machineId	                INT,	
	date			            	DATETIME,
	type			            	ENUM('preventiva', 'preditiva','corretiva','parada','baesada no tempo'),
	costs				    		DECIMAL(10,2),
    
    PRIMARY KEY (pk_maintenanceHistoryId),
    FOREIGN KEY (fk_machineId) REFERENCES machine(pk_machineId) ON DELETE CASCADE
);


-- Controle de Qualidade de Peças:

CREATE TABLE IF NOT EXISTS inspection(
	pk_inspectionId         			INT AUTO_INCREMENT,
	observations	                    VARCHAR(300),	
	date			            		DATE,
	fk_productionOrderId				INT,
    result                      		ENUM('aprovado','reprovado', 'andamento'),
    
    PRIMARY KEY (pk_inspectionId),
    FOREIGN KEY (fk_productionOrderId) REFERENCES productionOrder(pk_productionOrderId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS acceptance(
	pk_inspectionId             INT AUTO_INCREMENT,
	observations	            VARCHAR(300),	
	date			            DATE,
    destination                 VARCHAR(150),

    PRIMARY KEY (pk_inspectionId),
    FOREIGN KEY (pk_inspectionId) REFERENCES inspection(pk_inspectionId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rejection(
	pk_inspectionId              INT AUTO_INCREMENT,
	reason	                    VARCHAR(300),	
	date			            DATE,
    correctiveActions           VARCHAR(150),

    PRIMARY KEY (pk_inspectionId),
    FOREIGN KEY (pk_inspectionId) REFERENCES inspection(pk_inspectionId) ON DELETE CASCADE
);

SELECT COUNT(*) 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'usinagem_meteor';