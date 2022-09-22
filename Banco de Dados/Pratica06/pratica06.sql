-- Exercicio 01
/*
Fazer a modelagem lógica (DER) de um sistema para cadastrar os alunos
da faculdade, seus projetos e seus acompanhantes que eles poderão
trazer no dia da apresentação final do projeto.
- Cada aluno participa apenas de um projeto.
- Cada projeto pode ter a participação de um ou mais alunos.
- Cada aluno pode trazer zero ou mais acompanhantes.
- Há alguns alunos que atuam como representantes de outros alunos.
Qualquer problema ou queixa que os alunos tiverem, devem falar com o
aluno que os representa. O aluno representante, por sua vez, reporta os
problemas/queixas à equipe de socioemocional.
- Cada aluno é representado apenas por um aluno.
- Sobre os alunos, o sistema guarda o ra (chave primária), nome, telefone.
- Sobre os projetos, o sistema guarda um identificador (chave primária),
nome e a descrição do projeto.
- Sobre os acompanhantes, o sistema guarda um identificador, nome e o
tipo de relação com o aluno (se é pai, amigo, irmão, namorado, etc).
*/
/*
Criar um banco de dados AlunoProjeto no MySQL, selecionar esse
banco de dados e executar as instruções relacionadas a seguir.
- Criar as tabelas equivalentes à modelagem. 
*/

create database AlunoProjeto;
use AlunoProjeto;

create table projeto (
idProjeto int primary key auto_increment,
nome varchar(45),
descricao varchar(45)
);

create table aluno (
RA char(8) primary key,
nome varchar(45),
telefone char(11),
fkRepresentante char(8),
foreign key (fkRepresentante) references aluno(RA),
fkProjeto int,
foreign key (fkProjeto) references projeto(idProjeto)
);

create table acompanhante (
idAcompanhante int,
fkAluno char(8),
foreign key (fkAluno) references aluno(RA),
primary key (idAcompanhante,fkAluno),
nome varchar(45),
tipoRelacao varchar(45)
);

-- Inserir dados nas tabelas.
insert into projeto values 
(null,'AlertCenter','Projeto sobre DataCenters'),
(null,'BrightTec','Projeto sobre Controle de Luz'),
(null,'VidnumTec','Projeto sobre Viníciolas');

insert into aluno values
('01222999','Luis','98474617298',null,1),
('01222111','Murilo','18393837461','01222999',1),
('01222234','Ruan','18393837461',null,2),
('01222123','Nauana','18393837461','01222123',2),
('01222235','José','18393837461',null,3),
('01222457','Matheus','18393837461','01222235',3);

insert into acompanhante values 
(1,'01222999','Maria','mãe'),
(2,'01222999','Jose','pai'),
(1,'01222111','Carlos','primo'),
(2,'01222111','Laura','irmã'),
(1,'01222234','Josefina','irmã'),
(2,'01222234','Antonio','amigo'),
(1,'01222123','Marcos','amigo');

-- Exibir todos os dados de cada tabela criada, separadamente.
select * from projeto;
select * from aluno;
select * from acompanhante;

-- Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação.
-- Exibir os dados dos alunos e dos projetos correspondentes.
select  al.nome as Aluno,
		p.nome as Projeto 
        from aluno as al join projeto as p
			on al.fkProjeto = p.idProjeto;
            
-- Exibir os dados dos alunos e dos seus acompanhantes.
select  al.nome as Aluno,
		ac.nome as Acompanhante
			from aluno as al left join acompanhante as ac
				on ac.fkAluno = al.RA;
                
-- Exibir os dados dos alunos e dos seus representantes.
select  al.nome as Aluno,
		r.nome as Representante
        from aluno as al left join aluno as r
			on al.fkRepresentante = r.RA;

-- Exibir os dados dos alunos e dos projetos correspondentes, mas somente
-- de um determinado projeto (indicar o nome do projeto na consulta).
select  al.nome as Aluno,
		p.nome as Projeto
			from aluno as al join projeto as p
				on al.fkProjeto = p.idProjeto
			where p.nome = 'AlertCenter';

-- Exibir os dados dos alunos, dos projetos correspondentes e dos seus acompanhantes.
select  al.nome as Aluno,
		p.nome as Projeto,
		a.nome as Acompanhante
			from aluno as al 
				join projeto as p
					on al.fkProjeto = p.idProjeto
				left join acompanhante as a
					on a.fkAluno = al.RA;
	
-- Exercicio 02
/*
 Fazer a modelagem lógica de um sistema para cadastrar as campanhas de
doações que surgiram devido ao Covid-19 e os organizadores dessas
campanhas
- Cada organizador organiza mais de uma campanha de doação.
- Cada campanha de doação é organizada por apenas um organizador.
- Sobre cada organizador, o sistema guarda um identificador, que identifica de
forma única cada organizador. Esse identificador começa com o valor 30 e é
inserido de forma automática. Além desse identificador, o sistema guarda o
nome, o endereço (composto pelo nome da rua e bairro) e o e-mail do
organizador.
- Sobre cada campanha de doação, o sistema guarda um identificador, que
identifica de forma única cada campanha. Esse identificador começa com o valor
500 e é inserido de forma automática. O sistema também guarda a categoria da
doação (ex: alimento ou produto de higiene, ou máscaras de proteção, etc), a
instituição para a qual será feita a doação (pode haver até 2 instituições) e a data
final da campanha.
- Um organizador mais experiente orienta outros organizadores novatos. Cada
organizador novato é orientado apenas por um organizador mais experiente.
*/
/*
Escrever os comandos do MySQL para:
a) Criar um banco de dados chamado Campanha.
b) Selecionar esse banco de dados.
c) Criar as tabelas correspondentes à sua modelagem.
*/

