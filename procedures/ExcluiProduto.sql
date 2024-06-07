CREATE PROCEDURE ExcluiProduto
    @codigoProduto NUMERIC(10, 0)
AS
BEGIN
    DECLARE @tipo CHAR(20)

    SELECT @tipo = tipo
    FROM produto
    WHERE codigoProduto = @codigoProduto;

    IF @tipo = 'Produto Produzido'
    BEGIN
        DELETE FROM produtoProduzido WHERE codigoProduzido = @codigoProduto;
    END
    ELSE IF @tipo = 'Produto Fornecido'
    BEGIN
        DELETE FROM produtoFornecido WHERE codigoFornecido = @codigoProduto;
    END

    DELETE FROM produto WHERE codigoProduto = @codigoProduto;
END;

--TESTANDO
DECLARE @ret int
EXEC @ret = ExcluiProduto 20;
PRINT @ret