--07_CREATE TABLE.sql

/*
    CREATE TABLE ���̺�� (
        �÷���1 �÷�Ÿ�� (��������),
        �÷���2 �÷�Ÿ��,
        �÷���3 �÷�Ÿ��,
        ...
    );
*/
--�÷�Ÿ���� ����
/*
    NUMBER(����) : ���� (EX: NUMBER(7)�� 7�ڸ� ����)
    NUMBER(����, �Ҽ��� �ڸ���) : ���� (EX: NUMBER(7,2)�� ����5�ڸ�, �Ҽ�2�ڸ�)
    CHAR(ũ��)                : �������� ���ڵ�����(�Էµ� �ڷ���̿� ������� ������ ���̸� �����ϴ� Ÿ��)_�� ������� ����
    VARCHAR2(ũ��)            : ���� ���� ���� ������. ���� �Էµ� ���ڱ��� ��ŭ�� ������ �����ϴ� Ÿ��
    DATE               : ��¥�� ���� �� ���ִ� Ÿ��
    TIMESTAMP       : �и���������� ������ �� �ִ� Ÿ��
*/
DESC emp;

--���̺� ���� �� : ȸ�� ���̺�
CREATE TABLE MY_MEMBER (
    MEM_NO NUMBER(10),
    MEM_NAME VARCHAR(20),
    MEM_AGE NUMBER(3),
    JOINDATE DATE DEFAULT SYSDATE --DEFAULT : �⺻�� ����
);
DESC MY_MEMBER;

--���̺� ���� ��ɾ�
DROP TABLE MY_MEMBER;

--���� ���̺� �����ؼ� �����ϱ�_���� ������(�׽�Ʈ ��)
--�������ǵ� �Բ� ��������� �ʴ´�(NOT, NULL..)
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
--���̺� �÷� ���� ��ɾ�
--ALTER TABLE ���̺�� [ADD|MODIFY|DROP COLUMN] (�÷���1, �÷���2,...)
ALTER TABLE MY_MEMBER ADD (TEST NUMBER(5));
ALTER TABLE MY_MEMBER ADD (TEST2 NUMBER(5), TEST3 VARCHAR(50));

--MODIFY : �÷� Ÿ�� ����(�÷��� ������ X)
ALTER TABLE MY_MEMBER MODIFY (TEST NUMBER(7));
ALTER TABLE MY_MEMBER MODIFY (TEST DATE);

--DROP COLUMN : �÷� ����
ALTER TABLE MY_MEMBER DROP COLUMN TEST;
ALTER TABLE MY_MEMBER DROP COLUMN TEST2;
ALTER TABLE MY_MEMBER DROP COLUMN TEST3;

--��Ÿ ������ : �����Ϳ� ���� ������ (���̺� ����, �÷� ����, ..)
    --�츮�� ���������ʰ� DB�� �˾Ƽ� �߰�/�����ϸ� �����ϴ� ���̺�
SELECT * FROM TAB;--�˾ƺ��� ����

SELECT * FROM TABS;
SELECT * FROM USER_TABLES; --USER_TABLE�� ��Ÿ ������
SELECT * FROM USER_SEQUENCES;  --���� ������ ����
SELECT * FROM USER_INDEXES; --���� ���ؽ� ����
SELECT * FROM USER_CONSTRAINTS; --���� �������� ����

--���� ������ �������� �����ϱ�
SHOW USER;

SELECT * FROM ALL_TABLES; --USER_TABLE�� ��Ÿ ������
SELECT * FROM ALL_SEQUENCES;  --��� ���� ������ ����
SELECT * FROM ALL_INDEXES; --��� ���� ���ؽ� ����
SELECT * FROM ALL_CONSTRAINTS; --��� ���� �������� ����

DESC MY_MEMBER;
--SET UNUSED : �÷��� �����ϴ� ��� ��� ������� �ʰ� �����ϱ�
ALTER TABLE MY_MEMBER SET UNUSED(TEST);
ALTER TABLE MY_MEMBER SET UNUSED(TEST2);
ALTER TABLE MY_MEMBER SET UNUSED(TEST3);

--�����ִ� �ð��� UNUSEDó���� �÷����� �����Ѵ�
ALTER TABLE MY_MEMBER DROP UNUSED COLUMNS;



--���� : ���̺� ¥����
--���ǿ� �������� ������(���, ȸ������, �Խñ� ���)
CREATE TABLE HEALTH_MEMBER (
    MEM_NO NUMBER(10),
    MEM_NAME VARCHAR(20),
    MEM_AGE NUMBER(3),
    JOINDATE DATE DEFAULT SYSDATE, --DEFAULT : �⺻�� ����
    MEM_INBODY NUMBER(3),
    MEM_JOINMONTH NUMBER(2)
);
DESC HEALTH_MEMBER;
SELECT * FROM HEALTH_MEMBER;
