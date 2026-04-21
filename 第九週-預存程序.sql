CREATE PROCEDURE AddNewOrder
    @Order_ID VARCHAR(20),
    @Member_ID VARCHAR(20),
    @Goods_ID VARCHAR(20),
    @Quantity INT
AS
BEGIN
    -- 檢查會員是否存在
    IF NOT EXISTS (SELECT 1 FROM Member WHERE Member_ID = @Member_ID)
    BEGIN
        PRINT '錯誤：該會員不存在。';
        RETURN;
    END

    -- 檢查商品是否存在
    IF NOT EXISTS (SELECT 1 FROM Goods WHERE Goods_ID = @Goods_ID)
    BEGIN
        PRINT '錯誤：該商品不存在。';
        RETURN;
    END

    -- 新增訂單資料
    INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity)
    VALUES (@Order_ID, @Member_ID, @Goods_ID, @Quantity);

    PRINT '成功新增訂單！';
END;
GO
CREATE PROCEDURE GetMemberOrderSummary
    @Member_ID VARCHAR(20)
AS
BEGIN
    -- 檢查會員是否存在
    IF NOT EXISTS (SELECT 1 FROM Member WHERE Member_ID = @Member_ID)
    BEGIN
        PRINT '錯誤：該會員不存在。';
        RETURN;
    END

    -- 顯示該會員的所有訂單明細
    SELECT 
        o.Order_ID AS 訂單編號,
        g.name AS 商品名稱,
        g.price AS 單價,
        o.quantity AS 數量,
        (g.price * o.quantity) AS 小計
    FROM [Order] o
    JOIN Goods g ON o.Goods_ID = g.Goods_ID
    WHERE o.Member_ID = @Member_ID;

    -- 顯示該會員所有訂單總金額
    SELECT 
        SUM(g.price * o.quantity) AS 訂單總金額
    FROM [Order] o
    JOIN Goods g ON o.Goods_ID = g.Goods_ID
    WHERE o.Member_ID = @Member_ID;
END;
GO

