-- Criação da base de dados do projeto AlertCenter.

CREATE DATABASE AlertCenter;
USE AlertCenter;

-- Criação das tabelas conforme o DER.

-- Entidade Forte 
CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
CNPJ CHAR(14),
telefone1 CHAR(11),
telefone2 CHAR(11),
tipo VARCHAR(10),
-- Uma empresa pode ser Matriz ou Filial
CONSTRAINT chkTipo CHECK (tipo IN ('Matriz','Filial')), 
email VARCHAR(45),
-- Verificação básica do email e seus parâmetros
CONSTRAINT chkEmail CHECK (email LIKE '%@%.%' AND email NOT LIKE '@%' and email NOT LIKE '%.'), 
senha VARCHAR(45)
);

-- Atributo Endereco composto com mais de 2 itens 
-- Entidade Fraca (depende da Empresa)
CREATE TABLE Endereco (
idEndereco INT,
fkEmpresa INT UNIQUE,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
PRIMARY KEY (idEndereco,fkEmpresa),
rua VARCHAR(45),
bairro VARCHAR(45),
numero CHAR(5),
cep CHAR(8),
complemento VARCHAR(45)
);

-- Entidade Fraca (depende da Empresa)
CREATE TABLE DataCenter(
idDataCenter INT,
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
PRIMARY KEY (idDatacenter,fkEmpresa),
descricao varchar(45),
tier CHAR(1),
andar CHAR(2),
qtdRack INT
);

