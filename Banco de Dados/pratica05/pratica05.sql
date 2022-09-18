-- Exercicio 01
-- Criar um banco de dados Pet no MySQL, selecionar esse banco de dados e executar as instruções relacionadas a seguir.
create database PetShop;
use PetShop;

-- Criar as tabelas equivalentes à modelagem.
create table Cliente (
idCliente int primary key auto_increment,
Primeiro_nome varchar(45),
Sobrenome varchar(45),
telefoneFixo char(11),
telefoneCel char(11),
Rua varchar(45),
Bairro varchar(45),
Cidade varchar(45),
numero varchar(10)
);

create table Pet (
idPet int,
tipo varchar(45),
nome varchar(45),
raca varchar(45),
dtNasc date,
fkCliente int,
foreign key (fkCliente) references Cliente(idCliente),
primary key (fkCliente,idPet)
);


-- Inserir dados nas tabelas, de forma que exista mais de um tipo de animal diferente,
-- e que exista algum cliente com mais de um pet cadastrado. Procure inserir pelo
-- menos 2 clientes diferentes que tenham o mesmo sobrenome.

insert into Cliente values 
(null,'Murilo','Santos',null,'11987523390','Osvaldo Marques','Jd. Guarani','São Paulo', '1234'),
(null,'Roberto','Carlos',null,'11987523390','Osvaldo Perereira','Jd. Boa Vista','Santos','530'),
(null,'Jose','Carlos','11986123901','11987523390','Marcos Lima','Vila Marciano','Sorocaba','4230'),
(null,'Vinicius','Santos',null,'11987523390','Augusta','Barra-Funda','São Paulo','191');

insert into Pet values
(null,'cachorro','Luck','pastor alemão','2015-11-09',1),
(null,'gato','Lice','Siamês','2010-11-30',1),
(null,'passaro','Carlos','calopsita','2020-12-19',2),
(null,'gato','lua','Siamês','2009-01-18',2),
(null,'tigre','Listrado','pastor alemão','2019-02-17',3),
(null,'passaro','Quico','piriquito','2022-03-27',3),
(null,'cachorro','Mike','pastor alemão','2018-04-23',4),
(null,'passaro','Camara','calopsita','2018-05-21',4);

-- Exibir todos os dados de cada tabela criada, separadamente.
select * from pet;
select * from Cliente;

-- Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação
-- Altere o tamanho da coluna nome do cliente
alter table cliente modify column Primeiro_nome varchar(50);

-- Exibir os dados de todos os pets que são de um determinado tipo (por exemplo: cachorro).
select * from pet where tipo = 'gato';

-- Exibir apenas os nomes e as datas de nascimento dos pets.
select nome,dtNasc from pet;

-- Exibir os dados dos pets ordenados em ordem crescente pelo nome.
select * from pet order by nome;

-- Exibir os dados dos clientes ordenados em ordem decrescente pelo bairro.
select * from cliente order by bairro;

-- Exibir os dados dos clientes que têm o mesmo sobrenome.
select * from cliente where sobrenome = 'Santos';

-- Alterar o telefone de um determinado cliente
update cliente set TelefoneFixo = '11908712561' where idCliente = 1;

-- Exibir os dados dos clientes para verificar se alterou.
select * from cliente; 

-- Exibir os dados dos pets e dos seus respectivos donos.
select * from pet as p join cliente as c 
	on fkCliente = idCliente;
    
-- Exibir os dados dos pets e dos seus respectivos donos, mas somente de um determinado cliente.
select p.*, c.Primeiro_nome, c.sobrenome from pet as p join cliente as c 
	on fkCliente = idCliente
    where Primeiro_nome = 'Jose';
    
-- Excluir algum pet.
delete from pet where idPet = 8 and fkCliente = 4;

-- Exibir os dados dos pets para verificar se excluiu.
select * from pet;

-- Excluir as tabelas.
drop table pet;
drop table cliente;

-- Exercicio 02
/* Fazer a modelagem lógica (DER) de um sistema para armazenar os gastos
individuais das pessoas de sua família.
Crie uma entidade Pessoa, com atributos idPessoa, nome, data de nascimento,
profissão.
Crie uma outra entidade Gasto, com atributos idGasto, data, valor, descrição.
Depois de desenhado o DER, implemente no MySQL as tabelas equivalentes ao
modelo que você criou e: */

