CREATE PROCEDURE RegistraCompra
    @codigoCompra NUMERIC(10, 0),
    @data DATE,
    @quantidadeItem INT,
    @statusCompra CHAR(15),
    @tipoPagamento CHAR(15),
    @cnpj NUMERIC(14, 0),
	@quantidade int,
	@precoUnitario MONEY,
	@codigoFornecido NUMERIC(10,0)
AS
BEGIN TRANSACTION;

    INSERT INTO pedidoCompra (codigoCompra, data, quantidadeItem, precoTotal, statusCompra, tipoPagamento, cnpj)
    VALUES (@codigoCompra, @data, @quantidadeItem, 0, @statusCompra, @tipoPagamento, @cnpj);

    IF @@ROWCOUNT > 0
    BEGIN
        INSERT INTO compor2 (quantidade, precoUnitario, codigoCompra, codigoFornecido)
        VALUES (@quantidade, @precoUnitario, @codigoCompra, @codigoFornecido);

        IF @@ROWCOUNT > 0 
        BEGIN
            DECLARE @valorTotal MONEY;
            SET @valorTotal = @quantidade * @precoUnitario
            IF @@ROWCOUNT > 0 
            BEGIN
                UPDATE pedidoCompra
                SET precoTotal = @valorTotal
                WHERE codigoCompra = @codigoCompra;

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
EXEC RegistraCompra 
    @codigoCompra = 105, 
    @data = '2023-03-15', 
    @quantidadeItem = 20, 
    @statusCompra = 'Pendente', 
    @tipoPagamento = 'Crédito', 
    @cnpj = 12345678901234, 
    @quantidade = 5, 
    @precoUnitario = 20.00,
    @codigoFornecido = 1003;