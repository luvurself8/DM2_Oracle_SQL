/* 2023년 4월 24일(월) */
-- 집합연산자 ( 합집합(Union, Union All), 교집합(Intersection), 차집합(Minus) )

-- 사원번호가 145,147,158번인 사원의 사원번호와, 이름을 조회 (3명)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158);

-- 이름이 'A'로 시작하는 사원의 사원번호와 이름을 조회 (10명)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';


-- 3개의 데이터 중 교집합 -- 2명
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

INTERSECT

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';


-- 3개의 데이터 중 차집합 -- 2명
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

MINUS

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

-- 순서를 바꿔서 차집합 실행
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

MINUS

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158);


--합집합
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158);


--합집합(UNION ALL) : 중복된 데이터도 다 출력
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION ALL

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

--오류 : 컬럼의 개수가 다르면 오류
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

--오류 : 컬럼의 개수가 같아도 타입이 다르면 오류
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

-- 정상 출력 : 컬럼의 개수가 같고, 타입도 같다. (첫번째 집합을 기준으로 출력됨)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, EMAIL
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;

-- 첫 번째 집합을 기준으로 조회됨 
SELECT EMPLOYEE_ID, FIRST_NAME, EMAIL 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%'

UNION

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (145, 147, 158)

ORDER BY FIRST_NAME;


/* 단일행 함수
1) 문자열 함수
- lower(문자열) : 영문자 소문자로 변경
- upper(문자열) : 영문자 대문자로 변경
- initcap(문자열) : 영문자 첫글자 대문자, 나머지 소문자로 변경
- concat(문자열, 문자열) : 두 개의 문자열을 합침
- substr(문자열, 위치) : 특정 문자열 뒤의 모든 부분 문자열 반환
- substr(문자열, 위치, 개수) : 특정 문자열 뒤의 정한 개수의 부분 문자열 반환
- length(문자열) : 문자열의 길이 반환
- instr(문자열, 부분문자열) : 부분문자열의 위치를 반환
- concat(문자열1, 문자열2) : 두 개의 문자열을 합침
- replace(전체 문자열,찾는 문자열, 바꿀 문자열) : 문자 치환
 */

-- FIRST_NAME을 소문자로 변경하여 조회
SELECT LOWER(FIRST_NAME) 
FROM EMPLOYEES;

-- DUMMY TABLE(DUAL)을 이용해 조회 
SELECT LOWER('World Cup 2002')
FROM DUAL;

-- FIRST_NAME을 대문자로 변경하여 조회
SELECT UPPER(FIRST_NAME) 
FROM EMPLOYEES;

-- INITCAP()
SELECT INITCAP('THE SOAP')
FROM DUAL;


-- SUBSTR() : INDEX가 1부터 시작함(주의)
SELECT SUBSTR('THE SOAP', 5)
FROM DUAL;

-- SUBSTR() : INDEX가 1부터 시작함(주의)
SELECT SUBSTR('THE SOAP', 5, 2) AS RESULT
FROM DUAL;

-- LENGTH() 
SELECT LENGTH('THE SOAP')
FROM DUAL;

-- INSTR() : 위치값 반환
SELECT INSTR('THE SOAP', 'S')
FROM DUAL;

-- INSTR() : 위치값 반환
SELECT INSTR('오라클 마스터', '라')
FROM DUAL;

-- INSTR() : 없는 데이터는 0 반환
SELECT INSTR('오라클 마스터', '매')
FROM DUAL;

-- WHERE 절에서 사용
-- (함수를 사용하지 않은 경우)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;

-- (함수를 WHERE절에 사용하는 경우) -- SUBSTR(문자열, 음수, 개수) : 음수는 뒤에서 부터
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -1, 1) = 'n';

-- 끝에서 2번째 2개가 'en'으로 끝나는 사람
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, -2, 2) = 'en';

-- [연습] 입사일이 03년인 직원 조회 : LIKE 말고 SUBSTR 으로
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE SUBSTR(HIRE_DATE, 1, 2) ='03';

-- [연습] 입사일이 01월에 입사한 직원 조회 : LIKE 로..
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%/01/%';

-- [연습] 입사일이 01월에 입사한 직원 조회 : SUBSTR 로..
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE SUBSTR(HIRE_DATE, 4, 2) ='01';

