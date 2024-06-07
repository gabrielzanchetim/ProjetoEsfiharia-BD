CREATE VIEW VisaoAtendente AS
SELECT 
    pAtendente.nome AS NomeAtendente, 
    pv.codigo AS CodigoPedido, 
    pCliente.nome AS NomeCliente, 
    pv.statusPedido AS Status
FROM 
    funcionario f
    JOIN pedidoVenda pv ON f.cpf = pv.cpfFuncionario
    JOIN cliente c ON pv.cpfCliente = c.cpf
    JOIN pessoa pAtendente ON f.cpf = pAtendente.cpf
    JOIN pessoa pCliente ON c.cpf = pCliente.cpf
WHERE 
    f.cargo = 'Atendente';

--TESTANDO
SELECT * FROM VisaoAtendente;