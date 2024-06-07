CREATE PROCEDURE AtualizarPrecoProduto
    @codigoProduto NUMERIC(10, 0),
    @novoPreco MONEY
AS
BEGIN TRANSACTION
    UPDATE produto
    SET preco = @novoPreco
    WHERE codigoProduto = @codigoProduto;
	IF @@ROWCOUNT > 0 
		BEGIN
			COMMIT TRANSACTION;
			RETURN 1;
		END
	ELSE
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;
		END

--TESTANDO
DECLARE @ret int
EXEC @ret = AtualizarPrecoProduto 1001, 25.99; 
PRINT @ret