USE OnlineShop;
GO

BEGIN TRANSACTION;

-- 鎖定 G002 商品並將價格暫時改為 9999
UPDATE Goods
SET price = 9999
WHERE Goods_ID = 'G002';

PRINT '管理者已修改價格';
-- 自動還原
WAITFOR DELAY '00:00:15'; 
ROLLBACK; 
PRINT '價格還原。';