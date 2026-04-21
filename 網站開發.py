import gradio as gr
import pyodbc
import pandas as pd

# --- 1. 資料庫連線設定 ---
DB_CONFIG = {
    'DRIVER': '{ODBC Driver 17 for SQL Server}',       
    'SERVER': 'localhost\SQLEXPRESS',          
    'DATABASE': 'OnlineShop',       
    'UID': '',                      
    'PWD': '',                      
    'Trusted_Connection': 'yes'     
}

def get_connection():
    """建立資料庫連線"""
    conn_str = f"DRIVER={DB_CONFIG['DRIVER']};SERVER={DB_CONFIG['SERVER']};DATABASE={DB_CONFIG['DATABASE']};"
    if DB_CONFIG['Trusted_Connection'] == 'yes':
        conn_str += "Trusted_Connection=yes;"
    else:
        conn_str += f"UID={DB_CONFIG['UID']};PWD={DB_CONFIG['PWD']};"
    return pyodbc.connect(conn_str)

def execute_query(sql, params):
    """執行 INSERT, UPDATE, DELETE 的通用函數"""
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(sql, params)
        conn.commit()
        conn.close()
        return "✅ 操作成功！"
    except Exception as e:
        return f"❌ 操作失敗: {str(e)}"

def read_table(table_name):
    """讀取 (Read) 資料表"""
    try:
        conn = get_connection()
        query_table = f"[{table_name}]" if table_name == "Order" else table_name
        query = f"SELECT * FROM {query_table}"
        df = pd.read_sql(query, conn)
        conn.close()
        return df
    except Exception as e:
        return pd.DataFrame({"Error": [str(e)]})

# --- 動態獲取 ID 列表 ---
def get_id_list(table_name, column_name):
    """從資料庫讀取特定欄位的所有值，用於下拉選單"""
    try:
        conn = get_connection()
        query = f"SELECT {column_name} FROM [{table_name}]"
        df = pd.read_sql(query, conn)
        conn.close()
        # 將結果轉為 Python list
        return df[column_name].astype(str).tolist()
    except:
        return []

# --- 2. 定義各資料表的 CRUD 邏輯 ---

# === Member ===
def create_member(mid, name, gender, bday, phone):
    sql = "INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES (?, ?, ?, ?, ?)"
    return execute_query(sql, (mid, name, gender, bday, phone))

def update_member(mid, name, gender, bday, phone):
    sql = "UPDATE Member SET name=?, gender=?, birthday=?, phone=? WHERE Member_ID=?"
    return execute_query(sql, (name, gender, bday, phone, mid))

def delete_member(mid):
    sql = "DELETE FROM Member WHERE Member_ID=?"
    return execute_query(sql, (mid,))

# === Publisher ===
def create_publisher(pid, name):
    sql = "INSERT INTO Publisher (Publisher_ID, name) VALUES (?, ?)"
    return execute_query(sql, (pid, name))

def update_publisher(pid, name):
    sql = "UPDATE Publisher SET name=? WHERE Publisher_ID=?"
    return execute_query(sql, (name, pid))

def delete_publisher(pid):
    sql = "DELETE FROM Publisher WHERE Publisher_ID=?"
    return execute_query(sql, (pid,))

# === Goods ===
def create_goods(gid, name, price, pid, stock):
    sql = "INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES (?, ?, ?, ?, ?)"
    return execute_query(sql, (gid, name, price, pid, stock))

def update_goods(gid, name, price, pid, stock):
    sql = "UPDATE Goods SET name=?, price=?, Publisher_ID=?, stock=? WHERE Goods_ID=?"
    return execute_query(sql, (name, price, pid, stock, gid))

def delete_goods(gid):
    sql = "DELETE FROM Goods WHERE Goods_ID=?"
    return execute_query(sql, (gid,))

