CREATE VIEW VisaoEntregador AS
SELECT 
    pEntregador.nome AS NomeEntregador, 
    pv.codigo AS CodigoPedido, 
    pCliente.nome AS NomeCliente, 
    pv.valorTotal AS Valor,
    pv.tipoPagamento AS Pagamento,
    pCliente.endereço AS EnderecoEntrega
FROM 
    entregador e
    JOIN pedidoVenda pv ON e.cpf = pv.cpfEntregador
    JOIN cliente c ON pv.cpfCliente = c.cpf
    JOIN pessoa pEntregador ON e.cpf = pEntregador.cpf
    JOIN pessoa pCliente ON c.cpf = pCliente.cpf;

--TESTANDO
SELECT * FROM VisaoEntregador;