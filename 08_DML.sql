--08_DML.sql

--DDL (Data Definition Language) : ���̺� ����/����/����
--DML (Data Manioulation Language) : ������ ����/����/����/��ȸ

--CRUD : ��� ���α׷��� �����ϴ� �ʼ����� ���
 --Create    : ������ ����(INSERT)
 --Read      : ������ ��ȸ(SELECT)
 --Update    : ������ ����(UPDATE)
 --Delete    : ������ ����(DELETE)

--INSERT : ���̺� ���ο� ������ ����(�߰�, ����)
    --INSERT INTO ���̺�� (�÷�1, �÷�2, ...) VALUE(��1, ��2, ...);
SELECT * FROM MY_MEMBER;
--���� �⺻���� ������ INSERT
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME, MEM_AGE, JOINDATE) VALUES (1, 'ȫ�浿', 10, '20/07/02');
--�÷��� ������ �ٲ�� VALUES�� ������ �ٲ㼭 �־���Ѵ�.
INSERT INTO MY_MEMBER(MEM_NAME, MEM_AGE, JOINDATE, MEM_NO) VALUES('�׽�Ʈ1', 13, '19/05/04', 2);
--��� �÷��� ������� �߰��� ���� �÷��D�� �����ص� �ȴ�
INSERT INTO MY_MEMBER VALUES(3, '�׽�Ʈ2', 15, '13/07/07');
--NOT NULL�� ������ �÷��� �ƴ��ϸ� ���� ���� ���� ���� �ִ�
--�÷��� ������ VALUES�� ������ ���̳��� ������ �߻��Ѵ�)
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME) VALUES(4, '�׽�Ʈ3');  --������ �÷��� �ڵ����� NULL�� ���Եȴ�
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME) VALUES(NULL, 'test01'); --���Ѵٸ� NULL�� ������ ���� �ִ�
INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME) VALUES(7, '');      --''�� �ٿ��� �����͸� �߰��ϸ� NULL�� �ȴ�

INSERT INTO MY_MEMBER(MEM_NO, MEM_NAME, MEM_AGE) VALUES(4, '�׽�Ʈ4', 9);

--���������� ������ �߰�(�׽�Ʈ�� ���� �����)
INSERT INTO MY_MEMBER SELECT * FROM MY_MEMBER;




--UPDATE : ���̺� ������ ����
--UPDATE ���̺�� SET �÷�1 = VALUE1, �÷�2 = VALUE2, ... WHERE ����;
-- * ������ �������� ������ ��� ���� �����ȴ� *

COMMIT; --������� DML�� ���� ������ ���̺� ��Ȳ�� Ȯ�����´� (DDL�� COMMIT�� ROLLBACK�� ���� ���� �ʴ´�)

SELECT * FROM MY_MEMBER;
UPDATE my_member SET mem_name='��浿', mem_no=10, mem_age=45, joindate='08/11/30';

ROLLBACK;

UPDATE my_member SET mem_name='��浿' WHERE mem_name='ȫ�浿';   
--������ �ٿ��� ���ϴ� ���� ����(ȫ�浿�̶�� �̸��� ��浿���� ����)���� ���� ���� �Ϸ��� WHERE���� ��ǥ�� ���̰� �ϸ� ��

--**���̺��� �ϳ��� ��(Row)�� �����ϰ� ���� �� �� �ִ� �÷��� �ʿ��ϴ�
    --�׷� �÷��� ���ٸ�, ���� ���� ���� ��� ���� �����ǰų� �����Ǿ������ **
    
-- ���̺��� �ϳ��� ���� �ĺ��� �� ���ִ� �÷��� �⺻Ű(PRIVATE KEY, PK)��� �Ѵ�
    --�⺻Ű�� �Ǳ����� �÷��� ����
     --1. �ߺ��� ����� �Ѵ� (UNIQUE)
     --2. NULL�� ����� �Ѵ� (NOT NULL)

--Ű�� ����
    --���� Ű : Ű�� �� �� �ִ� ��� �÷��� ����
            -- EX) [�̸�, �̸���], [�̸���], [�̸�, ��ȭ��ȣ]..
    --���� Ű : 2�� �̻��� �÷��� ����� Ű
    --�ĺ� Ű : �⺻ Ű�� �� �� �ִ� �ĺ��� �÷�
    --�⺻ Ű(Private Key) : �ĺ� Ű �߿��� ���õ� Ű
    --��ü Ű : �ĺ� Ű �߿��� ���õ��� ���� Ű
    --�ܷ� Ű(Foreign Key) : �ٸ� ���̺����� �⺻ Ű(Ȥ�� UNIQUE�� ����)������ 
 --                                     �� ���̺����� �ߺ��� ����ϴ� �÷�. �ٸ� ���̺��� �⺻Ű �÷��� �ݵ�� �����ؾ��Ѵ�.
 --           EX) EMP���̺��� DEPTNO�� �ܷ�Ű, DEPT���̺��� DEPTNO�� �⺻Ű.
 --                 EMP���̺� ���ο� ���� �߰� �� ��, DEPT���̺��� DEPTNO�� ���� �μ���ȣ�� ����� �� ����



SELECT * FROM emp02;

--��������1 : EMP���̺��� �����Ͽ� EMP02���̺��� ����
CREATE TABLE emp02 AS SELECT * FROM emp;
--��������2 :  �μ���ȣ�� 10���� ������� �μ���ȣ�� 40������ ����
UPDATE emp02 SET deptno=40 WHERE deptno=10;
--��������3 : �޿��� 3000�̻��� ������� �޿��� 10%�λ�
UPDATE emp02 SET sal=sal*1.1 WHERE sal>=3000;
--��������4 : 1981�⿡ �Ի��� ������� �Ի����� ���÷� ����
UPDATE emp02 SET hiredate=SYSDATE WHERE hiredate LIKE '81%';
--��������5 : 
COMMIT;


--DELETE : ���̺� ������ ����
    --DELETE FROM ���̺�� WHERE ����;
--*** ������ �������� ������ ��� ���� �����ȴ� ***
DELETE FROM emp02;
SELECT * FROM emp02;
ROLLBACK;


--emp02���̺��� COMM�� ���� �ʴ� ����� ����(NULL�� ���� �Ϸ��� comm=NULL �� ����X)
DELETE FROM emp02 WHERE comm IS NULL;
ROLLBACK;






