CREATE PROCEDURE CadastroNovaVenda
    @codigo NUMERIC(10, 0),
    @data DATE,
    @horario TIME,
    @statusPedido CHAR(20),
    @tipoPagamento CHAR(20),
    @cpfCliente NUMERIC(11, 0),
    @cpfFuncionario NUMERIC(11, 0),
    @cpfEntregador NUMERIC(11, 0) = NULL,
    @horarioEntrega TIME = NULL,
    @taxaEntrega MONEY = NULL,
    @codigoProduto NUMERIC(10, 0),
    @quantidade INT
AS
BEGIN
    BEGIN TRANSACTION;

    INSERT INTO pedidoVenda (codigo, data, horario, valorTotal, statusPedido, tipoPagamento, cpfCliente, cpfFuncionario, cpfEntregador, horarioEntrega, taxaEntrega)
    VALUES (@codigo, @data, @horario, 0, @statusPedido, @tipoPagamento, @cpfCliente, @cpfFuncionario, @cpfEntregador, @horarioEntrega, @taxaEntrega);

    IF @@ROWCOUNT > 0
    BEGIN
        INSERT INTO compor1 (codigoPedido, codigoProduto, quantidade)
        VALUES (@codigo, @codigoProduto, @quantidade);

        IF @@ROWCOUNT > 0 
        BEGIN
            DECLARE @valorTotal MONEY;
            SELECT @valorTotal = c.quantidade * p.preco
            FROM compor1 c
            INNER JOIN produto p ON c.codigoProduto = p.codigoProduto
            WHERE c.codigoPedido = @codigo;

            IF @@ROWCOUNT > 0 
            BEGIN
                UPDATE pedidoVenda
                SET valorTotal = @valorTotal
                WHERE codigo = @codigo;

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
END;

--TESTANDO
EXEC CadastroNovaVenda 
    @codigo = 4, 
    @data = '2023-03-10',
    @horario = '15:00',
    @statusPedido = 'Em Preparo',
    @tipoPagamento = 'Dinheiro',
    @cpfCliente = 12345678901,
    @cpfFuncionario = 23456789012,
    @cpfEntregador = 34567890123, 
    @horarioEntrega = NULL,
    @taxaEntrega = NULL, 
    @codigoProduto = 1001,
    @quantidade = 2;