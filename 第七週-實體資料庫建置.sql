CREATE DATABASE OnlineShop
GO
USE OnlineShop
ALTER AUTHORIZATION ON DATABASE::OnlineShop TO [sa];
-- 建立會員資料表
CREATE TABLE Member (
    Member_ID VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    gender CHAR(1),
    birthday DATE,
    phone VARCHAR(20)
);

-- 建立發行商資料表
CREATE TABLE Publisher (
    Publisher_ID VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100)
);

-- 建立商品資料表
CREATE TABLE Goods (
    Goods_ID VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    price INT,
    Publisher_ID VARCHAR(20),
	stock INT,
    FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID)
);

-- 建立訂購資料表
CREATE TABLE [Order] (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Member_ID VARCHAR(20),
    Goods_ID VARCHAR(20),
    quantity INT,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Goods_ID) REFERENCES Goods(Goods_ID)
);

INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M001', '會員1', 'M', '1991-03-15', '0919605595');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M002', '會員2', 'M', '1992-05-22', '0953397804');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M003', '會員3', 'M', '1993-09-23', '0961220078');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M004', '會員4', 'F', '1994-06-10', '0958259480');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M005', '會員5', 'F', '1995-05-25', '0974860258');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M006', '會員6', 'F', '1996-08-18', '0965269616');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M007', '會員7', 'M', '1997-05-13', '0996164835');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M008', '會員8', 'M', '1998-02-16', '0923932274');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M009', '會員9', 'F', '1999-08-11', '0981130391');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M010', '會員10', 'F', '1990-02-27', '0977635291');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M011', '會員11', 'F', '1991-01-24', '0935901545');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M012', '會員12', 'F', '1992-06-24', '0917725904');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M013', '會員13', 'M', '1993-09-25', '0932412700');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M014', '會員14', 'M', '1994-04-14', '0923724916');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M015', '會員15', 'M', '1995-03-25', '0964373253');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M016', '會員16', 'M', '1996-02-12', '0915940992');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M017', '會員17', 'M', '1997-07-17', '0995549152');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M018', '會員18', 'F', '1998-01-10', '0945412095');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M019', '會員19', 'M', '1999-01-14', '0941441581');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M020', '會員20', 'F', '1990-03-26', '0987641186');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M021', '會員21', 'M', '1991-01-10', '0958063780');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M022', '會員22', 'M', '1992-09-24', '0988743615');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M023', '會員23', 'F', '1993-07-21', '0913608346');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M024', '會員24', 'F', '1994-06-14', '0951251084');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M025', '會員25', 'M', '1995-05-12', '0962526000');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M026', '會員26', 'F', '1996-08-15', '0933761461');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M027', '會員27', 'M', '1997-05-13', '0945232212');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M028', '會員28', 'M', '1998-03-15', '0914576438');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M029', '會員29', 'F', '1999-01-19', '0992034086');
INSERT INTO Member (Member_ID, name, gender, birthday, phone) VALUES ('M030', '會員30', 'F', '1990-07-13', '0989508239');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P001', '發行商1');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P002', '發行商2');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P003', '發行商3');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P004', '發行商4');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P005', '發行商5');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P006', '發行商6');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P007', '發行商7');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P008', '發行商8');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P009', '發行商9');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P010', '發行商10');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P011', '發行商11');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P012', '發行商12');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P013', '發行商13');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P014', '發行商14');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P015', '發行商15');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P016', '發行商16');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P017', '發行商17');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P018', '發行商18');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P019', '發行商19');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P020', '發行商20');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P021', '發行商21');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P022', '發行商22');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P023', '發行商23');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P024', '發行商24');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P025', '發行商25');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P026', '發行商26');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P027', '發行商27');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P028', '發行商28');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P029', '發行商29');
INSERT INTO Publisher (Publisher_ID, name) VALUES ('P030', '發行商30');
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G001', '商品1', 370, 'P027', 1);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G002', '商品2', 243, 'P005', 2);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G003', '商品3', 237, 'P024', 3);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G004', '商品4', 490, 'P020', 4);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G005', '商品5', 594, 'P009', 5);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G006', '商品6', 663, 'P029', 6);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G007', '商品7', 962, 'P008', 7);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G008', '商品8', 861, 'P009', 8);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G009', '商品9', 334, 'P021', 9);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G010', '商品10', 115, 'P004', 10);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G011', '商品11', 540, 'P016', 11);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G012', '商品12', 471, 'P001', 12);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G013', '商品13', 386, 'P020', 13);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G014', '商品14', 509, 'P005', 14);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G015', '商品15', 340, 'P024', 15);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G016', '商品16', 361, 'P021', 16);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G017', '商品17', 849, 'P015', 17);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G018', '商品18', 695, 'P001', 18);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G019', '商品19', 659, 'P008', 19);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G020', '商品20', 447, 'P001', 20);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G021', '商品21', 804, 'P023', 21);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G022', '商品22', 277, 'P022', 22);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G023', '商品23', 754, 'P019', 23);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G024', '商品24', 623, 'P015', 24);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G025', '商品25', 309, 'P019', 25);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G026', '商品26', 627, 'P028', 26);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G027', '商品27', 489, 'P008', 27);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G028', '商品28', 577, 'P025', 28);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G029', '商品29', 883, 'P007', 29);
INSERT INTO Goods (Goods_ID, name, price, Publisher_ID, stock) VALUES ('G030', '商品30', 141, 'P013', 30);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O001', 'M002', 'G002', 2);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O002', 'M003', 'G003', 7);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O003', 'M004', 'G004', 2);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O004', 'M005', 'G005', 10);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O005', 'M006', 'G006', 4);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O006', 'M007', 'G007', 10);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O007', 'M008', 'G008', 9);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O008', 'M009', 'G009', 3);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O009', 'M010', 'G010', 8);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O010', 'M011', 'G011', 4);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O011', 'M012', 'G012', 9);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O012', 'M013', 'G013', 4);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O013', 'M014', 'G014', 9);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O014', 'M015', 'G015', 6);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O015', 'M016', 'G016', 9);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O016', 'M017', 'G017', 6);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O017', 'M018', 'G018', 10);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O018', 'M019', 'G019', 2);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O019', 'M020', 'G020', 10);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O020', 'M021', 'G021', 9);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O021', 'M022', 'G022', 2);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O022', 'M023', 'G023', 6);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O023', 'M024', 'G024', 6);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O024', 'M025', 'G025', 1);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O025', 'M026', 'G026', 4);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O026', 'M027', 'G027', 10);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O027', 'M028', 'G028', 5);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O028', 'M029', 'G029', 10);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O029', 'M030', 'G030', 7);
INSERT INTO [Order] (Order_ID, Member_ID, Goods_ID, quantity) VALUES ('O030', 'M001', 'G001', 6);