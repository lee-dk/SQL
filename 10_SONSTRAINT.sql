--10_CONSTRAINT.sql

-- �������� : ���̺� �������� �ڷᰡ �ԷµǴ� ���� �����ϱ� ���� �÷����� ���� �ϴ� ��Ģ
    --NOT NULL : NULL�� ������� �ʴ´�
    --UNIQUE : �ߺ����� ������� �����´�. �׻� ������ ���� ������ �Ѵ�
    --PRIMARY KEY : NOT NULL + UNIQUE. ���̺� �⺻Ű�� �ȴ�
    --FOREIGN KEY : �����ϴ� ���̺��� Ư�� �÷�(PK OR UNIQUE)�� �����ϴ� ���� ����Ѵ�
    --                         �ܷ�Ű�� �����Ϸ��� �÷��� �ݵ�� �⺻Ű�̰ų� UNIQUE���� �Ѵ�
    --CHECK : ���� ���ϴ� ���� ������ �����Ѵ�
    
--�������� ��Ÿ������ Ȯ��
--CONSTRAINT_TYPE �÷��� ���� ���� � ������������ �� �� �ִ�
     --P : PRIMARY KEY
     --R : FOREIGN KEY
     --U : UNIQUE
     --C : NOT NULL, CHECK
     
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='MY_MEMBER';

--��� �÷��� ���������� �����Ǿ����� Ȯ��
SELECT * FROM USER_CONS_COLUMNS;


SELECT * FROM my_member;
DESC my_member;

--�̹� �����ϴ� ���̺� �������� �߰��ϱ�
--���������� �߰��Ϸ��� �÷��� ���������� ������Ű�� ���ϴ� ���� �����ϸ� ���������� �߰��� �� ����
--ALTER TABLE ���̺�� ADD CONTRAINT �������Ǹ� ��������(�÷�);

--�⺻Ű �������� �߰��ϱ�
ALTER TABLE my_member ADD CONSTRAINT my_member_memno_pk PRIMARY KEY(mem_no);

SELECT * FROM USER_constraints;

--NOT NULL �������� �߰��ϱ�
--NOT NULL���������� ADD CONSTRAINT�� �ƴ϶� MODIFY CONSTRAINT�� ����ؾ��Ѵ�
--NULL�� ����ϴ� ���¿��� NULL�� ������� �ʴ� ���·� �����ϴ� ���̱� ������ MODIFY�� ����Ѵ�
ALTER TABLE my_member MODIFY mem_name CONSTRAINT my_member_mname_mn NOT NULL;

INSERT INTO my_member(mem_no, mem_age, joindate) VALUES (my_member_memno_seq.nextval, 123, SYSDATE);
SELECT * FROM my_member ORDER BY mem_no;
DESC my_member;

--�������� �����ϱ�
--ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

--�⺻Ű �������� �����ϱ�
ALTER TABLE my_member DROP CONSTRAINT my_member_memno_pk;

--NOT NULL �������� �����ϱ�
ALTER TABLE my_member DROP CONSTRAINT my_member_mname_mn;


--emp02�� dept02�� ����
DROP TABLE emp02;
DROP TABLE dept02;

CREATE TABLE emp02 AS SELECT * FROM emp;
CREATE TABLE dept02 AS SELECT * FROM dept;

SELECT * FROM emp02;
SELECT * FROM dept02;

--emp02�� fk�߰�
-- ALTER TABLE ���̺��  ADD CONSTRAINT �������Ǹ�  FOREIGN KEY(�÷���) REFERENCES ���������̺��(�÷���);
ALTER TABLE emp02 ADD CONSTRAINT emp02_deptno_fk FOREIGN KEY(deptno) REFERENCES dept02(deptno);

--fk�� �߰��Ϸ��� dept02�� deptno�� PKȤ�� UNOQUE���� �Ѵ�
ALTER TABLE dept02 ADD CONSTRAINT dept02_deptno_unq UNIQUE(deptno);

SELECT * FROM emp02;

--FK���������� �ɸ� �÷��� NULL���� ��������� �������� �ʴ� ���� ������� �ʴ´�
--�����ϰ� �ִ� ���� �������� �ʴ� ���� ������� �ʴ´�
INSERT INTO emp02 VALUES(1, 'TEST', 'TEST', 7782, SYSDATE, 0, NULL, NULL);
INSERT INTO emp02 VALUES(1, 'TEST', 'TEST', 7782, SYSDATE, 0, NULL, 11); --10, 20, 30�� ����

SELECT * FROM my_member;
SELECT * FROM USER_constraints;

--CHECK �������� (���ϴ� ��� �÷��� �� ���� ���� ������ �߰� �� ������)
--ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� CHECK(�÷�)
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

--���̺� ������ ���ÿ� �������� ���߰�
CREATE TABLE test_cons( 
        tno NUMBER(5) PRIMARY KEY,
        tname VARCHAR2(10) NOT NULL,
        gender VARCHAR2(1) CHECK (gender IN('M', 'F')),
        joindate DATE DEFAULT SYSDATE
);
--�������� �̸��� ���ڵ����� �����Ǳ� ������ ����Ŭ���� �������ִ� �̸����� ������(�ſ� ������)

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



--����� �ִ� ���̺� �˸��� �������ǵ��� �߰��Ͻÿ�
--NOT NULL, CHECK, PRIMARY KEY, FOREIGN KEY(�ʿ��ϴٸ� ���̺� �߰�), UNIQUE

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