create database Campanha;
use campanha;

create table organizador (
idOrganizador int primary key auto_increment,
nome varchar(45),
rua varchar(45),
bairro varchar(45),
email varchar(45),
fkOrganizadorExperiente int,
foreign key (fkOrganizadorExperiente) references organizador(idOrganizador)
) auto_increment = 30;

create table campanha (
idCampanha int auto_increment,
fkOrganizador int,
foreign key (fkOrganizador) references organizador(idOrganizador),
primary key (idCampanha,fkOrganizador),
categoria varchar(45),
instituicao1 varchar(45),
instituicao2 varchar(45),
dtFinal date
) auto_increment = 500;

-- d) Inserir dados nas tabelas, de forma que exista mais de uma campanha para
-- algum organizador, e mais de um organizador novato sendo orientado por algum
-- organizador mais experiente.

insert into organizador values 
(null,'Murilo','Rua Marcio Lima','Jardim São Miguel','murilo@hotmail.com',null),
(null,'Maria','Rua Faria Lima','Jardim São Paulo','maria@hotmail.com',null),
(null,'Jose','Rua Santos Marcos','Jardim Paulista','jose@hotmail.com',30),
(null,'Robert','Rua Paulo Jose','Jardim São Matheus','robert@hotmail.com',30),
(null,'Elisa','Rua Rogerio Marta','Jardim São Miguel','elisa@hotmail.com',31),
(null,'Mariano','Rua Paulista Aparecida','Jardim Faria Lima','mariano@hotmail.com',31);

insert into campanha values
(null,30,'alimento','Hospital Matilde','Centro de Tadeu','2022-01-10'),
(null,30,'higiene','Hospital Marcos',null,'2024-02-11'),
(null,31,'máscaras','Hospital Maria','Centro de Jose','2022-01-12'),
(null,31,'material de construção','Hospital Matilda','Centro de marias','2024-01-13'),
(null,32,'alimento','Hospital Luis',null,'2022-05-14'),
(null,32,'alimento','Hospital Carlos',null,'2024-06-10'),
(null,33,'material de construção','Hospital SP','Centro de Badias','2022-01-11'),
(null,33,'alimento','Hospital RJ','Centro de Nanias','2023-07-20'),
(null,34,'máscaras','Hospital HJ',null,'2025-01-11'),
(null,34,'material de construção','Hospital PQ',null,'2032-08-18'),
(null,35,'alimento','Hospital SP','Centro de Tadeu','2042-01-19'),
(null,35,'máscaras','Hospital Matilde',null,'2023-01-10');

-- e) Exibir todos os dados de cada tabela criada, separadamente.
select * from organizador;
select * from campanha;

-- f) Fazer os acertos da chave estrangeira, caso não tenha feito no momento da
-- criação das tabelas.
-- g) Exibir os dados dos organizadores e os dados de suas respectivas campanhas.
select  o.nome as Organizador,
		c.*
		from organizador as o
			join campanha as c
				on c.fkOrganizador = o.idOrganizador;

-- h) Exibir os dados de um determinado organizador (informar o nome do organizador na consulta) 
-- e os dados de suas respectivas campanhas.
select  o.nome as Organizador,
		c.*
		from organizador as o
			join campanha as c
				on c.fkOrganizador = o.idOrganizador
		where nome = 'Murilo';

-- i) Exibir os dados dos organizadores novatos e os dados dos respectivos
-- organizadores orientadores.
select  novato.nome as Novato,
		experiente.nome as Experiente
		from organizador as novato
			join organizador as experiente
				on novato.fkOrganizadorExperiente = experiente.idOrganizador;

-- j) Exibir os dados dos organizadores novatos e os dados dos respectivos
-- organizadores orientadores, porém somente de um determinado organizador
-- orientador (informar o nome do organizador orientador na consulta).
select  novato.nome as Novato,
		experiente.nome as Experiente
		from organizador as novato
			join organizador as experiente
				on novato.fkOrganizadorExperiente = experiente.idOrganizador
		where experiente.nome = 'Maria';
                
-- l) Exibir os dados dos organizadores novatos, os dados das respectivas
-- campanhas organizadas e os dados dos respectivos organizadores orientadores.
select  o.nome as Organizador,
		c.categoria as CategoriaCampanha,
		c.instituicao1 as Insituicao1,
		c.instituicao2 as Insituicao2,
		c.dtFinal as DataFinal,
		e.nome as Orientador
			from organizador as o
				join campanha as c
					on c.fkOrganizador = o.idOrganizador
				left join organizador as e
					on o.fkOrganizadorExperiente = e.idOrganizador;
                    
-- m) Exibir os dados de um organizador novato (informar o seu nome na consulta),
-- os dados das respectivas campanhas em que trabalha e os dados do seu
-- organizador orientador.
select  o.nome as Organizador,
		c.categoria as CategoriaCampanha,
		c.instituicao1 as Insituicao1,
		c.instituicao2 as Insituicao2,
		c.dtFinal as DataFinal,
		e.nome as Orientador
			from organizador as o
				join campanha as c
					on c.fkOrganizador = o.idOrganizador
				left join organizador as e
					on o.fkOrganizadorExperiente = e.idOrganizador
			where o.nome = 'Robert';