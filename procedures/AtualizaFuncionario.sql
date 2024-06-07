CREATE PROCEDURE AtualizaFuncionario
    @cpf NUMERIC(11, 0),
    @novoSalario MONEY,
    @novoCargo CHAR(20),
    @novoEndereco CHAR(50),
    @novoTelefone NUMERIC(11, 0)
AS
    BEGIN TRANSACTION;

    UPDATE funcionario
    SET salario = @novoSalario, cargo = @novoCargo
    WHERE cpf = @cpf;

    IF @@ROWCOUNT > 0
		BEGIN
			UPDATE pessoa
			SET endereço = @novoEndereco, telefone = @novoTelefone
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

DECLARE @ret int
EXEC @ret = AtualizaFuncionario 98765432111, 3500.00, 'Supervisor', 'Nova Rua, Novo Bairro',12345678901;
PRINT @ret