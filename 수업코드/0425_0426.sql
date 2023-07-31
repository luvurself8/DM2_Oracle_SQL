/* 4�� 25��(ȭ) */

-- [��������]
-- 1. 80�� �μ��� �޿� ���, �ְ�, ����, �ο����� ���϶�.

SELECT 
    AVG(SALARY), MAX(SALARY), MIN(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID = 80;

-- 2. �� �μ��� �޿��� ���, �ְ�, ����, �ο����� ���Ͻÿ�.
SELECT 
    DEPARTMENT_ID, AVG(SALARY), MAX(SALARY), MIN(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 3. �� �μ��� ��� ����, ��ü ����, ���������� ���Ͽ� ��� ������ ���� ������ ���,
--    �� �μ���ȣ�� NULL�̸� ������� �ʴ´�.
SELECT 
    DEPARTMENT_ID, CEIL(AVG(SALARY)), SUM(SALARY),  MIN(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL
ORDER BY 2 DESC;

-- 4. �� �μ��� ���� ������ �ϴ� ����� �ο����� ���Ͽ� �μ���ȣ, ������, �ο��� ���
SELECT 
    DEPARTMENT_ID, JOB_ID, COUNT(JOB_ID)
FROM EMPLOYEES
GROUP BY JOB_ID, DEPARTMENT_ID
ORDER BY 1 ;


-- 5. ���� ������ �ϴ� ����� ���� 4�� �̻��� ������ �ο����� ���
SELECT JOB_ID, COUNT(JOB_ID)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING   COUNT(JOB_ID)   >=4 
ORDER BY 2 DESC;


/* JOIN 
    - �� �̻��� ���̺�� ���� ������ ���� ���
    - ���̺���� ���� PK�� FK�� ���踦 ������ �ִ�.
    
*/

SELECT * FROM DEPARTMENTS;

-- EQUI JOIN (--> INNER JOIN)
-- PK�� FK�� ���ƾ� ������ ��. 
-- FK�� NULL�� ��� ���ε��� ���� �� �ִ�.
-- �̸�(E), �޿�(E), �μ���(D)
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e, DEPARTMENTS d
WHERE d.department_id = e.department_id
ORDER BY 1;

/** INNER JOIN **/
-- ����� EQUI JOIN�� ����
-- ������ �ٸ�
-- INNER Ű����� ���� ����
-- ON�� ���� ����(pk = fk) --> USING (�÷���) : ( ) �� ���� �Ұ�

-- ��ü ������ �״��
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e INNER JOIN DEPARTMENTS d
ON d.department_id = e.department_id
ORDER BY 1;

-- INNER Ű���� ���� ��
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e JOIN DEPARTMENTS d
ON d.department_id = e.department_id
ORDER BY 1;

-- ON ��� USING ���
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e JOIN DEPARTMENTS d
USING ( department_id) 
ORDER BY 1;

--[����] �μ���(DEPARTMENT_NAME), ���ø�(CITY)�� ��ȸ�Ͻÿ�
-- 1) ����Ŭ ����
SELECT d.DEPARTMENT_NAME, l.CITY
FROM DEPARTMENTS d, LOCATIONS l
WHERE d.LOCATION_ID = l.LOCATION_ID;

-- 2) ANSI ǥ�� (JOIN ~ ON)
SELECT d.DEPARTMENT_NAME, l.CITY
FROM DEPARTMENTS d INNER JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID;

-- 3) ANSI ǥ�� (JOIN ~ USING)
SELECT d.DEPARTMENT_NAME, l.CITY
FROM DEPARTMENTS d JOIN LOCATIONS l
USING (LOCATION_ID);

/** ���̺� 3�� �̻󿡼� JOIN�� �� �� **/
--[����] �μ���(DEPARTMENT_NAME), ���ø�(CITY), �����(COUNTRIES)�� ��ȸ�Ͻÿ�. 

-- 1) ����Ŭ ����
SELECT d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME
FROM DEPARTMENTS d, LOCATIONS l, COUNTRIES c
WHERE 
    d.LOCATION_ID = l.LOCATION_ID
    AND
    l.COUNTRY_ID = c.COUNTRY_ID;

-- 2) ANSI ǥ�� (JOIN ~ ON)
SELECT d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME
FROM DEPARTMENTS d JOIN LOCATIONS l
ON   d.LOCATION_ID = l.LOCATION_ID
JOIN COUNTRIES c
ON   l.COUNTRY_ID = c.COUNTRY_ID;

