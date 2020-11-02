--04_GROUP.sql

--GROUP 함수 : 하나이상의 행을 그룹으로 묶어연산할 수 있다
--      SUM, AVG, COUNT, MAX, MIN ...

SELECT * FROM EMP;
--SUM함수로 급여의 총합 구하기
SELECT SUM(sal) FROM EMP;

--SUM함수로 보너스의 총합 구하기
SELECT SUM(comm) FROM EMP;

--avg함수로 급여의 평균 구하기
SELECT AVG(sal) FROM EMP;

--MAX()로 최대 급여 구하기
SELECT MAX(sal) FROM EMP;

--MIN()로 최소 급여 구하기
SELECT MIN(sal) FROM EMP;

--COUNT() : 결과의 갯수를 계산해준다
SELECT COUNT(*) AS "모든사원" FROM EMP;

--NULL은 횟수에서 제외한다
SELECT COUNT(comm) FROM EMP;

--COUNT내부에 DISTINCT를 활용해 중복을 제거한 개수를 셀 수 있다
SELECT COUNT(DISTINCT job) FROM EMP;

--연습문제 : 가장 최근에 입사한 직원의 입사일과 가장 오래된 직원의 입사일을 출력
SELECT MAX(hiredate) AS "최근 입사 직원", MIN(hiredate) AS "오래된 직원" FROM EMP;

--연습문제 : 10번 부서 직원들 중에 보너스를 받는 직원의 수를 출력
SELECT  COUNT(comm) FROM EMP WHERE deptno=10 AND comm<>0;

--GROUP BY절 : 그룹을 묶어 그룹별로 그룹함수를 적용하기 위한 문법

SELECT * FROM EMP;
--GROUP BY deptno : EMP테이블의 모든 행을 deptno기준으로 그룹짓는다
--그룹을 지으면 그룹지을때 사용했던 컬럼과 그룹함수의 결과만 출력할 수 있다.
--즉, 각 그룹별로 하나로 취합될 수 있는 결과만 GROUP BY와 함께 사용할 수 있다

--각 부서별 최대 월급 출력
SELECT deptno, MAX(sal) FROM EMP GROUP BY deptno;

--동명이인 중 가장 돈을 많이 받는 사람
SELECT ename, MAX(sal) FROM EMP GROUP BY ename;

--각 직급별 최소 월급
SELECT job, MIN(sal) FROM EMP GROUP BY job;




--연습문제 : 소속 부서별로 평균 급여 출력 ROUND(결과 ,소수점 )
SELECT deptno AS "부서 번호", ROUND(AVG(sal),2) AS "평균 급여" FROM EMP GROUP BY deptno;


--HAVING절 : GROUP BY의 결과에 조건을 부과하고 싶을 경우 사용
--EX) 부서별로 평균 급여를 조회 하되, 평균급여가 2000이상인 그룹만 조회
SELECT 
    deptno AS "부서 번호", 
    ROUND(AVG(sal),2) AS "평균 급여" 
FROM EMP 
GROUP BY deptno 
HAVING AVG(sal) >= 2000;

--연습문제 : 부서별 최소 월급을 출력하되 최소 급여가 1000이하인 부서만 출력
SELECT 
    deptno AS "부서 번호", 
    ROUND(MIN(sal),2) AS "최소 급여" 
FROM EMP 
GROUP BY deptno 
HAVING MIN(sal) <= 1000;





