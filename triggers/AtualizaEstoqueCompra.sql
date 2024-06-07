CREATE TRIGGER AtualizaEstoqueCompra
ON compor2 FOR INSERT
AS
BEGIN
    UPDATE produto
    SET quantidadeEstoque = quantidadeEstoque + i.quantidade
    FROM inserted i
    WHERE produto.codigoProduto = i.codigoFornecido;
END;