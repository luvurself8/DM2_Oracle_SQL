/* 4월 27일  */
-- [문제] 아래 주어진 테이블을 생성하시오
-- (테이블) 소속사 정보를 컬럼 수집 - 부모
-- (테이블)아이돌 그룹정보를 저장하고자 하는 컬럼 수집 (자식) (부모)
-- (테이블) 팬클럽 정보 (자식)

DROP TABLE  IDOL_FAN_CLUB;
DROP TABLE IDOL_MEMBER;
DROP TABLE IDOL_TEAM;
DROP TABLE AGENCY;

DROP SEQUENCE AGENCY_SEQ;
DROP SEQUENCE   IDOL_MEMBER_SEQ;

CREATE TABLE AGENCY
(
   AGENCY_ID NUMBER PRIMARY KEY,		  		    -- AGENCY 아이디
   AGENCY_NAME VARCHAR2(50) UNIQUE,  		-- 소속사명
   CEO VARCHAR2(20) NOT NULL, 				        -- 대표명
   TEL VARCHAR2(20) NOT NULL, 				        -- 대표전화 NN
   STOCK CHAR(1) DEFAULT 'N' CHECK (STOCK IN ('Y', 'N')), --상장여부 
   FOUNDED_YEAR NUMBER(4) ,						        -- 설립연도 
   IDOL_TEAM_COUNT NUMBER(3) DEFAULT 1 	-- 관리하는 아이돌 팀 수
);

CREATE SEQUENCE AGENCY_SEQ;

INSERT INTO AGENCY
(AGENCY_ID, AGENCY_NAME, CEO, TEL, FOUNDED_YEAR, IDOL_TEAM_COUNT)
VALUES
(AGENCY_SEQ.NEXTVAL, 'KITA ENTERTAINMENT', '삼장법사', '02-111-8888', 2023, 5);

INSERT INTO AGENCY
(AGENCY_ID, AGENCY_NAME, CEO, TEL, FOUNDED_YEAR, STOCK,  IDOL_TEAM_COUNT)
VALUES
(AGENCY_SEQ.NEXTVAL, '(주) SM', '이수만', '02-333-0000', 1990, 'Y', 20);

SELECT * FROM AGENCY;

SELECT AGENCY_SEQ.CURRVAL FROM DUAL;

CREATE TABLE IDOL_TEAM
(
  TEAM_ID NUMBER  PRIMARY KEY, 			-- PK
  TEAM_NAME VARCHAR2(50), 					-- 팀명
  MEMBER_CNT, 
  LEADER CHAR(1) DEFAULT 'N' CHECK (LEADER IN('Y', 'N')),  -- 팀리더 ('Y', 'N')
  DEBUT_DATE DATE, 								-- 데뷔일
  AGENCY_ID NUMBER REFERENCES AGENCY(AGENCY_ID) 	-- FK
 ); 
 
CREATE TABLE IDOL_MEMBER
(
   IDOL_ID NUMBER PRIMARY KEY,
   IDOL_NAME VARCHAR2(50), 					-- 아이돌 활동명
   BIRTHDAY DATE, 								    -- 팀원 생년월일
   COUNTRY VARCHAR2(30), 						-- 국적
   POSITIONS VARCHAR2(30), 					-- 역할 (예: 보컬, 랩, 댄스, 비주얼)
   GENDER CHAR(1) CHECK (GENDER IN('M', 'F')), 		        --  성별 ('M', 'F')
  TEAM_ID NUMBER REFERENCES IDOL_TEAM(TEAM_ID) 	-- FK
);
  
CREATE SEQUENCE   IDOL_MEMBER_SEQ;
  
  
CREATE TABLE  IDOL_FAN_CLUB
(
  CLUB_NAME VARCHAR2(20) PRIMARY KEY, 		-- 팬클럽명 PK
  PAY NUMBER  DEFAULT 50000, 					        -- 가입비
  COLOR VARCHAR2(30), 							            --  팬클럽 색상
  FAN_CNT NUMBER DEFAULT 0, 					        -- 팬클럽 회원 수 
  TEAM_ID NUMBER REFERENCES IDOL_TEAM(TEAM_ID) -- FK
);

/***************************
   SEQUENCE 생성하기 
- 일련번호 자동 생성 객체
- 발생 속성 : NEXTVAL
- 번호 확인 : CURRVAL
****************************/ 

CREATE SEQUENCE 시퀀명;   -- 명명규칙 : 테이블명_SEQ
SELECT AGENCY_SEQ.CURRVAL FROM DUAL;




