# SQL-course

這個倉庫整理了 SQL 課程實作內容，主題涵蓋：

- 資料需求分析、ERM、正規化
- 實體資料庫建置與測試資料
- 預存程序（Stored Procedure）
- 自訂函數（User-Defined Function）
- 觸發程序（Trigger）
- 交易與鎖定（Transaction / Isolation Level）
- SQL Server 與 Python（機器學習、CRUD 網站介面）整合

---

## 倉庫檔案總覽

### 課程講義（PDF / Architect）

- `第一週-資料需求分析.pdf`
- `第二週-ERM.pdf`
- `第二週-ERM.architect`
- `第三週-Normalization.pdf`
- `第六週-ERMvs.Normalization.pdf`
- `第九週-預存程序.pdf`
- `第十週-自訂函數.pdf`
- `第十一週-觸發程序.pdf`
- `第十二週-交易與鎖定.pdf`
- `環境建置說明文件.pdf`
- `網站開發.pdf`
- `機器學習.pdf`

### SQL 實作檔

- `第七週-實體資料庫建置.sql`：建立 `OnlineShop` 資料庫、資料表與測試資料
- `第九週-預存程序.sql`：會員訂單報表預存程序
- `第十週-自訂函數.sql`：計算訂單金額與會員總消費函數
- `第十一週-觸發程序.sql`：訂單數量檢查、發行商刪除限制
- `第十二週_1.sql`：交易控制與錯誤處理（TRY...CATCH）
- `第十二週_2A.sql`、`第十二週_2B.sql`：鎖定/隔離層級示範
- `網站開發.sql`：網站開發資料庫初始化（含測試資料）
- `機器學習.sql`：SQL Server 外部 Python 腳本執行範例

### Python 程式

- `網站開發.py`：以 Gradio + pyodbc 建立 OnlineShop CRUD 操作介面

---

## 快速開始

1. 使用 SQL Server 開啟並執行 `第七週-實體資料庫建置.sql`（或 `網站開發.sql`）初始化資料庫。
2. 依照主題執行對應 SQL：
   - 預存程序：`第九週-預存程序.sql`
   - 自訂函數：`第十週-自訂函數.sql`
   - 觸發程序：`第十一週-觸發程序.sql`
   - 交易與鎖定：`第十二週_1.sql`、`第十二週_2A.sql`、`第十二週_2B.sql`
3. 若要執行 Python CRUD 介面：
   - 調整 `網站開發.py` 中 `DB_CONFIG` 連線設定
   - 安裝套件：`gradio`、`pyodbc`、`pandas`
   - 執行：`python 網站開發.py`

---

## 學習順序

1. 需求分析與 ERM（第 1～2 週）
2. 正規化（第 3、6 週）
3. 建庫與資料表（第 7 週）
4. 預存程序 / 函數 / 觸發器（第 9～11 週）
5. 交易與鎖定（第 12 週）
6. 延伸整合：網站 CRUD 與機器學習