create database Gastos_Pessoa;

use Gastos_Pessoa;

create table Pessoa (
idPessoa int primary key auto_increment,
nome varchar(45),
dtNasc date,
profissao varchar(45)
);

create table Gasto( 
idGasto int auto_increment,
dataGasto date,
valor decimal (8,2),
descricao varchar(45),
fkPessoa int,
foreign key (fkPessoa) references Pessoa(idPessoa),
primary key (idGasto,fkPessoa)
);

-- Insira dados nas tabelas.
insert into Pessoa values 
(null,'Marcos','2000-01-30','Engenheiro'),
(null,'Laura','1999-06-30','Administradora'),
(null,'Pedro','1989-02-12','Programador');

insert into Gasto values
(null,'2020-12-31', 1000.10,'Máquina de lavar',1),
(null,'2021-11-20', 150.40,'McDonalds',1),
(null,'2022-10-23', 200.10,'Farol do carro',2),
(null,'2021-09-26', 300.50,'Outback',2),
(null,'2022-08-10', 15000.00,'Iphone 13 pro max',3),
(null,'2021-09-11', 4000.99,'Computador dell i5',3);

-- Exiba os dados de cada tabela individualmente.
select * from Pessoa;
select* from gasto;

-- Exiba somente os dados de cada tabela, mas filtrando por algum dado da 
-- tabela (por exemplo, as pessoas de alguma profissão, etc).
select * from pessoa where profissao = 'programador';
select * from gasto where descricao = 'McDonalds';

-- Exiba os dados das pessoas e dos seus gastos correspondentes.
select * from pessoa join gasto 
	on fkPessoa = idPessoa;

-- Exiba os dados de uma determinada pessoa e dos seus gastos correspondentes.
select p.nome, g.* from pessoa as p join gasto as g 
	on fkPessoa = idPessoa;

-- Atualize valores já inseridos na tabela.
update gasto set descricao = 'Farol do carro Fox' where idGasto = 3;

-- Exclua um ou mais registros de alguma tabela.
delete from gasto where fkPessoa = 3;
delete from pessoa where idPessoa = 3;


-- Exercício 03
/*
3. Fazer a modelagem lógica no MySQL Workbench de um sistema para cadastrar 
os setores de uma empresa, os funcionários desses setores e os acompanhantes 
desses funcionários para uma festa que a empresa está organizando para celebrar 
o fim da pandemia.
- Cada setor pode ter mais de um funcionário.
- Cada funcionário trabalha apenas em um setor.
- Sobre cada setor, o sistema guarda um número que identifica de forma única cada 
setor. Além desse identificador, o sistema guarda o nome do setor e o número do 
andar do prédio em que fica o setor.
- Sobre cada funcionário, o sistema guarda um identificador que é a chave primária 
que identifica um funcionário de forma única. Além do identificador, o sistema 
guarda o nome do funcionário, seu telefone e seu salário (que deve ser maior do 
que zero, ou seja, o sistema não pode aceitar valores negativos ou iguais a zero.
- A empresa está organizando uma festa para celebrar o final da pandemia de Covid. 
Nessa festa, cada funcionário poderá trazer zero ou mais acompanhantes. Cada 
acompanhante só poderá estar relacionado a um funcionário.
- Sobre cada acompanhante, o sistema guarda um identificador que forma uma 
chave primária composta, juntamente com a identificação do funcionário que o 
convidou para a festa. Além disso, o sistema guarda o nome, o tipo de relação que 
o acompanhante tem com o funcionário e a data de nascimento do acompanhante.
*/

-- Escrever os comandos do MySQL para: 
-- Criar um banco de dados chamado PraticaFuncionario.
-- Selecionar esse banco de dados.
-- Criar as tabelas correspondentes à sua modelagem.

create database PraticaFuncionario;
use PraticaFuncionario;

create table setor (
idSetor int primary key auto_increment,
nome varchar(45),
andar char(3)
);

