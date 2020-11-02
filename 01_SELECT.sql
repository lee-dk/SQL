--01_SELECT.sql

/*
    ���� ���̺�
        ���ĸ�     Į�θ�     ����     �α⵵  ��       <-�÷���(����), �ο�(����)
        ������     500       7000     9.0    ����
        Ƣ��       800       4000     9.5    ����
        
    �����ı� ���̺�
        ���ĸ�     ����      ����
        ������     10      �ʹ� ���־��
*/

--���� ������ ������ �ִ� ���̺� Ȯ���ϱ�
SELECT * FROM TAB;
SELECT * FROM TABS;

--���̺��� ���� ���캸��
DESC EMP;

/*
    EMPNO    : �����ȣ
    ENAME    : �����
    JOB      : ����
    MGR      : �ش����� ����� �����ȣ
    HIREDATE : �Ի���
    SAL      : ����
    COMM     : ���ʽ�
    DEPTNO   : ������ ���� �μ���ȣ
    
    NOT NULL : �ش� �÷����� �� ��(NULL)�� ������ �ʴ´�
    
    NUMBER(4)   : ���� 4�ڸ��� ������ ���ִ� �÷�
    VARCHAR2(10): ���ڿ� �ִ���� 10�� ������ �� �ִ� �÷�
    DATE        : ��¥�����͸� ������ ���ִ�
    NUMBER(7,2) : �Ҽ��� 
*/


--SELECT �� : �������͸� ��ȸ�� �� ����ϴ� ������
--  SELECT �÷��� FROM ���̺�� ;

--���� ������ ���� ���̺� �̸� BONUS, DEPT, EMP, SALGRADE
SELECT * FROM BONUS;
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;


--�÷��� : ǥ�� ���� �ش� �ϴ� ��, *�� ����ϸ� ���̺��� ��� �÷��� ���Ѵ�.
SELECT ENAME, JOB FROM EMP;
SELECT EMPNO, ENAME, SAL FROM EMP;


--1. ����� ��� ������ ����ϴ� �������� �ۼ�
SELECT * FROM EMP;

--2. ����� �̸��� �޿��� �Ի����ڸ� ����ϴ� SQL�ۼ�
SELECT ENAME, SAL, HIREDATE FROM EMP; --�÷����� �ۼ��ϴ� ������� ���

--SELECT�ϸ鼭  ��������� ����ϱ�
SELECT ename, SAL + 1000 from emp;

--�޿��� ���� ���ϱ�(AS�� ��ĥ ����)
select ename, sal*12 AS YEAR_SAL from emp;

--���ʽ� ����ϱ�
select ename, sal+comm as ���ʽ����� from emp;
select * from emp;
--���ڿ� NULL���� ����ϸ� NULL�� �ȴ�(NULL�� ?���� �˼����� ���� �ǹ��Ѵ�)

--null���� ���ü� �ִ� �÷����� ����ϱ� (NVL : NULL VALUE)
SELECT ename, sal + NVL(comm, 0) AS "����(+���ʽ�)" FROM emp;

--��ҹ��� ���� ����
--������ : ��ҹ��� ���� ����(select�� SELECT�������)
--�÷��� : ��ҹ��� ���� ���� (COMM�̳� comm�̳� Comm�������)
--������ : ��ҹ��� ���� ��
--���� �������ΰ� �빮�ڸ� ���� ���������� �������� �ҹ��ڷ� ���(�������)

--SELECT DISTINCT : �ߺ��Ǵ� ���� �ѹ����� ����ϴ� Ű����
SELECT DISTINCT job AS ���� From emp;
SELECT DISTINCT deptno AS �μ���ȣ From emp;
SELECT DISTINCT NVL(mgr, 0) AS �Ŵ��� From emp;

--�����͸� ���� �����Ҽ� �ֵ��� �ϱ����� �����ͺ��̽��� ���