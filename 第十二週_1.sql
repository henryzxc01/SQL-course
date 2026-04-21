USE OnlineShop;
GO

BEGIN TRY
    -- 開始交易
    BEGIN TRANSACTION;

    -- 宣告變數
    DECLARE @BuyQty INT = 5;         -- 購買數量
    DECLARE @TargetMember VARCHAR(20) = 'M001';
    DECLARE @TargetGoods VARCHAR(20) = 'G001';
    DECLARE @NewOrderID VARCHAR(20) = 'O999';
    
    -- 檢查庫存是否足夠
    DECLARE @CurrentStock INT;
    SELECT @CurrentStock = stock FROM Goods WHERE Goods_ID = @TargetGoods;

    IF @CurrentStock < @BuyQty
    BEGIN
        -- 若庫存不足，主動拋出錯誤，這會跳轉到 CATCH 區塊
        THROW 51000, '庫存不足，無法完成交易！', 1;
    END

    -- 扣除庫存
    UPDATE Goods
    SET stock = stock - @BuyQty
    WHERE Goods_ID = @TargetGoods;

    -- 建立訂單
    INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity)
    VALUES (@NewOrderID, @TargetMember, @TargetGoods, @BuyQty);

    -- 若上述步驟都沒報錯，提交交易
    COMMIT TRANSACTION;
    PRINT '交易成功：訂單已建立且庫存已扣除。';

END TRY
BEGIN CATCH
    -- 錯誤處理與回滾
    ROLLBACK TRANSACTION;

    PRINT '交易失敗，已執行 ROLLBACK。';
    PRINT '錯誤訊息: ' + ERROR_MESSAGE();
END CATCH;