/*
Fazer a modelagem lógica de um sistema para cadastrar os clientes, suas vendas e
seus respectivos produtos.
- Cada cliente realiza mais de uma venda.
- Cada venda é de apenas um cliente e tem mais de um produto.
- Cada produto pode ser vendido em mais de uma venda.
- Sobre cada cliente, o sistema guarda um identificador, que identifica de forma única
cada cliente. Além desse identificador, o sistema guarda o nome, o email e o
endereço.
- Sobre cada venda, o sistema guarda um identificador, que identifica de forma única
cada venda. O sistema também guarda o total da venda e a data.
- Sobre cada produto, o sistema guarda um identificador, que identifica de forma
única cada produto. Além desse identificador, o sistema guarda o nome, a descrição
e o preço do produto.
- Um cliente indica outro cliente, necessário que o sistema guarde qual cliente indicou
o outro cliente. Cada cliente pode indicar muitos clientes e cada cliente é indicado por
apenas um cliente.
- O sistema ainda precisa saber quantidade do produto vendido numa determinada
venda e o valor do desconto.
Abra no MySQL Workbench uma nova aba para fazer os comandos SQL.
Escrever os comandos do MySQL para:
a) Criar um banco de dados chamado Venda.
b) Selecionar esse banco de dados.
c) Criar as tabelas correspondentes à sua modelagem.
d) Inserir dados nas tabelas, de forma que exista mais de uma venda para cada
cliente, e mais de um cliente sendo indicado por outro cliente.
e) Exibir todos os dados de cada tabela criada, separadamente.
f) Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação
das tabelas.
*/


create database venda;

use venda;

create table cliente(
idCliente int primary key auto_increment,
nome varchar(45),
email varchar(45),
fkIndicador int,
foreign key (fkIndicador) references cliente(idCliente) 
);

create table endereco(
idEndereco int primary key auto_increment,
cep char(11),
bairro varchar(45),
cidade varchar(45)
);

create table enderecoCompleto (
fkEndereco int,
fkCliente int,
foreign key (fkEndereco) references endereco(idEndereco),
foreign key (fkCliente) references cliente(idCliente),
primary key (fkEndereco,fkCliente),
numero int,
complemento varchar(45)
);

create table produto(
idProduto int primary key auto_increment,
nome varchar(45),
descricao varchar(45),
preco decimal(10,2)
)auto_increment=100;

create table venda(
idVenda int,
fkCliente int,
fkProduto int,
foreign key (fkCliente) references cliente(idCliente),
foreign key (fkProduto) references produto(idProduto),
primary key (idVenda,fkCliente,fkProduto),
qtdProduto int,
total decimal(10,2),
dtVenda date,
desconto decimal(10,2)
);

insert into cliente values 
	(null,'Murilo','murilo@gmail.com',null),
	(null,'Jose','jose@gmail.com',1),
	(null,'Maria','maria@gmail.com',1);

INSERT INTO endereco VALUES 
	(null, '01414-905','Cerqueira Cesar', 'São Paulo'),
	(null, '04253-000','Sacomã', 'São Paulo'),
	(null, '88050-000','Centro', 'Florianópolis');

INSERT INTO enderecoCompleto VALUES
	(1,1, 1500, 'apto 100'),
	(2,2, 595, '10 andar'),
	(2,3, 595, '6 andar');
    
insert into produto values 
	(null,'celular','Apple',3500.00),
	(null,'celular','Samsung',2500.00),
	(null,'notebook','Lenovo',3500.00),
	(null,'tablet','Apple',4500.00);
    
insert into venda values 
	(1,1,100,3,(select preco * 3 from produto where idProduto = 100),20220101,20.00),
	(1,1,101,1,(select preco * 1 from produto where idProduto = 101),20220101,20.00),
	(2,1,103,5,(select preco * 5 from produto where idProduto = 103),20220110,200.00),
	(2,1,102,1,(select preco * 1 from produto where idProduto = 102),20220110,200.00),
	(1,2,103,1,(select preco * 1 from produto where idProduto = 103),20220102,20.00),
	(1,2,100,1,(select preco * 1 from produto where idProduto = 100),20220102,20.00),
	(1,3,102,3,(select preco * 3 from produto where idProduto = 102),20220103,20.00),
	(1,3,103,1,(select preco * 1 from produto where idProduto = 103),20220103,20.00);
    