create table funcionario(
idFuncionario int primary key auto_increment,
nome varchar(45),
telefone char(11),
salario decimal (10,2),
constraint chkSalario check (salario > 0),
fkSetor int,
foreign key (fkSetor) references setor(idSetor)
);

create table acompanhante (
idAcompanhante int,
nome varchar(45),
relacao varchar (45),
dtNasc date,
fkFuncionario int,
foreign key (fkFuncionario) references funcionario(idFuncionario),
primary key(fkFuncionario,idAcompanhante)
);

-- Inserir dados nas tabelas, de forma que exista mais de um funcionário em cada setor cadastrado.
insert into setor values 
(null,'Finanças','20'),
(null,'Recursos Humanos','21'),
(null,'Administração','22');

insert into funcionario values
(null,'Murilo','11982741781',4000.00,1),
(null,'Maria','11872617389',4000.00,1),
(null,'Kebler','11982746171',3000.00,2),
(null,'Marta','11926412717',3000.00,2),
(null,'José','11673828988',5000.00,3),
(null,'Laura','11988882342',5000.00,3);

insert into acompanhante values
(1,'Joao','primo','2003-11-09',1),
(2,'Maria','prima','2001-10-10',1),
(3,'Josefa','mae','1999-09-11',2),
(4,'Pedro','pai','1998-12-12',3),
(5,'Carol','amiga','1997-11-14',4),
(6,'Rebeca','amiga','1996-10-12',5),
(7,'Raquel','prima','2000-02-15',6),
(8,'Elimar','prima','2001-01-25',6);

-- Exibir todos os dados de cada tabela criada, separadamente.
select * from setor;
select * from funcionario;
select * from acompanhante;

-- Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação.
-- Exibir os dados dos setores e dos seus respectivos funcionários.
select * from setor join funcionario 
	on fkSetor = idSetor;

-- Exibir os dados de um determinado setor (informar o nome do setor na 
-- consulta) e dos seus respectivos funcionários.
select s.nome, f.* from setor as s join funcionario as f
	on fkSetor = idSetor where s.nome = 'Administração';

-- Exibir os dados dos funcionários e de seus acompanhantes.
select f.nome as Funcionario ,a.* from funcionario as f join acompanhante as a
	on fkFuncionario = idFuncionario;

-- Exibir os dados de apenas um funcionário (informar o nome do funcionário) e 
-- os dados de seus acompanhantes.
select f.nome as Funcionario ,a.* from funcionario as f join acompanhante as a
	on fkFuncionario = idFuncionario where f.nome = 'Murilo';

-- Exibir os dados dos funcionários, dos setores em que trabalham e dos seus acompanhantes.
select s.nome as Setor, f.nome as Funcionario, a.nome as Acompanhante 
	from setor as s join funcionario as f 
		on f.fkSetor = s.idsetor
			join acompanhante as a
				on a.fkFuncionario = f.idFuncionario;
                
-- Exercicio 04
/*
. Fazer a modelagem lógica de um sistema para cadastrar os treinadores de 
nadadores, que participarão de vários campeonatos, representando o Brasil.
- Cada treinador treina mais de um nadador.
- Cada nadador tem apenas um treinador.
- Sobre cada nadador, o sistema guarda um identificador, que identifica de forma 
única cada um deles. Esse identificador começa com o valor 100 e é inserido de 
forma automática. Além desse identificador, o sistema guarda o nome, o estado de 
origem e a data de nascimento do nadador.
- Sobre cada treinador, o sistema guarda um identificador, que identifica de forma 
única cada treinador. Esse identificador começa com o valor 10 e é inserido de forma 
automática. O sistema também guarda o nome do treinador, o telefone (apenas um 
número de telefone) e o e-mail do treinador.
- Um treinador mais experiente orienta outros treinadores novatos. Cada treinador 
novato é orientado apenas por um treinador.
*/
/*
Escrever os comandos do MySQL para:
a) Criar um banco de dados chamado Treinador.
b) Selecionar esse banco de dados.
c) Criar as tabelas correspondentes à sua modelagem.
*/

create database Treinador;
use treinador;

create table treinador(
idTreinador int primary key auto_increment,
nome varchar(45),
telefone char(11),
email varchar(45),
fkTreinadorExperiente int,
foreign key (fkTreinadorExperiente) references treinador(idTreinador)
)auto_increment = 10;

