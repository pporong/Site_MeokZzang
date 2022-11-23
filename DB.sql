#DB 생성
DROP DATABASE IF EXISTS MZ_Recipe;
CREATE DATABASE MZ_Recipe;
USE MZ_Recipe;

# 게시물 테이블 생성
CREATE TABLE article(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '공지1',
`body` = '공지내용1~';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1!';
 
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2!';

# 회원 테이블 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(20) NOT NULL,
    loginPw CHAR(60) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반,7=관리자)',
    `name` CHAR(20) NOT NULL, 
    nickname CHAR(20) NOT NULL,
    cellphoneNum CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부 (0=탈퇴 전,1=탈퇴 후)',
    delDate DATETIME COMMENT '탈퇴날짜'
);

# 멤버 데이터 생성 (관리자)
INSERT INTO `member`
SET regDate = NOW(),
    updateDate = NOW(),
    loginId = 'admin1',
    loginPw = 'admin1',
    `authLevel` = 7,
    `name` = '김관리',
    nickname = '관리자',
    cellphoneNum = '010-0000-0000',
    email = 'ppoemong@gmail.com';
    
# 멤버 데이터 생성 (일반)
INSERT INTO `member`
SET regDate = NOW(),
    updateDate = NOW(),
    loginId = 'test1',
    loginPw = 'test1',
    `name` = '김회원',
    nickname = '사용자1',
    cellphoneNum = '010-1234-5678',
    email = 'ppoemong@gmail.com';
    
INSERT INTO `member`
SET regDate = NOW(),
    updateDate = NOW(),
    loginId = 'test2',
    loginPw = 'test2',
    `name` = '최회원',
    nickname = '사용자2',
    cellphoneNum = '010-5678-1234',
    email = 'ppoemong@gmail.com';
    

# 게시물 테이블에 회원번호 칼럼 추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER `updateDate`;

# memberId 추가
UPDATE article
SET memberId = 0
WHERE memberId = 1;

# 게시판 테이블 생성
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항), free1(자유게시판1), free2(자유게시판2),..',
    `name` CHAR(50) NOT NULL UNIQUE COMMENT '게시판 이름',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부 (0=삭제 전,1=삭제 후)',
    delDate DATETIME COMMENT '삭제날짜'
);

# basic board 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free1',
`name` = '자유';

# 게시물 테이블에 boardId 칼럼 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER `memberId`;

# 1 게시물을 공지사항 게시물로 수정
UPDATE article
SET boardId = 1
WHERE id IN (1)

# 2, 3번 게시물을 공지사항 게시물로 수정
UPDATE article
SET boardId = 2
WHERE id IN (2, 3)

# 1번 게시물을 관리자1이 쓴 게시물로 수정
UPDATE article
SET memberId = 1
WHERE id IN (1)

# 2, 3번 게시물을 회원1이 쓴 게시물로 수정
UPDATE article
SET memberId = 2
WHERE id IN (2, 3)

SELECT * FROM `member`;
SELECT * FROM article;
SELECT * FROM board;

# 게시물 테이블에 boardId 칼럼 추가
ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0;

# reactionPoint 테이블
CREATE TABLE reactionPoint (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
	relId INT(10) UNSIGNED NOT NULL COMMENT '관련 데이터  번호',
    `point` SMALLINT(2) NOT NULL
);

# reactionPoint 테스트 데이터
# 1번 회원이 1번 article 에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 1번 회원이 2번 article 에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

# 2번 회원이 1번 article 에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 2번 회원이 2번 article 에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`point` = -1;

# 3번 회원이 1번 article 에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