select * from cliente;
select * from endereco;
select * from enderecoCompleto;
select * from produto;
select * from venda;

-- g) Exibir os dados dos clientes e os dados de suas respectivas vendas.
select c.nome,
		v.idVenda,
		v.fkProduto,
		v.qtdProduto,
        v.total,
		v.dtVenda
		from cliente as c
			join venda as v
				on c.idCliente = v.fkCliente;
                
-- h) Exibir os dados de um determinado cliente (informar o nome do cliente na consulta)
-- e os dados de suas respectivas vendas.
select c.nome,
		v.idVenda,
		v.fkProduto,
		v.qtdProduto,
        v.total,
		v.dtVenda
		from cliente as c
			join venda as v
				on c.idCliente = v.fkCliente
		where c.nome = "Murilo";
        
-- i) Exibir os dados dos clientes e de suas respectivas indicações de clientes.
select  c.nome as Cliente,
		i.nome as Indicador
			from cliente as c
				left join cliente as i
					on i.idCliente = c.fkIndicador;

-- j) Exibir os dados dos clientes indicados e os dados dos respectivos clientes
-- indicadores, porém somente de um determinado cliente indicador (informar o nome
-- do cliente que indicou na consulta).
select  c.nome as Cliente,
		i.nome as Indicador
			from cliente as c
				left join cliente as i
					on i.idCliente = c.fkIndicador
			where i.nome = "Murilo";
            
-- l) Exibir os dados dos clientes, os dados dos respectivos clientes que indicaram, os
-- dados das respectivas vendas e dos produtos.
select  c.nome as Cliente,
		i.nome as Indicador,
        v.idVenda,
        v.qtdProduto,
        p.nome as Produto,
        p.descricao,
        v.total
			from cliente as c
				left join cliente as i
					on i.idCliente = c.fkIndicador
				join venda as v
					on v.fkCliente = c.idCliente
				join produto as p
					on v.fkProduto = p.idProduto;
                    
-- m) Exibir apenas a data da venda, o nome do produto e a quantidade do produto
-- numa determinada venda.
select  v.dtVenda,
        p.nome as Produto,
        v.qtdProduto
			from venda as v
				join cliente as c
					on v.fkCliente = c.idCliente
				join produto as p
						on v.fkProduto = p.idProduto
				where v.idVenda = 1 and v.fkCliente = 1;
                    
-- n) Exibir apenas o nome do produto, o valor do produto e a soma da quantidade de
-- produtos vendidos agrupados pelo nome do produto.
select  p.nome,
		p.preco,
		sum(v.qtdProduto) as qtdProdutosVendidos
			from produto as p
				join venda as v
					on v.fkProduto = p.idProduto
			group by p.nome;
            
-- o) Inserir dados de um novo cliente. Exibir os dados dos clientes, das respectivas
-- vendas, e os clientes que não realizaram nenhuma venda.
insert into cliente values 
	(null,'Claudia','claudia@gmail.com',2);

select * from cliente as c
	left join venda as v
		on v.fkCliente = c.idCliente;
        
-- p) Exibir o valor mínimo e o valor máximo dos preços dos produtos;
select max(preco) as Maximo ,min(preco) as Minimo from produto;

-- q) Exibir a soma e a média dos preços dos produtos;
select sum(preco) as Soma, avg(preco) as Media from produto;

-- r) Exibir a quantidade de preços acima da média entre todos os produtos;
select preco from produto where preco > (select avg(preco) from produto);

-- s) Exibir a soma dos preços distintos dos produtos;
select sum(distinct preco) from produto;

-- t) Exibir a soma dos preços dos produtos agrupado por uma determinada venda;
select sum(preco) from produto as p
		join venda as v
			on p.idProduto = v.fkProduto
            where v.idVenda = 1 and fkCliente = 1 
            group by idVenda;