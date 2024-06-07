CREATE VIEW ViewPrecosFornecedoresProduto
AS
SELECT
    pf.codigoFornecido AS CodigoProduto,
    p.nome AS NomeProduto,
    f.cnpj AS CNPJFornecedor,
    f.nomeEmpresa AS NomeFornecedor,
    pf.precoFornecido AS PrecoFornecido
FROM
    fornece pf
JOIN
    fornecedor f ON pf.cnpjFornecedor = f.cnpj
JOIN
    produtoFornecido pforn ON pf.codigoFornecido = pforn.codigoFornecido
JOIN
    produto p ON pforn.codigoFornecido = p.codigoProduto;

--TESTANDO

SELECT * FROM ViewPrecosFornecedoresProduto WHERE CodigoProduto = 2;