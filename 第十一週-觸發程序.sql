CREATE TRIGGER trg_CheckOrderQuantity
ON [Order]
FOR INSERT, UPDATE
AS
BEGIN
    -- 如果 quantity <= 0 則阻擋
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE quantity <= 0
    )
    BEGIN
        RAISERROR('訂購數量不可小於或等於 0！', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

GO
CREATE TRIGGER trg_NoDeletePublisherIfUsed
ON Publisher
INSTEAD OF DELETE
AS
BEGIN
    -- 檢查被刪除的 Publisher 是否被 Goods 使用
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN Goods g ON g.Publisher_ID = d.Publisher_ID
    )
    BEGIN
        RAISERROR('該發行商仍有商品使用，無法刪除！', 16, 1);
        RETURN;
    END

    -- 若沒有被使用，允許刪除
    DELETE FROM Publisher
    WHERE Publisher_ID IN (SELECT Publisher_ID FROM deleted);
END;
GO
