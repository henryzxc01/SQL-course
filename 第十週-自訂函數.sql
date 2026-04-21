CREATE FUNCTION fn_CalcOrderAmount
(
    @Order_ID VARCHAR(20)
)
RETURNS INT
AS
BEGIN
    DECLARE @Amount INT;

    SELECT @Amount = g.price * o.quantity
    FROM [Order] o
    JOIN Goods g ON o.Goods_ID = g.Goods_ID
    WHERE o.Order_ID = @Order_ID;

    RETURN @Amount;
END;
GO

CREATE FUNCTION fn_GetMemberTotalAmount
(
    @Member_ID VARCHAR(20)
)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;

    SELECT @Total = SUM(dbo.fn_CalcOrderAmount(o.Order_ID))
    FROM [Order] o
    WHERE o.Member_ID = @Member_ID;

    RETURN @Total;
END;
GO

CREATE PROCEDURE sp_GetMemberOrderReport
(
    @Member_ID VARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- 檢查會員是否存在
    IF NOT EXISTS (SELECT 1 FROM Member WHERE Member_ID = @Member_ID)
    BEGIN
        PRINT '錯誤：會員不存在';
        RETURN;
    END

    PRINT '===== 該會員訂單明細 =====';

    SELECT 
        o.Order_ID AS 訂單編號,
        g.name AS 商品名稱,
        g.price AS 單價,
        o.quantity AS 數量,
        dbo.fn_CalcOrderAmount(o.Order_ID) AS 小計
    FROM [Order] o
    JOIN Goods g ON o.Goods_ID = g.Goods_ID
    WHERE o.Member_ID = @Member_ID;

    PRINT '===== 該會員總消費金額 =====';

    SELECT dbo.fn_GetMemberTotalAmount(@Member_ID) AS 總金額;
END;
GO

EXEC sp_GetMemberOrderReport 'M005';