# 게시물 테이블에 goodReactionPoint 칼럼 추가
ALTER TABLE article ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
# 게시물 테이블에 badReactionPoint 칼럼 추가
ALTER TABLE article ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 기존 게시물의 goodReactionPoint,badReactionPoint 필드의 값 채워주기
UPDATE article AS A
INNER JOIN (
	SELECT RP.relTypeCode, RP.relId,
	SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
	SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
	FROM reactionPoint AS RP
	GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;


#######################################################

SELECT * FROM reactionPoint;

DESC article;

SELECT * FROM article;

SELECT LAST_INSERT_ID();

/*# 게시물 갯수 늘리기
insert into article
(
	regDate, updateDate, memberId, boardId, title, `body`
)
select now(), now(), FLOOR(RAND() * 2) + 1, FLOOR(RAND() * 2) + 1, concat('제목_',rand()), CONCAT('내용_',RAND())
from article;
*/

/*
--> getArticles
select A.*, 
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(if(RP.point > 0, RP.point, 0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)),0) AS extra__badReactionPoint
from (
	SELECT A.*, M.nickname AS extra__writerName
	FROM article AS A
	LEFT JOIN `member` AS M
	ON A.memberId= M.id 
			) As A
left JOIN reactionPoint AS RP
ON RP.relTypeCode = 'article'
and A.id = RP.relId
group by A.id
*/

/*
--> getArticle
SELECT A.*, M.nickname AS extra__writerName,
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(if(RP.point > 0, RP.point, 0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)),0) AS extra__badReactionPoint
FROM article AS A
LEFT JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
on RP.relTypeCode = 'article'
and A.id = RP.relId
WHERE A.id =1
GROUP BY A.id
*/

/*
select ifnull(sum(RP.point),0) as s
from reactionPoint AS RP
where RP.relTypeCode = 'article'
AND RP.relId = 2
and RP.memberId = 2
*/

/*
--> 각 게시물 별, 좋아요, 싫어요 총합
select RP.relTypeCode, RP.relId,
sum(if(RP.point > 0, RP.point, 0)) as goodReactionPoint,
sum(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
from reactionPoint as RP
group by RP.relTypeCode, RP.relId
*/
/*
SELECT *
FROM reactionPoint AS RP
GROUP BY RP.relTypeCode, RP.relId
*/

SELECT * FROM article;

# 기존 게시물의 goodReactionPoint,badReactionPoint 필드의 값 채워주기
UPDATE article AS A
INNER JOIN (
	SELECT RP.relTypeCode, RP.relId,
	SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
	SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
	FROM reactionPoint AS RP
	GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;


# 댓글 table 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(30) NOT NULL COMMENT '관련데이터타입코드',
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련데이터번호',
    `body` TEXT NOT NULL
);


# reply 테이블에 goodReactionPoint 칼럼 추가
ALTER TABLE reply ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
# reply 테이블에 badReactionPoint 칼럼 추가
ALTER TABLE reply ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# reply 테이블에 index 걸기
ALTER TABLE `MZ_Recipe`.`reply` ADD INDEX (`relTypeCode` , `relId`); 


# 부가정보테이블
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(70) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`);

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;


# 회원 테이블의 로그인 비밀번호의 길이를 100으로 늘림
ALTER TABLE `member` MODIFY COLUMN loginPw VARCHAR(100) NOT NULL;

# 기존 회원의 비밀번호를 암호화 
UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

#######################################################

SELECT * FROM attr;

SELECT * FROM reply;

SELECT * FROM reactionPoint;

DESC article;

SELECT * FROM article;

SELECT * FROM `member`;

SELECT LAST_INSERT_ID();

-- explain SELECT R.*, M.nickname AS extra__writerName
-- FROM reply AS R
-- LEFT JOIN `member` AS M
-- ON R.memberId = M.id
-- WHERE R.relTypeCode = 'article'
-- AND R.relId = 2
-- ORDER BY R.id DESC

-- SELECT R.*,
-- M.nickname AS extra__writerName
-- FROM reply AS R
-- LEFT JOIN `member` AS M
-- ON R.memberId = M.id
-- WHERE R.id = 3

SELECT SHA2('Hello',256)

-- -----------------------------------`MZ_Recipe`----------------
SELECT * FROM article ORDER BY id DESC;
SELECT * FROM board;
SELECT * FROM `member`;
SELECT * FROM reactionPoint;

SELECT * FROM attr;
-- --------------------------------------------------------------