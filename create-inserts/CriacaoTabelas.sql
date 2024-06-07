use esfiharia
go 

create table pessoa (
	cpf numeric(11, 0) not null,
	nome char(30) not null,
	telefone numeric(11, 0) not null,
	endereço char(50) not null,
	primary key(cpf)
)
go

create table funcionario (
	codigoFuncionario numeric(10, 0) not null,
	cargo char(20) not null,
	dataNasc date not null,
	salario money not null,
	cargaHoraria int not null,
	cpf numeric(11, 0) not null,
	primary key (cpf),
	unique (codigoFuncionario),
	foreign key (cpf) references pessoa
)
go

create table entregador (
	cpf numeric(11, 0) not null,
	cnh numeric(11, 0) not null,
	primary key (cpf),
	foreign key (cpf) references pessoa
)
go

create table cliente (
	cpf numeric(11, 0) not null,
	primary key (cpf),
	foreign key (cpf) references pessoa
)
go

create table produto (
	codigoProduto numeric(10, 0) not null,
	nome char(30) not null,
	quantidadeEstoque int not null,
	categoria char(20) not null,
	preco money not null,
	tipo char(20) not null,
	primary key (codigoProduto)
)
go

create table produtoProduzido (
	codigoProduzido numeric(10, 0) not null,
	sabor char(15) not null,
	primary key (codigoProduzido),
	foreign key (codigoProduzido) references produto
)
go

create table produtoFornecido (
	codigoFornecido numeric(10, 0) not null,
	primary key (codigoFornecido),
	foreign key (codigoFornecido) references produto
)
go

create table usar (
	codigoProduzido numeric(10, 0) not null,
	codigoFornecido numeric(10, 0) not null,
	quantidade int not null,
	foreign key (codigoProduzido) references produtoProduzido, 
	foreign key (codigoFornecido) references produtoFornecido 
)
go

create table pedidoVenda (
	codigo numeric(10, 0) not null,
	data date not null,
	horario time not null,
	valorTotal money not null,
	statusPedido char(20) not null,
	tipoPagamento char(20) not null,
	horarioEntrega time,
	taxaEntrega money,
	cpfCliente numeric(11, 0) not null,
	cpfFuncionario numeric(11, 0) not null,
	cpfEntregador numeric(11, 0),
	primary key(codigo),
	foreign key (cpfCliente)  references cliente,
	foreign key (cpfFuncionario) references funcionario,
	foreign key (cpfEntregador) references entregador
)
go

create table compor1 (
	codigoPedido numeric(10, 0) not null,
	codigoProduto numeric(10, 0) not null,
	quantidade int not null,
	foreign key (codigoPedido) references pedidoVenda,
	foreign key (codigoProduto) references produto
)
go

create table fornecedor (
	cnpj numeric(14, 0) not null,
	nomeEmpresa char(30) not null,
	endereco char(50) not null,
	primary key (cnpj)
)
go

create table pedidoCompra (
	codigoCompra numeric(10, 0) not null,
	data date not null,
	quantidadeItem
 int not null,
	precoTotal money not null,
	statusCompra char(15) not null,
	tipoPagamento char(15) not null,
	cnpj numeric(14, 0) not null,
	primary key (codigoCompra),
	foreign key (cnpj) references fornecedor
)
go

create table compor2 (
	quantidade int not null,
	precoUnitario money not null,
	codigoCompra numeric(10, 0) not null,
	codigoFornecido numeric(10, 0) not null,
	foreign key (codigoCompra) references pedidoCompra,
	foreign key (codigoFornecido) references produtoFornecido
)
go

create table fornece (
	codigoFornecido numeric(10, 0) not null,
	cnpjFornecedor numeric(14, 0) not null,
	precoFornecido money not null,
	foreign key (codigoFornecido) references produtoFornecido,
	foreign key (cnpjFornecedor) references	fornecedor
)
go



-- INDEX PARA CHAVES ESTRANGEIRAS
create index idx_cpfFuncionario on funcionario (cpf)
create index idx_cpfEntregador on entregador (cpf)
create index idx_cpfCliente on cliente (cpf)
create index idx_codigoProduzido on produtoProduzido (codigoProduzido)
create index idx_codigoFornecido on produtoFornecido (codigoFornecido)
create index idx_codigoProduzido on usar (codigoProduzido)
create index idx_codigoFornecidoOnUsar on usar (codigoFornecido)
create index idx_cpfClienteOnPedidoVenda on pedidoVenda (cpfCliente)
create index idx_cpfFuncionarioOnPedidoVenda on pedidoVenda (cpfFuncionario)
create index idx_cpfEntregadorOnPedidoVenda on pedidoVenda (cpfEntregador)
create index idx_CodigoPedido on compor1 (codigoPedido)
create index idx_CodigoProduto on compor1 (codigoProduto)
create index idx_cnpjFornecedor on pedidoCompra (cnpj)
create index idx_codigoCompra on compor2 (codigoCompra)
create index idx_codigoFornecidoOnCompor2 on compor2(codigoFornecido)
create index idx_codigoFornecidoOnFornece on fornece (codigoFornecido)
create index idx_cnpjFornecedorOnFornece on fornece (cnpjFornecedor)
