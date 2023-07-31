/* 4월 25일(화) */

-- [연습문제]
-- 1. 80번 부서의 급여 평균, 최고, 최저, 인원수를 구하라.

SELECT 
    AVG(SALARY), MAX(SALARY), MIN(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID = 80;

-- 2. 각 부서별 급여의 평균, 최고, 최저, 인원수를 구하시오.
SELECT 
    DEPARTMENT_ID, AVG(SALARY), MAX(SALARY), MIN(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 3. 각 부서별 평균 월급, 전체 월급, 최저월급을 구하여 평균 월급이 많은 순으로 출력,
--    단 부서번호가 NULL이면 출력하지 않는다.
SELECT 
    DEPARTMENT_ID, CEIL(AVG(SALARY)), SUM(SALARY),  MIN(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL
ORDER BY 2 DESC;

-- 4. 각 부서별 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무명, 인원수 출력
SELECT 
    DEPARTMENT_ID, JOB_ID, COUNT(JOB_ID)
FROM EMPLOYEES
GROUP BY JOB_ID, DEPARTMENT_ID
ORDER BY 1 ;


-- 5. 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력
SELECT JOB_ID, COUNT(JOB_ID)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING   COUNT(JOB_ID)   >=4 
ORDER BY 2 DESC;


/* JOIN 
    - 둘 이상의 테이블로 부터 질의해 오는 명령
    - 테이블들은 보통 PK와 FK의 관계를 가지고 있다.
    
*/

SELECT * FROM DEPARTMENTS;

-- EQUI JOIN (--> INNER JOIN)
-- PK와 FK가 같아야 조인이 됨. 
-- FK가 NULL인 경우 조인되지 않을 수 있다.
-- 이름(E), 급여(E), 부서명(D)
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e, DEPARTMENTS d
WHERE d.department_id = e.department_id
ORDER BY 1;

/** INNER JOIN **/
-- 결과는 EQUI JOIN과 같음
-- 문법이 다름
-- INNER 키워드는 생략 가능
-- ON에 조인 조건(pk = fk) --> USING (컬럼명) : ( ) 는 생략 불가

-- 전체 문법을 그대로
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e INNER JOIN DEPARTMENTS d
ON d.department_id = e.department_id
ORDER BY 1;

-- INNER 키워드 생략 예
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e JOIN DEPARTMENTS d
ON d.department_id = e.department_id
ORDER BY 1;

-- ON 대신 USING 사용
SELECT e.FIRST_NAME,  e.SALARY, d .DEPARTMENT_NAME
FROM EMPLOYEES  e JOIN DEPARTMENTS d
USING ( department_id) 
ORDER BY 1;

--[연습] 부서명(DEPARTMENT_NAME), 도시명(CITY)을 조회하시오
-- 1) 오라클 문법
SELECT d.DEPARTMENT_NAME, l.CITY
FROM DEPARTMENTS d, LOCATIONS l
WHERE d.LOCATION_ID = l.LOCATION_ID;

-- 2) ANSI 표준 (JOIN ~ ON)
SELECT d.DEPARTMENT_NAME, l.CITY
FROM DEPARTMENTS d INNER JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID;

-- 3) ANSI 표준 (JOIN ~ USING)
SELECT d.DEPARTMENT_NAME, l.CITY
FROM DEPARTMENTS d JOIN LOCATIONS l
USING (LOCATION_ID);

/** 테이블 3개 이상에서 JOIN을 할 때 **/
--[연습] 부서명(DEPARTMENT_NAME), 도시명(CITY), 나라명(COUNTRIES)을 조회하시오. 

-- 1) 오라클 문법
SELECT d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME
FROM DEPARTMENTS d, LOCATIONS l, COUNTRIES c
WHERE 
    d.LOCATION_ID = l.LOCATION_ID
    AND
    l.COUNTRY_ID = c.COUNTRY_ID;

