CREATE DATABASE IF NOT EXISTS G3;

use G3;
-- 建立順序 --
	-- 4.>5.>2.>3.>1. --

-- 刪除表格用 --
DROP DATABASE IF EXISTS G3;

-- 1. --
DROP TABLE IF EXISTS report; -- 檢舉 --
DROP TABLE IF EXISTS my_like; -- 點讚 --
DROP TABLE IF EXISTS message; -- 留言 --
DROP TABLE IF EXISTS article; -- 文章 (需先刪除 留言、點讚、檢舉)--
DROP TABLE IF EXISTS forum; -- 版類 (需先刪除 文章、點讚、檢舉)--

-- 2.--
DROP TABLE IF EXISTS login_record; -- 登入紀錄 --
DROP TABLE IF EXISTS Complaint; -- 申訴 --
DROP TABLE IF EXISTS user; -- 會員 (需先刪除 申訴、登入紀錄、3.訂單、1.文章、1.留言、1.點讚、1.檢舉)--
DROP TABLE IF EXISTS Access; -- 權限 (需先刪除 會員)--
DROP TABLE IF EXISTS user_status; -- 會員狀態 (需先刪除 會員、1.檢舉)--

-- 3. --
DROP TABLE IF EXISTS administrator; -- 管理員 --
DROP TABLE IF EXISTS QA; -- QA --
DROP TABLE IF EXISTS order_details; --  訂單明細 --
DROP TABLE IF EXISTS customer_order; -- 訂單 (需先刪除 訂單明細)--

-- 4. --
DROP TABLE IF EXISTS book_author; -- 書籍作者 --
DROP TABLE IF EXISTS books_and_picture; -- 書籍圖片 --
DROP TABLE IF EXISTS book_products; -- 書籍商品 (需先刪除 3.訂單明細)--
DROP TABLE IF EXISTS book_class; -- 書籍類別 (需先刪除 書籍商品)--
DROP TABLE IF EXISTS Author; -- 作者 (需先刪除 書籍作者)--
DROP TABLE IF EXISTS publishing_house; -- 出版社 (需先刪除 書籍商品)--

-- 5. --
DROP TABLE IF EXISTS purchase_details; -- 採購明細 (需先刪除 4.書籍商品)--
DROP TABLE IF EXISTS Purchase; -- 採購 (需先刪除 採購明細)--
DROP TABLE IF EXISTS promotion_details; -- 促銷明細 (需先刪除 4.書籍商品)--
DROP TABLE IF EXISTS promotion_project; -- 促銷專案 (需先刪除 促銷明細、3.訂單明細)--

-- 建立表格及輸入測試用資料 --
-- 1. --
-- 版類 --
	CREATE TABLE forum (
		forumNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '版類編號',
		name VARCHAR(20) COMMENT '名稱'
	) COMMENT '版類 forum';

	INSERT INTO forum (name) VALUES ('版類A');
	INSERT INTO forum (name) VALUES ('版類B');
	INSERT INTO forum (name) VALUES ('版類C');
	INSERT INTO forum (name) VALUES ('版類D');
	INSERT INTO forum (name) VALUES ('版類E');

-- 文章 --
	CREATE TABLE article (
		articleNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '文章編號',
		userNumber INT NOT NULL COMMENT '會員編號',
		forumNumber	INT NOT NULL COMMENT '版類編號',
		content	LONGTEXT COMMENT '內容',
		issueTime DATETIME COMMENT '發文時間',
		titleContent VARCHAR(255) COMMENT '標題內容',
		articleState INT COMMENT '文章狀態',
		likeSum	INT COMMENT '總讚數',
		pageView INT COMMENT '瀏覽次數',
	  	CONSTRAINT fk_article_userNumber FOREIGN KEY (userNumber) REFERENCES User(number),
	  	CONSTRAINT fk_article_forumNumber FOREIGN KEY (forumNumber) REFERENCES forum(forumNumber)
	) COMMENT '文章 article';
			
	INSERT INTO article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (1, 1, '文章內容1','2024-04-10 09:00:00','標題1', 1,10,100);
	INSERT INTO article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (2, 2, '文章內容2','2024-04-10 09:00:00','標題2', 0,5,10);
	INSERT INTO article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (3, 3, '文章內容3','2024-04-10 09:00:00','標題3', 1,80,500);
	INSERT INTO article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (4, 4, '文章內容4','2024-04-10 09:00:00','標題4', 1,6,70);
	INSERT INTO article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (5, 5, '文章內容5','2024-04-10 09:00:00','標題5', 0,100,1000);