-- 3) ANSI ǥ�� (JOIN ~ USING)
SELECT d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME
FROM DEPARTMENTS d JOIN LOCATIONS l
USING  (LOCATION_ID)
JOIN COUNTRIES c
USING (COUNTRY_ID);

-- [����] ������, �Ի���, �ټӿ���, �μ���, ���޸�, �޿�
-- 1) ����Ŭ ����
SELECT 
    FIRST_NAME, HIRE_DATE, 
    TO_CHAR(SYSDATE, 'YYYY')- TO_CHAR(HIRE_DATE, 'YYYY') AS "�ټӳ��", 
    DEPARTMENT_NAME, 
    JOB_TITLE, 
    SALARY
FROM EMPLOYEES e, JOBS j, DEPARTMENTS d
WHERE
    e.DEPARTMENT_ID = d.DEPARTMENT_ID
    AND
    e.JOB_ID = j.JOB_ID
ORDER BY FIRST_NAME;    

-- 2) JOIN~ON
SELECT 
    FIRST_NAME, HIRE_DATE, 
    TO_CHAR(SYSDATE, 'YYYY')- TO_CHAR(HIRE_DATE, 'YYYY') AS "�ټӳ��", 
    DEPARTMENT_NAME, 
    JOB_TITLE, 
    SALARY
FROM EMPLOYEES e JOIN JOBS j
ON e.JOB_ID = j.JOB_ID
JOIN  DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY FIRST_NAME;

-- 3) JOIN~USING : 3�� �̻��� ���̺��� ������ �Ҷ����� e.�� ���� ALIAS�� �÷��� ���̸� ����
SELECT 
    FIRST_NAME, HIRE_DATE, 
    TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(HIRE_DATE, 'YYYY') AS "�ټӳ��", 
    DEPARTMENT_NAME, 
    JOB_TITLE, 
    SALARY
FROM EMPLOYEES e JOIN JOBS j
USING (JOB_ID)
JOIN  DEPARTMENTS d
USING (DEPARTMENT_ID)
ORDER BY FIRST_NAME;

/** OUTER JOIN **/
-- FK�� ���� ���̺��� �����Ͱ� NULL�� ��, ��ȸ���� �ʴ� �����͸� ��ȸ�ϱ� ���� ���ι��
-- JOIN ������ ���� ���� ��쿡�� ����� ��ȯ�ް��� �� ��.
-- ���� : LEFT OUTER, RIGHT OUTER, FULL OUTER

/* LEFT OUTER */
-- ���� ���� ���̺��� �����͸� ��������, ������ ���̺��� �����͸� �������µ�, 
-- ���� ���� ������ �ȸ����� NULL�� ä��.

-- [����] �̸�, �μ����� ��ȸ�Ͻÿ�
-- 1) ����Ŭ ����
SELECT e.FIRST_NAME,  d .DEPARTMENT_NAME
FROM EMPLOYEES  e, DEPARTMENTS d
WHERE d.department_id(+) = e.department_id
ORDER BY 1;

-- 2) LEFT OUTER JOIN ~ ON
SELECT e.FIRST_NAME,  d .DEPARTMENT_NAME
FROM EMPLOYEES  e LEFT OUTER JOIN DEPARTMENTS d
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY 1;

--3) LEFT OUTER JOIN ~ USING
SELECT e.FIRST_NAME,  d .DEPARTMENT_NAME
FROM EMPLOYEES  e LEFT OUTER JOIN DEPARTMENTS d
USING (DEPARTMENT_ID)
ORDER BY 1;

-- 4) LEFT OUTER JOIN ~ ON (Ʋ�� : �θ����̺��� ���ʿ� �ֱ� ������ ����� Ʋ��)
SELECT e.FIRST_NAME,  d .DEPARTMENT_NAME
FROM DEPARTMENTS d LEFT OUTER JOIN   EMPLOYEES  e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY 1;

-- 5) LEFT OUTER JOIN ~ ON (RIGHT�� �ٲٸ� ��!)
SELECT e.FIRST_NAME,  d .DEPARTMENT_NAME
FROM DEPARTMENTS d RIGHT OUTER JOIN   EMPLOYEES  e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY 1;