-- 2) ANSI 표준 (JOIN ~ ON)
SELECT d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME
FROM DEPARTMENTS d JOIN LOCATIONS l
ON   d.LOCATION_ID = l.LOCATION_ID
JOIN COUNTRIES c
ON   l.COUNTRY_ID = c.COUNTRY_ID;

-- 3) ANSI 표준 (JOIN ~ USING)
SELECT d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME
FROM DEPARTMENTS d JOIN LOCATIONS l
USING  (LOCATION_ID)
JOIN COUNTRIES c
USING (COUNTRY_ID);

-- [연습] 직원명, 입사일, 근속연수, 부서명, 직급명, 급여
-- 1) 오라클 문법
SELECT 
    FIRST_NAME, HIRE_DATE, 
    TO_CHAR(SYSDATE, 'YYYY')- TO_CHAR(HIRE_DATE, 'YYYY') AS "근속년수", 
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
    TO_CHAR(SYSDATE, 'YYYY')- TO_CHAR(HIRE_DATE, 'YYYY') AS "근속년수", 
    DEPARTMENT_NAME, 
    JOB_TITLE, 
    SALARY
FROM EMPLOYEES e JOIN JOBS j
ON e.JOB_ID = j.JOB_ID
JOIN  DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY FIRST_NAME;

-- 3) JOIN~USING : 3개 이상의 테이블에서 조인을 할때에는 e.과 같은 ALIAS를 컬럼명에 붙이면 오류
SELECT 
    FIRST_NAME, HIRE_DATE, 
    TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(HIRE_DATE, 'YYYY') AS "근속년수", 
    DEPARTMENT_NAME, 
    JOB_TITLE, 
    SALARY
FROM EMPLOYEES e JOIN JOBS j
USING (JOB_ID)
JOIN  DEPARTMENTS d
USING (DEPARTMENT_ID)
ORDER BY FIRST_NAME;

/** OUTER JOIN **/
-- FK를 가진 테이블의 데이터가 NULL일 때, 조회되지 않는 데이터를 조회하기 위한 조인방법
-- JOIN 조건이 같지 않을 경우에도 결과를 반환받고자 할 때.
-- 종류 : LEFT OUTER, RIGHT OUTER, FULL OUTER

/* LEFT OUTER */
-- 먼저 왼쪽 테이블의 데이터를 가져오고, 오른쪽 테이블의 데이터를 가져오는데, 
-- 만약 조인 조건이 안맞으면 NULL로 채움.

-- [연습] 이름, 부서명을 조회하시오
-- 1) 오라클 문법
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

-- 4) LEFT OUTER JOIN ~ ON (틀림 : 부모테이블이 왼쪽에 있기 때문에 결과가 틀림)
SELECT e.FIRST_NAME,  d .DEPARTMENT_NAME
FROM DEPARTMENTS d LEFT OUTER JOIN   EMPLOYEES  e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY 1;

-- 5) LEFT OUTER JOIN ~ ON (RIGHT로 바꾸면 됨!)
SELECT e.FIRST_NAME,  d .DEPARTMENT_NAME
FROM DEPARTMENTS d RIGHT OUTER JOIN   EMPLOYEES  e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY 1;


/*  SELF JOIN */
-- PK, FK 하나의 테이블 내에 존재

-- 오라클 문법
SELECT 
    e2.EMPLOYEE_ID /* P */ , e2.FIRST_NAME /* P */ AS "직원명", 
    e2.MANAGER_ID/* FK(C) */,  e1.FIRST_NAME  /* P*/ AS "MANAGER 명"
FROM EMPLOYEES e1,  EMPLOYEES e2
WHERE e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- INNER JOIN~ON
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME  AS "직원명", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER 명"
FROM EMPLOYEES e1 INNER JOIN EMPLOYEES e2
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- 1) 오라클 문법 전체 조회 
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME AS "직원명", 
    e2.MANAGER_ID,  e1.FIRST_NAME  AS "MANAGER 명"
