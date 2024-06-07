CREATE PROCEDURE CadastroCliente
    @cpf NUMERIC(11, 0),
    @nome CHAR(30),
    @telefone NUMERIC(11, 0),
    @endereco CHAR(50)
AS
    BEGIN TRANSACTION
    
    INSERT INTO pessoa (cpf, nome, telefone, endereço)
    VALUES (@cpf, @nome, @telefone, @endereco);

    IF @@ROWCOUNT > 0
		BEGIN
			INSERT INTO cliente (cpf)
			VALUES (@cpf)
			IF @@ROWCOUNT > 0
				BEGIN
					COMMIT TRANSACTION
					RETURN 1
				END
			ELSE
				BEGIN
					ROLLBACK TRANSACTION
					RETURN 0
				END
		END
    ELSE
		BEGIN
			ROLLBACK TRANSACTION
			RETURN 0
		END



---TESTANDO
DECLARE @ret int
EXEC @ret = CadastroCliente 98765432100,'Maria Clara', 11987654321, 'Avenida Campinas, 261'
PRINT @ret