-- Entidade Forte (nós forneceremos os dispositivos)
CREATE TABLE Dispositivo (
idDispositivo INT PRIMARY KEY AUTO_INCREMENT,
numeroSerie VARCHAR(10),
descricao VARCHAR(45),
fkDataCenter INT,
fkEmpresa INT,
FOREIGN KEY (fkDataCenter) REFERENCES DataCenter(idDataCenter),
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

-- Entidade Fraca (depende do Dispotivo)
CREATE TABLE Metrica (
idMetrica INT,
fkDispositivo INT,
FOREIGN KEY (fkDispositivo) REFERENCES Dispositivo(idDispositivo),
PRIMARY KEY (idMetrica,fkDispositivo),
temperatura DOUBLE,
umidade DOUBLE,
dtMetrica DATETIME
);


-- Inserindo dados nas tabelas.

INSERT INTO Empresa VALUES
(NULL,'SPTech','38735516000157','11939289129',NULL,'Matriz','sptech@sptech.school','senhASPTECH'),
(NULL,'Facebook','14857417000180','21926747238','22998172289','Matriz','facebook@hotmail.com','senhaFACEBOOK'),
(NULL,'Microsoft','83483534000143','13987652678','14908723336','Matriz','microsoft@hotmail.school','senhaMicrosoft');

INSERT INTO Endereco VALUES 
(1,1,'Rua Haddock Lobo','Consolação','595','01414000','Prédio'),
(1,2,'Rua WAShinton Luis','Toronto','1000B','92847189','Empresa'),
(1,3,'Rua Microsoft Silva','New Yeah','1235','02938173','Empresa');

-- Dois Data Center para Facebook e Microsoft, mostrando que uma empresa pode ter um ou mais.
INSERT INTO DataCenter VALUES
(1,1,'SPTech-2319','2','25',1),
(1,2,'Facebook-2039','4','30',2),
(2,2,'Facebook-4920','4','22',2),
(1,3,'Microsoft-1298','4','12',2),
(2,3,'Microsoft-2491','4','05',2);

-- Um dispositivo por Rack.
INSERT INTO Dispositivo VALUES
(NULL,'1298AN','DHT-11',1,1),
(NULL,'982NAS','DHT-11',1,2),
(NULL,'ERT453','DHT-11',1,2),
(NULL,'192SD1','DHT-11',2,2),
(NULL,'123JAS','DHT-11',2,2),
(NULL,'493NSM','DHT-11',1,3),
(NULL,'929FNW','DHT-11',1,3),
(NULL,'029DMV','DHT-11',2,3),
(NULL,'234AJE','DHT-11',2,3);

-- Duas métricas testes por dispositivo.
INSERT INTO METRICA VALUES 
(1,1,50.5,19.2,'2022-09-12 09:23:00'),
(2,1,30.5,11.2,'2022-08-12 08:22:00'),
(1,2,50.9,10.3,'2022-07-11 07:23:00'),
(2,2,20.5,49.4,'2022-06-12 06:24:00'),
(1,3,17.5,59.5,'2022-05-11 05:25:00'),
(2,3,12.5,19.6,'2022-04-11 04:26:00'),
(1,4,07.5,39.7,'2022-03-13 03:27:00'),
(2,4,03.5,49.8,'2022-02-14 02:28:00'),
(1,5,44.5,29.9,'2022-01-15 01:29:00'),
(2,5,35.5,39.8,'2022-09-16 00:29:00'),
(1,6,30.5,49.7,'2022-08-17 09:19:00'),
(2,6,20.5,19.6,'2022-07-18 08:29:00'),
(1,7,50.6,29.5,'2022-06-19 07:19:00'),
(2,7,30.7,29.4,'2022-12-14 06:23:00'),
(1,8,30.8,49.3,'2022-11-17 05:24:00'),
(2,8,20.9,29.2,'2022-12-12 04:25:00'),
(1,9,03.5,19.1,'2022-11-11 03:26:00'),
(2,9,12.5,09.1,'2022-12-14 02:27:00');


-- Comandos de Consulta

-- Consultar as tabelas separadamente 
SELECT * FROM Empresa;
SELECT * FROM DataCenter;
SELECT * FROM Dispositivo;
SELECT * FROM Endereco;
SELECT * FROM Metrica;

-- Consulta de Tabelas Relacionadas

-- Consultar as empresas e seus respectivos endereços.
SELECT  empresa.nome AS Empresa, 
		endereco.rua,
        endereco.bairro,
        endereco.numero,
        endereco.cep,
        endereco.complemento
			FROM Empresa AS empresa JOIN Endereco AS endereco
				ON endereco.fkEmpresa = empresa.idEmpresa;
                
-- Consultar informações dos Data Centers e suas respectivas Empresas.
SELECT  e.nome AS Empresa, 
		dc.idDataCenter,
		dc.descricao,
		dc.tier,
        dc.andar,
        dc.qtdRack
			FROM Empresa AS e JOIN DataCenter AS dc
				ON dc.fkEmpresa = e.idEmpresa;

-- Consultar todos os dispositivos presentes nos DataCenters de suas respectivas empresas.
SELECT  e.nome AS Empresa,
		dc.idDataCenter,
		dc.descricao AS 'DataCenter Descrição',
		dc.qtdRack,
		dis.idDispositivo,
		dis.numeroSerie AS 'Numero Serie do Dispositivo',
		dis.descricao AS 'Nome Dispositivo'
			FROM Empresa AS e 
				JOIN DataCenter AS dc
					ON dc.fkEmpresa = e.idEmpresa
				JOIN Dispositivo AS dis
					ON dis.fkDataCenter = dc.idDataCenter AND dis.fkEmpresa = dc.fkEmpresa;
                    
-- Consultar os Dispositivos e suas Métricas
SELECT  dis.idDispositivo,
		dis.numeroSerie,
		dis.descricao,
		m.temperatura,
		m.umidade,
		m.dtMetrica
			FROM Dispositivo AS dis LEFT JOIN Metrica AS m
				ON m.fkDispositivo = dis.idDispositivo;
                
-- Consultar quantos dispositivos tem em uma determinada Empresa
SELECT  e.nome AS Empresa,
		dis.idDispositivo,
		dis.numeroSerie,
		dis.descricao
			FROM Empresa AS e
				JOIN DataCenter AS dc
					ON dc.fkEmpresa = e.idEmpresa
				JOIN Dispositivo AS dis
					ON dis.fkDataCenter = dc.idDataCenter AND dis.fkEmpresa = dc.fkEmpresa
			WHERE e.nome = 'Facebook';

-- Consulta do nome das Empresas, seu endereço (somente o CEP e número), 
-- a descrição dos seus respectivos Data Centers e o numero de série dos dispositivos.
SELECT  empresa.nome AS Empresa,
		endereco.cep AS CEP,
		endereco.numero,
        dc.descricao AS 'Data Center',
        dis.numeroSerie AS Dispositivo
			FROM Empresa AS empresa
				JOIN Endereco AS endereco 
					ON endereco.fkEmpresa = empresa.idEmpresa
				JOIN DataCenter AS dc
					ON dc.fkEmpresa = empresa.idEmpresa
				JOIN Dispositivo AS dis
					ON dis.fkDataCenter = dc.idDatacenter AND dis.fkEmpresa = dc.fkEmpresa;