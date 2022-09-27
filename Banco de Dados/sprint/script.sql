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

-- Atributo composto de mais de 2 itens 
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
tier CHAR(1),
andar CHAR(2),
qtdRack INT
);

-- Entidade Forte
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
(NULL,'SPTech','38735516000157','11939289129',NULL,'Matriz','sptech@sptech.school','senhaSPTECH'),
(NULL,'Facebook','14857417000180','21926747238','22998172289','Matriz','facebook@hotmail.com','senhaFACEBOOK'),
(NULL,'Microsoft','83483534000143','13987652678','14908723336','Matriz','microsoft@hotmail.school','senhaMicrosoft');

INSERT INTO Endereco VALUES 
(1,1,'Rua Haddock Lobo','Consolação','595','01414000','Prédio'),
(1,2,'Rua Washinton Luis','Toronto','1000B','92847189','Empresa'),
(1,3,'Rua Microsoft Silva','New Yeah','1235','02938173','Empresa');

INSERT INTO DataCenter VALUES
(1,1,'2','25',5),
(1,2,'4','30',20),
(2,2,'4','22',25),
(1,3,'4','12',30),
(2,3,'4','05',40);

INSERT INTO Dispositivo VALUES
(NULL,'1298AN','DHT-11',1,1),
(NULL,'982NAS','DHT-11',1,2),
(NULL,'ERT453','DHT-11',2,2),
(NULL,'192SD1','DHT-11',1,3),
(NULL,'123JAS','DHT-11',2,3);

INSERT INTO METRICA VALUES 
(1,1,50.5,19.2,'2022-09-12 09:23:00'),
(2,1,30.5,11.2,'2022-08-12 08:22:00'),
(1,2,50.9,10.3,'2022-07-12 07:23:00'),
(2,2,20.5,49.4,'2022-06-12 06:24:00'),
(1,3,17.5,59.5,'2022-05-12 05:25:00'),
(2,3,12.5,19.6,'2023-04-12 04:26:00'),
(1,4,07.5,39.7,'2023-03-12 03:27:00'),
(2,4,03.5,49.8,'2023-02-12 02:28:00'),
(1,5,40.5,19.9,'2023-01-12 01:29:00'),
(2,5,10.5,29.2,'2023-12-12 00:20:00');
