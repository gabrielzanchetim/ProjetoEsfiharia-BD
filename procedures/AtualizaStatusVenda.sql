CREATE PROCEDURE AtualizaStatusVenda
    @codigoPedido NUMERIC(10, 0),
    @novoStatus CHAR(20)
AS
BEGIN TRANSACTION
    IF @novoStatus IN ('Finalizado', 'Cancelado', 'Em andamento', 'Entregue')
		BEGIN
			UPDATE pedidoVenda
			SET statusPedido = @novoStatus
			WHERE codigo = @codigoPedido;
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
EXEC @ret = AtualizaStatusVenda @codigoPedido = 1, @novoStatus = 'Finalizado';
PRINT @ret