/*  SELF JOIN */
-- PK, FK �ϳ��� ���̺� ���� ����

-- ����Ŭ ����
SELECT 
    e2.EMPLOYEE_ID /* P */ , e2.FIRST_NAME /* P */ AS "������", 
    e2.MANAGER_ID/* FK(C) */,  e1.FIRST_NAME  /* P*/ AS "MANAGER ��"
FROM EMPLOYEES e1,  EMPLOYEES e2
WHERE e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- INNER JOIN~ON
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME  AS "������", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER ��"
FROM EMPLOYEES e1 INNER JOIN EMPLOYEES e2
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- 1) ����Ŭ ���� ��ü ��ȸ 
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME AS "������", 
    e2.MANAGER_ID,  e1.FIRST_NAME  AS "MANAGER ��"
FROM EMPLOYEES e1,  EMPLOYEES e2
WHERE e2.MANAGER_ID = e1.EMPLOYEE_ID(+)
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- 2) LEFT OUTER JOIN~ON 
SELECT 
    e2.EMPLOYEE_ID  , e2.FIRST_NAME  AS "������", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER ��"
FROM EMPLOYEES e2 LEFT OUTER JOIN   EMPLOYEES e1
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY  e2.FIRST_NAME ;

/* [��������] */
-- 1. JOIN�� �̿��Ͽ� ���ID�� 100���� ����� �μ���ȣ�� �μ��̸��� ����Ͻÿ�
SELECT 
    e.EMPLOYEE_ID, DEPARTMENT_ID, DEPARTMENT_NAME
FROM 
    EMPLOYEES e JOIN DEPARTMENTS d
USING (DEPARTMENT_ID)
WHERE e.EMPLOYEE_ID = 100;

-- 2. INNER JOIN�� �̿��Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �����̸��� �������� ����Ͻÿ�
SELECT e.FIRST_NAME, l.CITY, r.REGION_NAME
FROM 
    EMPLOYEES e, DEPARTMENTS d, LOCATIONS l, COUNTRIES c, REGIONS r
WHERE
    e.DEPARTMENT_ID = d.DEPARTMENT_ID
    AND
    d.LOCATION_ID = l.LOCATION_ID
    AND
    l.COUNTRY_ID = c.COUNTRY_ID
    AND
    c.REGION_ID = r.REGION_ID;

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 100�� �μ��� ���ϴ� 
--    ������� ������ ��� ������, ���� �μ��� ���ø��� ����Ͻÿ�.
--    (100�� �μ����� ���� 6������)

SELECT e.FIRST_NAME, j.JOB_TITLE, l.CITY
FROM 
    EMPLOYEES e, DEPARTMENTS d, JOBS j, LOCATIONS l
WHERE 
    e.DEPARTMENT_ID = 100
    AND
    j.JOB_ID = e.JOB_ID
    AND
    e.DEPARTMENT_ID = d.DEPARTMENT_ID
    AND
    d.LOCATION_ID = l.LOCATION_ID;
    
-- 4. JOIN�� ����Ͽ� Ŀ�̼��� �޴� ��� ����� �̸�, �μ�ID, ���ø��� ����Ͻÿ�
SELECT e.FIRST_NAME, d.DEPARTMENT_ID, l.CITY
FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
WHERE
    e.COMMISSION_PCT IS NOT NULL
    AND
    e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
    AND
    d.LOCATION_ID = l.LOCATION_ID(+)
ORDER BY FIRST_NAME;    
    
-- 5. INNER JOIN�� ���ϵ�ī�带 ����Ͽ� �̸��� A�� ���Ե� ��� ����� �̸��� �μ����� ����Ͻÿ�(��, ��ҹ��� ���� ����)
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND  FIRST_NAME LIKE '%A%';  -- WHERE�� ����ϰų�, ON���� AND�� �����ص� ����

-- 6. JOIN�� ����Ͽ� Seattle�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ ��  �μ����� ����Ͻÿ�
SELECT FIRST_NAME, JOB_TITLE, DEPARTMENT_ID, DEPARTMENT_NAME, CITY
FROM 
    EMPLOYEES  JOIN DEPARTMENTS
USING (DEPARTMENT_ID)
JOIN JOBS 
USING (JOB_ID)
JOIN LOCATIONS
USING(LOCATION_ID)
WHERE 
    CITY = 'Seattle';

