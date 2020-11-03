--10_CONSTRAINT.sql

-- 제약조건 : 테이블에 부적절한 자료가 입력되는 것을 방지하기 위해 컬럼마다 정의 하는 규칙
    --NOT NULL : NULL을 허용하지 않는다
    --UNIQUE : 중복값을 허용하지 ㅇ낳는다. 항상 유일한 값을 갖도록 한다
    --PRIMARY KEY : NOT NULL + UNIQUE. 테이블 기본키가 된다
    --FOREIGN KEY : 참조하는 테이블의 특정 컬럼(PK OR UNIQUE)에 존재하는 값만 허용한다
    --                         외래키로 참조하려는 컬럼은 반드시 기본키이거나 UNIQUE여야 한다
    --CHECK : 직접 원하는 값의 조건을 설정한다
    
--제약조건 메타데이터 확인
--CONSTRAINT_TYPE 컬럼의 값에 따라 어떤 제약조건인지 알 수 있다
     --P : PRIMARY KEY
     --R : FOREIGN KEY
     --U : UNIQUE
     --C : NOT NULL, CHECK
     
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='MY_MEMBER';

--어느 컬럼에 제약조건이 설정되었는지 확인
SELECT * FROM USER_CONS_COLUMNS;


SELECT * FROM my_member;
DESC my_member;

--이미 존재하는 테이블에 제약조건 추가하기
--제약조건을 추가하려는 컬럼에 제약조건을 만족시키지 못하는 행이 존재하면 제약조건을 추가할 수 없다
--ALTER TABLE 테이블명 ADD CONTRAINT 제약조건명 제약조건(컬럼);

--기본키 제약조건 추가하기
ALTER TABLE my_member ADD CONSTRAINT my_member_memno_pk PRIMARY KEY(mem_no);

SELECT * FROM USER_constraints;

--NOT NULL 제약조건 추가하기
--NOT NULL제약조건은 ADD CONSTRAINT가 아니라 MODIFY CONSTRAINT를 사용해야한다
--NULL을 허용하는 상태에서 NULL을 허용하지 않는 상태로 변경하는 것이기 때문에 MODIFY를 사용한다
ALTER TABLE my_member MODIFY mem_name CONSTRAINT my_member_mname_mn NOT NULL;

INSERT INTO my_member(mem_no, mem_age, joindate) VALUES (my_member_memno_seq.nextval, 123, SYSDATE);
SELECT * FROM my_member ORDER BY mem_no;
DESC my_member;

--제약조건 제거하기
--ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

--기본키 제약조건 제거하기
ALTER TABLE my_member DROP CONSTRAINT my_member_memno_pk;

--NOT NULL 제약조건 제거하기
ALTER TABLE my_member DROP CONSTRAINT my_member_mname_mn;


--emp02와 dept02를 생성
DROP TABLE emp02;
DROP TABLE dept02;

CREATE TABLE emp02 AS SELECT * FROM emp;
CREATE TABLE dept02 AS SELECT * FROM dept;

SELECT * FROM emp02;
SELECT * FROM dept02;

--emp02에 fk추가
-- ALTER TABLE 테이블명  ADD CONSTRAINT 제약조건명  FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(컬럼명);
ALTER TABLE emp02 ADD CONSTRAINT emp02_deptno_fk FOREIGN KEY(deptno) REFERENCES dept02(deptno);

--fk를 추가하려면 dept02의 deptno가 PK혹은 UNOQUE여야 한다
ALTER TABLE dept02 ADD CONSTRAINT dept02_deptno_unq UNIQUE(deptno);

SELECT * FROM emp02;

--FK제약조건이 걸린 컬럼에 NULL값은 허용하지만 존재하지 않는 값은 허용하지 않는다
--참조하고 있는 곳에 존재하지 않는 값은 허용하지 않는다
INSERT INTO emp02 VALUES(1, 'TEST', 'TEST', 7782, SYSDATE, 0, NULL, NULL);
INSERT INTO emp02 VALUES(1, 'TEST', 'TEST', 7782, SYSDATE, 0, NULL, 11); --10, 20, 30만 가능

SELECT * FROM my_member;
SELECT * FROM USER_constraints;

--CHECK 제약조건 (원하는 대로 컬럼에 들어갈 값에 대한 조건을 추가 할 수있음)
--ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 CHECK(컬럼)
ALTER TABLE my_member ADD CONSTRAINT my_member_age_chk CHECK(mem_age BETWEEN 1 AND 999);

