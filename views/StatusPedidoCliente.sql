CREATE VIEW StatusPedidoCliente AS
SELECT c.cpf, pv.codigo AS CodigoPedido, pv.valorTotal AS ValorTotal, pv.statusPedido AS Status
FROM cliente c
JOIN pedidoVenda pv ON c.cpf = pv.cpfCliente;

--TESTANDO
SELECT * FROM StatusPedidoCliente;

Visualização limitada dos dados dos clientes:
CREATE VIEW VisualizacaoClientes AS
SELECT cpf, nome, telefone
FROM pessoa
WHERE cpf IN (SELECT cpf FROM cliente);

--TESTANDO
SELECT * FROM VisualizacaoClientes;