FROM EMPLOYEES e1,  EMPLOYEES e2
WHERE e2.MANAGER_ID = e1.EMPLOYEE_ID(+)
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- 2) LEFT OUTER JOIN~ON 
SELECT 
    e2.EMPLOYEE_ID  , e2.FIRST_NAME  AS "직원명", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER 명"
FROM EMPLOYEES e2 LEFT OUTER JOIN   EMPLOYEES e1
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY  e2.FIRST_NAME ;

/* [연습문제] */
-- 1. JOIN을 이용하여 사원ID가 100번인 사원의 부서번호와 부서이름을 출력하시오
SELECT 
    e.EMPLOYEE_ID, DEPARTMENT_ID, DEPARTMENT_NAME
FROM 
    EMPLOYEES e JOIN DEPARTMENTS d
USING (DEPARTMENT_ID)
WHERE e.EMPLOYEE_ID = 100;

-- 2. INNER JOIN을 이용하여 사원이름과 함께 그 사원이 소속된 도시이름과 지역명을 출력하시오
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

-- 3. INNER JOIN과 USING 연산자를 사용하여 100번 부서에 속하는 
--    직원명과 직원의 담당 업무명, 속한 부서의 도시명을 출력하시오.
--    (100번 부서에는 직원 6명있음)

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
    
-- 4. JOIN을 사용하여 커미션을 받는 모든 사원의 이름, 부서ID, 도시명을 출력하시오
SELECT e.FIRST_NAME, d.DEPARTMENT_ID, l.CITY
FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
WHERE
    e.COMMISSION_PCT IS NOT NULL
    AND
    e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
    AND
    d.LOCATION_ID = l.LOCATION_ID(+)
ORDER BY FIRST_NAME;    
    
-- 5. INNER JOIN과 와일드카드를 사용하여 이름에 A가 포함된 모든 사원의 이름과 부서명을 출력하시오(단, 대소문자 구분 없음)
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND  FIRST_NAME LIKE '%A%';  -- WHERE를 사용하거나, ON절에 AND로 연결해도 동일

-- 6. JOIN을 사용하여 Seattle에 근무하는 모든 사원의 이름, 업무, 부서번호 및  부서명을 출력하시오
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

-- 7. SELF 조인을 사용하여 사원의 이름 및 사원번호와 매니저 이름 및 매니저 번호와  함께 조회하시오. (이미 풀었던 문제임)
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME  AS "직원명", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER 명"
FROM EMPLOYEES e1 INNER JOIN EMPLOYEES e2
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY e2.MANAGER_ID,  e2.FIRST_NAME ;

-- 8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 조회
SELECT 
    e2.EMPLOYEE_ID , e2.FIRST_NAME  AS "직원명", 
    e2.MANAGER_ID,  e1.FIRST_NAME   AS "MANAGER 명"
FROM EMPLOYEES e2 LEFT OUTER JOIN EMPLOYEES e1
ON e2.MANAGER_ID = e1.EMPLOYEE_ID
ORDER BY 1 DESC ;


-- 9. SELF JOIN을 사용하여 'Oliver' 사원의 부서명, 그 사원과 동일한 부서에서 근무하는  동료 사원의 이름을 조회. 
--     단, 각 열의 별칭은 부서명, 동료로 할 것.
SELECT 
    DEPARTMENT_NAME AS 부서명, FIRST_NAME 동료명
FROM 
    EMPLOYEES e2 LEFT OUTER JOIN EMPLOYEES e1
