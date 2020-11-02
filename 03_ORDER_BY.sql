--03_ORDER_BY


--ORDER BY절 : SELECT의 결과를 원하는 컬럼의 기준으로 정렬할 수 있다
--      ASC  : ASCENDING, 오름차순, 작은값이 먼저나온다
--      DESC : DESCENDING, 내림차순, 큰 값이 먼저나온다
--                   오름차순        /       내림차순
--   날짜     더 오래된 정보가 먼저    /   최근 날짜가 먼저
--   숫자         작은값 먼저         /    큰 값 부터
--   문자         A to Z             /    Z to A
--   NULL       가장 마지막에 나옴     /    가장 먼저 나옴

--ASC는 생략이 가능하다(ORDER BY의 기본값은 오름차순(ASC)이다)
SELECT * FROM EMP ORDER BY SAL ASC;
SELECT * FROM EMP ORDER BY SAL DESC;

SELECT * FROM EMP ORDER BY ename;
SELECT * FROM EMP ORDER BY ename DESC;

SELECT * FROM EMP ORDER BY hiredate ASC;
SELECT * FROM EMP ORDER BY hiredate DESC;

SELECT * FROM EMP ORDER BY comm ASC;
SELECT * FROM EMP ORDER BY comm DESC;

--정렬기준 여러개 두기
--EX) 부서번호기준으로 먼저 정렬한 뒤 부서원들은 이름순으로 정렬
SELECT * FROM EMP ORDER BY deptno ASC, ename ASC;

SELECT * FROM EMP;
--연습문제 : 사원번호/사원이름/직급/입사일을 최근 입사한 순서대로 출력
SELECT empno,ename,job,hiredate FROM EMP ORDER BY hiredate DESC;
--연습문제 : 모든 사원정보를 직급기준으로 오름차순으로 출력하되, 같은 직급인 경우 월급을 많이 받는 순으로 정렬하여 출력
SELECT * FROM EMP ORDER BY job, sal DESC;