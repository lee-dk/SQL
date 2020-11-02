-- 02_WHERE.sql

-- WHERE절 : 데이터를 조회할 때 조건을 지정할 수 있다
-- SELECT 컬럼 FROM 테이블 WHERE 조건;

/*

    = : 같다
    !=, <>, ^= : 다르다
    >, <, >=, <= :비교

*/


SELECT * FROM emp;
SELECT * FROM emp WHERE sal = 1600;

--월급이 1600이 아닌 직원 조회
SELECT * FROM emp WHERE sal != 1600;
SELECT * FROM emp WHERE sal <> 1600;
SELECT * FROM emp WHERE sal ^= 1600;    -- !=, <>, ^= 같은 뜻

--월급이 1600 이상, 이하인 직원 조회
SELECT * FROM emp WHERE sal >= 1600;
SELECT * FROM emp WHERE sal <= 1600;

--문자 혹은 날짜 데이터도 크기 비교가 가능하다
SELECT * FROM emp WHERE ename >= 'D';
SELECT * FROM emp WHERE ename >= 'M';
SELECT * FROM emp WHERE hiredate < '81/05/05';  --날짜크기가 더 작다는 것은 오래됐다
SELECT * FROM emp WHERE hiredate >= '81/05/05';  --날짜크기가 더 크다는 것은 최신이다

--연습문제 : 급여가 1500이하인 사원의 사원번호/사원이름/급여 출력
SELECT empno,ename,sal FROM emp WHERE sal <= 1500;

--연습문제 : 사원이름이 'MARTIN'인 사원의 사원번호/이름/급여를 출력
SELECT empno,ename,sal FROM emp WHERE ename = 'MARTIN';

--AND, OR, NOT
SELECT * FROM emp;
--급여가 1500이상이고 직급이 'salesman'인 사원 조회
SELECT * FROM emp WHERE sal  >= 1500 AND job = 'SALESMAN';
--10번 부서에 속하지 않은 직원 조회
SELECT * FROM emp WHERE NOT deptno = 10;
--급여가 2천이상 3천이하인 직워 조회
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 3000;
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;

--이름이 'A'보다 크고 'D'보다 작은 사원 조회
SELECT * FROM emp WHERE ename BETWEEN 'A' AND 'D';

--IN (A, B,C, ...)
--EX) 급여가 800이거나 1600이거나 2850인 직원 조회
SELECT * FROM emp WHERE sal = 800 OR sal=1600 OR sal=2850;
SELECT * FROM emp WHERE sal IN(800, 1600, 2850);

SELECT * FROM emp;
--연습문제 : 사원번호가 7521이거나 7654이거나 7844인 직원의 사원번호/이름/고용일을 출력
SELECT empno,ename,hiredate FROM emp WHERE empno IN(7521, 7654, 7844);

--연습문제 : 사원번호가 7521도 아니고 7654도 아니고 7844도 아닌 사원 조회
SELECT * FROM emp WHERE empno!=7521 AND empno!=7654 AND empno!=7844;
SELECT * FROM emp WHERE empno NOT IN(7521, 7654, 7844);

--LIKE 연산자와 와일드카드
--  _ : 하나의 문자자가 아무거나 와도 된다
--  % : 하나 이상의 문자가 아무거나 비어있어도되고 아무문자가 와도 된다

--이름에 'E'가 들어가는 직원을 조회
SELECT * FROM emp WHERE ename LIKE '%E%';
--뒤에서 두 번째 글자가 E인 사원을 조회
SELECT * FROM emp WHERE ename LIKE '%E_';
--앞에서 두 번째 글자가 L인 사원을 조회
SELECT * FROM emp WHERE ename LIKE '_L%';
--앞에서 세 번째 글자가 L인 사원을 조회
SELECT * FROM emp WHERE ename LIKE '__L%';

--연습문제 : 이름이 K로 시작하는 직원의 사원번호/이름 조회
SELECT empno,ename FROM emp WHERE ename LIKE 'K%';
--연습문제 : 이름에 K가 들어가는 직원의 사원번호/이름 조회
SELECT empno,ename FROM emp WHERE ename LIKE '%K%';
--연습문제 : 이름이 K로 끝나는 직원의 사원번호/이름 조회
SELECT empno,ename FROM emp WHERE ename LIKE '%K';
--연습문제 : 이름에 K가 안들어가는 직원의 사원번호/이름 조회
SELECT empno,ename FROM emp WHERE ename NOT LIKE '%K%';

--보너스가 NULL인 사람 조회
SELECT * FROM emp WHERE comm=NULL;
--NULL은 비교연산자로 비교 불가능
SELECT * FROM emp WHERE comm IS NULL;
--보너스가 NULL이 아닌 사람 조회
SELECT * FROM emp WHERE comm IS NOT NULL;

--매니저가 없는 직원 조회
SELECT * FROM emp WHERE mgr IS NULL;