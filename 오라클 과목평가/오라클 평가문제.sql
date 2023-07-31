-- 2023년 5월 9일 시험문제 

-- 1. 제약조건 5가지를 쓰시오. (5점)
Unique, Not Null, Primary Key, Check, Foreign Key

-- 2. 기본키가 가지고 있는 기본 제약조건 2가지는 무엇인가? (5점)
Unique, Not Null

-- 3. 부모테이블과 자식테이블 간의 관계를 맺기 위해서 사용하는 제약조건은 무엇인가? (5점)
Foreign Key

-- 4. HR 계정의 기본 제공 테이블 이용하여 도시별 사원 수를 다음과 같이 출력하시오. (10점)
SELECT CITY "도시명", COUNT(*) "인원수"
FROM EMPLOYEES  JOIN DEPARTMENTS 
USING (DEPARTMENT_ID)
JOIN LOCATIONS 
USING (LOCATION_ID)
GROUP BY CITY;

-- 5. 프로그램 실행 날짜를 기준으로 근무한 기간이 16년 미만인 사원들의 이름과 입사일을 입사일 기준으로 오름차순하여 출력하시오. (5점)
 
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE (SYSDATE-HIRE_DATE)/365 < 16
ORDER BY 3;

?
-- 6. 사원별로 이름과, 급여, 부서번호 및 자신 부서의 평균 급여를 조회하시오. (평균급여는 소수점 2자리까지 출력) (10점)
SELECT FIRST_NAME "이름", LAST_NAME "성", SALARY "급여", DEPARTMENT_ID "부서번호",  "부서 평균 급여"
FROM EMPLOYEES OUTER JOIN 
    (SELECT DEPARTMENT_ID, TO_CHAR(ROUND(AVG(SALARY), 2), '9999,999.99')  AS "부서 평균 급여"
     FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID) tbl
USING (DEPARTMENT_ID);


-- 7. 사원번호, 업무 기간, 업무명이 출력되도록 하시오. JOB_HISTORY, JOBS 테이블 사용 (5점)
 
SELECT j.EMPLOYEE_ID "사원번호",
       trunc((j.END_DATE - j.START_DATE)/365)||'년 ' ||
       trunc(((j.END_DATE-j.START_DATE)/365-trunc((j.END_DATE-j.START_DATE)/365) )*10)||'개월' as "업무기간", 
       js.JOB_TITLE "업무명"
FROM JOB_HISTORY j JOIN JOBS js
ON j.JOB_ID = js.JOB_ID ;


SELECT j.EMPLOYEE_ID "사원번호",
       trunc(months_beween(j.END_DATE, j.START_DATE)/12)||'년 ' ||
       trunc(((j.END_DATE-j.START_DATE)/365-trunc((j.END_DATE-j.START_DATE)/365) )*10)||'개월' as "업무기간", 
       js.JOB_TITLE "업무명"
FROM JOB_HISTORY j JOIN JOBS js
ON j.JOB_ID = js.JOB_ID ;


-- 8. 2023년 7월 19일이 수료일이라고 했을 때 오늘 날짜로부터 몇일 남았는지 출력하는 SQL문장을 작성하시오. (5점)
 
SELECT CEIL(TO_DATE('23/07/19')-SYSDATE) "남은 일수" FROM DUAL;


-- 9. 각 부서별 평균 근무일을 아래와 같이 조회하시오. (10점)
SELECT DEPARTMENT_NAME "부서명", CEIL(AVG(SYSDATE-HIRE_DATE)) "평균 근무일"
FROM EMPLOYEES JOIN DEPARTMENTS
USING (DEPARTMENT_ID)
GROUP BY DEPARTMENT_NAME
ORDER BY 2 DESC;

-- 10. Employees 테이블에서 매니저가 같은 사원들의 평균급여가 4000이상인 사원의 평균급여, 최대급여, 최소급여를 그림과 같이 출력하시오. 단, 매니저번호가 없는 사원은 0번으로 출력하고, 소수점 이하 올림하시오.(10점)
 
SELECT 
    NVL(MANAGER_ID, 0) "매니저번호"
    , CEIL( AVG(SALARY)) "평균급여"
    , MAX(SALARY) "최대급여"
    , MIN(SALARY) "최소급여"
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING CEIL( AVG(SALARY)) >= 4000
ORDER BY 1;

-- ※ 다음은 문구를 취급하는 대형 문구사 재고정보를 관리하는 테이블이다. 주어진 조건의 테이블과 시퀀스를  
--    생성하시오. (테이블을 생성하면서 제약조건을 부여할 것.) 

-- 11. 테이블명: Categories (제품 카테고리) (10점)
CREATE TABLE categories (
    CATEGORY_ID CHAR(7) PRIMARY KEY 
  		 CHECK(CATEGORY_ID IN ('WR_PROD', 'PA_PROD', 'AR_PROD', 'ME_PROD', 'ET_PROD' )),
    CATEGORY_NAME VARCHAR2(30) UNIQUE 
 		CHECK(CATEGORY_NAME IN ('필기구', '종이류', '미술용품', '측정용품', '기타')),
    CATEGORY_DESC VARCHAR2(3000)
);

-- 12. 테이블명: Products (제품) (5점)
CREATE TABLE products
(
    PROD_ID         NUMBER PRIMARY KEY,
    PROD_NAME       VARCHAR2(30) NOT NULL,
    COUNTRY         VARCHAR2(50) NOT NULL,
    MANUFACTURES    VARCHAR2(50) NOT NULL,
    MAKING_DATE     DATE,
    CATEGORY_ID     REFERENCES categories(CATEGORY_ID) 
);

-- 13. 시퀀스 : Products_seq (제품 테이블의 시퀀스 객체 : 100부터 시작하여 50씩 증가하도록 설정) (5점)
CREATE SEQUENCE products_seq
START WITH 100
INCREMENT BY 50;


-- 14. 테이블명: Stock (재고) (5점)
CREATE TABLE STOCK (
    STOCK_ID    	NUMBER PRIMARY KEY,
    PROD_ID     	NUMBER  REFERENCES  products(PROD_ID) ON DELETE CASCADE,
    RECEIVE_DATE 	DATE,
    FORWARD_DATE 	DATE DEFAULT SYSDATE, 
    UNIT_PRICE 	NUMBER(10, 2) DEFAULT 0,
    TOTAL_STOCK 	NUMBER(7) DEFAULT 0
);

-- 15. 시퀀스 : Stock_seq (재고 테이블의 시퀀스 객체) (5점)
CREATE SEQUENCE STOCK_SEQ;


