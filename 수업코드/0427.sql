/* 4�� 27��  */
-- [����] �Ʒ� �־��� ���̺��� �����Ͻÿ�
-- (���̺�) �Ҽӻ� ������ �÷� ���� - �θ�
-- (���̺�)���̵� �׷������� �����ϰ��� �ϴ� �÷� ���� (�ڽ�) (�θ�)
-- (���̺�) ��Ŭ�� ���� (�ڽ�)

DROP TABLE  IDOL_FAN_CLUB;
DROP TABLE IDOL_MEMBER;
DROP TABLE IDOL_TEAM;
DROP TABLE AGENCY;

DROP SEQUENCE AGENCY_SEQ;
DROP SEQUENCE   IDOL_MEMBER_SEQ;

CREATE TABLE AGENCY
(
   AGENCY_ID NUMBER PRIMARY KEY,		  		    -- AGENCY ���̵�
   AGENCY_NAME VARCHAR2(50) UNIQUE,  		-- �Ҽӻ��
   CEO VARCHAR2(20) NOT NULL, 				        -- ��ǥ��
   TEL VARCHAR2(20) NOT NULL, 				        -- ��ǥ��ȭ NN
   STOCK CHAR(1) DEFAULT 'N' CHECK (STOCK IN ('Y', 'N')), --���忩�� 
   FOUNDED_YEAR NUMBER(4) ,						        -- �������� 
   IDOL_TEAM_COUNT NUMBER(3) DEFAULT 1 	-- �����ϴ� ���̵� �� ��
);

CREATE SEQUENCE AGENCY_SEQ;

INSERT INTO AGENCY
(AGENCY_ID, AGENCY_NAME, CEO, TEL, FOUNDED_YEAR, IDOL_TEAM_COUNT)
VALUES
(AGENCY_SEQ.NEXTVAL, 'KITA ENTERTAINMENT', '�������', '02-111-8888', 2023, 5);

INSERT INTO AGENCY
(AGENCY_ID, AGENCY_NAME, CEO, TEL, FOUNDED_YEAR, STOCK,  IDOL_TEAM_COUNT)
VALUES
(AGENCY_SEQ.NEXTVAL, '(��) SM', '�̼���', '02-333-0000', 1990, 'Y', 20);

SELECT * FROM AGENCY;

SELECT AGENCY_SEQ.CURRVAL FROM DUAL;

CREATE TABLE IDOL_TEAM
(
  TEAM_ID NUMBER  PRIMARY KEY, 			-- PK
  TEAM_NAME VARCHAR2(50), 					-- ����
  MEMBER_CNT, 
  LEADER CHAR(1) DEFAULT 'N' CHECK (LEADER IN('Y', 'N')),  -- ������ ('Y', 'N')
  DEBUT_DATE DATE, 								-- ������
  AGENCY_ID NUMBER REFERENCES AGENCY(AGENCY_ID) 	-- FK
 ); 
 
CREATE TABLE IDOL_MEMBER
(
   IDOL_ID NUMBER PRIMARY KEY,
   IDOL_NAME VARCHAR2(50), 					-- ���̵� Ȱ����
   BIRTHDAY DATE, 								    -- ���� �������
   COUNTRY VARCHAR2(30), 						-- ����
   POSITIONS VARCHAR2(30), 					-- ���� (��: ����, ��, ��, ���־�)
   GENDER CHAR(1) CHECK (GENDER IN('M', 'F')), 		        --  ���� ('M', 'F')
  TEAM_ID NUMBER REFERENCES IDOL_TEAM(TEAM_ID) 	-- FK
);
  
CREATE SEQUENCE   IDOL_MEMBER_SEQ;
  
  
CREATE TABLE  IDOL_FAN_CLUB
(
  CLUB_NAME VARCHAR2(20) PRIMARY KEY, 		-- ��Ŭ���� PK
  PAY NUMBER  DEFAULT 50000, 					        -- ���Ժ�
  COLOR VARCHAR2(30), 							            --  ��Ŭ�� ����
  FAN_CNT NUMBER DEFAULT 0, 					        -- ��Ŭ�� ȸ�� �� 
  TEAM_ID NUMBER REFERENCES IDOL_TEAM(TEAM_ID) -- FK
);

/***************************
   SEQUENCE �����ϱ� 
- �Ϸù�ȣ �ڵ� ���� ��ü
- �߻� �Ӽ� : NEXTVAL
- ��ȣ Ȯ�� : CURRVAL
****************************/ 

CREATE SEQUENCE ������;   -- ����Ģ : ���̺��_SEQ
SELECT AGENCY_SEQ.CURRVAL FROM DUAL;




