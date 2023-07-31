SELECT * FROM COUNTRIES;
SELECT * FROM REGIONS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- �̸��� �޿������� ��ȸ
SELECT FIRST_NAME, SALARY FROM EMPLOYEES;


SELECT DISTINCT DEPARTMENT_ID 
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID DESC;

-- �̸�, �޿�, �μ���ȣ�� �̸������� ���������ؼ� ��ȸ
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY FIRST_NAME;  
  
-- ��Ī ���
SELECT FIRST_NAME AS �̸�, SALARY AS �޿�, DEPARTMENT_ID �μ���ȣ
FROM EMPLOYEES
ORDER BY FIRST_NAME;

-- ��Ī�� ū����ǥ�� ����ϴ� ��� : Ư������, ���� ���� ���Ե� ��� 
SELECT FIRST_NAME AS "�̸� ��", SALARY AS "�� ��", DEPARTMENT_ID �μ���ȣ
FROM EMPLOYEES
ORDER BY FIRST_NAME; 

-- [����] ������ �޿��� 5%�� ���ʽ��� �����Ϸ��� �Ѵ�.
-- ������ �����ȣ, �̸�, �޿�, ���ʽ�, �հ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY*0.05 AS BONUS, SALARY + SALARY*0.05 AS TOTAL
FROM EMPLOYEES;

-- ������ �ڿ� '��'�� �ٿ� ��ȸ�Ͻÿ�
SELECT FIRST_NAME || '��' AS "�̸�"
FROM EMPLOYEES;

-- '�̸� ��'�� �ٿ��� ��ȸ�Ͻÿ�
SELECT FIRST_NAME || ' ' || LAST_NAME
  FROM EMPLOYEES;

-- �޿��� 10000 �̻��� ������� �����ȣ, �̸�, �޿�, ������ ��ȸ�Ͻÿ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM EMPLOYEES
WHERE SALARY >= 10000;

-- �޿��� 10000 �̻��� ������� �����ȣ, �̸�, �޿�, ������  �޿��� ���� ������ ��ȸ�Ͻÿ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM EMPLOYEES
WHERE SALARY >= 10000
ORDER BY SALARY DESC;

-- �����ȣ, �̸�, �޿�, �μ���ȣ�� ��ȸ. �μ���ȣ�� 80���� �����͸� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;


-- �޿��� 5000~10000 �̻��� ������� �����ȣ, �̸�, �޿�, ������ ��ȸ�Ͻÿ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM EMPLOYEES
WHERE SALARY >= 5000 AND SALARY <= 10000;

-- �μ���ȣ�� 10�̰ų� 50�� �μ��� ���� �������� �̸�, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 50;


-- �μ���ȣ�� 10�̳� 50�� �ƴ� �μ��� ���� �������� �̸�, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE NOT(DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 50);

-- ���� �ڵ带 �μ����� �������� ����
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE NOT(DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 50)
ORDER BY 0;
  
-- �̸�, �޿�, Ŀ�̼��� ��ȸ�Ͻÿ�
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES;
  
-- �̸�, �޿�, Ŀ�̼��� ��ȸ�Ͻÿ� (Ŀ�̼��� �޴� ���)
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT != NULL;  

SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;  
  
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;  

-- �Ŵ����� ���� ������ �̸�, ������ ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_iD IS NULL;

-- �̸�, �޿�, Ŀ�̼Ǳݾ�, �Ѽ��ɾ��� ��ȸ (��, Ŀ�̼��� �ִ� ���)
SELECT FIRST_NAME, SALARY, COMMISSION_PCT*SALARY AS "Ŀ�̼� �ݾ�", 
			 SALARY + COMMISSION_PCT*SALARY AS "�Ѽ��ɾ�"
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- �޿��� 10000~15000 ������ ������ �̸�, �޿��� ��ȸ
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 15000;

-- �μ���ȣ�� 10�̰ų� 50�� �μ��� ���� �������� �̸�, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 50);

-- �޿��� 7000�� �ʰ��ϰ� �̸����� 'SKING' �� ������ �̸�, ��ȭ��ȣ, �̸��� ��ȸ
SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
FROM EMPLOYEES
WHERE SALARY > 7000 AND EMAIL = 'SKING';

-- ������ �̸��� �Ի����� ��ȸ�Ͻÿ�. (�Ի��� ��)
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE;


-- ������ �̸��� �Ի����� ��ȸ�Ͻÿ�
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES;

-- ������ �̸��� �Ի��� 07�⵵�� �Ի��� ����� ��ȸ '07/01/01'~'07/12/31'
--   (�Ի��� ��)
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '07/01/01' AND '07/12/31'
ORDER BY HIRE_DATE;

-- ������ �̸��� �Ի��� 07�⵵�� ������ �Ի��� ����� ��ȸ  (�Ի��� ��)
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE < '07/01/01' 
ORDER BY HIRE_DATE;

-- ��¥ �����͸� �������?
SELECT FIRST_NAME, HIRE_DATE, HIRE_DATE+1
FROM EMPLOYEES;

-- ������ �̸��� 'J'�� �����ϴ� ������ ��ȸ (������)
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'J%';
  
-- ������ �̸��� 'n'�� ������ ������ ��ȸ (������)
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%n';

-- ������ �̸��� 'n'�� �����鼭 �̸��� ���̰� 5�� ������ ��ȸ (������)
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '____n';

-- ������ �̸��� �Ի��� 07�⵵�� �Ի��� ����� ��ȸ LIKE �̿�   (�Ի��� ��)
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '07%'
ORDER BY HIRE_DATE;

-- ������ �̸��� �Ի��� 1���� �Ի��� ����� ��ȸ LIKE �̿� (�Ի��� ��)
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%/01/%'
ORDER BY HIRE_DATE;

-- [����]
-- 1) �Ŵ����� 103�� ������ ����(���̵�, �̸�, �μ�, �Ŵ�����ȣ)�� ��ȸ�Ͻÿ�.
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 103;

-- 2) ��� �μ����� ������ ���� ������ ���� (�̸�, ��ȭ��ȣ, �μ�)�� ��ȸ�Ͻÿ�
SELECT FIRST_NAME, PHONE_NUMBER, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- 3) �޿��� 10000�� �ʰ��ϸ鼭 JOB_ID�� 'SA_REP'�� ����� �̸���, �̸�, ��ȭ��ȣ, JOB_ID ������ ��ȸ�Ͻÿ�
SELECT EMAIL, FIRST_NAME, PHONE_NUMBER, JOB_ID
FROM EMPLOYEES
WHERE SALARY > 10000 AND JOB_ID='SA_REP';

-- 4) �μ��� 60�̰ų� �̸��� A�� �����ϴ� �����ϴ� ������ ����(�̸�, �޿�, �μ�)��  ��ȸ�Ͻÿ�.
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID=60 OR FIRST_NAME LIKE 'A%';


-- 5) �μ��� 10�̰ų� 50�̰ų� 60�� �μ��� ������ ����(�̸�, �޿�, �μ�)�� ��ȸ�Ͻÿ�
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 50, 60);

-- 6) �̸��� 3������ ��� ����� ������ ��ȸ�Ͻÿ�.
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '___';

-- 7) ��ü �������� ������ 'CLERK' ���� ��ȸ (������ ����)
SELECT FIRST_NAME, JOB_ID 
FROM EMPLOYEES
WHERE JOB_ID LIKE '%CLERK';