INSERT INTO my_member VALUES(my_member_memno_seq.nextval, 'TESTER', -5, SYSDATE);
INSERT INTO my_member VALUES(my_member_memno_seq.nextval, 'TESTER', 0, SYSDATE);
INSERT INTO my_member VALUES(my_member_memno_seq.nextval, 'TESTER', -999, SYSDATE);

ALTER TABLE my_member ADD (GENDER VARCHAR(1) DEFAULT 'M');
ALTER TABLE my_member DROP COLUMN GENDER;

ALTER TABLE my_member ADD CONSTRAINT my_member_gender_chk CHECK(GENDER IN('M', 'F', 'L', 'G', 'B', 'T'));
SELECT * FROM my_member;
SELECT * FROM USER_constraints;

INSERT INTO my_member VALUES(my_member_memno_seq.nextval, 'TESTER', 55, SYSDATE, 'F');
INSERT INTO my_member VALUES(my_member_memno_seq.nextval, 'TESTER', 55, SYSDATE, 'C');
INSERT INTO my_member VALUES(my_member_memno_seq.nextval, 'TESTER', 55, SYSDATE, 'T');

--테이블 생성과 동시에 제약조건 ㅈ추가
CREATE TABLE test_cons( 
        tno NUMBER(5) PRIMARY KEY,
        tname VARCHAR2(10) NOT NULL,
        gender VARCHAR2(1) CHECK (gender IN('M', 'F')),
        joindate DATE DEFAULT SYSDATE
);
--제약조건 이름ㅇ ㅣ자동으로 생성되기 때문에 오라클에서 지정해주는 이름으로 설정됨(매우 불편함)

CREATE TABLE test_cons2( 
        tno NUMBER(5) CONSTRAINT cons2_tno_pk PRIMARY KEY,
        tname VARCHAR2(10) CONSTRAINT cons2_tname_nn NOT NULL,
        gender VARCHAR2(1) CONSTRAINT cons2_gen_chk CHECK (gender IN('M', 'F')),
        joindate DATE DEFAULT SYSDATE
);
SELECT * FROM test_cons2;
SELECT * FROM user_constraints WHERE TABLE_NAME ='test_cons2';

CREATE TABLE test_cons3( 
        tno NUMBER(5) ,
        tname VARCHAR2(10),
        gender VARCHAR2(1),
        joindate DATE DEFAULT SYSDATE,
        CONSTRAINT cons3_tno_pk PRIMARY KEY(tno),
         CONSTRAINT cons3_tname_nn NOT NULL(tname),
          CONSTRAINT cons3_gen_chk CHECK (gender IN('M', 'F'))
);



--만들고 있던 테이블에 알맞은 제약조건들을 추가하시오
--NOT NULL, CHECK, PRIMARY KEY, FOREIGN KEY(필요하다면 테이블 추가), UNIQUE

CREATE TABLE test_ex( 
        tno NUMBER(5) CONSTRAINT ex_tno_pk PRIMARY KEY,
        tname VARCHAR2(10) CONSTRAINT ex_tname_nn NOT NULL,
        gender VARCHAR2(1) CONSTRAINT ex_gen_chk CHECK (gender IN('M', 'F')),
        joindate DATE DEFAULT SYSDATE
);
ALTER TABLE test_ex ADD (PW NUMBER(4));
ALTER TABLE test_ex DROP COLUMN e_mail;

ALTER TABLE test_ex ADD (e_mail VARCHAR2(100));

ALTER TABLE test_ex ADD CONSTRAINT ex_pw_fk FOREIGN KEY(pw) REFERENCES test_ex2(pw);

CREATE SEQUENCE test_ex_tno_seq NOCYCLE NOCACHE;
INSERT INTO test_ex VALUES(test_ex_tno_seq.nextval, 'TESTER', 'F', SYSDATE, 1234, 'abc@def.com');

SELECT * FROM test_ex;

DROP TABLE test_ex;
SELECT * FROM USER_constraints;


CREATE TABLE test_ex2( 
        tno NUMBER(5) CONSTRAINT ex2_tno_pk PRIMARY KEY,
        tname VARCHAR2(10) CONSTRAINT ex2_tname_nn NOT NULL,
        gender VARCHAR2(1) CONSTRAINT ex2_gen_chk CHECK (gender IN('M', 'F')),
        joindate DATE DEFAULT SYSDATE
);

SELECT * FROM test_ex2;

ALTER TABLE test_ex2 ADD (PW NUMBER(4) DEFAULT 1234);
ALTER TABLE test_ex2 ADD CONSTRAINT ex_pw_unq UNIQUE(pw)





