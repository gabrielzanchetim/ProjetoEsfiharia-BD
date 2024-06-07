CREATE PROCEDURE CadastroFuncionario
    @cpf NUMERIC(11, 0),
    @nome CHAR(30),
    @telefone NUMERIC(11, 0),
    @endereco CHAR(50),
    @codigoFuncionario NUMERIC(10, 0),
    @cargo CHAR(20),
    @dataNasc DATE,
    @salario MONEY,
    @cargaHoraria INT
AS
    BEGIN TRANSACTION
    
    INSERT INTO pessoa (cpf, nome, telefone, endereço)
    VALUES (@cpf, @nome, @telefone, @endereco);

    IF @@ROWCOUNT > 0
		BEGIN
			INSERT INTO funcionario (codigoFuncionario, cargo, dataNasc, salario, cargaHoraria, cpf)
			VALUES (@codigoFuncionario, @cargo, @dataNasc, @salario, @cargaHoraria, @cpf);

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
EXEC @ret = CadastroFuncionario 98765432111, 'Maria Oliveira', 11999886655, 'Rua dos Funcionários 321', 100, 'Gerente', '1985-08-15', 3000.00, 40;
PRINT @ret