-- 留言 --
	CREATE TABLE message (
		messageNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '留言編號',
		userNumber INT NOT NULL COMMENT '會員編號',
		articleNumber	INT NOT NULL COMMENT '文章編號',
		content	TEXT COMMENT '內容',
		messageTime	DATETIME COMMENT '留言時間',
		messageState INT COMMENT '留言狀態',
		likeSum	INT COMMENT '總讚數',
		CONSTRAINT fk_message_userNumber FOREIGN KEY (userNumber) REFERENCES User(number),
		CONSTRAINT fk_message_articleNumber FOREIGN KEY (articleNumber) REFERENCES article(articleNumber)
	) COMMENT '留言 message';
		

	INSERT INTO message (userNumber, articleNumber, content, messageTime , messageState , likeSum) VALUES (1, 1, '文章內容1','2024-04-10 09:00:00',1,10);
	INSERT INTO message (userNumber, articleNumber, content, messageTime , messageState , likeSum) VALUES (2, 3, '文章內容3','2024-04-10 10:00:00',1,10);
	INSERT INTO message (userNumber, articleNumber, content, messageTime , messageState , likeSum) VALUES (3, 5, '文章內容5','2024-04-10 11:00:00',1,10);
	INSERT INTO message (userNumber, articleNumber, content, messageTime , messageState , likeSum) VALUES (4, 4, '文章內容7','2024-04-10 12:00:00',1,10);
	INSERT INTO message (userNumber, articleNumber, content, messageTime , messageState , likeSum) VALUES (5, 2, '文章內容9','2024-04-10 13:00:00',1,10);

-- 點讚 --
	CREATE TABLE my_like (
		number	INT PRIMARY KEY AUTO_INCREMENT COMMENT '編號',
		articleNumber INT  COMMENT '文章編號',
		messageNumber INT  COMMENT '留言編號',
		userNumber	INT NOT NULL COMMENT '會員編號',
		CONSTRAINT fk_my_like_articleNumber FOREIGN KEY (articleNumber) REFERENCES article(articleNumber),
		CONSTRAINT fk_my_like_messageNumber FOREIGN KEY (messageNumber) REFERENCES message(messageNumber),
		CONSTRAINT fk_my_like_userNumber FOREIGN KEY (userNumber) REFERENCES User(number)
	) COMMENT '點讚 my_like';

	INSERT INTO my_like (articleNumber, messageNumber, userNumber) VALUES (1,1,1);
	INSERT INTO my_like (articleNumber, messageNumber, userNumber) VALUES (1,2,2);
	INSERT INTO my_like (articleNumber, messageNumber, userNumber) VALUES (2,1,2);
	INSERT INTO my_like (articleNumber, messageNumber, userNumber) VALUES (2,3,1);
	INSERT INTO my_like (articleNumber, messageNumber, userNumber) VALUES (3,4,1);