-- 7. SELF ������ ����Ͽ� ����� �̸� �� �����ȣ�� �Ŵ��� �̸� �� �Ŵ��� ��ȣ��  �Բ� ��ȸ�Ͻÿ�. (�̹� Ǯ���� ������)
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME  AS "������", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER ��"
FROM EMPLOYEES e1 INNER JOIN EMPLOYEES e2
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��ȸ
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME  AS "������", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER ��"
FROM EMPLOYEES e2 LEFT OUTER JOIN EMPLOYEES e1
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY 1 DESC ;


-- 9. SELF JOIN�� ����Ͽ� 'Oliver' ����� �μ���, �� ����� ������ �μ����� �ٹ��ϴ�  ���� ����� �̸��� ��ȸ. 
--     ��, �� ���� ��Ī�� �μ���, ����� �� ��.
SELECT 
    DEPARTMENT_NAME AS �μ���, FIRST_NAME �����
FROM 
    EMPLOYEES e2 LEFT OUTER JOIN EMPLOYEES e1
ON (e2.DEPARTNAME_ID =     
WHERE FIRST_NAME = 'Oliver';


-- 11. SELF JOIN�� ����Ͽ� �����ں��� ���� �Ի��� ��� ����� �̸� �� �Ի����� �Ŵ��� �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�
SELECT e1.FIRST_NAME, e1.HIRE_DATE, e2.FIRST_NAME AS "�Ŵ����̸�", e2.HIRE_DATE AS "�Ի���"
FROM EMPLOYEES e1 JOIN EMPLOYEES e2
ON e1.MANAGER_ID = e2.EMPLOYEE_ID
AND
e1.HIRE_DATE < e2.HIRE_DATE;

-- 20. Last name�� ��King���� Manager�� �� ����� �̸��� �޿��� ��ȸ�Ͻÿ�.
SELECT e1.FIRST_NAME, e1.SALARY
FROM EMPLOYEES e1 JOIN EMPLOYEES e2
ON e1.MANAGER_ID = e2.EMPLOYEE_ID
WHERE e2.LAST_NAME = 'King';

-- 21. Finance�μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ���Ͻÿ�
SELECT
    DEPARTMENT_ID, FIRST_NAME, JOB_TITLE
FROM
    DEPARTMENTS JOIN EMPLOYEES
USING (DEPARTMENT_ID)
JOIN JOBS
USING (JOB_ID)
WHERE
    DEPARTMENT_NAME = 'Finance';
    
-- 22. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� 
--       �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ��ȸ�Ͻÿ�

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
HAVING SALARY >= AVG(SALARY) AND
FIRST_NAME LIKE '%M%';

/* *****************************************************************
*** ��������(Sub Query)
- Query ���� �ȿ� �Ǵٸ� Query ������ ���Ե� ����
- ���������� ��������

  1) ���� ���� : 
		- ������ ����� ��ȸ�Ǵ� ����.
		- ���� ������ ���� ����� �������� ����� ���� ���������� ����ȴ�.

  2) �������� : 
		- ���� ���� ���ʿ� ��ġ�� ����.
		- ���������� ���� ����� ���������� �����̳� ����� ���ȴ�.
		- ��κ� ���������� ���� ����ǰ� �� �� �� ����� ���������� ���޵Ǿ� �����
		- ������������ Order by�� ��� �Ұ�
		- ���� ������ ��� ��ġ
			* where �� : �� 1���� ������ ��� �Ǵ� �÷� 1��¥�� ���
			* having�� : ������������ �׷��ฦ ������� ��
			* from ��
			* select ��
			* insert���� into��
			* update���� set��
            
 3) ���������� ����
    - ������ �������� : 
        ���������� ����� �ϳ��� ���
        
    - ������ �������� : 
        ���������� ����� �ϳ� �̻��� ���
        �����ڿ� �Բ� ��� (IN, ANY, ALL, EXISTS)
        ANY, ALL �� �񱳿����ڿ� �Բ� ���
***************************************************************** */

-- 13. �����ȣ�� 109�� ������� �޿��� ���� ����� ǥ��(����̸��� ���) ��ȸ�Ͻÿ�.
-- 1) �Ϲ� ���� 2���� �۾��� ����
SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 109;

SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE SALARY > 9000;

