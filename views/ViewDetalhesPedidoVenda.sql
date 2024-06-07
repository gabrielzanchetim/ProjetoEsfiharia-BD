CREATE VIEW ViewDetalhesPedidoVenda
AS
SELECT
    pv.codigo AS CodigoPedido,
    pFuncionario.nome AS NomeAtendente,
    pEntregador.nome AS NomeEntregador,
    pCliente.nome AS NomeCliente,
    prod.nome AS NomeProduto,
    c1.quantidade AS Quantidade,
    pv.valorTotal AS ValorTotal
FROM
    pedidoVenda pv
JOIN
    cliente c ON pv.cpfCliente = c.cpf
JOIN
    pessoa pCliente ON c.cpf = pCliente.cpf
JOIN
    funcionario f ON pv.cpfFuncionario = f.cpf
JOIN
    pessoa pFuncionario ON f.cpf = pFuncionario.cpf
LEFT JOIN
    entregador e ON pv.cpfEntregador = e.cpf
LEFT JOIN
    pessoa pEntregador ON e.cpf = pEntregador.cpf
JOIN
    compor1 c1 ON pv.codigo = c1.codigoPedido
JOIN
    produto prod ON c1.codigoProduto = prod.codigoProduto;

--TESTANDO
SELECT * FROM ViewDetalhesPedidoVenda;