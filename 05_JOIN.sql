--05_JOIN.sql

--JOIN : 관계를 맺은 두 테이블을 엮어서 원하는 정보를 조회하는 것

SELECT * FROM emp;  --직원 정보 테이블
SELECT * FROM dept; --부서 정보 테이블 (deptno:부서번호/dname:부서명/loc:지역)

--CROSS JOIN : 두 테이블의 모근 경우의 수를 조회하는 조인(의미있는 데이터를 찾기 전의 과정)
SELECT * FROM emp, dept;
--CROSS JOIN만으로는 아무의미 없다
--JOIN결과가 의미를 가지기 위해서는 CROSS JOIN의 결과에 조건을 지정해야한다
SELECT ename, emp.deptno, dept.deptno, dname, dept.loc FROM emp, dept;
--컬럼명이 겹치는 경우 어느 테이블의 컬럼명인지 명확하게 적어줘야한다.

--EQUI JOIN : 동일 컬럼을 기준으로 조인한다
SELECT * FROM emp, dept WHERE emp.deptno=dept.deptno;   --동일 컬럼을 기준으로 하지않으면 

--EX)이름이 MARTIN인 사람위 이름/부서명을 조회 하고 싶을 때
SELECT emp.ename, dept.dname FROM emp, dept WHERE emp.deptno=dept.deptno AND emp.ename='MARTIN';


--연습문제 : 뉴욕에 근무하는 직원의 이름과 급여를 조회 
SELECT ename, sal FROM emp, dept WHERE emp.deptno=dept.deptno AND loc='NEW YORK';
--연습문제 : SALES부서 소속인 직원의 이름과 입사일을 조회
SELECT ename, hiredate FROM emp, dept WHERE emp.deptno=dept.deptno AND dname='SALES';
--연습문제 : 직급이 MANAGER인 직원의 이름/부서번호/부서명/지역을 조회
SELECT ename, emp.deptno, dname, loc FROM emp, dept WHERE emp.deptno=dept.deptno AND job='MANAGER';
SELECT 
    ename, e.deptno, dname, loc 
FROM 
    emp e, dept d --테이블명에 별칭을 부여할 수 있다
WHERE 
    e.deptno=d.deptno AND job='MANAGER';

--NON-EQUI JOIN : 값이 동일하지 않은 컬럼으로 두 테이블을 조인한다

SELECT * FROM salgrade;
SELECT emp.*, g.grade FROM emp, salgrade g WHERE emp.sal BETWEEN losal AND hisal;

--SELF JOIN : 테이블 하나로 조인하는 것(자기 자신과 조인)   (a하나에 b 12개씩..)*12

--직원들의 정보와 매니저이름을 함께 조회
SELECT a.*, b.* FROM emp a, emp b;
--a테이블의 mgr컬럼과 b테이블의 empno컬럼이 일치한다면 b는 a의 매니저이다
SELECT a.*, b.ename FROM emp a, emp b WHERE a.mgr=b.empno;


SELECT a.*, b.* FROM emp a, emp b WHERE a.mgr=b.empno;
--연습문제 : 매니저가 KING인 직원들의 이름과 직급 출력
SELECT a.ename, a.job FROM emp a, emp b WHERE a.mgr=b.empno AND b.ename='KING';
--연습문제 : ALLEN과 동일한 근무지(depno)에서 근무하는 직원의 이름을 출력
SELECT a.ename FROM emp a, emp b WHERE b.ename='ALLEN' AND a.deptno=b.deptno;

--OUTER JOIN : 조건을 만족시키지 못해 조회되지 않는 정보도 함께 조회하고 싶을 때 사용하는 조인
SELECT * FROM emp a, emp b WHERE a.mgr=b.empno; --KING이 안나옴 (KING은 mgr이 NULL이라..)
-- 조인 조건을 한번도 만족시키지 못해서 등장하지 못한 행을 (+)를 붙인 쪽에 NULL을 붙여서라도 보여준다
SELECT * FROM emp a, emp b WHERE a.mgr=b.empno(+);  --매니저가 없어서 조회되지 않던 행에 NULL을 추가해서 조회

SELECT * FROM emp a, emp b WHERE a.mgr(+)=b.empno;  --관리하는 직원이 없어서 조회되지 않던 행에 NULL로 관리하는 직원을 추가해줘서 조회

--(+) : 조인에 사용된 테이블 중 어느쪽 테이블에 NULL을 추가해서 조회할 것인지를 결정한다.

SELECT * FROM emp;
SELECT * FROM dept;
--연습문제 : EMP테이블과 DEPT테이블을 조인하여 사원명/부서번호/부서명을 출력하고
--          사원이 한명도 없는 부서도 출력 되도록 하기
SELECT ename AS 사원명, e.deptno AS 부서번호, dname AS 부서명 FROM emp e, dept d WHERE e.deptno(+)=d.deptno;

--미국 표준에 따른 각 조인의 사용법

--1. CROSS JOIN
SELECT * FROM emp, dept;
SELECT * FROM emp CROSS JOIN dept;  --ANSI

--2. INNER JOIN (EQUI, SELF, NON-EQUI JOIN)
    --조건에 맞는 행만 보여주는 조인
SELECT * FROM emp, dept WHERE emp.deptno=dept.deptno;
SELECT * FROM emp INNER JOIN dept ON emp.deptno=dept.deptno;    --ANSI
SELECT * FROM emp INNER JOIN dept USING (deptno);       --ANSI
SELECT * FROM emp a INNER JOIN emp b ON a.mgr=b.empno;  --ANSI SELF
SELECT * FROM emp INNER JOIN salgrade ON sal BETWEEN losal AND hisal;

--3. NATURAL JOIN(동일한 이름의 컬럼으로 INNER JOIN을 하는 경우) 알아서 동일한 컬럼은 찾아줌
SELECT * FROM emp NATURAL JOIN dept;

--4. OUTER JOIN(LEFT | RIGHT | FULL)
    --조건에 맞지않는 행도 보여주는 조인
    
--RIGHT OUTER JOIN : 오른쪽 테이블에서 안나온 정보를 왼쪽 테이블에 (+)해서 보고싶을 때
SELECT * FROM emp RIGHT OUTER JOIN dept USING (deptno);
--LEFT OUTER JOIN : 왼쪽 테이블에서 안나온 정보를 오른쪽 테이블에 (+)해서 보고싶을 때
SELECT * FROM emp LEFT OUTER JOIN dept USING (deptno);
--FULL OUTER JOIN : 양쪽에 (+)를 다 붙인 경우
SELECT * FROM emp FULL OUTER JOIN dept USING (deptno);
SELECT * FROM emp a FULL OUTER JOIN emp b ON a.mgr=b.empno;