create table Nadador (
idNadador int primary key auto_increment,
nome varchar(45),
estadoOrigem varchar(45),
daNasc date,
fkTreinador int null,
foreign key (fkTreinador) references treinador(idTreinador)
) auto_increment = 100;

-- d) Inserir dados nas tabelas, de forma que exista mais de um nadador para algum 
-- treinador, e mais de um treinador sendo orientado por algum treinador mais experiente.
insert into treinador values 
(null,'Murilo','18291827167','murilo@hotmail.com',null),
(null,'Maiara','12312425612','maiara@hotmail.com',10),
(null,'Robert','23423758965','robert@hotmail.com',10);


insert into nadador values 
(null, 'Maria','São Paulo','2000-04-23',10),
(null, 'Carlos','Bahia','2001-08-22',10),
(null, 'Devid','Maranhão','2002-07-21',11),
(null, 'Michael','Rio de Janeiro','2003-12-25',11),
(null, 'Giovana','Tocantins','2004-11-26',12),
(null, 'Nauana','Paraná','2005-10-27',12);

-- e) Exibir todos os dados de cada tabela criada, separadamente.
select * from treinador;
select * from nadador;

-- f) Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação das tabelas.
-- g) Exibir os dados dos treinadores e os dados de seus respectivos nadadores.
select t.nome as Treinador, n.* from treinador as t join nadador as n
	on fkTreinador = idTreinador;

-- h) Exibir os dados de um determinado treinador (informar o nome do treinador na 
-- consulta) e os dados de seus respectivos nadadores.
select t.nome as Treinador, n.* from treinador as t join nadador as n
	on fkTreinador = idTreinador where t.nome = 'Murilo';

-- i) Exibir os dados dos treinadores e os dados dos respectivos treinadores orientadores.
select  t.*,te.nome as TreinadorExperiente
	from treinador as te join treinador as t
		on t.fkTreinadorExperiente = te.idTreinador;

-- j) Exibir os dados dos treinadores e os dados dos respectivos treinadores
-- orientadores, porém somente de um determinado treinador orientador (informar o 
-- nome do treinador na consulta).
select  t.*,te.nome as TreinadorExperiente
	from treinador as te join treinador as t
		on t.fkTreinadorExperiente = te.idTreinador
			where te.nome = 'Murilo';

-- l) Exibir os dados dos treinadores, os dados dos respectivos nadadores e os dados 
-- dos respectivos treinadores orientadores.
select  te.nome as TreinadorExperiente, t.nome as TreinadorNovato, n.nome as Nadador
	from treinador as te join treinador as t
		on t.fkTreinadorExperiente = te.idTreinador
			join Nadador as n
				on n.fkTreinador = t.idTreinador;

-- m) Exibir os dados de um treinador (informar o seu nome na consulta), os dados dos 
-- respectivos nadadores e os dados do seu treinador orientador.
select  te.nome as TreinadorExperiente, t.nome as TreinadorNovato, n.nome as Nadador
	from treinador as te join treinador as t
		on t.fkTreinadorExperiente = te.idTreinador
			join Nadador as n
				on n.fkTreinador = t.idTreinador
					where t.nome = 'Maiara';

-- Exercicio 05 - DESAFIO

/*
[DESAFIO] Fazer a modelagem lógica (DER) de um sistema para UMA clínica 
médica. Supor que a clínica tem vários médicos e vários pacientes, sendo que cada 
paciente pode ser atendido por mais de um médico da clínica. E cada médico, 
obviamente, pode atender mais de um paciente. 
Sobre o paciente, o sistema guarda um identificador, o nome, o número do telefone 
(que pode ser mais de um) e o endereço. 
Sobre o médico, o sistema guarda o número de CRM (Conselho Regional de 
Medicina), que é usado como identificador do médico, o nome do médico, a 
especialidade do médico (que pode ser mais de uma) e o número de telefone do 
médico (que pode ser mais de um).
É importante também guardar a informação da data e horário de cada consulta 
realizada. 
Atenção: Não precisa ter a entidade clinica, porque não vamos armazenar dados 
de várias clínicas, apenas de uma!
Não precisa implementar no MySQL.
*/