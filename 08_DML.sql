--08_DML.sql

--DDL (Data Definition Language) : 테이블 생성/수정/삭제
--DML (Data Manioulation Language) : 데이터 생성/수정/삭제/조회

--CRUD : 모든 프로그램에 존재하는 필수적인 기능
 --Create    : 데이터 생성(INSERT)
 --Read      : 데이터 조회(SELECT)
 --Update    : 데이터 수정(UPDATE)
 --Delete    : 데이터 삭제(DELETE)

--INSERT : 테이블에 새로운 데이터 생성(추가, 삽입)
    --INSERT INTO 테이블명 (컬럼1, 컬럼2, ...) VALUE(값1, 값2, ...);
SELECT * FROM MY_MEMBER;
--가장 기본적인 형태의 INSERT
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME, MEM_AGE, JOINDATE) VALUES (1, '홍길동', 10, '20/07/02');
--컬럼의 순서가 바뀌면 VALUES의 순서도 바꿔서 넣어야한다.
INSERT INTO MY_MEMBER(MEM_NAME, MEM_AGE, JOINDATE, MEM_NO) VALUES('테스트1', 13, '19/05/04', 2);
--모든 컬럼을 순서대로 추가할 때는 컬럼묭을 생략해도 된다
INSERT INTO MY_MEMBER VALUES(3, '테스트2', 15, '13/07/07');
--NOT NULL로 설정한 컬럼이 아닐하면 값을 넣지 않을 수도 있다
--컬럼의 개수와 VALUES의 개수가 차이나면 에러가 발생한다)
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME) VALUES(4, '테스트3');  --누락된 컬럼은 자동으로 NULL이 대입된다
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME) VALUES(NULL, 'test01'); --원한다면 NULL을 대입할 수도 있다
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME) VALUES(7, '');      --''를 붙여서 데이터를 추가하면 NULL이 된다

INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME, MEM_AGE) VALUES(4, '테스트4', 9);

--서브쿼리로 데이터 추가(테스트에 많이 사용함)
INSERT INTO MY_MEMBER SELECT * FROM MY_MEMBER;




--UPDATE : 테이블 데이터 수정
--UPDATE 테이블명 SET 컬럼1 = VALUE1, 컬럼2 = VALUE2, ... WHERE 조건;
-- * 조건을 설정하지 않으면 모든 행이 수정된다 *

COMMIT; --현재까지 DML로 인해 수정된 테이블 상황을 확정짓는다 (DDL은 COMMIT과 ROLLBACK이 적용 되지 않는다)

SELECT * FROM MY_MEMBER;
UPDATE my_member SET mem_name='고길동', mem_no=10, mem_age=45, joindate='08/11/30';

ROLLBACK;

UPDATE my_member SET mem_name='고길동' WHERE mem_name='홍길동';   
--조건을 붙여서 원하는 값만 변경(홍길동이라는 이름을 고길동으로 변경)여러 행을 변경 하려면 WHERE전에 쉼표를 붙이고 하면 됨

--**테이블에는 하나의 행(Row)을 유일하게 구분 할 수 있는 컬럼이 필요하다
    --그런 컬럼이 없다면, 같은 값을 지닌 모든 행이 수정되거나 삭제되어버린다 **
    
-- 테이블의 하나의 행을 식별해 줄 수있는 컬럼을 기본키(PRIVATE KEY, PK)라고 한다
    --기본키가 되기위한 컬럼의 조건
     --1. 중복이 없어야 한다 (UNIQUE)
     --2. NULL이 없어야 한다 (NOT NULL)

--키의 종류
    --슈퍼 키 : 키가 될 수 있는 모든 컬럼의 조합
            -- EX) [이름, 이메일], [이메일], [이름, 전화번호]..
    --복합 키 : 2개 이상의 컬럼을 사용한 키
    --후보 키 : 기본 키가 될 수 있는 후보인 컬럼
    --기본 키(Private Key) : 후보 키 중에서 선택된 키
    --대체 키 : 후보 키 중에서 선택되지 않은 키
    --외래 키(Foreign Key) : 다른 테이블에서는 기본 키(혹은 UNIQUE만 만족)이지만 
 --                                     이 테이블에서는 중복을 허용하는 컬럼. 다른 테이블의 기본키 컬럼을 반드시 참조해야한다.
 --           EX) EMP테이블에서 DEPTNO은 외래키, DEPT테이블에서 DEPTNO는 기본키.
 --                 EMP테이블에 새로운 행을 추가 할 때, DEPT테이블의 DEPTNO에 없는 부서번호는 사용할 수 없다



SELECT * FROM emp02;

--연습문제1 : EMP테이블을 복사하여 EMP02테이블을 생성
CREATE TABLE emp02 AS SELECT * FROM emp;
--연습문제2 :  부서번호가 10번인 사원들의 부서번호를 40번으로 변경
UPDATE emp02 SET deptno=40 WHERE deptno=10;
--연습문제3 : 급여가 3000이상인 사원들의 급여를 10%인상
UPDATE emp02 SET sal=sal*1.1 WHERE sal>=3000;
--연습문제4 : 1981년에 입사한 사원들의 입사일을 오늘로 수정
UPDATE emp02 SET hiredate=SYSDATE WHERE hiredate LIKE '81%';
--연습문제5 : 
COMMIT;


--DELETE : 테이블 데이터 삭제
    --DELETE FROM 테이블명 WHERE 조건;
--*** 조건을 지정하지 않으면 모든 행이 삭제된다 ***
DELETE FROM emp02;
SELECT * FROM emp02;
ROLLBACK;


--emp02테이블에서 COMM을 받지 않는 사원을 삭제(NULL을 삭제 하려면 comm=NULL 은 실행X)
DELETE FROM emp02 WHERE comm IS NULL;
ROLLBACK;