-- 2) ���������� �۾��� ����. (������ ��������)
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE SALARY >  (SELECT SALARY
                                 FROM EMPLOYEES
                                 WHERE EMPLOYEE_ID = 109 ) ;

--[ �ǽ�] 162���� �޿��� ���� �޿��� ���� ���� ����� ��ȸ�Ͻÿ�. (�̸�, �޿�, �μ���ȣ)
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY =  (SELECT SALARY
                                 FROM EMPLOYEES
                                 WHERE EMPLOYEE_ID = 162);

-- FROM ������ ����ϴ� ��������
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

-- ROWNUM 1~10���� ��ȸ
SELECT ROWNUM, tbl.* FROM
    (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50) tbl
WHERE SALARY > 3000
AND ROWNUM BETWEEN 1 AND  10;    

-- 11 ~ 20 ���� ��ȸ�� �ȵ�! WHY
-- > ROWNUM�� �������� ��ȣ�� �ο��Ǵ� ���̱� ������ 11���� ���� �����ϴ� ��ȣ�� ����
SELECT  FROM
    (SELECT ROWNUM rno, tbl.* FROM
        (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 50) tbl
    WHERE SALARY > 3000 )
WHERE RNO BETWEEN 11 AND  20;    

/* *****************************************************************
*** ��������(Sub Query)
- Query ���� �ȿ� �Ǵٸ� Query ������ ���Ե� ����
- ���������� ��������

  1) ���� ���� : 
		- ������ ����� ��ȸ�Ǵ� ����.
		- ���� ������ ���� ����� �������� ����� ���� ���������� ����ȴ�.

  2) �������� : 
		- ���� ���� ���ʿ� ��ġ�� ����.
		- ���������� ���� ����� ���������� �����̳� ����� ���ȴ�.
		- ��κ� ���������� ���� ����ǰ� �� �� �� ����� ���������� ���޵Ǿ� �����
		- ������������ Order by�� ��� �Ұ�
		- ���� ������ ��� ��ġ
			* where �� : �� 1���� ������ ��� �Ǵ� �÷� 1��¥�� ���
			* having�� : ������������ �׷��ฦ ������� ��
			* from ��
			* select ��
			* insert���� into��
			* update���� set��
            
 3) ���������� ����
    - ������ �������� : 
        ���������� ����� �ϳ��� ���
        
    - ������ �������� : 
        ���������� ����� �ϳ� �̻��� ���
        �����ڿ� �Բ� ��� (IN, ANY, ALL, EXISTS)
        ANY, ALL �� �񱳿����ڿ� �Բ� ���
***************************************************************** */

-- 10. SELF JOIN�� ����Ͽ� ���� 'Chen'�� ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
SELECT FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE > (SELECT HIRE_DATE
                                    FROM EMPLOYEES
                                    WHERE LAST_NAME = 'Chen')
ORDER BY 2;                                    

-- 12. ���ID�� 101�� ����� �������� ���� ����� ǥ��(����̸��� ���)�Ͻÿ�.
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID 
                             FROM EMPLOYEES 
                             WHERE EMPLOYEE_ID = 101);


/* 4�� 26�� : �������� */
-- [����] FROM ���� �������� ��� : 03�� ������ �Ի��� �Ϸù�ȣ(ROWNUM) �� ������ ������, �޿�, �Ի���, �μ��� ��ȸ 
SELECT temp.* 
FROM 
    ( SELECT ROWNUM AS RNO, FIRST_NAME, SALARY, HIRE_DATE, DEPARTMENT_NAME
      FROM EMPLOYEES JOIN DEPARTMENTS
      USING (DEPARTMENT_ID)
    )  temp
WHERE HIRE_DATE < '03/01/01';

-- [����] WHERE���� �������� ��� : �̸��� 'Lisa'�� ����� �Ŵ������ ���� ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID = (SELECT MANAGER_ID
                                        FROM EMPLOYEES
                                        WHERE FIRST_NAME = 'Lisa');

-- [����] �ϳ��� ���� �ȿ� ���������� �� �� => ��������
-- 'Chen', 'Davies' ��� ���� ���� ������ �̸��� ���� ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME ='Greenberg' OR LAST_NAME ='Errazuriz';

-- 'Greenberg' ���� �޿��� �����鼭 ����  'Errazuriz'�� ������ �Ŵ����� �̸��� ������ ��ȸ
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY 
                                FROM EMPLOYEES
                                WHERE LAST_NAME = 'Greenberg')
