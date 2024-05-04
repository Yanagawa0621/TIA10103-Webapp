CREATE DATABASE IF NOT EXISTS G3;

use G3;

DROP TABLE IF EXISTS administrator;
DROP TABLE IF EXISTS QA;
DROP TABLE IF EXISTS customer_order;
DROP TABLE IF EXISTS order_details;

CREATE TABLE administrator(
	account VARCHAR(20) PRIMARY KEY COMMENT'帳號',
    password VARCHAR(20) COMMENT'密碼',
    name VARCHAR(255) COMMENT'名稱'
)COMMENT'管理員';

DESC administrator;

INSERT INTO administrator(account,password,name) VALUES
('AS127894','A79461354','FAKER'),
('QW121345','F83748512','peter'),
('dog123','d98765432','cat'),
('cat2222','c1234567','dog'),
('abcd1234','a1234567','alpha');

SELECT * FROM administrator;

-- QA --
CREATE TABLE qa(
	number INT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT'編號',
    className VARCHAR(20) COMMENT'類別名稱',
    content   VARCHAR(255) COMMENT'內容'
) COMMENT'qa';

INSERT INTO qa(className,content) VALUES
('購物流程說明','book talk提供簡單又安全的交易環境，在進行交易前，需請先加入會員,加入會員是完全免費的，於加入完成後，即可開始購物！'),
('查詢商品出貨進度','目前會員已可自行於會員專區中查詢商品出貨情形，請您可登錄「會員專區」→「交易記錄」→「訂單查詢」，查詢您訂購商品的出貨狀況。'),
('為什麼我的訂單取消失敗','由於目前訂單作業皆由系統24小時執行處理，若您的訂單商品都有庫存商品，因出貨速度快速恐會有預約取消失敗或已無法取消的狀況。'),
('如何取消訂單','目前book talk已有提供「線上取消訂單」及「預約取消訂單」的功能，會員皆可至「會員專區」中進行異動。'),
('我拿到的是否會是最新版的書籍','博客來網站上的資料都是由出版社提供，一般僅會列出初版日期，若書籍有再刷，將不會將再版的資料更新於網站上。');


-- 訂單 --
CREATE TABLE customer_order (
    orderNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '訂單編號',
    userNumber INT NOT NULL COMMENT '會員編號',
    orderStatus INT COMMENT '訂單狀態編號',
    establishmentTime DATETIME COMMENT '成立時間',
    note TEXT COMMENT '備註內容',
    shippingTime DATETIME COMMENT '出貨時間',
    receiver VARCHAR(255) COMMENT '收件人',
    shippingAddress VARCHAR(255) COMMENT '收件地址',
    deliveryFee DECIMAL(10, 2) COMMENT '運費',
    total DECIMAL(10, 2) COMMENT '總金額' -- 這裡要補逗點
    -- CONSTRAINT fk_customer_order_userNumber FOREIGN KEY (userNumber) REFERENCES user(number)
) COMMENT '訂單表格';

INSERT INTO customer_order (userNumber, orderStatus, establishmentTime, note, shippingTime, receiver, shippingAddress, deliveryFee, total)
VALUES
(1, 1, '2022-04-15 10:00:00', '第一筆訂單', '2022-04-16 10:00:00', '收件人A', '地址A', 100.00, 500.00),
(2, 2, '2022-04-16 11:00:00', '第二筆訂單', '2022-04-17 11:00:00', '收件人B', '地址B', 150.00, 600.00),
(3, 1, '2022-04-17 12:00:00', '第三筆訂單', '2022-04-18 12:00:00', '收件人C', '地址C', 200.00, 700.00),
(4, 2, '2022-04-18 13:00:00', '第四筆訂單', '2022-04-19 13:00:00', '收件人D', '地址D', 250.00, 800.00),
(5, 1, '2022-04-19 14:00:00', '第五筆訂單', '2022-04-20 14:00:00', '收件人E', '地址E', 300.00, 900.00);


--  訂單明細 --
CREATE TABLE order_details (
    orderNumber INT COMMENT '訂單編號',
    bookNumber INT COMMENT '書籍編號',
    promotionProjectNumber INT COMMENT '促銷專案編號',
    quantity INT COMMENT '數量',
    unitPrice DECIMAL(10, 2) COMMENT '單價',
    subtotal DECIMAL(10, 2) COMMENT '小計',
    evaluateContent TEXT COMMENT '評價內容',
    PRIMARY KEY (orderNumber, bookNumber),
    CONSTRAINT order_details_orderNumber FOREIGN KEY (orderNumber) REFERENCES customer_order(orderNumber) -- 這裡要補逗點 --
    -- CONSTRAINT order_details_bookNumber FOREIGN KEY (bookNumber) REFERENCES book_products(bookNumber),
	-- CONSTRAINT order_details_promotionProjectNumber FOREIGN KEY (promotionProjectNumber) REFERENCES promotion_project(promotionProjectNumber),

) COMMENT '訂單明細表格';

INSERT INTO order_details (orderNumber, bookNumber, promotionProjectNumber, quantity, unitPrice, subtotal, evaluateContent)
VALUES
(1, 1, 1, 2, 100.00, 200.00, '第一筆評價'),
(1, 2, 2, 1, 150.00, 150.00, '第二筆評價'),
(2, 3, 1, 3, 200.00, 600.00, '第三筆評價'),
(3, 1, 2, 1, 250.00, 250.00, '第四筆評價'),
(3, 2, 3, 2, 300.00, 600.00, '第五筆評價');