-- CONCAT() : 두개의 문자열을 합치는 함수  ==> || 연산자와 동일함.
SELECT CONCAT('I have', ' a dream')
FROM DUAL;

SELECT 
    CONCAT (EMPLOYEE_ID, FIRST_NAME),
    CONCAT (EMPLOYEE_ID, CONCAT(' : ', FIRST_NAME))
FROM EMPLOYEES;

-- REPLACE(문자열, 찾을 문자열, 바꿀문자열)
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES;

SELECT FIRST_NAME, REPLACE(HIRE_DATE, '/', '-')
FROM EMPLOYEES;

-- 전화번호에 '.' 을 공백으로 바꾸시오
SELECT FIRST_NAME, REPLACE(PHONE_NUMBER, '.', ' ')
FROM EMPLOYEES;


/*
2) 숫자함수
- abs(숫자)           : 숫자의 절대값을 구한다.
- ceil(숫자)          : 올림 (가장 가까운 양의 방향의 정수를 반환)
- floor(숫자)        : 버림 (가장 가까운 음의 방향의 정수를 반환)
- round(숫자, 자릿수) : 지정한 자릿수 위치에서 반올림
- trunc(숫자, 자릿수) : 지정한 자릿수 위치에서 절삭
- mod(숫자1, 숫자2)   : 숫자1을 숫자2로 나눈 나머지
- power(숫자1, 숫자2) : 숫자1을 숫자2번만큼 곱한 값
- sign(숫자)          : 숫자가 음수이면 -1, 양수이면 1, 0이면 0을 반환
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

/* 날짜함수
     - 날짜관련 값 : SYSDATE(현재 시스템 날짜), SYSTIMESTAMP(현재 시스템날짜와 시간)
     - 날짜는 +, - 연산만 가능
*/

SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;

SELECT SYSDATE+1 FROM DUAL; -- 다음날
SELECT SYSDATE-1 FROM DUAL; -- 전날

SELECT SYSDATE*2 FROM DUAL; -- 다음날

SELECT TO_DATE('23/01/01'), '23/01/01'  FROM DUAL;
SELECT CEIL(SYSDATE-TO_DATE('23/01/01')) FROM DUAL;  -- 2023년 1월 1일부터 114일째임.

SELECT ADD_MONTHS(SYSDATE, 10) FROM DUAL;    -- 열달 후
SELECT ADD_MONTHS(SYSDATE, -10) FROM DUAL;  -- 열달 전

-- [연습-1] 오늘날짜를 기준으로 근무일수를 계산하시오 (EMPLOYEES 테이블에서 직원명, 근무일)
SELECT FIRST_NAME, CEIL(SYSDATE-HIRE_DATE) AS 총근무일수
FROM EMPLOYEES
ORDER BY 2 DESC;

-- [연습-2] 오늘날짜를 기준으로 근무한 달수를 계산하시오
SELECT 
    FIRST_NAME, 
    CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 총근무개월수
FROM EMPLOYEES
ORDER BY 2 DESC;

-- 특정 달의 마지막 날을 구함
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 2020년 2월의 마지막날을 구하시오
SELECT LAST_DAY(TO_DATE('20/02/01')) FROM DUAL;

-- NEXT_DAY(날짜, 요일값)
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일') FROM DUAL;


-- 다음 주 금요일이 몇 일인가요?
SELECT NEXT_DAY(NEXT_DAY(SYSDATE, '금요일'), '금요일')  AS "다음다음 금요일" FROM DUAL;
SELECT  NEXT_DAY(SYSDATE+7, '금요일') FROM DUAL;

/*
4) 변환함수
- to_date(문자열)   : 날짜로 변환가능한 문자열을 날짜타입으로 변환
- to_number(문자열) : 숫자 형태로 된 문자열을 숫자타입으로 변환

*/

SELECT '123.5', TO_NUMBER('123.5')  FROM DUAL;

SELECT 
    SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI') AS "현재 시간(중요)",
     TO_CHAR(SYSDATE, 'YYYY-Mon-DD HH:MI') AS "현재 시간",
     TO_CHAR(SYSDATE, 'YYYY-Mon-DDD HH:MI') AS "현재 시간"
FROM DUAL;

-- 숫자를 천자리 콤마, 소수 자리수 출력

