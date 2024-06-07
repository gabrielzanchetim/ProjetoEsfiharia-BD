CREATE PROCEDURE AtualizaEnderecoFornecedor
    @cnpj NUMERIC(14, 0),
    @novoEndereco CHAR(50)
AS
BEGIN TRANSACTION
    UPDATE fornecedor
    SET endereco = @novoEndereco
    WHERE cnpj = @cnpj;
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
EXEC @ret = AtualizaEnderecoFornecedor 12345678909999, 'Rua Nova, 200';
PRINT @ret