ON (e2.DEPARTNAME_ID =     
WHERE FIRST_NAME = 'Oliver';


-- 11. SELF JOIN을 사용하여 관리자보다 먼저 입사한 모든 사원의 이름 및 입사일을 매니저 이름 및 입사일과 함께 출력하시오
SELECT e1.FIRST_NAME, e1.HIRE_DATE, e2.FIRST_NAME AS "매니저이름", e2.HIRE_DATE AS "입사일"
FROM EMPLOYEES e1 JOIN EMPLOYEES e2
ON e1.MANAGER_ID = e2.EMPLOYEE_ID
AND
e1.HIRE_DATE < e2.HIRE_DATE;

-- 20. Last name이 ‘King’을 Manager로 둔 사원의 이름과 급여를 조회하시오.
SELECT e1.FIRST_NAME, e1.SALARY
FROM EMPLOYEES e1 JOIN EMPLOYEES e2
ON e1.MANAGER_ID = e2.EMPLOYEE_ID
WHERE e2.LAST_NAME = 'King';

-- 21. Finance부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시하시오
SELECT
    DEPARTMENT_ID, FIRST_NAME, JOB_TITLE
FROM
    DEPARTMENTS JOIN EMPLOYEES
USING (DEPARTMENT_ID)
JOIN JOBS
USING (JOB_ID)
WHERE
    DEPARTMENT_NAME = 'Finance';
    
-- 22. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 
--       근무하는 사원의 사원번호, 이름, 급여를 조회하시오

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
HAVING SALARY >= AVG(SALARY) AND
FIRST_NAME LIKE '%M%';

/* *****************************************************************
*** 서브쿼리(Sub Query)
- Query 문장 안에 또다른 Query 문장이 포함된 쿼리
- 메인쿼리와 서브쿼리

  1) 메인 쿼리 : 
		- 실행의 결과가 조회되는 쿼리.
		- 서브 쿼리에 의해 실행된 쿼리문의 결과에 의해 메인쿼리가 실행된다.

  2) 서브쿼리 : 
		- 메인 쿼리 안쪽에 위치한 쿼리.
		- 서브쿼리의 실행 결과가 메인쿼리의 조건이나 결과로 사용된다.
		- 대부분 서브쿼리가 먼저 실행되고 난 후 그 결과가 메인쿼리에 전달되어 실행됨
		- 서브쿼리에는 Order by절 사용 불가
		- 서브 쿼리의 사용 위치
			* where 절 : 값 1개로 나오는 결과 또는 컬럼 1개짜리 결과
			* having절 : 메인쿼리에서 그룹행를 사용했을 때
			* from 절
			* select 절
			* insert문의 into절
			* update문의 set절
            
 3) 서브쿼리의 종류
    - 단일행 서브쿼리 : 
        서브쿼리의 결과가 하나인 경우
        
    - 복수행 서브쿼리 : 
        서브쿼리의 결과가 하나 이상인 경우
        연산자와 함께 사용 (IN, ANY, ALL, EXISTS)
        ANY, ALL 은 비교연산자와 함께 사용
***************************************************************** */

-- 13. 사원번호가 109인 사원보다 급여가 많은 사원을 표시(사원이름과 담당) 조회하시오.
-- 1) 일반 쿼리 2개로 작업한 내용
SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 109;

SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE SALARY > 9000;

-- 2) 서브쿼리로 작업한 내용. (단일행 서브쿼리)
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE SALARY >  (SELECT SALARY
                                 FROM EMPLOYEES
                                 WHERE EMPLOYEE_ID = 109 ) ;

--[ 실습] 162번의 급여와 같은 급여를 받은 직원 명단을 조회하시오. (이름, 급여, 부서번호)
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY =  (SELECT SALARY
                                 FROM EMPLOYEES
                                 WHERE EMPLOYEE_ID = 162);

-- FROM 절에서 사용하는 서브쿼리
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

-- ROWNUM 1~10까지 조회
SELECT ROWNUM, tbl.* FROM
    (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50) tbl
WHERE SALARY > 3000
AND ROWNUM BETWEEN 1 AND  10;    

-- 11 ~ 20 까지 조회는 안됨! WHY
-- > ROWNUM은 동적으로 번호가 부여되는 것이기 때문에 11에서 부터 시작하는 번호는 없음
SELECT  FROM
    (SELECT ROWNUM rno, tbl.* FROM
        (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 50) tbl
    WHERE SALARY > 3000 )