SELECT TO_CHAR(123450, '999,999.00') FROM DUAL;
SELECT TO_CHAR(123450, '$999,999.00') FROM DUAL;
SELECT TO_CHAR(123450, 'L999,999.00') FROM DUAL;

-- [연습] EMPLOYEES 테이블에서 이름, 급여, 입사일을 조회
-- 출력 포맷은 급여 천자리마다 콤마, 소수점이하 3자리, 앞에 $ 기호 출력
-- 입사일 년4자리/월2자리/일2자리 (요일)

SELECT 
    FIRST_NAME, 
    TO_CHAR(SALARY, '$999,999.000') AS SALARY, 
    TO_CHAR(HIRE_DATE, 'YYYY/MM/DD (DY)') AS HIRE_DATE
FROM EMPLOYEES;

/*
5) NULL 함수
- nvl(컬럼, 데이터)           :컬럼의 데이터가 null이면 데이터값으로 출력하라는 의미
- nvl2(컬럼, 데이터1, 데이터2):컬럼이 데이터가 null이 아니면 앞, 널이면 뒤
*/

SELECT 
    FIRST_NAME, SALARY, COMMISSION_PCT, NVL(COMMISSION_PCT, 0)
FROM EMPLOYEES;

-- 커미션이 없는 사람은 0, 있는 사람은 급여*커미션

SELECT 
    FIRST_NAME, SALARY, COMMISSION_PCT, 
    NVL2(COMMISSION_PCT, SALARY*COMMISSION_PCT,  0) AS "커미션"
FROM EMPLOYEES;


-- [연습] 이름, 부서번호, 부서가 있으면 부서번호, 부서가 없으면 0
SELECT FIRST_NAME, NVL(DEPARTMENT_ID, 0) 
FROM EMPLOYEES
ORDER BY FIRST_NAME;

-- [연습] 이름, 부서번호, 부서가 있으면 부서번호, 부서가 없으면 "임시" (TO_CHAR()를 이용)
SELECT 
    FIRST_NAME, 
    NVL(TO_CHAR(DEPARTMENT_ID), '임시') AS "부서번호"
FROM EMPLOYEES
ORDER BY FIRST_NAME;

-- [연습] 사원번호, 이름, 팀장번호, 팀장이 없으면 "회장" 
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME, 
    NVL(TO_CHAR(MANAGER_ID), '회장') AS "팀장번호"
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

/*
6) 기타함수 
- swtich~case와 같은 개념의 함수
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

-- CASE~WHEN 함수로 변경
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
    TO_CHAR(HIRE_DATE, 'YYYY/MM/DD')  AS "입사일",
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 3), '월요일'), 'YYYY-MM-DD') AS "정직원 발령일",
    NVL(TO_CHAR(COMMISSION_PCT), 'N/A') "커미션"
FROM EMPLOYEES;

/*
*** 다중행 함수(그룹행 함수)
- 여러 행들이 있을 때 그룹화 시킨 행들에 함수를 적용
- 종류
  COUNT(컬럼명)
  MIN(컬럼명)
  MAX(컬럼명)
  AVG(컬럼명)
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
-- 그룹행 함수를 사용할 때 특정 컬럼을 기준으로 그룹화 시켜 결과를 조회

-- 각 부서별 팀원 수를 조회. NULL DATA는 제외
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL
ORDER BY DEPARTMENT_ID;

-- 각 부서별 팀원 수를 조회. 인원수가 1명이거나 NULL은 제외
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL 
              AND COUNT(*) != 1
ORDER BY DEPARTMENT_ID;

-- 각 부서 별 팀원 수와, 최대급여금액, 최소급여금액을 조회. 
-- 인원수가 1명이거나 NULL은 제외
SELECT DEPARTMENT_ID, COUNT(*), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL 
              AND COUNT(*) != 1
ORDER BY DEPARTMENT_ID;


-- (오류) 각 부서별 팀원 수를 조회 (그룹행 함수와 단일 컬럼은 같이 조회 불가)
SELECT DEPARTMENT_ID, FIRST_NAME, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;


-- [문제] 입사연도 별 입사인원을 조회하시오
SELECT 
    TO_CHAR(HIRE_DATE, 'YYYY') AS "입사 년도", 
    COUNT(*) AS "입사 인원"
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY  TO_CHAR(HIRE_DATE, 'YYYY');










