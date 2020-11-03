--07_CREATE TABLE.sql

/*
    CREATE TABLE 테이블명 (
        컬럼명1 컬럼타입 (제약조건),
        컬럼명2 컬럼타입,
        컬럼명3 컬럼타입,
        ...
    );
*/
--컬럼타입의 종류
/*
    NUMBER(길이) : 정수 (EX: NUMBER(7)은 7자리 정수)
    NUMBER(길이, 소수점 자릿수) : 정수 (EX: NUMBER(7,2)는 정수5자리, 소수2자리)
    CHAR(크기)                : 고정길이 문자데이터(입력된 자료길이와 상관없이 정해진 길이를 차지하는 타입)_잘 사용하지 않음
    VARCHAR2(크기)            : 가변 길이 문자 데이터. 실제 입력된 문자길이 만큼만 공간을 차지하는 타입
    DATE               : 날짜를 저장 할 수있는 타입
    TIMESTAMP       : 밀리세컨드까지 저잘할 수 있는 타입
*/
DESC emp;

--테이블 생성 예 : 회원 테이블
CREATE TABLE MY_MEMBER (
    MEM_NO NUMBER(10),
    MEM_NAME VARCHAR(20),
    MEM_AGE NUMBER(3),
    JOINDATE DATE DEFAULT SYSDATE --DEFAULT : 기본값 설정
);
DESC MY_MEMBER;

--테이블 삭제 명령어
DROP TABLE MY_MEMBER;

--기존 테이블 복사해서 생성하기_원본 보존용(테스트 용)
--제약조건도 함께 복사되지는 않는다(NOT, NULL..)
CREATE TABLE emp02 AS SELECT * FROM emp;
CREATE TABLE emp03 AS SELECT * FROM emp WHERE deptno IN(20,30);
CREATE TABLE emp04 AS SELECT empno, ename, sal FROM emp;

SELECT * FROM EMP02;
SELECT * FROM EMP03;
SELECT * FROM EMP04;

DROP TABLE EMP02;
DROP TABLE EMP03;
DROP TABLE EMP04;


SELECT * FROM MY_MEMBER;
DESC MY_MEMBER;
--테이블 컬럼 수정 명령어
--ALTER TABLE 테이블명 [ADD|MODIFY|DROP COLUMN] (컬럼명1, 컬럼명2,...)
ALTER TABLE MY_MEMBER ADD (TEST NUMBER(5));
ALTER TABLE MY_MEMBER ADD (TEST2 NUMBER(5), TEST3 VARCHAR(50));

--MODIFY : 컬럼 타입 변경(컬럼명 수정은 X)
ALTER TABLE MY_MEMBER MODIFY (TEST NUMBER(7));
ALTER TABLE MY_MEMBER MODIFY (TEST DATE);

--DROP COLUMN : 컬럼 삭제
ALTER TABLE MY_MEMBER DROP COLUMN TEST;
ALTER TABLE MY_MEMBER DROP COLUMN TEST2;
ALTER TABLE MY_MEMBER DROP COLUMN TEST3;

--메타 데이터 : 데이터에 대한 데이터 (테이블 정보, 컬럼 정보, ..)
    --우리가 관리하지않고 DB가 알아서 추가/삭제하며 관리하는 테이블
SELECT * FROM TAB;--알아보기 힘듦

SELECT * FROM TABS;
SELECT * FROM USER_TABLES; --USER_TABLE도 메타 데이터
SELECT * FROM USER_SEQUENCES;  --유저 시퀀스 정보
SELECT * FROM USER_INDEXES; --유저 인텍스 정보
SELECT * FROM USER_CONSTRAINTS; --유저 제약조건 정보

--현재 유저가 누구인지 구경하기
SHOW USER;

SELECT * FROM ALL_TABLES; --USER_TABLE도 메타 데이터
SELECT * FROM ALL_SEQUENCES;  --모든 유저 시퀀스 정보
SELECT * FROM ALL_INDEXES; --모든 유저 인텍스 정보
SELECT * FROM ALL_CONSTRAINTS; --모든 유저 제약조건 정보

DESC MY_MEMBER;
--SET UNUSED : 컬럼을 삭제하는 대신 잠깐 사용하지 않게 설정하기
ALTER TABLE MY_MEMBER SET UNUSED(TEST);
ALTER TABLE MY_MEMBER SET UNUSED(TEST2);
ALTER TABLE MY_MEMBER SET UNUSED(TEST3);

--여유있는 시간에 UNUSED처리된 컬럼들을 삭제한다
ALTER TABLE MY_MEMBER DROP UNUSED COLUMNS;



--숙제 : 테이블 짜오기
--현실에 있을법한 데이터(배달, 회원관리, 게시글 등등)
CREATE TABLE HEALTH_MEMBER (
    MEM_NO NUMBER(10),
    MEM_NAME VARCHAR(20),
    MEM_AGE NUMBER(3),
    JOINDATE DATE DEFAULT SYSDATE, --DEFAULT : 기본값 설정
    MEM_INBODY NUMBER(3),
    MEM_JOINMONTH NUMBER(2)
);
DESC HEALTH_MEMBER;
SELECT * FROM HEALTH_MEMBER;