WHERE RNO BETWEEN 11 AND  20;    

/* *****************************************************************
*** 서브쿼리(Sub Query)
- Query 문장 안에 또다른 Query 문장이 포함된 쿼리
- 메인쿼리와 서브쿼리

  1) 메인 쿼리 : 
		- 실행의 결과가 조회되는 쿼리.
		- 서브 쿼리에 의해 실행된 쿼리문의 결과에 의해 메인쿼리가 실행된다.

  2) 서브쿼리 : 
		- 메인 쿼리 안쪽에 위치한 쿼리.
		- 서브쿼리의 실행 결과가 메인쿼리의 조건이나 결과로 사용된다.
		- 대부분 서브쿼리가 먼저 실행되고 난 후 그 결과가 메인쿼리에 전달되어 실행됨
		- 서브쿼리에는 Order by절 사용 불가
		- 서브 쿼리의 사용 위치
			* where 절 : 값 1개로 나오는 결과 또는 컬럼 1개짜리 결과
			* having절 : 메인쿼리에서 그룹행를 사용했을 때
			* from 절
			* select 절
			* insert문의 into절
			* update문의 set절
            
 3) 서브쿼리의 종류
    - 단일행 서브쿼리 : 
        서브쿼리의 결과가 하나인 경우
        
    - 복수행 서브쿼리 : 
        서브쿼리의 결과가 하나 이상인 경우
        연산자와 함께 사용 (IN, ANY, ALL, EXISTS)
        ANY, ALL 은 비교연산자와 함께 사용
***************************************************************** */

-- 10. SELF JOIN을 사용하여 성이 'Chen'인 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오.
SELECT FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE > (SELECT HIRE_DATE
                                    FROM EMPLOYEES
                                    WHERE LAST_NAME = 'Chen')
ORDER BY 2;                                    

-- 12. 사원ID가 101인 사원과 담당업무가 같은 사원을 표시(사원이름과 담당)하시오.
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID 
                             FROM EMPLOYEES 
                             WHERE EMPLOYEE_ID = 101);


/* 4월 26일 : 서브쿼리 */
-- [연습] FROM 절에 서브쿼리 사용 : 03년 이전에 입사한 일련번호(ROWNUM) 와 직원의 직원명, 급여, 입사일, 부서명 조회 
SELECT temp.* 
FROM 
    ( SELECT ROWNUM AS RNO, FIRST_NAME, SALARY, HIRE_DATE, DEPARTMENT_NAME
      FROM EMPLOYEES JOIN DEPARTMENTS
      USING (DEPARTMENT_ID)
    )  temp
WHERE HIRE_DATE < '03/01/01';

-- [연습] WHERE절에 서브쿼리 사용 : 이름이 'Lisa'인 사원의 매니저명과 성을 조회하시오.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID = (SELECT MANAGER_ID
                                        FROM EMPLOYEES
                                        WHERE FIRST_NAME = 'Lisa');

-- [연습] 하나의 문장 안에 서브쿼리가 두 개 => 조건절에
-- 'Chen', 'Davies' 라는 성을 가진 직원의 이름과 성을 조회하시오.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME ='Greenberg' OR LAST_NAME ='Errazuriz';

-- 'Greenberg' 보다 급여가 많으면서 성이  'Errazuriz'인 직원의 매니저의 이름과 성씨를 조회
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY 
                                FROM EMPLOYEES
                                WHERE LAST_NAME = 'Greenberg')
AND EMPLOYEE_ID = (SELECT MANAGER_ID
                                FROM EMPLOYEES
                                WHERE LAST_NAME = 'Errazuriz');

-- [연습] Bruce와 Daniel의 성씨를 조회하시오
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME IN ('Bruce', 'Daniel');

