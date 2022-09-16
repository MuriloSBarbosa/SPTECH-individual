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