AND EMPLOYEE_ID = (SELECT MANAGER_ID
                                FROM EMPLOYEES
                                WHERE LAST_NAME = 'Errazuriz');

-- [����] Bruce�� Daniel�� ������ ��ȸ�Ͻÿ�
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME IN ('Bruce', 'Daniel');

-- ����������
SELECT
    (SELECT LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME='Bruce') AS "Bruce�� ��",
    (SELECT LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME='Daniel') AS "Daniel�� ��"
FROM DUAL;

-- [����] 'Valli'��� �̸��� ���� ������ �μ����� ��ȸ�Ͻÿ�. (��������)
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                                               FROM EMPLOYEES
                                               WHERE FIRST_NAME = 'Valli');


/*������ �������� */

-- 1) IN ������ ����ϱ�
SELECT* 
FROM EMPLOYEES
WHERE JOB_ID IN (SELECT JOB_ID
                              FROM EMPLOYEES
                              WHERE DEPARTMENT_ID = 30);
                              
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;


-- 2) ANY / ALL ������ :
--    ���������� ��ȸ�� ����� �ϳ� �̻� �����ϴ� ���� �ִ��� ��ȸ
--   > ANY, < ANY, = ANY (IN ���� ����), != ANY, >= ANY, <= ANY
--  > ALL, <ALL, =ALL, != ALL, >=ALL, <=ALL

-- [����-1] ST_MAN������ �޿� �� ���� ���� �޴� �޿����� ���� �޴� ������� �̸�, �޿��� ��ȸ
-- ���� ������ ����� ���� ������ ���� ū����
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');

-- [���� 2] ST_MAN������ �޿� �� ���� ���� �޴� �޿����� �� ���� �޴� ������� �̸�, �޿��� ��ȸ
-- ���������� ��ȸ�� ����� ���� ū������ ������ 
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');
                                        
-- [����3] ST_MAN������ �޿� �� ���� ���� �޴� �޿����� �� ���� �޴� ������� �̸�, �޿��� ��ȸ
-- ���� ������ ������
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');
                                        
-- [����4] ST_MAN������ �޿� �� ���� ���� �޴� �޿����� �� ���� �޴� ������� �̸�, �޿��� ��ȸ
-- ū������ ū��
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');                                        

-- [ ���� ] ������ 'REP' �� ������ �޴� �޿��� ������ �޿��� �޴� �������� �����ȣ, �̸�, ����, �޿�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY = ANY (SELECT SALARY
                                        FROM EMPLOYEES
                                        WHERE JOB_ID LIKE '%REP');



-- 3) EXISTS
-- ���� ������ ����� �����ϴ� ���� �����ϸ� ���������� ����
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE  EXISTS (SELECT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE   DEPARTMENT_ID = 500);
                            
-- ���� 'Chen' �̶�� ������ �����ϸ� �� ������ �μ���, �̸�, ��, �޿� : �������� + ����
SELECT DEPARTMENT_NAME, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES JOIN DEPARTMENTS
USING (DEPARTMENT_ID)
WHERE EXISTS (SELECT FIRST_NAME 
                             FROM EMPLOYEES
                             WHERE LAST_NAME = 'Chen')
AND LAST_NAME = 'Chen';                             

-- [����]
SELECT FIRST_NAME, DEPARTMENT_ID, NVL(COMMISSION_PCT, 0) 
FROM EMPLOYEES
WHERE ( SALARY, NVL(COMMISSION_PCT, 0))
                IN  ( SELECT SALARY, NVL(COMMISSION_PCT, 0) 
                       FROM EMPLOYEES
                       WHERE DEPARTMENT_ID = 80) ;

/* [�������� ����] */

-- 13. �����ȣ�� 109�� ������� �޿��� ���� ����� ǥ��(����̸��� ���) ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, JOB_TITLE
FROM EMPLOYEES  JOIN JOBS 
USING (JOB_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 109);

-- 14. �ּ� �޿��� �޴� ������ ���� �޿��� �޴� ����� �̸�, ��������, �޿��� ��ȸ�Ͻÿ�.
--      (�׷��Լ� ��� + �������� + ����)
SELECT FIRST_NAME, LAST_NAME, JOB_TITLE, SALARY
FROM EMPLOYEES JOIN JOBS
USING (JOB_ID)
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES);

