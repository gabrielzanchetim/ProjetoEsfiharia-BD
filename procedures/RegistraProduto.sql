CREATE PROCEDURE RegistraProduto
    @codigoProduto NUMERIC(10, 0),
    @nome CHAR(30),
    @quantidadeEstoque INT,
    @categoria CHAR(20),
    @preco MONEY,
    @tipo CHAR(20),
    @codigoProduzidoFornecido NUMERIC(10, 0),
    @sabor CHAR(15) = NULL
AS
BEGIN
    BEGIN TRANSACTION;

    INSERT INTO produto (codigoProduto, nome, quantidadeEstoque, categoria, preco, tipo)
    VALUES (@codigoProduto, @nome, @quantidadeEstoque, @categoria, @preco, @tipo);

    IF @@ROWCOUNT > 0
    BEGIN
        IF @tipo = 'Produto Produzido'
        BEGIN
            INSERT INTO produtoProduzido (codigoProduzido, sabor)
            VALUES (@codigoProduzidoFornecido, @sabor);

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
        ELSE IF @tipo = 'Produto Fornecido'
        BEGIN
            INSERT INTO produtoFornecido (codigoFornecido)
            VALUES (@codigoProduzidoFornecido);

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
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN 0; 
    END
END;

--TESTANDO
DECLARE @ret int
EXEC @ret = RegistraProduto 20, 'Pizza Margherita', 100, 'Comida', 25.00, 'Produto Produzido', 20, 'Margherita';
PRINT @ret
