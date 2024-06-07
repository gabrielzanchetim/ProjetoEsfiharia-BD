CREATE PROCEDURE AtualizaCliente
    @cpf NUMERIC(11, 0),
    @novoTelefone NUMERIC(11, 0),
    @novoEndereco CHAR(50)
AS
	BEGIN TRANSACTION
		UPDATE pessoa
		SET telefone = @novoTelefone, endereço = @novoEndereco
		WHERE cpf = @cpf;

		IF @@ROWCOUNT>0
			BEGIN
				COMMIT TRANSACTION
				RETURN 1
			END
		ELSE
			BEGIN
				ROLLBACK TRANSACTION
				RETURN 0
			END

--TESTANDO
DECLARE @ret int
EXEC @ret = AtualizaCliente 12345678900, 11987654321, 'Rua Nova 456'
PRINT @ret