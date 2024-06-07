CREATE PROCEDURE ExcluiFuncionario
    @cpf NUMERIC(11, 0)
AS
    BEGIN TRANSACTION

    DELETE FROM funcionario
    WHERE cpf = @cpf;

    IF @@ROWCOUNT > 0
		BEGIN
			DELETE FROM pessoa
			WHERE cpf = @cpf;

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
		END
    ELSE
		BEGIN
			ROLLBACK TRANSACTION;
			RETURN 0;
		END

--TESTANDO
DECLARE @ret int
EXEC @ret = ExcluiFuncionario 98765432111;
PRINT @ret