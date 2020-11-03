--06_��������.sql

--��������
    --�ϳ��� SELECT�� �ȿ� ���Ե� �� �ϳ��� SELECT���� ������� �Ѵ�
    --���������� �����ϰ� �ִ� ������ ����������� �Ѵ�
    --�񱳿����ڿ� ����� ���� �ݵ�� �񱳿������� �����ʿ� ����ؾ��Ѵ�
    --()�� �ѷ��׾ƾ��Ѵ�
    
    
--EX) ���������� �̿��� KING�� ���� �μ����� �ٹ��ϴ� ������ ��� ����
SELECT * FROM emp WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING');
SELECT * FROM emp a, emp b WHERE a.deptno=b.deptno AND b.ename='KING';

SELECT * FROM emp;
SELECT * FROM emp, dept WHERE emp.deptno=dept.deptno;
--�������� : SMITH�� ���� �μ����� �ٹ��ϴ� ������ �̸��� �μ���ȣ�� ��ȸ
SELECT ename, deptno FROM emp WHERE deptno=(SELECT deptno FROM emp WHERE ename='SMITH');
SELECT a.ename, a.deptno FROM emp a, emp b WHERE a.deptno=b.deptno AND b.ename='SMITH';
--�������� : SMITH�� ������ ������ ���� ��������� ��� ���
SELECT * FROM emp WHERE job=(SELECT job FROM emp WHERE ename='SMITH'); -- AND ename<>'SMITH';
SELECT a.* FROM emp a, emp b WHERE b.ename='SMITH' AND a.job=b.job;
--�������� : MARTIN�� �޿��� �����ϰų� �� ���� �޴� ����� �̸��� �޿��� ���
SELECT ename, sal FROM emp WHERE sal>=(SELECT sal FROM emp WHERE ename='MARTIN');
SELECT a.ename, a.sal FROM emp a, emp b WHERE b.ename='MARTIN' AND a.sal>=b.sal;
--�������� : DALLAS���� �ٹ��ϴ� ����� �̸��� �μ���ȣ�� ���
SELECT ename, deptno FROM emp WHERE deptno=(SELECT deptno FROM dept WHERE loc='DALLAS');
SELECT ename, e.deptno FROM emp e, dept d WHERE e.deptno=d.deptno AND loc='DALLAS';

--���±����� ���������� ����� �� ���ٸ� �������� ����ߴ�
--����� �� �ٸ� ������ ���������� '���� �� ��������(SINGLE Row)��� �Ѵ�
--������ ���������� �׷��Լ��� ����ϸ� ���� �����ϴ�

--��տ��޺��� ������ ���� �޴� ������� ����
SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp);

--���� ��(Multi Row) ���������� �ݵ�� ������ �����ڿ� �Բ� ����ؾ��Ѵ�
    --IN(), ANY, ALL, EXISTS...
    
--IN : ���� ���� �� �ϳ��� ��ġ�ϸ� TRUE
--ex)������ 3000�̻��� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ� ���
SELECT * FROM emp WHERE deptno IN (SELECT DISTINCT deptno FROM emp WHERE sal>=3000);

--ALL : ��ȣ�ȿ� ���� ������ �̿��� �񱳰� ��� ���̾�� TRUE
--EX)������ SALESMAN�� ��� ����� ���� �޿��� ���� �޴� ����� ��ȸ
SELECT * FROM EMP WHERE sal > ALL(SELECT sal FROM emp WHERE job='SALESMAN');
SELECT * FROM EMP WHERE sal > (SELECT MAX(sal) FROM emp WHERE job='SALESMAN');

--ANY : ��ȣ���� ���������� �̿��� ���� �ϳ��� �����ص� TRUE
--EX)������ SALESMAN�� ��� ������� ���� ���� �޴� ������� ���� �޿��� �� ���� �޴� ���
SELECT * FROM EMP WHERE sal > ANY(SELECT sal FROM emp WHERE job='SALESMAN');
SELECT * FROM EMP WHERE sal > (SELECT MIN(sal) FROM emp WHERE job='SALESMAN');

--EXISTS : ���������� ����� �����ϸ� TRUE
--EX)�Ҽӵ� ����� �����ϴ� �μ������� ���
SELECT * FROM dept WHERE EXISTS (SELECT * FROM emp WHERE emp.deptno=dept.deptno);
SELECT * FROM dept WHERE NOT EXISTS (SELECT * FROM emp WHERE emp.deptno=dept.deptno);

SELECT * FROM emp;
SELECT ROUND(AVG(sal),2), deptno FROM emp GROUP BY deptno;
--�������� : �μ����� ���� �޿��� ���� �޴� ����� �̸�/�޿�/�μ���ȣ ���_���߿�(Multi Column) ��������
SELECT ename, sal, deptno FROM emp WHERE (sal, deptno) IN (SELECT MAX(sal), deptno FROM emp GROUP BY deptno);
    --�������� : �μ����� ��պ��� ���� �޴� ����� �̸��� �޿�/ �μ���ȣ ���
    SELECT 
        a.ename, a.sal, a.deptno 
    FROM 
        emp a, (SELECT ROUND(AVG(sal),2) AS avgsal, deptno FROM emp GROUP BY deptno) B 
        --���̺� �ڸ��� ���������� ��� ����� ���̺�(VIEW)�� ���� : INLINE-VIEW
    WHERE 
        b.deptno=a.deptno AND a.sal > b.avgsal;
--�������� : 30�� �μ� �Ҽ��� ��� ����� ���� �޿��� �� ���� �޴� ����� ���� ���
SELECT * FROM emp WHERE sal > ALL(SELECT sal FROM emp WHERE deptno=30);
--�������� : ��� SALESMAN�� �� ��� �Ѹ��� �޿�+���ʽ� �ݾ׺��� �޿��� �� ���̹޴� ����� ���� ���
SELECT * FROM emp WHERE sal > ANY(SELECT sal+NVL(comm,0) FROM emp WHERE job='SALESMAN');
