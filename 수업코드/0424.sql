/* 2023�� 4�� 24��(��) */
-- ���տ����� ( ������(Union, Union All), ������(Intersection), ������(Minus) )

-- �����ȣ�� 145,147,158���� ����� �����ȣ��, �̸��� ��ȸ (3��)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158);

-- �̸��� 'A'�� �����ϴ� ����� �����ȣ�� �̸��� ��ȸ (10��)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';


-- 3���� ������ �� ������ -- 2��
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

INTERSECT

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';


-- 3���� ������ �� ������ -- 2��
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

MINUS

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

-- ������ �ٲ㼭 ������ ����
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

MINUS

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158);


--������
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158);


--������(UNION ALL) : �ߺ��� �����͵� �� ���
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

--���� : �÷��� ������ �ٸ��� ����
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

--���� : �÷��� ������ ���Ƶ� Ÿ���� �ٸ��� ����
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

-- ���� ��� : �÷��� ������ ����, Ÿ�Ե� ����. (ù��° ������ �������� ��µ�)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, EMAIL
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

-- ù ��° ������ �������� ��ȸ�� 
SELECT EMPLOYEE_ID, FIRST_NAME, EMAIL 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;


/* ������ �Լ�
1) ���ڿ� �Լ�
- lower(���ڿ�) : ������ �ҹ��ڷ� ����
- upper(���ڿ�) : ������ �빮�ڷ� ����
- initcap(���ڿ�) : ������ ù���� �빮��, ������ �ҹ��ڷ� ����
- concat(���ڿ�, ���ڿ�) : �� ���� ���ڿ��� ��ħ
- substr(���ڿ�, ��ġ) : Ư�� ���ڿ� ���� ��� �κ� ���ڿ� ��ȯ
- substr(���ڿ�, ��ġ, ����) : Ư�� ���ڿ� ���� ���� ������ �κ� ���ڿ� ��ȯ
- length(���ڿ�) : ���ڿ��� ���� ��ȯ
- instr(���ڿ�, �κй��ڿ�) : �κй��ڿ��� ��ġ�� ��ȯ
- concat(���ڿ�1, ���ڿ�2) : �� ���� ���ڿ��� ��ħ
- replace(��ü ���ڿ�,ã�� ���ڿ�, �ٲ� ���ڿ�) : ���� ġȯ
 */

-- FIRST_NAME�� �ҹ��ڷ� �����Ͽ� ��ȸ
SELECT LOWER(FIRST_NAME) 
FROM EMPLOYEES;

-- DUMMY TABLE(DUAL)�� �̿��� ��ȸ 
SELECT LOWER('World Cup 2002')
FROM DUAL;

-- FIRST_NAME�� �빮�ڷ� �����Ͽ� ��ȸ
SELECT UPPER(FIRST_NAME) 
FROM EMPLOYEES;

-- INITCAP()
SELECT INITCAP('THE SOAP')
FROM DUAL;


-- SUBSTR() : INDEX�� 1���� ������(����)
SELECT SUBSTR('THE SOAP', 5)
FROM DUAL;

-- SUBSTR() : INDEX�� 1���� ������(����)
SELECT SUBSTR('THE SOAP', 5, 2) AS RESULT
FROM DUAL;

-- LENGTH() 
SELECT LENGTH('THE SOAP')
FROM DUAL;

-- INSTR() : ��ġ�� ��ȯ
SELECT INSTR('THE SOAP', 'S')
FROM DUAL;

-- INSTR() : ��ġ�� ��ȯ
SELECT INSTR('����Ŭ ������', '��')
FROM DUAL;

-- INSTR() : ���� �����ʹ� 0 ��ȯ
SELECT INSTR('����Ŭ ������', '��')
FROM DUAL;

-- WHERE ������ ���
-- (�Լ��� ������� ���� ���)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;

-- (�Լ��� WHERE���� ����ϴ� ���) -- SUBSTR(���ڿ�, ����, ����) : ������ �ڿ��� ����
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -1, 1) = 'n';

-- ������ 2��° 2���� 'en'���� ������ ���
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -2, 2) = 'en';

