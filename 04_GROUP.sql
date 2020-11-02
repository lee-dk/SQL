--04_GROUP.sql

--GROUP �Լ� : �ϳ��̻��� ���� �׷����� ������� �� �ִ�
--      SUM, AVG, COUNT, MAX, MIN ...

SELECT * FROM EMP;
--SUM�Լ��� �޿��� ���� ���ϱ�
SELECT SUM(sal) FROM EMP;

--SUM�Լ��� ���ʽ��� ���� ���ϱ�
SELECT SUM(comm) FROM EMP;

--avg�Լ��� �޿��� ��� ���ϱ�
SELECT AVG(sal) FROM EMP;

--MAX()�� �ִ� �޿� ���ϱ�
SELECT MAX(sal) FROM EMP;

--MIN()�� �ּ� �޿� ���ϱ�
SELECT MIN(sal) FROM EMP;

--COUNT() : ����� ������ ������ش�
SELECT COUNT(*) AS "�����" FROM EMP;

--NULL�� Ƚ������ �����Ѵ�
SELECT COUNT(comm) FROM EMP;

--COUNT���ο� DISTINCT�� Ȱ���� �ߺ��� ������ ������ �� �� �ִ�
SELECT COUNT(DISTINCT job) FROM EMP;

--�������� : ���� �ֱٿ� �Ի��� ������ �Ի��ϰ� ���� ������ ������ �Ի����� ���
SELECT MAX(hiredate) AS "�ֱ� �Ի� ����", MIN(hiredate) AS "������ ����" FROM EMP;

--�������� : 10�� �μ� ������ �߿� ���ʽ��� �޴� ������ ���� ���
SELECT  COUNT(comm) FROM EMP WHERE deptno=10 AND comm<>0;

--GROUP BY�� : �׷��� ���� �׷캰�� �׷��Լ��� �����ϱ� ���� ����

SELECT * FROM EMP;
--GROUP BY deptno : EMP���̺��� ��� ���� deptno�������� �׷����´�
--�׷��� ������ �׷������� ����ߴ� �÷��� �׷��Լ��� ����� ����� �� �ִ�.
--��, �� �׷캰�� �ϳ��� ���յ� �� �ִ� ����� GROUP BY�� �Բ� ����� �� �ִ�

--�� �μ��� �ִ� ���� ���
SELECT deptno, MAX(sal) FROM EMP GROUP BY deptno;

--�������� �� ���� ���� ���� �޴� ���
SELECT ename, MAX(sal) FROM EMP GROUP BY ename;

--�� ���޺� �ּ� ����
SELECT job, MIN(sal) FROM EMP GROUP BY job;




--�������� : �Ҽ� �μ����� ��� �޿� ��� ROUND(��� ,�Ҽ��� )
SELECT deptno AS "�μ� ��ȣ", ROUND(AVG(sal),2) AS "��� �޿�" FROM EMP GROUP BY deptno;


--HAVING�� : GROUP BY�� ����� ������ �ΰ��ϰ� ���� ��� ���
--EX) �μ����� ��� �޿��� ��ȸ �ϵ�, ��ձ޿��� 2000�̻��� �׷츸 ��ȸ
SELECT 
    deptno AS "�μ� ��ȣ", 
    ROUND(AVG(sal),2) AS "��� �޿�" 
FROM EMP 
GROUP BY deptno 
HAVING AVG(sal) >= 2000;

--�������� : �μ��� �ּ� ������ ����ϵ� �ּ� �޿��� 1000������ �μ��� ���
SELECT 
    deptno AS "�μ� ��ȣ", 
    ROUND(MIN(sal),2) AS "�ּ� �޿�" 
FROM EMP 
GROUP BY deptno 
HAVING MIN(sal) <= 1000;