-- 서브쿼리로
SELECT
    (SELECT LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME='Bruce') AS "Bruce의 성",
    (SELECT LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME='Daniel') AS "Daniel의 성"
FROM DUAL;

-- [문제] 'Valli'라는 이름을 가진 직원의 부서명을 조회하시오. (서브쿼리)
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                                               FROM EMPLOYEES
                                               WHERE FIRST_NAME = 'Valli');


/*복수행 서브퀴리 */

-- 1) IN 연산자 사용하기
SELECT* 
FROM EMPLOYEES
WHERE JOB_ID IN (SELECT JOB_ID
                              FROM EMPLOYEES
                              WHERE DEPARTMENT_ID = 30);
                              
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;


-- 2) ANY / ALL 연산자 :
--    서브쿼리로 조회된 결과에 하나 이상 만족하는 행이 있는지 조회
--   > ANY, < ANY, = ANY (IN 사용과 동일), != ANY, >= ANY, <= ANY
--  > ALL, <ALL, =ALL, != ALL, >=ALL, <=ALL

-- [연습-1] ST_MAN직군의 급여 중 가장 많이 받는 급여보다 적게 받는 사람들의 이름, 급여를 조회
-- 서브 쿼리의 결과중 가장 작은값 보다 큰값들
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');

-- [연습 2] ST_MAN직군의 급여 중 가장 적게 받는 급여보다 더 적게 받는 사람들의 이름, 급여를 조회
-- 서브쿼리로 조회된 결과중 가장 큰값보다 작은값 
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');
                                        
-- [연습3] ST_MAN직군의 급여 중 가장 적게 받는 급여보다 더 적게 받는 사람들의 이름, 급여를 조회
-- 작은 값보다 작은값
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');
                                        
-- [연습4] ST_MAN직군의 급여 중 가장 적게 받는 급여보다 더 적게 받는 사람들의 이름, 급여를 조회
-- 큰값보다 큰값
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY 
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'ST_MAN');                                        

-- [ 연습 ] 직군이 'REP' 인 직원이 받는 급여와 동일한 급여를 받는 직원들의 사원번호, 이름, 직군, 급여
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY = ANY (SELECT SALARY
                                        FROM EMPLOYEES
                                        WHERE JOB_ID LIKE '%REP');



-- 3) EXISTS
-- 서브 쿼리의 결과에 만족하는 행이 존재하면 메인쿼리를 실행
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE  EXISTS (SELECT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE   DEPARTMENT_ID = 500);
                            
-- 성이 'Chen' 이라는 직원이 존재하면 그 직원의 부서명, 이름, 성, 급여 : 서브쿼리 + 조인
SELECT DEPARTMENT_NAME, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES JOIN DEPARTMENTS
USING (DEPARTMENT_ID)
WHERE EXISTS (SELECT FIRST_NAME 
                             FROM EMPLOYEES
                             WHERE LAST_NAME = 'Chen')
AND LAST_NAME = 'Chen';                             

-- [연습]
SELECT FIRST_NAME, DEPARTMENT_ID, NVL(COMMISSION_PCT, 0) 
FROM EMPLOYEES
WHERE ( SALARY, NVL(COMMISSION_PCT, 0))
                IN  ( SELECT SALARY, NVL(COMMISSION_PCT, 0) 
                       FROM EMPLOYEES
                       WHERE DEPARTMENT_ID = 80) ;

/* [서브쿼리 문제] */

-- 13. 사원번호가 109인 사원보다 급여가 많은 사원을 표시(사원이름과 담당) 조회하시오.
SELECT FIRST_NAME, JOB_TITLE
FROM EMPLOYEES  JOIN JOBS 
USING (JOB_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 109);

-- 14. 최소 급여를 받는 직원과 같은 급여를 받는 사원의 이름, 담당업무명, 급여를 조회하시오.
--      (그룹함수 사용 + 서브쿼리 + 조인)
SELECT FIRST_NAME, LAST_NAME, JOB_TITLE, SALARY
FROM EMPLOYEES JOIN JOBS
USING (JOB_ID)
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES);