-- 檢舉 --
	CREATE TABLE report (
		reportNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '檢舉編號',
		reportedArticleNumber INT COMMENT '被檢舉文章編號',
		reportedMessageNumber INT COMMENT '被檢舉留言編號',
		reporter INT COMMENT '檢舉人',
		userStatus INT COMMENT '會員狀態',
		processingStatusCode INT COMMENT '處理狀態編號',
		content LONGTEXT COMMENT '內容',
		reportTime DATETIME COMMENT '檢舉時間',
		penaltyStartDate DATE COMMENT '處罰起始日期',
		penaltyEndDate DATE COMMENT '處罰結束日期',
		auditResultComment VARCHAR(255) COMMENT '審核的結果評論',
		CONSTRAINT fk_report_reportedArticleNumber FOREIGN KEY (reportedArticleNumber) REFERENCES article(articleNumber),
		CONSTRAINT fk_report_reportedMessageNumber FOREIGN KEY (reportedMessageNumber) REFERENCES message(messageNumber),
		CONSTRAINT fk_report_reporter FOREIGN KEY (reporter) REFERENCES User(number),
		CONSTRAINT fk_report_userStatus FOREIGN KEY (userStatus) REFERENCES user_status(userStatus)
	) COMMENT '檢舉 report';

	INSERT INTO report (reportedArticleNumber, reportedMessageNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (1, NULL, 1, 1, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO report (reportedArticleNumber, reportedMessageNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (2, NULL, 2, 1, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO report (reportedArticleNumber, reportedMessageNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (3, NULL, 3, 2, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO report (reportedArticleNumber, reportedMessageNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (4, NULL, 4, 1, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO report (reportedArticleNumber, reportedMessageNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (5, NULL, 5, 2, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');

-- 2. --
-- 會員狀態 --
CREATE TABLE IF NOT EXISTS user_status (
    userStatus INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT '狀態編號',
    statusName VARCHAR(20) COMMENT '狀態名稱',
    statusDescribe VARCHAR(50) COMMENT '狀態說明',
    statusDays INTEGER COMMENT '狀態天數'
) COMMENT '會員狀態 user_status';

INSERT INTO user_status (statusName, statusDescribe, statusDays) VALUES ('1','1',7);
INSERT INTO user_status (statusName, statusDescribe, statusDays) VALUES ('2','2',0);

-- 權限 --
CREATE TABLE IF NOT EXISTS access (
    accessNumber INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT '權限編號',
    name VARCHAR(20) COMMENT '名稱',
    accessDescribe VARCHAR(50) COMMENT '權限說明'
) COMMENT '權限 access';

INSERT INTO access (name, accessDescribe) VALUES ('1', '描述1');

-- 會員 --
CREATE TABLE IF NOT EXISTS user (
    number INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT '編號',
    accountStatusNumber INTEGER NOT NULL COMMENT '帳號狀態編號',
    accessNumber INTEGER NOT NULL COMMENT '權限編號',
    account VARCHAR(20) COMMENT '帳號',
    passcode VARCHAR(20) COMMENT '密碼',
    name VARCHAR(20) COMMENT '名字',
    registerDate DATE COMMENT '註冊日期',
    sex CHAR(1) COMMENT '性別',
    eMail VARCHAR(255) COMMENT '電子郵件',
    introduceOneself LONGTEXT COMMENT '自我介紹',
    birthday DATE COMMENT '生日',
    photo LONGBLOB COMMENT '照片',
    nationalIdNumber CHAR(10) COMMENT '身分證字號',
    telephoneNumber VARCHAR(15) COMMENT '電話',
    address VARCHAR(255) COMMENT '地址',
    statusStartDate DATE COMMENT '狀態起始日',
    UNIQUE(account, eMail, nationalIdNumber),
    CONSTRAINT fk_user_accountStatusNumber FOREIGN KEY (accountStatusNumber) REFERENCES user_status(userStatus),
    CONSTRAINT fk_user_accessNumber FOREIGN KEY (accessNumber) REFERENCES access(accessNumber)
) COMMENT '會員 User';

INSERT INTO user (accountStatusNumber, accessNumber, account, passcode, name, registerDate, sex, eMail, introduceOneself, birthday, photo, nationalIdNumber, telephoneNumber, address, statusStartDate) 
VALUES 
    (1, 1, '134', '123', 'abc', '1981-11-17', '1', 'abc@gmail.com', 'HELLO!', '1981-11-17', NULL, '1', '1', '1', '1982-12-18'),
    (1, 1, '1765', '456', 'def', '1983-01-19', '1', 'def@gmail.com', 'HI@', '1981-11-17', NULL, '1', '1', '1', '1983-02-20'),
    (1, 1, '1876', '3423', 'vcxv', '1983-01-30', '1', 'vcxv@gmail.com', 'TIF@', '1981-11-17', NULL, '1', '1', '1', '1979-07-12'),
    (1, 1, '112', '789', 'ghi', '1984-02-20', '1', 'ghi@gmail.com', 'eum#', '1981-11-17', NULL, '1', '1', '1', '1985-03-21'),
	(1, 1, '2132', '6757', 'kyty', '1984-02-11', '1', 'kyty@gmail.com', 'ijelm', '1981-11-09', NULL, '1', '1', '1', '1985-03-01');

-- 登入記錄 --
CREATE TABLE IF NOT EXISTS login_record (
    number INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT '編號',
    userNumber INTEGER NOT NULL COMMENT '會員編號',
    loginTime DATETIME COMMENT '登入時間',
    ip VARCHAR(45) COMMENT 'IP位址',
    area VARCHAR(20) COMMENT '地區',
    CONSTRAINT fk_login_record_userNumber FOREIGN KEY (userNumber) REFERENCES user(number)
) COMMENT '登入紀錄 login_record';

INSERT INTO login_record (userNumber, loginTime, ip, area) VALUES (1, '1981-11-17 11:12:13', '1', 'taiwan');

-- 申訴 --
CREATE TABLE IF NOT EXISTS complaint (
    complaintNumber INTEGER AUTO_INCREMENT PRIMARY KEY COMMENT '申訴編號',
    userNumber INTEGER NOT NULL COMMENT '會員編號',
    processingStatus INTEGER NOT NULL COMMENT '處理狀態',
    complaintTypeNumber INTEGER COMMENT '申訴類別',
    content LONGTEXT COMMENT '內容',
    complaintTime DATETIME COMMENT '申訴時間',
    completedDate DATETIME COMMENT '完成日期',
    response LONGTEXT COMMENT '回覆內容',
    CONSTRAINT fk_Complaint_userNumber FOREIGN KEY (userNumber) REFERENCES user(number)
) COMMENT '申訴 complaint';

INSERT INTO complaint (userNumber, processingStatus, complaintTypeNumber, content, complaintTime, completedDate, response) VALUES (1, 1, 1, '123', '1981-11-17 00:00:00', '1981-11-17 00:00:00', '1');

-- 3. --
-- 管理員 --
CREATE TABLE administrator(
	account VARCHAR(20) PRIMARY KEY COMMENT'帳號',
    passcode VARCHAR(20) COMMENT'密碼',
    name VARCHAR(255) COMMENT'名稱'
)COMMENT'管理員 administrator';

INSERT INTO administrator(account,passcode,name) VALUES
('AS127894','A79461354','FAKER'),
('QW121345','F83748512','peter'),
('dog123','d98765432','cat'),
('cat2222','c1234567','dog'),
('abcd1234','a1234567','alpha');

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
    note LONGTEXT COMMENT '備註內容',
    shippingTime DATETIME COMMENT '出貨時間',
    receiver VARCHAR(255) COMMENT '收件人',
    shippingAddress VARCHAR(255) COMMENT '收件地址',
    deliveryFee DECIMAL(10, 2) COMMENT '運費',
    total DECIMAL(10, 2) COMMENT '總金額' ,
    CONSTRAINT fk_customer_order_userNumber FOREIGN KEY (userNumber) REFERENCES user(number)
) COMMENT '訂單表格 customer_order';

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
    evaluateContent LONGTEXT COMMENT '評價內容',
    PRIMARY KEY (orderNumber, bookNumber),
    CONSTRAINT order_details_orderNumber FOREIGN KEY (orderNumber) REFERENCES customer_order(orderNumber),
    CONSTRAINT order_details_bookNumber FOREIGN KEY (bookNumber) REFERENCES book_products(bookNumber),
	CONSTRAINT order_details_promotionProjectNumber FOREIGN KEY (promotionProjectNumber) REFERENCES promotion_project(promotionProjectNumber)
) COMMENT '訂單明細表格 order_details';

INSERT INTO order_details (orderNumber, bookNumber, promotionProjectNumber, quantity, unitPrice, subtotal, evaluateContent)
VALUES
(1, 1, 1, 2, 100.00, 200.00, '第一筆評價'),
(1, 2, 2, 1, 150.00, 150.00, '第二筆評價'),
(2, 3, 1, 3, 200.00, 600.00, '第三筆評價'),
(3, 1, 2, 1, 250.00, 250.00, '第四筆評價'),
(3, 2, 3, 2, 300.00, 600.00, '第五筆評價');



-- 4. --
-- 出版社 --
CREATE TABLE publishing_house(
	publishingHouseNumber int PRIMARY KEY AUTO_INCREMENT COMMENT '出版社編號',
	name varchar(255) COMMENT '名稱',
	address varchar(255) COMMENT '地址',
	personInCharge varchar(255) COMMENT '負責人',
	telephoneNumber varchar(15) COMMENT '電話號碼'
) COMMENT '出版社 publishing_house';

INSERT INTO publishing_house (name,address,personInCharge,telephoneNumber) VALUES ('電極文庫','404台中市北區民權路313號','陳蘭','0938492848');
INSERT INTO publishing_house (name,address,personInCharge,telephoneNumber) VALUES ('String文化','404台中市北區雙十路一段65號','張嘉輝','0947563678');
INSERT INTO publishing_house (name,address,personInCharge,telephoneNumber) VALUES ('頂端','111台北市士林區中山北路七段14巷72-74號','古嘉莉','0937547327');
INSERT INTO publishing_house (name,address,personInCharge,telephoneNumber) VALUES ('梁山','111台北市士林區中山北路五段460巷4號','蔡怡貞','0947382845');
INSERT INTO publishing_house (name,address,personInCharge,telephoneNumber) VALUES ('鼎文','802高雄市苓雅區五福一路67號','吳志成','0956428719');

-- 作者 --
CREATE TABLE Author(
	authorNumber int PRIMARY KEY AUTO_INCREMENT COMMENT '作者編號',
	authorName varchar(225) COMMENT '作者名稱',
	englishName varchar(225) COMMENT '英文名稱'
) COMMENT '作者 Author';

INSERT INTO Author (authorName,englishName) VALUES ('乙一','Otsuichi');
INSERT INTO Author (authorName,englishName) VALUES ('J·K·羅琳','J. K. Rowling');
INSERT INTO Author (authorName,englishName) VALUES ('尚・卡羅','Sean Carroll');
INSERT INTO Author (authorName,englishName) VALUES ('東野圭吾','Higashino Keigo');
INSERT INTO Author (authorName,englishName) VALUES ('約翰·麥可·克萊頓','John Michael Crichton');

-- 書籍類別 --
CREATE TABLE book_class(
	classNumber int PRIMARY KEY AUTO_INCREMENT COMMENT '類別編號',
	className varchar(225) COMMENT '類別名稱'
) COMMENT '書籍類別 book_class';

INSERT INTO book_class (className) VALUES ('科幻');
INSERT INTO book_class (className) VALUES ('日本文學');
INSERT INTO book_class (className) VALUES ('自然與科學');
INSERT INTO book_class (className) VALUES ('推理懸疑');
INSERT INTO book_class (className) VALUES ('輕小說');

-- 書籍商品 --
CREATE TABLE book_products(
	bookNumber int PRIMARY KEY AUTO_INCREMENT COMMENT '書籍編號',
	bookClassNumber int NOT NULL COMMENT '書籍類別編號',
	publishiingHouseCode int NOT NULL COMMENT '出版社編碼',
	productStatus int COMMENT '商品狀態',
	bookTitle varchar(225) COMMENT '書籍名稱',
	isbn varchar(13)  COMMENT 'ISBN',
	price decimal(10,2) COMMENT '價格',
	publicationDate date COMMENT '出版日期',
	stock int COMMENT '庫存量',
	introductionContent LONGTEXT COMMENT '介紹內容',
	CONSTRAINT fk_book_products_bookClassNumber FOREIGN KEY (bookClassNumber) REFERENCES book_class (classNumber),
    CONSTRAINT fk_book_products_publishiingHouseCode FOREIGN KEY (publishiingHouseCode) REFERENCES publishing_house (publishingHouseNumber),
    CONSTRAINT uk_book_products_isbn UNIQUE (isbn)
) COMMENT '書籍商品 book_products';

INSERT INTO book_products (bookClassNumber,publishiingHouseCode,productStatus,bookTitle,isbn,price,publicationDate,stock,introductionContent) VALUES (3,2,0,'潛藏的宇宙：量子世界與時空的湧現','9786269762156',550.00,'2023-12-04',10,
	'　　當代最活躍的理論物理學家之一尚・卡羅，在本書中集中火力，暢談被物理學界視為「不夠嚴肅」的量子力學基礎研究，以無礙的思路與生花妙筆，描繪出量子宇宙觀的完整圖像，並大聲而謹慎地宣告，多重宇宙論中的多世界詮釋，是已知對於現實最深刻、最全面的理解：

　　「量子力學並非只是真理的一個近似值，它就是真理本身。」

　　￭你在讀這段文字的時候，就有好幾個副本的你被創造出來。
　　本書作者尚・卡羅是知名理論物理學家，也是全世界最受讚譽的科學健筆之一，在著作中重新書寫了20世紀的物理學史。《潛藏的宇宙》已被譽為傑作，這本書第一次描寫了與量子力學基本謎題的正面交鋒，如何徹底扭轉我們對空間和時間的思考方式。他調和量子力學與愛因斯坦相對論的方式，基本上改變了一切。

　　物理學從1927年開始就陷入危機，但大多數物理學家並未認清這個難堪的事實。量子力學一直有很明顯的裂縫，都被無視了。科普界總是告訴我們它有多怪異，多麼不可能懂：學術界則對有志研究量子基礎的學生潑冷水，說這是「死胡同」。卡羅賭上了他的專業信譽，寫下這本立論大膽卻完全合乎邏輯的書，他在書中表示，這個危機現在可以解除了，只是必須接受宇宙中不是只有一個我們。有很多很多個尚・卡羅，很多很多個你和我。

　　你的副本每秒鐘會生成好幾千次。量子行為的多世界理論主張，每次發生量子事件，世界連同其中的一切就會跟著分裂，除了沒有發生該量子事件的世界之外。卡羅用獨特的清晰口吻，把反對這項揭示的意見逐一解決，使他的論述最終無可避免必須成立。

　　關於我們如何思考自身在宇宙中的位置，很難得有一本書如此全面地重新加以整理。一個看待宇宙和萬物本質的全新理解，已經呼之欲出。

　　￭本書內容分為三個部分：
　　第一部聚焦在說明測量問題、波函數的機率蘊含，與薛丁格方程式－－請放心，沒有要算給你看，作者最看不慣的就是「閉嘴，去計算」學派－－只是要讓你知道多世界詮釋是怎麼來的，還有為什麼這是目前對宇宙最精準的描述。

　　第二部，瞄準多世界詮釋的宇宙，邀請你這個觀察者一起進入其中，成為和「宇宙波函數」水乳交融的一部分，這裡沒有古典力學，沒有哥本哈根式的崩陷（或譯為塌縮）這個牽強的解釋。對於量子力學最容易引起投射的一點：意識或自由意志，也細細剖析了一番。

　　第三部，帶我們回到無垠的疆界中看時空的「湧現」，會用這個看起來很潮的名詞是有道理的，提醒我們必須抗拒「眼見為真」的想法，才能認識到重力的本質，以及一切的可能性都是持續存在，導致多世界是目前最簡潔的、可能最接近「真相」的物理描述。');
INSERT INTO book_products (bookClassNumber,publishiingHouseCode,productStatus,bookTitle,isbn,price,publicationDate,stock,introductionContent) VALUES (1,4,0,'哈利波特(1)：神秘的魔法石','9789573317241',250.00,'2000-06-01',17,
	'　　　在世界的另一個角落裡，有一個神秘的國度，裡面住滿了巫師，貓頭鷹是他們的信差，飛天掃帚是交通工具，西洋棋子會思考，幽靈頑皮鬼滿天飛，畫像裡的人還會跑出來串門子。

　　　十一歲的哈利波特，從小被阿姨一家當成怪胎，經常得滿屋子躲避表哥達力的追打。他一直以為自己只是個平凡的小男孩，直到一封又一封神秘的信，將他帶入這個充滿神奇魔法的巫師世界，而他的身世之謎與魔法石的秘密也將同時解開。

　　　「哈利波特」已成為一種蔓延全世界的閱讀現象。');
INSERT INTO book_products (bookClassNumber,publishiingHouseCode,productStatus,bookTitle,isbn,price,publicationDate,stock,introductionContent) VALUES (4,3,0,'拉普拉斯的魔女','9789863668916',360.00,'2016-01-29',8,
	'在這個世界上，
	沒有一個個體能夠獨自存在，而不具備任何意義──

　　因故退職的前警察武尾徹，受託擔任年輕少女羽原圓華的保鑣，隨行期間，少女不時展露出能夠預測未來等不可思議的神奇能力。

　　某日，在報上出現一則發生於溫泉區的硫化氫中毒致死的意外事件後，少女就此消失蹤影。該起中毒致死意外，在地球化學教授青江判定不可能是人為事件的情況下，以意外落幕。然而重重的疑點、現場出現的神祕少女，不斷牽引出更多的謎題……

　　此時，相隔甚遠的另一個溫泉區，相同的中毒致死事件竟然再度上演，為了追查真相而前往第二起意外現場的青江，再度遇見同一名少女──羽原圓華……

　　過去、未來，
　　透過她的計算，一切將無所遁形……

　　【拉普拉斯之魔】D　mon de Laplace
　　為法國數學家皮埃爾-西蒙‧拉普拉斯於1814年提出的理論。其理論假設若有一生物能掌握宇宙中每個原子確切的位置和動量，即能夠運用力學規律推算出宇宙所有事件的發生歷程、過去以及未來。後人將此假定生物定名為「拉普拉斯之魔」。');
INSERT INTO book_products (bookClassNumber,publishiingHouseCode,productStatus,bookTitle,isbn,price,publicationDate,stock,introductionContent) VALUES (2,5,0,'ZOO【經典回歸版】','9789865580704',340.00,'2021-07-01',5,
	'受虐的少年少女、瀕死的父親、
	純真的機器女孩、寂寞的男孩、
	懷抱著祕密的男人女人、
	與被剝奪自由的人們──
	
	有人想活下來、想死得其所、想藏住真相、想得到幸福。
	這些重量不一的執念，化做十一個深入人心的晶瑩物語。');
INSERT INTO book_products (bookClassNumber,publishiingHouseCode,productStatus,bookTitle,isbn,price,publicationDate,stock,introductionContent) VALUES (5,1,0,'侏羅紀公園','9789862272237',380.00,'2017-06-15',9,
	'進化史就是一部生命逃脫一切障礙的歷史。
	這過程是痛苦的，甚至充滿危險，但生命卻找到了出路。

　　在中美洲的努布拉島，恐龍復活了。
　　不過，當人類與恐龍，兩個相差六千五百萬年的物種
　　面對面，科技創造的究竟是奇蹟還是災難？

　　出版史和電影史上的經典傳奇
　　紐約時報暢銷書排行榜第一名 累計銷售兩億本
　　電影橫掃全球票房六百億

　　億萬富翁哈蒙德，夢想打造一座前所未見的動物園、渡假村、主題樂園，只要支付門票
　　就能入場，近距離接觸活生生的恐龍。為了確保遊客安全，只繁衍單一性別的恐龍、運
　　用電腦監控位置，再用電網與壕溝保持距離。

　　在園區正式開放前，顧問與投資人代表受哈蒙德之邀登島參觀時，不對勁的事情發生了
　　──恐龍數量比預期的更多、島上的電腦系統癱瘓，還遇上中斷對外交通與通訊的暴風
　　雨。儘管預先做好了種種準備，但是似乎並不夠，遠遠不夠……
');

-- 書籍圖片 --
CREATE TABLE books_and_picture(
	pictureNumber int PRIMARY KEY AUTO_INCREMENT COMMENT '圖片編號',
	bookNumber int NOT NULL COMMENT '書籍編號',
	pictureFile longblob COMMENT '圖片檔',
	CONSTRAINT fk_books_and_picture_bookNumber FOREIGN KEY (bookNumber) REFERENCES book_products (bookNumber)
) COMMENT '書籍圖片 books_and_picture';

INSERT INTO books_and_picture (bookNumber) VALUES (1);
INSERT INTO books_and_picture (bookNumber) VALUES (2);
INSERT INTO books_and_picture (bookNumber) VALUES (3);
INSERT INTO books_and_picture (bookNumber) VALUES (4);
INSERT INTO books_and_picture (bookNumber) VALUES (5);

 -- 書籍作者 --
CREATE TABLE book_author(
	bookNumber int COMMENT '書籍編號',
	authorNumber int COMMENT '作者編號',
	PRIMARY KEY (bookNumber,authorNumber),
	CONSTRAINT fk_book_author_bookNumber FOREIGN KEY (bookNumber) REFERENCES book_products (bookNumber),
	CONSTRAINT fk_book_author_authorNumber FOREIGN KEY (authorNumber) REFERENCES Author (authorNumber)
) COMMENT '書籍作者 book_author';

INSERT INTO book_author (bookNumber,authorNumber) VALUES (1,3);
INSERT INTO book_author (bookNumber,authorNumber) VALUES (2,2);
INSERT INTO book_author (bookNumber,authorNumber) VALUES (3,4);
INSERT INTO book_author (bookNumber,authorNumber) VALUES (4,1);
INSERT INTO book_author (bookNumber,authorNumber) VALUES (5,5);

-- 5. --
-- 採購 --
CREATE TABLE purchase (
	purchaseNumber	INT PRIMARY KEY AUTO_INCREMENT COMMENT '採購編號',
	purchaseDate	date COMMENT '採購日期'
) COMMENT '採購';

INSERT INTO purchase (purchaseDate) VALUES ('2024-04-01');
INSERT INTO purchase (purchaseDate) VALUES ('2024-04-02');
INSERT INTO purchase (purchaseDate) VALUES ('2024-04-03');
INSERT INTO purchase (purchaseDate) VALUES ('2024-04-04');
INSERT INTO purchase (purchaseDate) VALUES ('2024-04-05');

-- 採購明細 --
CREATE TABLE purchase_details (
	bookNumber	INT COMMENT '書籍編號',
    purchaseNumber INT COMMENT '採購編號',
	quantity	INT COMMENT '數量',
    price	Decimal(10,2) COMMENT '金額',
    PRIMARY KEY (bookNumber, purchaseNumber),
    CONSTRAINT fk_purchase_details_bookNumber FOREIGN KEY(bookNumber) REFERENCES book_products(bookNumber),
    CONSTRAINT fk_purchase_details_purchaseNumber FOREIGN KEY(purchaseNumber) REFERENCES purchase(purchaseNumber)
) COMMENT '採購明細';

INSERT INTO purchase_details (bookNumber, purchaseNumber, quantity, price) VALUES (1, 1, 20, 6000);
INSERT INTO purchase_details (bookNumber, purchaseNumber, quantity, price) VALUES (2, 2, 10, 3400);
INSERT INTO purchase_details (bookNumber, purchaseNumber, quantity, price) VALUES (2, 3, 30, 10200);
INSERT INTO purchase_details (bookNumber, purchaseNumber, quantity, price) VALUES (3, 4, 7, 2000);
INSERT INTO purchase_details (bookNumber, purchaseNumber, quantity, price) VALUES (3, 5, 8, 3000);

-- 促銷專案 --
CREATE TABLE promotion_project (
	promotionProjectNumber	INT PRIMARY KEY AUTO_INCREMENT COMMENT '促銷專案編號',
	promotionProjectName	VARCHAR(20) COMMENT '促銷專案名稱',
    promotionStartDate		date COMMENT '促銷開始日期',
    promotionLastDate		date COMMENT '促銷結束日期',
    title	VARCHAR(255) COMMENT '標題',
    content	LONGTEXT COMMENT '內容',
    picture longblob COMMENT '圖片'
) COMMENT '促銷專案';

INSERT INTO promotion_project (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('值得擁有', '2024-04-01', '2024-04-14', '值得擁有buy one get one free', '好書值得擁有');
INSERT INTO promotion_project (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('聽書在唱歌', '2024-04-02', '2024-04-13', '全館79折', '用心，書會唱歌給你聽');
INSERT INTO promotion_project (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('愚人節不愚人', '2024-04-01', '2024-04-30', '全館7折', '誰說愚人節好康的都是假消息，讓你一整個月都優惠');
INSERT INTO promotion_project (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('書永遠是你的良師', '2024-04-05', '2024-04-25', '二件69折', '書讓你有學不完的知識');
INSERT INTO promotion_project (promotionProjectName, promotionStartDate, promotionLastDate, title, content) VALUES ('yoyo節', '2024-04-04', '2024-04-05', '兒童節童書滿千折百', 'yoyo節');

-- 促銷明細 --
CREATE TABLE promotion_details (
	promotionProjectNumber	INT COMMENT '促銷專案編號',
    promotionProductNumber INT COMMENT '促銷產品編號',
    promotionPrice	Decimal(10,2) COMMENT '促銷價格',
    PRIMARY KEY (promotionProjectNumber, promotionProductNumber),
    CONSTRAINT fk_promotion_details_promotionProductNumber FOREIGN KEY(promotionProductNumber) REFERENCES book_products(bookNumber),
    CONSTRAINT fk_promotion_details_promotionProjectNumber FOREIGN KEY(promotionProjectNumber) REFERENCES promotion_project(promotionProjectNumber)
) COMMENT '促銷明細';

INSERT INTO promotion_details (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (1, 1, 310.00);
INSERT INTO promotion_details (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (2, 2, 300.00);
INSERT INTO promotion_details (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (3, 3, 299.00);
INSERT INTO promotion_details (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (4, 4, 420.00);
INSERT INTO promotion_details (promotionProjectNumber, promotionProductNumber, promotionPrice) VALUES (5, 5, 300.00);
