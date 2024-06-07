CREATE VIEW ProdutosSemFornecedor AS
SELECT p.codigo, p.nome, p.quantidadeEstoque
FROM produto p
LEFT JOIN fornece f ON p.codigoProduto = f.codigoFornecido
WHERE f.codigoFornecido IS NULL && p.tipo = 'Produto Fornecido';

--TESTANDO
SELECT * FROM ProdutosSemFornecedor;

Visualização limitada para saber o status do pedido de compra
CREATE VIEW ViewDetalhesPedidoCompraLimitada
AS
SELECT
    pc.codigoCompra AS CodigoCompra,
    pc.statusCompra AS StatusCompra,
    pc.precoTotal AS ValorTotal,
    f.nomeEmpresa AS NomeFornecedor,
    pc.data AS Data,
    pc.tipoPagamento AS TipoPagamento
FROM
    pedidoCompra pc
JOIN
    fornecedor f ON pc.cnpj = f.cnpj;

--TESTANDO

SELECT * FROM ViewDetalhesPedidoCompraLimitada;