-- 15. 전체 평균 급여보다 적은 급여를 받은 사원들의 담당 업무를 찾아 담당업무(JOB_ID)와 급여를 조회하시오.
SELECT JOB_ID, SALARY
FROM EMPLOYEES
GROUP BY JOB_ID, SALARY
HAVING AVG(SALARY) IN (SELECT AVG(SALARY)
                        FROM EMPLOYEES
                        GROUP BY JOB_ID)
ORDER BY 1;

-- 16. 담당 업무가 IT_PROG인 사원보다 급여가 적으면서 업무가 IT_PROG가 아닌 사원들을 조회(사원번호, 이름, 담당업무) 하시오
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY
                                FROM EMPLOYEES
                                WHERE JOB_ID = 'IT_PROG')
AND JOB_ID != 'IT_PROG';


-- 17. 성이 'Chen'과 동일한 부서에 있는 사원의 이름과 입사일을 조회하시오
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                               FROM EMPLOYEES
                                               WHERE LAST_NAME = 'Chen');
                                        
-- 18. 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해 오름차순으로 정렬하시오
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                            FROM EMPLOYEES)
ORDER BY SALARY;

-- 19. 이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                        FROM EMPLOYEES
                                        WHERE FIRST_NAME LIKE '%K%');

-- 22. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호,
--  이름, 급여를 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                                FROM EMPLOYEES)
AND FIRST_NAME LIKE '%M%';                                

-- 23. 평균 급여가 가장 적은 업무 조회하기
-- 업무별 평균급여
SELECT MIN(tmp.SAL)
FROM (SELECT AVG(SALARY) AS SAL
FROM EMPLOYEES
GROUP BY JOB_ID) tmp;


/* *********************************
DDL
- 테이블명, 컬럼명은 키워드 사용 불가능
- 제약조건(CONSTRAINTS) : Primary Key , Foreign Key, Unique, Not Null, Check (단답형 문제 답)
   데이터의 무결성 보장
   Primary Key, Unique 제약조건은 자동을 Index가 생성되기 때문에 조회가 빨라진다.
   
   default : 제약조건은 아니지만 무결성을 보장하는 역할 담당.
  
***********************************/

-- 오라클 키워드 조회 (DBA)
SELECT * FROM V$RESERVED_WORDS; -- DBA만 가능한 명령 (SYSTEM 계정으로 접속 후 확인 가능)

DROP TABLE FITNESS;

CREATE TABLE FITNESS
(
   MEM_ID      VARCHAR2(5)  CONSTRAINTS FITNESS_ID_PK  PRIMARY KEY,
   MEM_NAME   VARCHAR2(15)  CONSTRAINTS FITNESS_NAME_NN NOT NULL,
   HEIGHT NUMBER(5, 2) DEFAULT 0,
   WEIGHT NUMBER(5, 2) DEFAULT 0,
   JOIN_DATE DATE DEFAULT SYSDATE
);

-- 어느 테이블에 어떤 제약조건이 걸려있는지 확인 할 수 있다.
SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME ='FITNESS';

-- INSERT 문
/*
INSERT INTO 테이블명
VALUES
('Hong' , '홍길동', 185.5, 75, '23/01/26');
*/

INSERT INTO FITNESS
VALUES
('Hong' , '홍길동', 185.5, 75, '23/01/26');

INSERT INTO FITNESS
(MEM_ID, MEM_NAME, HEIGHT, WEIGHT, JOIN_DATE)
VALUES
('Lim', '임꺽정', 180, 88, '23/04/25');

INSERT INTO FITNESS
(MEM_ID, MEM_NAME)
VALUES
('Son', '손오공');

COMMIT;

SELECT * FROM FITNESS;

-- [ 문제 ] 회원의 정보를 저장할 수 있는 MEMBERS 테이블을 생성하시오
SEQNO 숫자타입 PK,
USERID 가변길이 10