-- [����] �Ի����� 03���� ���� ��ȸ : LIKE ���� SUBSTR ����
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE SUBSTR(HIRE_DATE, 1, 2) ='03';

-- [����] �Ի����� 01���� �Ի��� ���� ��ȸ : LIKE ��..
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%/01/%';

-- [����] �Ի����� 01���� �Ի��� ���� ��ȸ : SUBSTR ��..
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE SUBSTR(HIRE_DATE, 4, 2) ='01';

-- CONCAT() : �ΰ��� ���ڿ��� ��ġ�� �Լ�  ==> || �����ڿ� ������.
SELECT CONCAT('I have', ' a dream')
FROM DUAL;

SELECT 
    CONCAT (EMPLOYEE_ID, FIRST_NAME),
    CONCAT (EMPLOYEE_ID, CONCAT(' : ', FIRST_NAME))
FROM EMPLOYEES;

-- REPLACE(���ڿ�, ã�� ���ڿ�, �ٲܹ��ڿ�)
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES;

SELECT FIRST_NAME, REPLACE(HIRE_DATE, '/', '-')
FROM EMPLOYEES;

-- ��ȭ��ȣ�� '.' �� �������� �ٲٽÿ�
SELECT FIRST_NAME, REPLACE(PHONE_NUMBER, '.', ' ')
FROM EMPLOYEES;


/*
2) �����Լ�
- abs(����)           : ������ ���밪�� ���Ѵ�.
- ceil(����)          : �ø� (���� ����� ���� ������ ������ ��ȯ)
- floor(����)        : ���� (���� ����� ���� ������ ������ ��ȯ)
- round(����, �ڸ���) : ������ �ڸ��� ��ġ���� �ݿø�
- trunc(����, �ڸ���) : ������ �ڸ��� ��ġ���� ����
- mod(����1, ����2)   : ����1�� ����2�� ���� ������
- power(����1, ����2) : ����1�� ����2����ŭ ���� ��
- sign(����)          : ���ڰ� �����̸� -1, ����̸� 1, 0�̸� 0�� ��ȯ
*/

SELECT ABS(-15.3) FROM DUAL;
SELECT ABS(15.3) FROM DUAL;

SELECT CEIL(15.3) FROM DUAL;
SELECT FLOOR(15.7) FROM DUAL;
SELECT FLOOR(15.7),  FLOOR(-15.7) FROM DUAL;
SELECT CEIL(15.7),  CEIL(-15.7) FROM DUAL;

SELECT ROUND(15.193, 1),  ROUND(15.193, 2) FROM DUAL;
SELECT ROUND(-15.193, 1),  ROUND(-15.193, 2) FROM DUAL;
SELECT ROUND(-15.193, 0),  ROUND(-15.193, -1),   ROUND(-15.193, -2)  FROM DUAL;

SELECT TRUNC(-15.193, 1),  TRUNC(-15.193, -1),  TRUNC(-15.193, -2)  FROM DUAL;

SELECT MOD(10, 3) FROM DUAL;
SELECT POWER(10, 3) FROM DUAL;
SELECT SIGN(10) FROM DUAL;

/* ��¥�Լ�
     - ��¥���� �� : SYSDATE(���� �ý��� ��¥), SYSTIMESTAMP(���� �ý��۳�¥�� �ð�)
     - ��¥�� +, - ���길 ����
*/

SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;

SELECT SYSDATE+1 FROM DUAL; -- ������
SELECT SYSDATE-1 FROM DUAL; -- ����

SELECT SYSDATE*2 FROM DUAL; -- ������

SELECT TO_DATE('23/01/01'), '23/01/01'  FROM DUAL;
SELECT CEIL(SYSDATE-TO_DATE('23/01/01')) FROM DUAL;  -- 2023�� 1�� 1�Ϻ��� 114��°��.

SELECT ADD_MONTHS(SYSDATE, 10) FROM DUAL;    -- ���� ��
SELECT ADD_MONTHS(SYSDATE, -10) FROM DUAL;  -- ���� ��

