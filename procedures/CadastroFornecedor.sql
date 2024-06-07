CREATE PROCEDURE CadastroFornecedor
    @cnpj NUMERIC(14, 0),
    @nomeEmpresa CHAR(30),
    @endereco CHAR(50)
AS
BEGIN TRANSACTION
    IF NOT EXISTS (SELECT * FROM fornecedor WHERE cnpj = @cnpj)
		BEGIN
			INSERT INTO fornecedor (cnpj, nomeEmpresa, endereco)
			VALUES (@cnpj, @nomeEmpresa, @endereco);
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
EXEC @ret = CadastroFornecedor 12345678909999, 'Empresa ABC', 'Rua Exemplo, 100';
PRINT @ret