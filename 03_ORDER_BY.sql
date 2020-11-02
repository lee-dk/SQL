--03_ORDER_BY


--ORDER BY�� : SELECT�� ����� ���ϴ� �÷��� �������� ������ �� �ִ�
--      ASC  : ASCENDING, ��������, �������� �������´�
--      DESC : DESCENDING, ��������, ū ���� �������´�
--                   ��������        /       ��������
--   ��¥     �� ������ ������ ����    /   �ֱ� ��¥�� ����
--   ����         ������ ����         /    ū �� ����
--   ����         A to Z             /    Z to A
--   NULL       ���� �������� ����     /    ���� ���� ����

--ASC�� ������ �����ϴ�(ORDER BY�� �⺻���� ��������(ASC)�̴�)
SELECT * FROM EMP ORDER BY SAL ASC;
SELECT * FROM EMP ORDER BY SAL DESC;

SELECT * FROM EMP ORDER BY ename;
SELECT * FROM EMP ORDER BY ename DESC;

SELECT * FROM EMP ORDER BY hiredate ASC;
SELECT * FROM EMP ORDER BY hiredate DESC;

SELECT * FROM EMP ORDER BY comm ASC;
SELECT * FROM EMP ORDER BY comm DESC;

--���ı��� ������ �α�
--EX) �μ���ȣ�������� ���� ������ �� �μ������� �̸������� ����
SELECT * FROM EMP ORDER BY deptno ASC, ename ASC;

SELECT * FROM EMP;
--�������� : �����ȣ/����̸�/����/�Ի����� �ֱ� �Ի��� ������� ���
SELECT empno,ename,job,hiredate FROM EMP ORDER BY hiredate DESC;
--�������� : ��� ��������� ���ޱ������� ������������ ����ϵ�, ���� ������ ��� ������ ���� �޴� ������ �����Ͽ� ���
SELECT * FROM EMP ORDER BY job, sal DESC;