-- 15. ��ü ��� �޿����� ���� �޿��� ���� ������� ��� ������ ã�� ������(JOB_ID)�� �޿��� ��ȸ�Ͻÿ�.
SELECT JOB_ID, SALARY
FROM EMPLOYEES
GROUP BY JOB_ID, SALARY
HAVING AVG(SALARY) IN (SELECT AVG(SALARY)
                        FROM EMPLOYEES
                        GROUP BY JOB_ID)
ORDER BY 1;

-- 16. ��� ������ IT_PROG�� ������� �޿��� �����鼭 ������ IT_PROG�� �ƴ� ������� ��ȸ(�����ȣ, �̸�, ������) �Ͻÿ�
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY
                                FROM EMPLOYEES
                                WHERE JOB_ID = 'IT_PROG')
AND JOB_ID != 'IT_PROG';


-- 17. ���� 'Chen'�� ������ �μ��� �ִ� ����� �̸��� �Ի����� ��ȸ�Ͻÿ�
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                               FROM EMPLOYEES
                                               WHERE LAST_NAME = 'Chen');
                                        
-- 18. �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���� ������������ �����Ͻÿ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                            FROM EMPLOYEES)
ORDER BY SALARY;

-- 19. �̸��� K�� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                        FROM EMPLOYEES
                                        WHERE FIRST_NAME LIKE '%K%');

-- 22. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ,
--  �̸�, �޿��� ��ȸ�Ͻÿ�.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                                FROM EMPLOYEES)
AND FIRST_NAME LIKE '%M%';                                

-- 23. ��� �޿��� ���� ���� ���� ��ȸ�ϱ�
-- ������ ��ձ޿�
SELECT MIN(tmp.SAL)
FROM (SELECT AVG(SALARY) AS SAL
FROM EMPLOYEES
GROUP BY JOB_ID) tmp;


/* *********************************
DDL
- ���̺��, �÷����� Ű���� ��� �Ұ���
- ��������(CONSTRAINTS) : Primary Key , Foreign Key, Unique, Not Null, Check (�ܴ��� ���� ��)
   �������� ���Ἲ ����
   Primary Key, Unique ���������� �ڵ��� Index�� �����Ǳ� ������ ��ȸ�� ��������.
   
   default : ���������� �ƴ����� ���Ἲ�� �����ϴ� ���� ���.
  
***********************************/

-- ����Ŭ Ű���� ��ȸ (DBA)
SELECT * FROM V$RESERVED_WORDS; -- DBA�� ������ ��� (SYSTEM �������� ���� �� Ȯ�� ����)

DROP TABLE FITNESS;

CREATE TABLE FITNESS
(
   MEM_ID      VARCHAR2(5)  CONSTRAINTS FITNESS_ID_PK  PRIMARY KEY,
   MEM_NAME   VARCHAR2(15)  CONSTRAINTS FITNESS_NAME_NN NOT NULL,
   HEIGHT NUMBER(5, 2) DEFAULT 0,
   WEIGHT NUMBER(5, 2) DEFAULT 0,
   JOIN_DATE DATE DEFAULT SYSDATE
);

-- ��� ���̺� � ���������� �ɷ��ִ��� Ȯ�� �� �� �ִ�.
SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME ='FITNESS';

-- INSERT ��
/*
INSERT INTO ���̺��
VALUES
('Hong' , 'ȫ�浿', 185.5, 75, '23/01/26');
*/

INSERT INTO FITNESS
VALUES
('Hong' , 'ȫ�浿', 185.5, 75, '23/01/26');

INSERT INTO FITNESS
(MEM_ID, MEM_NAME, HEIGHT, WEIGHT, JOIN_DATE)
VALUES
('Lim', '�Ӳ���', 180, 88, '23/04/25');

INSERT INTO FITNESS
(MEM_ID, MEM_NAME)
VALUES
('Son', '�տ���');

COMMIT;

SELECT * FROM FITNESS;

-- [ ���� ] ȸ���� ������ ������ �� �ִ� MEMBERS ���̺��� �����Ͻÿ�
SEQNO ����Ÿ�� PK,
USERID �������� 10

DROP TABLE SCORE_;

