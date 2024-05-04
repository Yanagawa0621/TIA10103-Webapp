CREATE DATABASE IF NOT EXISTS g3;

USE g3;

-- ���: �|��(User) --
-- number��PK --
-- accountStatusNumber, accessNumber��FK --
-- account, password, introduceOneself, nationalIdNumber��UK  --
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
    UNIQUE(account, password, introduceOneself, nationalIdNumber),-- �b�o�̩w�q�ߤ@�� --
    FOREIGN KEY (accountStatusNumber) REFERENCES UserStatus(UserStatus), -- �]�m "accountStatusNumber" ���~��A�Ѧ� "UserStatus" �� "UserStatus" �D��
    FOREIGN KEY (accessNumber) REFERENCES Access(accessNumber) -- �]�m "accessNumber" ���~��A�Ѧ� "Access" �� "accessNumber" �D��
);

-- ���J Access ����� --
INSERT INTO Access (name, accessDescribe) VALUES ('1', '�y�z1');

-- ���J User ����� --
INSERT INTO User (accountStatusNumber, accessNumber, account, password, name, registerDate, sex, eMail, introduceOneself, birthday, photo, nationalIdNumber, telephoneNumber, address, statusStartDate) 
VALUES 
    (1, 1, '1', '123', 'abc', '1981-11-17', '1', 'abc@gmail.com', 'HELLO!', '1981-11-17', NULL, '1', '1', '1', '1982-12-18'),
    (2, 1, '1', '456', 'def', '1983-01-19', '1', 'def@gmail.com', 'HI@', '1981-11-17', NULL, '1', '1', '1', '1983-02-20'),
    (3, 1, '1', '789', 'ghi', '1984-02-20', '1', 'ghi@gmail.com', 'eum#', '1981-11-17', NULL, '1', '1', '1', '1985-03-21');

 ----------------------------------------------------------------   
    
    
    
    
-- ���: �|�����A(UserStatus) --
CREATE TABLE IF NOT EXISTS UserStatus (
    UserStatus INTEGER AUTO_INCREMENT PRIMARY KEY,
    statusName VARCHAR(20),
    statusDescribe VARCHAR(50),
    statusDate DATE
);

-- ���J UserStatus ����� --
INSERT INTO UserStatus (statusName, statusDescribe, statusDate) 
VALUES 
    ('1', '1', DATE('1981-01-01'));
    
----------------------------------------------------------------   
    
    
    
    
-- ���: �v��(Access) --
CREATE TABLE IF NOT EXISTS Access (
    accessNumber INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    accessDescribe VARCHAR(50)
);

-- ���J Access ����� --
INSERT INTO Access (name, accessDescribe) 
VALUES 
    ('1', '�y�z1');

----------------------------------------------------------------    
    
    

    
-- ���: �n�J�O��(LoginRecord) --
-- number��PK --
-- userNumber��FK --
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
    
    

    
-- ���: �ӶD(Complaint) --
-- complaintNumber��PK --
-- userNumber��FK --
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
