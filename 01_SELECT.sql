--01_SELECT.sql

/*
    음식 테이블
        음식명     칼로리     가격     인기도  양       <-컬럼명(세로), 로우(가로)
        떡볶이     500       7000     9.0    적당
        튀김       800       4000     9.5    적음
        
    음식후기 테이블
        음식명     점수      내용
        떡볶이     10      너무 맛있어요
*/

--현재 계정이 가지고 있는 테이블 확인하기
SELECT * FROM TAB;
SELECT * FROM TABS;

--테이블의 구조 살펴보기
DESC EMP;

/*
    EMPNO    : 사원번호
    ENAME    : 사원명
    JOB      : 직급
    MGR      : 해당직원 상사의 사원번호
    HIREDATE : 입사일
    SAL      : 월급
    COMM     : 보너스
    DEPTNO   : 직원이 속한 부서번호
    
    NOT NULL : 해당 컬럼에는 빈 값(NULL)이 허용되지 않는다
    
    NUMBER(4)   : 정수 4자리를 저장할 수있는 컬럼
    VARCHAR2(10): 문자열 최대길이 10을 저장하 수 있는 컬럼
    DATE        : 날짜데이터를 저장할 수있는
    NUMBER(7,2) : 소수점 
*/


--SELECT 문 : 데이터터를 조회할 때 사용하는 쿼리문
--  SELECT 컬럼명 FROM 테이블명 ;

--현재 스콧이 가진 테이블 이름 BONUS, DEPT, EMP, SALGRADE
SELECT * FROM BONUS;
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;


--컬럼명 : 표의 제목에 해당 하는 것, *를 사용하면 테이블내의 모든 컬럼을 뜻한다.
SELECT ENAME, JOB FROM EMP;
SELECT EMPNO, ENAME, SAL FROM EMP;


--1. 사원의 모든 정보를 출력하는 쿼리문을 작성
SELECT * FROM EMP;

--2. 사원의 이름과 급여와 입사일자만 출력하는 SQL작성
SELECT ENAME, SAL, HIREDATE FROM EMP; --컬럼명을 작성하는 순서대로 출력

--SELECT하면서  산술연산자 사용하기
SELECT ename, SAL + 1000 from emp;

--급여로 연봉 구하기(AS로 별칠 지정)
select ename, sal*12 AS YEAR_SAL from emp;

--보너스 계산하기
select ename, sal+comm as 보너스포함 from emp;
select * from emp;
--숫자와 NULL값을 계산하면 NULL이 된다(NULL은 ?같은 알수없는 값을 의미한다)

--null값이 나올수 있는 컬럼으로 계산하기 (NVL : NULL VALUE)
SELECT ename, sal + NVL(comm, 0) AS "월급(+보너스)" FROM emp;

--대소문자 구분 여부
--쿼리문 : 대소문자 구분 안함(select나 SELECT상관없음)
--컬럼명 : 대소문자 구분 안음 (COMM이나 comm이나 Comm상관없음)
--데이터 : 대소문자 구분 함
--보통 문법적인건 대문자를 쓰고 문법적이지 않은것은 소문자로 사용(권장사항)

--SELECT DISTINCT : 중복되는 것을 한번씩만 출력하는 키워드
SELECT DISTINCT job AS 직급 From emp;
SELECT DISTINCT deptno AS 부서번호 From emp;
SELECT DISTINCT NVL(mgr, 0) AS 매니저 From emp;

--데이터를 쉽게 관리할수 있도록 하기위해 데이터베이스를 사용