DROP TABLE SCORE_;

-- [ 문제 ] 회원의 정보를 저장할 수 있는 MEMBERS 테이블을 생성하시오
/*
SEQNO 숫자타입 PK,
USERID 가변길이 10 UQ
USERNAME 가변길이 20 NN
BIRTHDAY 날짜타입 NN
GENDER 고정길이 1 CHECK '0', '1'
*/

CREATE TABLE MEMBERS
(
    SEQNO NUMBER CONSTRAINTS MEMBERS_SEQ_PK PRIMARY KEY,
    USERID VARCHAR2(10) CONSTRAINTS MEMBERS_ID_UQ UNIQUE,
    USERNAME VARCHAR2(20) CONSTRAINTS MEMBERS_NAME_NN NOT NULL,
    BIRTHDAY DATE  CONSTRAINTS MEMBERS_BIRTHDAY_NN NOT NULL,
    GENDER CHAR(1) CONSTRAINTS MEMBERS_GENDER_CK CHECK (GENDER IN ('0', '1'))
);

-- 삽입 : 데이터를 2개 넣으시오 (아무 데이터나)
-- 모든 컬럼에 데이터를 다 넣을 때에는 VALUES 앞쪽 생략가능
INSERT INTO MEMBERS
VALUES
(
    1, 
    'SON',
    '손오공',
    '00/01/02',
    '1'
);

INSERT INTO MEMBERS
VALUES
(
    2, 
    'KIM',
    '김영희',
    '95/05/01',
    '0'
);

-- DCL 명령 
COMMIT;
ROLLBACK;

-- 삭제
DELETE MEMBERS
WHERE SEQNO = 3;

-- 수정
UPDATE MEMBERS
SET
    USERNAME = '손영희'
WHERE USERID = 'SON';    
    
-- 조회
SELECT * FROM MEMBERS;

-- PK와 FK의 관계를 가진 테이블 생성하기
-- 1) 무조건 부모부터 생성 -> 자식테이블 생성
-- 2) 삭제는 자식테이블 삭제 후 -> 부모테이블 삭제

-- [문제] 위에서 생성한 MEMBERS 테이블의 자식테이블인 (구매:PURCHASE) 테이블을 작성하시오
/*
일련번호(SEQ_ID) : 정수형 PK
상품명 (ITEM) : 가변길이 문자열(50) NN
가격 (PRICE) : 정수형 (10) 기본값 100000
구매일 (PDAY)  DATE 기본값 현재날짜
수량 (QUANTITY) : 숫자형 3자리 기본값 1
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

-- 포린키는 부모의 UNIQUE를 이용해서 생성할 수도 있다.
CREATE TABLE PURCHASE2
(
    SEQ_ID NUMBER  PRIMARY KEY,
    ITEM VARCHAR2(50)  NOT NULL,
    PRICE NUMBER(10) DEFAULT 100000,
    PDAY DATE DEFAULT SYSDATE,
    QUANTITY NUMBER(3) DEFAULT 1,
    USERID VARCHAR2(10) REFERENCES MEMBERS(USERID) ON DELETE CASCADE
);

-- 손영희가 물건 2개 구매
INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(11, '자바의 정석', 1, 40000);

INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(12, '파이썬', 1, 25000);

-- 김영희가 물건 3개 구매
INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(13, '노트북', 2, 2570000);

INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO)
VALUES
(14, '키보드', 2);

INSERT INTO PURCHASE
(SEQ_ID, ITEM, SEQNO, PRICE)
VALUES
(15, '모니터', 2, 380000);

SELECT * FROM PURCHASE;

-- 일련번호, 구매인 이름, 아이템명, 가격 : INNER JOIN을 이용해서 조회하시오
SELECT ROWNUM, USERNAME, ITEM, PRICE
FROM MEMBERS JOIN PURCHASE
USING (SEQNO);



















