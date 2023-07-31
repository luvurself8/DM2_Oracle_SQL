-- 2023�� 5�� 9�� ���蹮�� 

-- 1. �������� 5������ ���ÿ�. (5��)
Unique, Not Null, Primary Key, Check, Foreign Key

-- 2. �⺻Ű�� ������ �ִ� �⺻ �������� 2������ �����ΰ�? (5��)
Unique, Not Null

-- 3. �θ����̺�� �ڽ����̺� ���� ���踦 �α� ���ؼ� ����ϴ� ���������� �����ΰ�? (5��)
Foreign Key

-- 4. HR ������ �⺻ ���� ���̺� �̿��Ͽ� ���ú� ��� ���� ������ ���� ����Ͻÿ�. (10��)
SELECT CITY "���ø�", COUNT(*) "�ο���"
FROM EMPLOYEES  JOIN DEPARTMENTS 
USING (DEPARTMENT_ID)
JOIN LOCATIONS 
USING (LOCATION_ID)
GROUP BY CITY;

-- 5. ���α׷� ���� ��¥�� �������� �ٹ��� �Ⱓ�� 16�� �̸��� ������� �̸��� �Ի����� �Ի��� �������� ���������Ͽ� ����Ͻÿ�. (5��)
 
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE (SYSDATE-HIRE_DATE)/365 < 16
ORDER BY 3;

?
-- 6. ������� �̸���, �޿�, �μ���ȣ �� �ڽ� �μ��� ��� �޿��� ��ȸ�Ͻÿ�. (��ձ޿��� �Ҽ��� 2�ڸ����� ���) (10��)
SELECT FIRST_NAME "�̸�", LAST_NAME "��", SALARY "�޿�", DEPARTMENT_ID "�μ���ȣ",  "�μ� ��� �޿�"
FROM EMPLOYEES OUTER JOIN 
    (SELECT DEPARTMENT_ID, TO_CHAR(ROUND(AVG(SALARY), 2), '9999,999.99')  AS "�μ� ��� �޿�"
     FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID) tbl
USING (DEPARTMENT_ID);


-- 7. �����ȣ, ���� �Ⱓ, �������� ��µǵ��� �Ͻÿ�. JOB_HISTORY, JOBS ���̺� ��� (5��)
 
SELECT j.EMPLOYEE_ID "�����ȣ",
       trunc((j.END_DATE - j.START_DATE)/365)||'�� ' ||
       trunc(((j.END_DATE-j.START_DATE)/365-trunc((j.END_DATE-j.START_DATE)/365) )*10)||'����' as "�����Ⱓ", 
       js.JOB_TITLE "������"
FROM JOB_HISTORY j JOIN JOBS js
ON j.JOB_ID = js.JOB_ID ;


SELECT j.EMPLOYEE_ID "�����ȣ",
       trunc(months_beween(j.END_DATE, j.START_DATE)/12)||'�� ' ||
       trunc(((j.END_DATE-j.START_DATE)/365-trunc((j.END_DATE-j.START_DATE)/365) )*10)||'����' as "�����Ⱓ", 
       js.JOB_TITLE "������"
FROM JOB_HISTORY j JOIN JOBS js
ON j.JOB_ID = js.JOB_ID ;


-- 8. 2023�� 7�� 19���� �������̶�� ���� �� ���� ��¥�κ��� ���� ���Ҵ��� ����ϴ� SQL������ �ۼ��Ͻÿ�. (5��)
 
SELECT CEIL(TO_DATE('23/07/19')-SYSDATE) "���� �ϼ�" FROM DUAL;


-- 9. �� �μ��� ��� �ٹ����� �Ʒ��� ���� ��ȸ�Ͻÿ�. (10��)
SELECT DEPARTMENT_NAME "�μ���", CEIL(AVG(SYSDATE-HIRE_DATE)) "��� �ٹ���"
FROM EMPLOYEES JOIN DEPARTMENTS
USING (DEPARTMENT_ID)
GROUP BY DEPARTMENT_NAME
ORDER BY 2 DESC;

-- 10. Employees ���̺��� �Ŵ����� ���� ������� ��ձ޿��� 4000�̻��� ����� ��ձ޿�, �ִ�޿�, �ּұ޿��� �׸��� ���� ����Ͻÿ�. ��, �Ŵ�����ȣ�� ���� ����� 0������ ����ϰ�, �Ҽ��� ���� �ø��Ͻÿ�.(10��)
 
SELECT 
    NVL(MANAGER_ID, 0) "�Ŵ�����ȣ"
    , CEIL( AVG(SALARY)) "��ձ޿�"
    , MAX(SALARY) "�ִ�޿�"
    , MIN(SALARY) "�ּұ޿�"
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING CEIL( AVG(SALARY)) >= 4000
ORDER BY 1;

-- �� ������ ������ ����ϴ� ���� ������ ��������� �����ϴ� ���̺��̴�. �־��� ������ ���̺�� ��������  
--    �����Ͻÿ�. (���̺��� �����ϸ鼭 ���������� �ο��� ��.) 

-- 11. ���̺��: Categories (��ǰ ī�װ�) (10��)
CREATE TABLE categories (
    CATEGORY_ID CHAR(7) PRIMARY KEY 
  		 CHECK(CATEGORY_ID IN ('WR_PROD', 'PA_PROD', 'AR_PROD', 'ME_PROD', 'ET_PROD' )),
    CATEGORY_NAME VARCHAR2(30) UNIQUE 
 		CHECK(CATEGORY_NAME IN ('�ʱⱸ', '���̷�', '�̼���ǰ', '������ǰ', '��Ÿ')),
    CATEGORY_DESC VARCHAR2(3000)
);

-- 12. ���̺��: Products (��ǰ) (5��)
CREATE TABLE products
(
    PROD_ID         NUMBER PRIMARY KEY,
    PROD_NAME       VARCHAR2(30) NOT NULL,
    COUNTRY         VARCHAR2(50) NOT NULL,
    MANUFACTURES    VARCHAR2(50) NOT NULL,
    MAKING_DATE     DATE,
    CATEGORY_ID     REFERENCES categories(CATEGORY_ID) 
);

-- 13. ������ : Products_seq (��ǰ ���̺��� ������ ��ü : 100���� �����Ͽ� 50�� �����ϵ��� ����) (5��)
CREATE SEQUENCE products_seq
START WITH 100
INCREMENT BY 50;


-- 14. ���̺��: Stock (���) (5��)
CREATE TABLE STOCK (
    STOCK_ID    	NUMBER PRIMARY KEY,
    PROD_ID     	NUMBER  REFERENCES  products(PROD_ID) ON DELETE CASCADE,
    RECEIVE_DATE 	DATE,
    FORWARD_DATE 	DATE DEFAULT SYSDATE, 
    UNIT_PRICE 	NUMBER(10, 2) DEFAULT 0,
    TOTAL_STOCK 	NUMBER(7) DEFAULT 0
);

-- 15. ������ : Stock_seq (��� ���̺��� ������ ��ü) (5��)
CREATE SEQUENCE STOCK_SEQ;


