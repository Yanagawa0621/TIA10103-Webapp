CREATE DATABASE IF NOT EXISTS g3;

use g3;

DROP TABLE IF EXISTS PurchaseDetails;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS PromotionDetails;
DROP TABLE IF EXISTS PromotionProject;


-- 採購 --
CREATE TABLE Purchase (
	purchaseNumber	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '採購編號',
	purchaseDate	date COMMENT '採購日期'
) COMMENT '採購';

INSERT INTO Purchase (purchaseDate) VALUES ('2024-04-01');
INSERT INTO Purchase (purchaseDate) VALUES ('2024-04-02');
INSERT INTO Purchase (purchaseDate) VALUES ('2024-04-03');
INSERT INTO Purchase (purchaseDate) VALUES ('2024-04-04');
INSERT INTO Purchase (purchaseDate) VALUES ('2024-04-05');


-- 採購明細 --
CREATE TABLE PurchaseDetails (
	bookNumber	INT COMMENT '書籍編號',
    purchaseNumber INT UNSIGNED COMMENT '採購編號',
	quantity	INT COMMENT '數量',
    price	Decimal(10,2) COMMENT '金額',
    PRIMARY KEY (bookNumber, purchaseNumber),
    -- CONSTRAINT fk_BookProducts_bookNumber FOREIGN KEY(bookNumber) REFERENCES BookProducts(bookNumber), --
    CONSTRAINT fk_Purchase_purchaseNumber FOREIGN KEY(purchaseNumber) REFERENCES Purchase(purchaseNumber)
) COMMENT '採購明細';

INSERT INTO PurchaseDetails (bookNumber, purchaseNumber, quantity, price) VALUES (1, 1, 20, 6000);
INSERT INTO PurchaseDetails (bookNumber, purchaseNumber, quantity, price) VALUES (2, 2, 10, 3400);
INSERT INTO PurchaseDetails (bookNumber, purchaseNumber, quantity, price) VALUES (2, 3, 30, 10200);
INSERT INTO PurchaseDetails (bookNumber, purchaseNumber, quantity, price) VALUES (3, 4, 7, 2000);
INSERT INTO PurchaseDetails (bookNumber, purchaseNumber, quantity, price) VALUES (3, 5, 8, 3000);


-- 促銷專案 --
CREATE TABLE PromotionProject (
	promotionProjectNumber	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '促銷專案編號',
	promotionProjectName	VARCHAR(20) COMMENT '促銷專案名稱',
    promotionStartDate		date COMMENT '促銷開始日期',
    promotionLastDate		date COMMENT '促銷結束日期',
    title	VARCHAR(255) COMMENT '標題',
    content	TEXT COMMENT '內容',
    picture longblob COMMENT '圖片'
) COMMENT '促銷專案';

INSERT INTO PromotionProject (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('值得擁有', '2024-04-01', '2024-04-14', '值得擁有buy one get one free', '好書值得擁有');
INSERT INTO PromotionProject (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('聽書在唱歌', '2024-04-02', '2024-04-13', '全館79折', '用心，書會唱歌給你聽');
INSERT INTO PromotionProject (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('愚人節不愚人', '2024-04-01', '2024-04-30', '全館7折', '誰說愚人節好康的都是假消息，讓你一整個月都優惠');
INSERT INTO PromotionProject (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('書永遠是你的良師', '2024-04-05', '2024-04-25', '二件69折', '書讓你有學不完的知識');
INSERT INTO PromotionProject (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('yoyo節', '2024-04-04', '2024-04-05', '兒童節童書滿千折百', 'yoyo節');


-- 促銷明細 --
CREATE TABLE PromotionDetails (
	promotionProjectNumber	INT UNSIGNED COMMENT '促銷專案編號',
    promotionProductNumber INT COMMENT '促銷產品編號',
    promotionPrice	Decimal(10,2) COMMENT '促銷價格',
    PRIMARY KEY (promotionProjectNumber, promotionProductNumber),
    -- CONSTRAINT fk_BookProducts_bookNumber FOREIGN KEY(promotionProductNumber) REFERENCES BookProducts(bookNumber), --
    CONSTRAINT fk_PromotionProject_promotionProjectNumber FOREIGN KEY(promotionProjectNumber) REFERENCES PromotionProject(promotionProjectNumber)
) COMMENT '促銷明細';

INSERT INTO PromotionDetails (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (1, 45624, 310);
INSERT INTO PromotionDetails (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (2, 46153, 300);
INSERT INTO PromotionDetails (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (3, 468123, 299);
INSERT INTO PromotionDetails (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (4, 45688, 420);
INSERT INTO PromotionDetails (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (5, 138897, 300);