-- [����-1] ���ó�¥�� �������� �ٹ��ϼ��� ����Ͻÿ� (EMPLOYEES ���̺��� ������, �ٹ���)
SELECT FIRST_NAME, CEIL(SYSDATE-HIRE_DATE) AS �ѱٹ��ϼ�
FROM EMPLOYEES
ORDER BY 2 DESC;

-- [����-2] ���ó�¥�� �������� �ٹ��� �޼��� ����Ͻÿ�
SELECT 
    FIRST_NAME, 
    CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS �ѱٹ�������
FROM EMPLOYEES
ORDER BY 2 DESC;

-- Ư�� ���� ������ ���� ����
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 2020�� 2���� ���������� ���Ͻÿ�
SELECT LAST_DAY(TO_DATE('20/02/01')) FROM DUAL;

-- NEXT_DAY(��¥, ���ϰ�)
SELECT SYSDATE, NEXT_DAY(SYSDATE, '������') FROM DUAL;


-- ���� �� �ݿ����� �� ���ΰ���?
SELECT NEXT_DAY(NEXT_DAY(SYSDATE, '�ݿ���'), '�ݿ���')  AS "�������� �ݿ���" FROM DUAL;
SELECT  NEXT_DAY(SYSDATE+7, '�ݿ���') FROM DUAL;

/*
4) ��ȯ�Լ�
- to_date(���ڿ�)   : ��¥�� ��ȯ������ ���ڿ��� ��¥Ÿ������ ��ȯ
- to_number(���ڿ�) : ���� ���·� �� ���ڿ��� ����Ÿ������ ��ȯ

*/

SELECT '123.5', TO_NUMBER('123.5')  FROM DUAL;

SELECT 
    SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI') AS "���� �ð�(�߿�)",
     TO_CHAR(SYSDATE, 'YYYY-Mon-DD HH:MI') AS "���� �ð�",
     TO_CHAR(SYSDATE, 'YYYY-Mon-DDD HH:MI') AS "���� �ð�"
FROM DUAL;

-- ���ڸ� õ�ڸ� �޸�, �Ҽ� �ڸ��� ���

SELECT TO_CHAR(123450, '999,999.00') FROM DUAL;
SELECT TO_CHAR(123450, '$999,999.00') FROM DUAL;
SELECT TO_CHAR(123450, 'L999,999.00') FROM DUAL;

-- [����] EMPLOYEES ���̺��� �̸�, �޿�, �Ի����� ��ȸ
-- ��� ������ �޿� õ�ڸ����� �޸�, �Ҽ������� 3�ڸ�, �տ� $ ��ȣ ���
-- �Ի��� ��4�ڸ�/��2�ڸ�/��2�ڸ� (����)

SELECT 
    FIRST_NAME, 
    TO_CHAR(SALARY, '$999,999.000') AS SALARY, 
    TO_CHAR(HIRE_DATE, 'YYYY/MM/DD (DY)') AS HIRE_DATE
FROM EMPLOYEES;

/*
5) NULL �Լ�
- nvl(�÷�, ������)           :�÷��� �����Ͱ� null�̸� �����Ͱ����� ����϶�� �ǹ�
- nvl2(�÷�, ������1, ������2):�÷��� �����Ͱ� null�� �ƴϸ� ��, ���̸� ��
*/

SELECT 
    FIRST_NAME, SALARY, COMMISSION_PCT, NVL(COMMISSION_PCT, 0)
FROM EMPLOYEES;

-- Ŀ�̼��� ���� ����� 0, �ִ� ����� �޿�*Ŀ�̼�

SELECT 
    FIRST_NAME, SALARY, COMMISSION_PCT, 
    NVL2(COMMISSION_PCT, SALARY*COMMISSION_PCT,  0) AS "Ŀ�̼�"
FROM EMPLOYEES;


-- [����] �̸�, �μ���ȣ, �μ��� ������ �μ���ȣ, �μ��� ������ 0
SELECT FIRST_NAME, NVL(DEPARTMENT_ID, 0) 
FROM EMPLOYEES
ORDER BY FIRST_NAME;

