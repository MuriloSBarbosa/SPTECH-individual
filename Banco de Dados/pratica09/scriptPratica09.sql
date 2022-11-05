create database pratica09;

use pratica09;

-- 1,2
create table grupo(
idGrupo int primary key auto_increment,
nome varchar(45),
descricao varchar(45)
);

create table aluno (
ra char(8) primary key,
nome varchar(45),
email varchar(45),
fkGrupo int,
foreign key (fkGrupo) references grupo(idGrupo)
);

create table professor (
idProfessor int primary key auto_increment,
nome varchar(45),
disciplina varchar(45)
)auto_increment = 1000;

create table avaliacao(
fkProfessor int,
foreign key (fkProfessor) references professor(idProfessor),
fkGrupo int,
foreign key (fkGrupo) references grupo(idGrupo),
dtAvalia datetime,
nota int
);

insert into grupo values
(null,'g1','DataCenter'),
(null,'g2','Plantaçãoo de Soja');

insert into aluno values
('01222099','Jose','jose@.com',1),
('01222098','Maria','maria@.com',1),
('01222097','Pedro','pedro@.com',1),
('01222096','Guilherme','gui@.com',2),
('01222095','Carla','carla@.com',2),
('01222094','Viviane','viviane@.com',2);


insert into professor values 
(null,'Vivian','Banco de Dados'),
(null,'Paulo','Banco de Dados'),
(null,'Caramico','Projeto e Inovação'),
(null,'Joao','Projeto e Inovação');

insert into avaliacao values 
(1000,1,'2022-01-01 15:30:00',7),
(1001,1,'2022-01-01 15:30:00',8),
(1000,2,'2022-01-01 15:40:00',9),
(1002,2,'2022-01-01 15:40:00',6),
(1003,2,'2022-01-01 15:40:00',8);

-- 3
select * from grupo;
select * from aluno;
select * from professor;
select * from avaliacao;

-- 4 Feito

-- 5 
select * from grupo g join aluno a on a.fkGrupo = g.idGrupo;

-- 6
select * from grupo g join aluno a on a.fkGrupo = g.idGrupo where idGrupo = 2;

-- 7 
select avg(nota) from avaliacao;

-- 8 
select min(nota), max(nota) from avaliacao;

-- 9 
select sum(nota) from avaliacao;

-- 10 
select  p.*,
		g.*,
		a.dtAvalia,
        a.nota
		from professor p 
			join avaliacao a
				on p.idProfessor = a.fkProfessor
            join grupo g
				on g.idGrupo = a.fkGrupo;

-- 11
select  p.*,
		g.*,
		a.dtAvalia,
        a.nota
		from professor p 
			join avaliacao a
				on p.idProfessor = a.fkProfessor
            join grupo g
				on g.idGrupo = a.fkGrupo
		where g.nome = 'g2';
	
-- 12
select g.nome 
		from grupo g
			join avaliacao a
				on a.fkGrupo = g.idGrupo
			join professor p
				on p.idProfessor = a.fkProfessor
                where p.nome = 'Vivian';
                
-- 13
select  g.*,
		al.*,
		p.*,
        a.dtAvalia
		from professor p 
			join avaliacao a
				on p.idProfessor = a.fkProfessor
            join grupo g
				on g.idGrupo = a.fkGrupo
			join aluno al
				on al.fkGrupo = g.idGrupo;

-- 14
select count(distinct nota) from avaliacao;

-- 15
select  p.nome,
		avg(a.nota) as Media,
        sum(a.nota) as Soma
		from professor p
			join avaliacao a
				on a.fkProfessor = p.idProfessor
        group by p.nome;
        
-- 16
select  g.nome,
		avg(a.nota) as Media,
        sum(a.nota) as Soma
		from grupo g
			join avaliacao a
				on a.fkGrupo = g.idGrupo
        group by g.nome;
        
-- 17
select  p.nome,
		min(a.nota) as Menor,
        max(a.nota) as Maior
		from professor p
			join avaliacao a
				on a.fkProfessor = p.idProfessor
        group by p.nome;
        
-- 18
select  g.nome,
		min(a.nota) as Menor,
        max(a.nota) as Maior
		from grupo g
			join avaliacao a
				on a.fkGrupo = g.idGrupo
        group by g.nome;