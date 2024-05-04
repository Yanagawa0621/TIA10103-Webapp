	CREATE DATABASE IF NOT EXISTS g3;

	use g3;




	DROP TABLE IF EXISTS `Like`;
	DROP TABLE IF EXISTS `Comment`;
	DROP TABLE IF EXISTS Article;
	DROP TABLE IF EXISTS Forum;
	DROP TABLE IF EXISTS Report;


	-- 版類 --
	CREATE TABLE Forum (
		forumNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '版類編號',
		`name` VARCHAR(20) COMMENT '名稱'
	) COMMENT '版類';

		

	INSERT INTO Forum (name) VALUES ('版類A');
	INSERT INTO Forum (name) VALUES ('版類B');
	INSERT INTO Forum (name) VALUES ('版類C');
	INSERT INTO Forum (name) VALUES ('版類D');
	INSERT INTO Forum (name) VALUES ('版類E');



	-- 文章 --
	CREATE TABLE Article (
		articleNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '文章編號',
		userNumber INT NOT NULL COMMENT '會員編號',
		forumNumber	INT NOT NULL COMMENT '版類編號',
		content	LONGTEXT COMMENT '內容',
		issueTime DATETIME COMMENT '發文時間',
		titleContent VARCHAR(255) COMMENT '標題內容',
		articleState INT COMMENT '文章狀態',
		likeSum	INT COMMENT '總讚數',
		pageView INT COMMENT '瀏覽次數',
	   FOREIGN KEY (userNumber) REFERENCES `User`(`number`),
	   FOREIGN KEY (forumNumber) REFERENCES Forum(forumNumber)
	) COMMENT '文章';
		

INSERT INTO Article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (1, 1, '文章內容1','2024-04-10 09:00:00','標題1', 1,10,100);
INSERT INTO Article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (2, 2, '文章內容2','2024-04-10 09:00:00','標題2', 0,5,10);
INSERT INTO Article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (3, 3, '文章內容3','2024-04-10 09:00:00','標題3', 1,80,500);
INSERT INTO Article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (4, 4, '文章內容4','2024-04-10 09:00:00','標題4', 1,6,70);
INSERT INTO Article (userNumber, forumNumber, content, issueTime , titleContent , articleState , likeSum , pageView) VALUES (5, 5, '文章內容5','2024-04-10 09:00:00','標題5', 0,100,1000);



	-- 留言 --
	CREATE TABLE `Comment` (
		commentNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '留言編號',
		userNumber INT NOT NULL COMMENT '會員編號',
		articleNumber	INT NOT NULL COMMENT '文章編號',
		content	TEXT COMMENT '內容',
		commentTime	DATETIME COMMENT '留言時間',
		commentState INT COMMENT '留言狀態',
		likeSum	INT COMMENT '總讚數',
	   FOREIGN KEY (userNumber) REFERENCES `User`(number),
	   FOREIGN KEY (articleNumber) REFERENCES Article(articleNumber)
	) COMMENT '留言';
		

INSERT INTO `Comment` (userNumber, articleNumber, content, commentTime , commentState , likeSum) VALUES (1, 1, '文章內容1','2024-04-10 09:00:00',1,10);
INSERT INTO `Comment` (userNumber, articleNumber, content, commentTime , commentState , likeSum) VALUES (2, 3, '文章內容3','2024-04-10 10:00:00',1,10);
INSERT INTO `Comment` (userNumber, articleNumber, content, commentTime , commentState , likeSum) VALUES (3, 5, '文章內容5','2024-04-10 11:00:00',1,10);
INSERT INTO `Comment` (userNumber, articleNumber, content, commentTime , commentState , likeSum) VALUES (4, 7, '文章內容7','2024-04-10 12:00:00',1,10);
INSERT INTO `Comment` (userNumber, articleNumber, content, commentTime , commentState , likeSum) VALUES (5, 9, '文章內容9','2024-04-10 13:00:00',1,10);




	-- 點讚 --
	CREATE TABLE `Like` (
		number	INT PRIMARY KEY AUTO_INCREMENT COMMENT '編號',
		articleNumber INT  COMMENT '文章編號',
		commentNumber INT  COMMENT '留言編號',
		userNumber	INT NOT NULL COMMENT '會員編號',
		FOREIGN KEY (articleNumber) REFERENCES Article(articleNumber),
		FOREIGN KEY (commentNumber) REFERENCES `Comment`(commentNumber),
		FOREIGN KEY (userNumber) REFERENCES `User`(userNumber)
	) COMMENT '點讚';

	INSERT INTO `Like` (articleNumber, commentNumber, userNumber) VALUES (1,1,1);
	INSERT INTO `Like` (articleNumber, commentNumber, userNumber) VALUES (1,2,2);
	INSERT INTO `Like` (articleNumber, commentNumber, userNumber) VALUES (2,1,2);
	INSERT INTO `Like` (articleNumber, commentNumber, userNumber) VALUES (2,3,1);
	INSERT INTO `Like` (articleNumber, commentNumber, userNumber) VALUES (3,4,1);














	CREATE TABLE Report (
		reportNumber INT PRIMARY KEY AUTO_INCREMENT COMMENT '檢舉編號',
		reportedArticleNumber INT COMMENT '被檢舉文章編號',
		reportedCommentNumber INT COMMENT '被檢舉留言編號',
		reporter INT COMMENT '檢舉人',
		userStatus INT COMMENT '會員狀態',
		processingStatusCode INT COMMENT '處理狀態編號',
		content LONGTEXT COMMENT '內容',
		reportTime DATETIME COMMENT '檢舉時間',
		penaltyStartDate DATE COMMENT '處罰起始日期',
		penaltyEndDate DATE COMMENT '處罰結束日期',
		auditResultComment VARCHAR(255) COMMENT '審核的結果評論',
		FOREIGN KEY (reportedArticleNumber) REFERENCES Article(articleNumber),
		FOREIGN KEY (reportedCommentNumber) REFERENCES `Comment`(commentNumber),
		FOREIGN KEY (reporter) REFERENCES `User`(`number`),
		FOREIGN KEY (userStatus) REFERENCES UserStatus(userStatus)
	) COMMENT '檢舉';

	INSERT INTO Report (reportedArticleNumber, reportedCommentNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (1, NULL, 1, 1, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO Report (reportedArticleNumber, reportedCommentNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (2, NULL, 2, 1, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO Report (reportedArticleNumber, reportedCommentNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (3, NULL, 3, 0, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO Report (reportedArticleNumber, reportedCommentNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (4, NULL, 4, 1, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
	INSERT INTO Report (reportedArticleNumber, reportedCommentNumber, reporter, userStatus, processingStatusCode, content, reportTime, penaltyStartDate, penaltyEndDate, auditResultComment) VALUES (5, NULL, 5, 0, 1, '檢舉內容1', '2024-04-10 14:00:00', '2024-04-12', '2024-04-15', '審核內容1');