-- [����] �̸�, �μ���ȣ, �μ��� ������ �μ���ȣ, �μ��� ������ "�ӽ�" (TO_CHAR()�� �̿�)
SELECT 
    FIRST_NAME, 
    NVL(TO_CHAR(DEPARTMENT_ID), '�ӽ�') AS "�μ���ȣ"
FROM EMPLOYEES
ORDER BY FIRST_NAME;

-- [����] �����ȣ, �̸�, �����ȣ, ������ ������ "ȸ��" 
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME, 
    NVL(TO_CHAR(MANAGER_ID), 'ȸ��') AS "�����ȣ"
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

/*
6) ��Ÿ�Լ� 
- swtich~case�� ���� ������ �Լ�
  DECODE(exp1, cond1, result1,
               cond2, result2,
					 cond3, result3,
               default)
 */

SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES;

SELECT 
    FIRST_NAME, 
    DECODE(DEPARTMENT_ID, 10, 'Administration',
                                                  20, 'Marketing',
                                                  30, 'Purchasing',
                                                  40, 'Human Resources',
                                                  50, 'Shipping') AS DEPT_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 20, 30, 40, 50);

-- CASE~WHEN �Լ��� ����
SELECT 
    FIRST_NAME, 
    CASE WHEN DEPARTMENT_ID =10 THEN 'Administration'
              WHEN DEPARTMENT_ID = 20 THEN 'Marketing'
              WHEN DEPARTMENT_ID = 30 THEN  'Purchasing'
              WHEN DEPARTMENT_ID = 40 THEN  'Human Resources'
              WHEN DEPARTMENT_ID = 50 THEN  'Shipping'
              ELSE 'Default'
   END AS  DEPT_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 20, 30, 40, 50);

-- p175 Q3
SELECT 
    EMPLOYEE_ID, FIRST_NAME, 
    TO_CHAR(HIRE_DATE, 'YYYY/MM/DD')  AS "�Ի���",
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 3), '������'), 'YYYY-MM-DD') AS "������ �߷���",
    NVL(TO_CHAR(COMMISSION_PCT), 'N/A') "Ŀ�̼�"
FROM EMPLOYEES;

/*
*** ������ �Լ�(�׷��� �Լ�)
- ���� ����� ���� �� �׷�ȭ ��Ų ��鿡 �Լ��� ����
- ����
  COUNT(�÷���)
  MIN(�÷���)
  MAX(�÷���)
  AVG(�÷���)
  STDDEV()
  VAR()
*/  

SELECT COUNT(FIRST_NAME) 
FROM EMPLOYEES;

SELECT COUNT(COMMISSION_PCT) 
FROM EMPLOYEES;

SELECT COUNT(*)
FROM EMPLOYEES;

SELECT COUNT(FIRST_NAME), MIN(SALARY), MAX(SALARY), AVG(SALARY)
FROM EMPLOYEES;

-- GROUP BY
-- �׷��� �Լ��� ����� �� Ư�� �÷��� �������� �׷�ȭ ���� ����� ��ȸ

-- �� �μ��� ���� ���� ��ȸ. NULL DATA�� ����
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL
ORDER BY DEPARTMENT_ID;

-- �� �μ��� ���� ���� ��ȸ. �ο����� 1���̰ų� NULL�� ����
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL 
              AND COUNT(*) != 1
ORDER BY DEPARTMENT_ID;

-- �� �μ� �� ���� ����, �ִ�޿��ݾ�, �ּұ޿��ݾ��� ��ȸ. 
-- �ο����� 1���̰ų� NULL�� ����
SELECT DEPARTMENT_ID, COUNT(*), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL 
              AND COUNT(*) != 1
ORDER BY DEPARTMENT_ID;


-- (����) �� �μ��� ���� ���� ��ȸ (�׷��� �Լ��� ���� �÷��� ���� ��ȸ �Ұ�)
SELECT DEPARTMENT_ID, FIRST_NAME, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;


-- [����] �Ի翬�� �� �Ի��ο��� ��ȸ�Ͻÿ�
SELECT 
    TO_CHAR(HIRE_DATE, 'YYYY') AS "�Ի� �⵵", 
    COUNT(*) AS "�Ի� �ο�"
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY  TO_CHAR(HIRE_DATE, 'YYYY');










