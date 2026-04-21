
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'external scripts enabled', 1;
RECONFIGURE;

USE OnlineShop
GO

EXEC sp_execute_external_script
    @language = N'Python',
    @script = N'
import pandas as pd
from sklearn.linear_model import LinearRegression
import numpy as np

# 1. 從 SQL 獲取輸入資料 (InputDataSet 是預設變數名稱)
df = InputDataSet

# 2. 準備訓練資料
# X 為自變數 (特徵)：價格 (Price)
# y 為應變數 (目標)：數量 (Quantity)
X = df[["price"]] 
y = df[["quantity"]]

# 3. 建立並訓練線性迴歸模型
linreg = LinearRegression()
linreg.fit(X, y)

# 4. 取得模型參數
# Coef (斜率): 代表價格每增加 1 單位，數量會變化多少
# Intercept (截距): 代表當價格為 0 時，預期的基礎數量
coef = linreg.coef_[0][0]
intercept = linreg.intercept_[0]
r_squared = linreg.score(X, y) # 模型的解釋力 (R平方)

# 5. 輸出結果
# 將結果封裝成 DataFrame 回傳給 SQL
OutputDataSet = pd.DataFrame({
    "Model_Type": ["Linear Regression"],
    "Independent_Var": ["Price"],
    "Dependent_Var": ["Quantity"],
    "Coefficient": [coef],
    "Intercept": [intercept],
    "R_Squared": [r_squared]
})
',
    @input_data_1 = N'
        SELECT G.price, O.quantity 
        FROM [Order] O
        INNER JOIN Goods G ON O.Goods_ID = G.Goods_ID
    ',
    @input_data_1_name = N'InputDataSet'
WITH RESULT SETS (
    (
        Model_Type VARCHAR(50), 
        Independent_Var VARCHAR(20), 
        Dependent_Var VARCHAR(20), 
        Coefficient FLOAT, 
        Intercept FLOAT,
        R_Squared FLOAT
    )
);
