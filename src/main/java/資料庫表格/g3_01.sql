CREATE DATABASE IF NOT EXISTS g3;

USE g3;

-- 表格: 會員(User) --
-- number為PK --
-- accountStatusNumber, accessNumber為FK --
-- account, password, introduceOneself, nationalIdNumber為UK  --
CREATE TABLE IF NOT EXISTS User (
    number INTEGER AUTO_INCREMENT PRIMARY KEY,
    accountStatusNumber INTEGER NOT NULL,
    accessNumber INTEGER NOT NULL,
    account VARCHAR(20),
    passcode VARCHAR(20),
    name VARCHAR(20),
    registerDate DATE,
    sex CHAR(1),
    eMail VARCHAR(255),
    introduceOneself TEXT,
    birthday DATE,
    photo LONGBLOB,
    nationalIdNumber CHAR(10),
    telephoneNumber VARCHAR(15),
    address VARCHAR(255),
    statusStartDate DATE,
    UNIQUE(account, password, introduceOneself, nationalIdNumber),-- 在這裡定義唯一鍵 --
    FOREIGN KEY (accountStatusNumber) REFERENCES UserStatus(UserStatus), -- 設置 "accountStatusNumber" 為外鍵，參考 "UserStatus" 表的 "UserStatus" 主鍵
    FOREIGN KEY (accessNumber) REFERENCES Access(accessNumber) -- 設置 "accessNumber" 為外鍵，參考 "Access" 表的 "accessNumber" 主鍵
);

-- 插入 Access 表的資料 --
INSERT INTO Access (name, accessDescribe) VALUES ('1', '描述1');

-- 插入 User 表的資料 --
INSERT INTO User (accountStatusNumber, accessNumber, account, password, name, registerDate, sex, eMail, introduceOneself, birthday, photo, nationalIdNumber, telephoneNumber, address, statusStartDate) 
VALUES 
    (1, 1, '1', '123', 'abc', '1981-11-17', '1', 'abc@gmail.com', 'HELLO!', '1981-11-17', NULL, '1', '1', '1', '1982-12-18'),
    (2, 1, '1', '456', 'def', '1983-01-19', '1', 'def@gmail.com', 'HI@', '1981-11-17', NULL, '1', '1', '1', '1983-02-20'),
    (3, 1, '1', '789', 'ghi', '1984-02-20', '1', 'ghi@gmail.com', 'eum#', '1981-11-17', NULL, '1', '1', '1', '1985-03-21');

 ----------------------------------------------------------------   
    
    
    
    
-- 表格: 會員狀態(UserStatus) --
CREATE TABLE IF NOT EXISTS UserStatus (
    UserStatus INTEGER AUTO_INCREMENT PRIMARY KEY,
    statusName VARCHAR(20),
    statusDescribe VARCHAR(50),
    statusDate DATE
);

-- 插入 UserStatus 表的資料 --
INSERT INTO UserStatus (statusName, statusDescribe, statusDate) 
VALUES 
    ('1', '1', DATE('1981-01-01'));
    
----------------------------------------------------------------   
    
    
    
    
-- 表格: 權限(Access) --
CREATE TABLE IF NOT EXISTS Access (
    accessNumber INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    accessDescribe VARCHAR(50)
);

-- 插入 Access 表的資料 --
INSERT INTO Access (name, accessDescribe) 
VALUES 
    ('1', '描述1');

----------------------------------------------------------------    
    
    

    
-- 表格: 登入記錄(LoginRecord) --
-- number為PK --
-- userNumber為FK --
CREATE TABLE IF NOT EXISTS LoginRecord (
    number INTEGER AUTO_INCREMENT PRIMARY KEY,
    userNumber INTEGER NOT NULL,
    loginTime DATETIME,
    ip VARCHAR(45),
    area VARCHAR(20),
    FOREIGN KEY (userNumber) REFERENCES User(number)
);

INSERT INTO LoginRecord (userNumber, loginTime, ip, area) 
VALUES 
    (1, '1981-11-17 11:12:13', '1', 'taiwan');
   
----------------------------------------------------------------    
    
    

    
-- 表格: 申訴(Complaint) --
-- complaintNumber為PK --
-- userNumber為FK --
CREATE TABLE IF NOT EXISTS Complaint (
    complaintNumber INTEGER AUTO_INCREMENT PRIMARY KEY,
    userNumber INTEGER NOT NULL,
    processingStatus INTEGER NOT NULL,
    complaintTypeNumber INTEGER,
    content LONGTEXT,
    complaintTime DATETIME,
    completedDate DATETIME,
    response LONGTEXT,
    FOREIGN KEY (userNumber) REFERENCES User(number)
);

INSERT INTO Complaint (userNumber, processingStatus, complaintTypeNumber, content, complaintTime, completedDate, response) 
VALUES 
    (1, 1, 1, '123', '1981-11-17 00:00:00', '1981-11-17 00:00:00', '1');
