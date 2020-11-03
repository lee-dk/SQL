--06_서브쿼리.sql

--서브쿼리
    --하나의 SELECT문 안에 포함된 또 하나의 SELECT문을 쿼리라고 한다
    --서브쿼리를 포함하고 있는 쿼리를 메인쿼리라고 한다
    --비교연산자와 사용할 때는 반드시 비교연산자의 오른쪽에 기술해야한다
    --()로 둘러쌓아야한다
    
    
--EX) 서브쿼리를 이용해 KING과 같은 부서에서 근무하는 직원의 모든 정보
SELECT * FROM emp WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING');
SELECT * FROM emp a, emp b WHERE a.deptno=b.deptno AND b.ename='KING';

SELECT * FROM emp;
SELECT * FROM emp, dept WHERE emp.deptno=dept.deptno;
--연습문제 : SMITH와 같은 부서에서 근무하는 직원의 이름과 부서번호를 조회
SELECT ename, deptno FROM emp WHERE deptno=(SELECT deptno FROM emp WHERE ename='SMITH');
SELECT a.ename, a.deptno FROM emp a, emp b WHERE a.deptno=b.deptno AND b.ename='SMITH';
--연습문제 : SMITH와 동일한 직급을 사진 사원정보를 모두 출력
SELECT * FROM emp WHERE job=(SELECT job FROM emp WHERE ename='SMITH'); -- AND ename<>'SMITH';
SELECT a.* FROM emp a, emp b WHERE b.ename='SMITH' AND a.job=b.job;
--연습문제 : MARTIN의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여를 출력
SELECT ename, sal FROM emp WHERE sal>=(SELECT sal FROM emp WHERE ename='MARTIN');
SELECT a.ename, a.sal FROM emp a, emp b WHERE b.ename='MARTIN' AND a.sal>=b.sal;
--연습문제 : DALLAS에서 근무하는 사원의 이름과 부서번호를 출력
SELECT ename, deptno FROM emp WHERE deptno=(SELECT deptno FROM dept WHERE loc='DALLAS');
SELECT ename, e.deptno FROM emp e, dept d WHERE e.deptno=d.deptno AND loc='DALLAS';

--여태까지는 서브쿼리의 결과가 단 한줄만 나오도록 사용했다
--결과가 한 줄만 나오는 서브쿼리를 '단일 행 서브쿼리(SINGLE Row)라고 한다
--단일행 서브쿼리는 그룹함수와 사용하면 더욱 안전하다

--평균월급보다 월급을 많이 받는 사원들의 정보
SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp);

--다중 행(Multi Row) 서브쿼리는 반드시 다중행 연산자와 함께 사용해야한다
    --IN(), ANY, ALL, EXISTS...
    
--IN : 여러 값들 중 하나라도 일치하면 TRUE
--ex)월급이 3000이상인 사원이 소속된 부서와 동일한 부서에서 근무하는 사원
SELECT * FROM emp WHERE deptno IN (SELECT DISTINCT deptno FROM emp WHERE sal>=3000);

--ALL : 괄호안에 여러 값들을 이용한 비교가 모두 참이어야 TRUE
--EX)직급이 SALESMAN인 모든 사람들 보다 급여를 많이 받는 사람들 조회
SELECT * FROM EMP WHERE sal > ALL(SELECT sal FROM emp WHERE job='SALESMAN');
SELECT * FROM EMP WHERE sal > (SELECT MAX(sal) FROM emp WHERE job='SALESMAN');

--ANY : 괄호안의 여러값들을 이용한 비교중 하나만 만족해도 TRUE
--EX)직급이 SALESMAN인 모든 사람들중 가장 적게 받는 사람보다 보다 급여를 더 많이 받는 사람
SELECT * FROM EMP WHERE sal > ANY(SELECT sal FROM emp WHERE job='SALESMAN');
SELECT * FROM EMP WHERE sal > (SELECT MIN(sal) FROM emp WHERE job='SALESMAN');

--EXISTS : 서브쿼리의 결과가 존재하면 TRUE
--EX)소속된 사원이 존재하는 부서정보만 출력
SELECT * FROM dept WHERE EXISTS (SELECT * FROM emp WHERE emp.deptno=dept.deptno);
SELECT * FROM dept WHERE NOT EXISTS (SELECT * FROM emp WHERE emp.deptno=dept.deptno);

SELECT * FROM emp;
SELECT ROUND(AVG(sal),2), deptno FROM emp GROUP BY deptno;
--연습문제 : 부서별로 가장 급여를 많이 받는 사원의 이름/급여/부서번호 출력_다중열(Multi Column) 서브쿼리
SELECT ename, sal, deptno FROM emp WHERE (sal, deptno) IN (SELECT MAX(sal), deptno FROM emp GROUP BY deptno);
    --연습문제 : 부서별로 평균보다 많이 받는 사원의 이름과 급여/ 부서번호 출력
    SELECT 
        a.ename, a.sal, a.deptno 
    FROM 
        emp a, (SELECT ROUND(AVG(sal),2) AS avgsal, deptno FROM emp GROUP BY deptno) B 
        --테이블 자리에 서브쿼리를 잠시 사용할 테이블(VIEW)를 생성 : INLINE-VIEW
    WHERE 
        b.deptno=a.deptno AND a.sal > b.avgsal;
--연습문제 : 30번 부서 소속의 모든 사원들 보다 급여를 더 많이 받는 사람의 정보 출력
SELECT * FROM emp WHERE sal > ALL(SELECT sal FROM emp WHERE deptno=30);
--연습문제 : 모든 SALESMAN들 중 적어도 한명의 급여+보너스 금액보다 급여를 더 많이받는 사원의 정보 출력
SELECT * FROM emp WHERE sal > ANY(SELECT sal+NVL(comm,0) FROM emp WHERE job='SALESMAN');
