CREATE TRIGGER AtualizaHorarioEntrega
ON pedidoVenda FOR UPDATE
AS
BEGIN
    IF UPDATE(statusPedido)
    BEGIN
        UPDATE pedidoVenda
        SET horarioEntrega = CAST(GETDATE() AS TIME)
        WHERE statusPedido = 'Entregue' AND horarioEntrega IS NULL;
    END
END;

--TESTANDO
UPDATE pedidoVenda SET statusPedido = 'Entregue' WHERE codigo = 999;