-- [ ���� ] ȸ���� ������ ������ �� �ִ� MEMBERS ���̺��� �����Ͻÿ�
/*
SEQNO ����Ÿ�� PK,
USERID �������� 10 UQ
USERNAME �������� 20 NN
BIRTHDAY ��¥Ÿ�� NN
GENDER �������� 1 CHECK '0', '1'
*/

CREATE TABLE MEMBERS
(
    SEQNO NUMBER CONSTRAINTS MEMBERS_SEQ_PK PRIMARY KEY,
    USERID VARCHAR2(10) CONSTRAINTS MEMBERS_ID_UQ UNIQUE,
    USERNAME VARCHAR2(20) CONSTRAINTS MEMBERS_NAME_NN NOT NULL,
    BIRTHDAY DATE  CONSTRAINTS MEMBERS_BIRTHDAY_NN NOT NULL,
    GENDER CHAR(1) CONSTRAINTS MEMBERS_GENDER_CK CHECK (GENDER IN ('0', '1'))
);

-- ���� : �����͸� 2�� �����ÿ� (�ƹ� �����ͳ�)
-- ��� �÷��� �����͸� �� ���� ������ VALUES ���� ��������
INSERT INTO MEMBERS
VALUES
(
    1, 
    'SON',
    '�տ���',
    '00/01/02',
    '1'
);

INSERT INTO MEMBERS
VALUES
(
    2, 
    'KIM',
    '�迵��',
    '95/05/01',
    '0'
);

-- DCL ��� 
COMMIT;
ROLLBACK;

-- ����
DELETE MEMBERS
WHERE SEQNO = 3;

-- ����
UPDATE MEMBERS
SET
    USERNAME = '�տ���'
WHERE USERID = 'SON';    
    
-- ��ȸ
SELECT * FROM MEMBERS;

-- PK�� FK�� ���踦 ���� ���̺� �����ϱ�
-- 1) ������ �θ���� ���� -> �ڽ����̺� ����
-- 2) ������ �ڽ����̺� ���� �� -> �θ����̺� ����

-- [����] ������ ������ MEMBERS ���̺��� �ڽ����̺��� (����:PURCHASE) ���̺��� �ۼ��Ͻÿ�
/*
�Ϸù�ȣ(SEQ_ID) : ������ PK
��ǰ�� (ITEM) : �������� ���ڿ�(50) NN
���� (PRICE) : ������ (10) �⺻�� 100000
������ (PDAY)  DATE �⺻�� ���糯¥
���� (QUANTITY) : ������ 3�ڸ� �⺻�� 1
SEQNO FK : 
*/

CREATE TABLE PURCHASE
(
    SEQ_ID NUMBER CONSTRAINTS PURCHASE_ID_PK PRIMARY KEY,
    ITEM VARCHAR2(50) CONSTRAINTS PURCHASE_ITEM_NN NOT NULL,
    PRICE NUMBER(10) DEFAULT 100000,
    PDAY DATE DEFAULT SYSDATE,
    QUANTITY NUMBER(3) DEFAULT 1,
    SEQNO NUMBER REFERENCES MEMBERS(SEQNO) ON DELETE CASCADE
);

-- ����Ű�� �θ��� UNIQUE�� �̿��ؼ� ������ ���� �ִ�.
CREATE TABLE PURCHASE2
(
    SEQ_ID NUMBER  PRIMARY KEY,
    ITEM VARCHAR2(50)  NOT NULL,
    PRICE NUMBER(10) DEFAULT 100000,
    PDAY DATE DEFAULT SYSDATE,
    QUANTITY NUMBER(3) DEFAULT 1,
    USERID VARCHAR2(10) REFERENCES MEMBERS(USERID) ON DELETE CASCADE
);

-- �տ��� ���� 2�� ����
INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(11, '�ڹ��� ����', 1, 40000);

INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(12, '���̽�', 1, 25000);

-- �迵�� ���� 3�� ����
INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(13, '��Ʈ��', 2, 2570000);

INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO)
VALUES
(14, 'Ű����', 2);

INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(15, '�����', 2, 380000);

SELECT * FROM PURCHASE;

-- �Ϸù�ȣ, ������ �̸�, �����۸�, ���� : INNER JOIN�� �̿��ؼ� ��ȸ�Ͻÿ�
SELECT ROWNUM, USERNAME, ITEM, PRICE
FROM MEMBERS JOIN PURCHASE
USING (SEQNO);



















