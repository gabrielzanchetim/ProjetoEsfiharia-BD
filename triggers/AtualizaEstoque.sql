CREATE TRIGGER AtualizaEstoque
ON compor1 FOR INSERT
AS
BEGIN
    UPDATE produto
    SET quantidadeEstoque = quantidadeEstoque - i.quantidade
    FROM inserted i
    WHERE produto.codigoProduto = i.codigoProduto;
END;

--TESTANDO
INSERT INTO compor1 VALUES (4, 1001, 10);
