# === Order ===
def create_order(oid, mid, gid, qty):
    sql = "INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES (?, ?, ?, ?)"
    return execute_query(sql, (oid, mid, gid, qty))

def update_order(oid, mid, gid, qty):
    sql = "UPDATE [Order] SET Member_ID=?, Goods_ID=?, quantity=? WHERE Order_ID=?"
    return execute_query(sql, (mid, gid, qty, oid))

def delete_order(oid):
    sql = "DELETE FROM [Order] WHERE Order_ID=?"
    return execute_query(sql, (oid,))


# --- 3. 建置 Gradio 介面 ---
with gr.Blocks(title="OnlineShop 資料庫管理系統") as demo:
    gr.Markdown("# 🛒 OnlineShop 資料庫管理系統")
    
    # Tab 1: Member
    with gr.Tab("會員 (Member)"):
        with gr.Row():
            with gr.Column(scale=1):
                gr.Markdown("### 資料操作區")
                m_id = gr.Textbox(label="Member_ID (主鍵)")
                m_name = gr.Textbox(label="姓名")
                m_gender = gr.Dropdown(choices=["M", "F"], label="性別")
                m_bday = gr.Textbox(label="生日 (YYYY-MM-DD)", placeholder="1990-01-01")
                m_phone = gr.Textbox(label="電話")
                
                with gr.Row():
                    btn_m_c = gr.Button("新增 (Create)", variant="primary")
                    btn_m_u = gr.Button("修改 (Update)")
                    btn_m_d = gr.Button("刪除 (Delete)", variant="stop")
                m_msg = gr.Textbox(label="系統訊息")

            with gr.Column(scale=2):
                gr.Markdown("### 資料列表 (Read)")
                btn_m_r = gr.Button("重新整理列表")
                m_out = gr.DataFrame(label="Member Table")

        btn_m_r.click(lambda: read_table("Member"), outputs=m_out)
        btn_m_c.click(create_member, inputs=[m_id, m_name, m_gender, m_bday, m_phone], outputs=m_msg)
        btn_m_u.click(update_member, inputs=[m_id, m_name, m_gender, m_bday, m_phone], outputs=m_msg)
        btn_m_d.click(delete_member, inputs=[m_id], outputs=m_msg)

    # Tab 2: Publisher
    with gr.Tab("發行商 (Publisher)"):
        with gr.Row():
            with gr.Column(scale=1):
                gr.Markdown("### 資料操作區")
                p_id = gr.Textbox(label="Publisher_ID (主鍵)")
                p_name = gr.Textbox(label="發行商名稱")
                
                with gr.Row():
                    btn_p_c = gr.Button("新增 (Create)", variant="primary")
                    btn_p_u = gr.Button("修改 (Update)")
                    btn_p_d = gr.Button("刪除 (Delete)", variant="stop")
                p_msg = gr.Textbox(label="系統訊息")

            with gr.Column(scale=2):
                gr.Markdown("### 資料列表 (Read)")
                btn_p_r = gr.Button("重新整理列表")
                p_out = gr.DataFrame(label="Publisher Table")

        btn_p_r.click(lambda: read_table("Publisher"), outputs=p_out)
        btn_p_c.click(create_publisher, inputs=[p_id, p_name], outputs=p_msg)
        btn_p_u.click(update_publisher, inputs=[p_id, p_name], outputs=p_msg)
        btn_p_d.click(delete_publisher, inputs=[p_id], outputs=p_msg)

    # Tab 3: Goods 
    with gr.Tab("商品 (Goods)"):
        with gr.Row():
            with gr.Column(scale=1):
                gr.Markdown("### 資料操作區")
                g_id = gr.Textbox(label="Goods_ID (主鍵)")
                g_name = gr.Textbox(label="商品名稱")
                g_price = gr.Number(label="價格")
                
                # 初始載入時抓取一次 Publisher_ID 列表
                pub_choices = get_id_list("Publisher", "Publisher_ID")
                g_pid = gr.Dropdown(label="Publisher_ID (外鍵)", choices=pub_choices, interactive=True, allow_custom_value=False)
                
                g_stock = gr.Number(label="庫存")
                
                with gr.Row():
                    btn_g_c = gr.Button("新增 (Create)", variant="primary")
                    btn_g_u = gr.Button("修改 (Update)")
                    btn_g_d = gr.Button("刪除 (Delete)", variant="stop")
                    # 新增按鈕：更新下拉選單內容
                    btn_g_refresh_list = gr.Button("🔄 更新廠商選單")
                
                g_msg = gr.Textbox(label="系統訊息")

            with gr.Column(scale=2):
                gr.Markdown("### 資料列表 (Read)")
                btn_g_r = gr.Button("重新整理列表")
                g_out = gr.DataFrame(label="Goods Table")

        # 更新選單的事件
        btn_g_refresh_list.click(
            lambda: gr.Dropdown(choices=get_id_list("Publisher", "Publisher_ID")), 
            outputs=g_pid
        )

        btn_g_r.click(lambda: read_table("Goods"), outputs=g_out)
        btn_g_c.click(create_goods, inputs=[g_id, g_name, g_price, g_pid, g_stock], outputs=g_msg)
        btn_g_u.click(update_goods, inputs=[g_id, g_name, g_price, g_pid, g_stock], outputs=g_msg)
        btn_g_d.click(delete_goods, inputs=[g_id], outputs=g_msg)

    # Tab 4: Order
    with gr.Tab("訂單 (Order)"):
        with gr.Row():
            with gr.Column(scale=1):
                gr.Markdown("### 資料操作區")
                o_id = gr.Textbox(label="Order_ID (主鍵)")
                
                mem_choices = get_id_list("Member", "Member_ID")
                goods_choices = get_id_list("Goods", "Goods_ID")
                
                o_mid = gr.Dropdown(label="Member_ID (外鍵)", choices=mem_choices, interactive=True)
                o_gid = gr.Dropdown(label="Goods_ID (外鍵)", choices=goods_choices, interactive=True)
                
                o_qty = gr.Number(label="數量")
                
                with gr.Row():
                    btn_o_c = gr.Button("新增 (Create)", variant="primary")
                    btn_o_u = gr.Button("修改 (Update)")
                    btn_o_d = gr.Button("刪除 (Delete)", variant="stop")
                    btn_o_refresh_lists = gr.Button("🔄 更新ID選單")

                o_msg = gr.Textbox(label="系統訊息")

            with gr.Column(scale=2):
                gr.Markdown("### 資料列表 (Read)")
                btn_o_r = gr.Button("重新整理列表")
                o_out = gr.DataFrame(label="Order Table")

        # 更新兩個選單的事件
        def refresh_order_dropdowns():
            return {
                o_mid: gr.Dropdown(choices=get_id_list("Member", "Member_ID")),
                o_gid: gr.Dropdown(choices=get_id_list("Goods", "Goods_ID"))
            }

        btn_o_refresh_lists.click(refresh_order_dropdowns, outputs=[o_mid, o_gid])

        btn_o_r.click(lambda: read_table("Order"), outputs=o_out)
        btn_o_c.click(create_order, inputs=[o_id, o_mid, o_gid, o_qty], outputs=o_msg)
        btn_o_u.click(update_order, inputs=[o_id, o_mid, o_gid, o_qty], outputs=o_msg)
        btn_o_d.click(delete_order, inputs=[o_id], outputs=o_msg)

    # 初始載入表格資料
    demo.load(lambda: read_table("Member"), outputs=m_out)
    demo.load(lambda: read_table("Publisher"), outputs=p_out)
    demo.load(lambda: read_table("Goods"), outputs=g_out)
    demo.load(lambda: read_table("Order"), outputs=o_out)

if __name__ == "__main__":
    demo.launch()