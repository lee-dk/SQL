--05_JOIN.sql

--JOIN : ���踦 ���� �� ���̺��� ��� ���ϴ� ������ ��ȸ�ϴ� ��

SELECT * FROM emp;  --���� ���� ���̺�
SELECT * FROM dept; --�μ� ���� ���̺� (deptno:�μ���ȣ/dname:�μ���/loc:����)

--CROSS JOIN : �� ���̺��� ��� ����� ���� ��ȸ�ϴ� ����(�ǹ��ִ� �����͸� ã�� ���� ����)
SELECT * FROM emp, dept;
--CROSS JOIN�����δ� �ƹ��ǹ� ����
--JOIN����� �ǹ̸� ������ ���ؼ��� CROSS JOIN�� ����� ������ �����ؾ��Ѵ�
SELECT ename, emp.deptno, dept.deptno, dname, dept.loc FROM emp, dept;
--�÷����� ��ġ�� ��� ��� ���̺��� �÷������� ��Ȯ�ϰ� ��������Ѵ�.

--EQUI JOIN : ���� �÷��� �������� �����Ѵ�
SELECT * FROM emp, dept WHERE emp.deptno=dept.deptno;   --���� �÷��� �������� ���������� 

--EX)�̸��� MARTIN�� ����� �̸�/�μ����� ��ȸ �ϰ� ���� ��
SELECT emp.ename, dept.dname FROM emp, dept WHERE emp.deptno=dept.deptno AND emp.ename='MARTIN';


--�������� : ���忡 �ٹ��ϴ� ������ �̸��� �޿��� ��ȸ 
SELECT ename, sal FROM emp, dept WHERE emp.deptno=dept.deptno AND loc='NEW YORK';
--�������� : SALES�μ� �Ҽ��� ������ �̸��� �Ի����� ��ȸ
SELECT ename, hiredate FROM emp, dept WHERE emp.deptno=dept.deptno AND dname='SALES';
--�������� : ������ MANAGER�� ������ �̸�/�μ���ȣ/�μ���/������ ��ȸ
SELECT ename, emp.deptno, dname, loc FROM emp, dept WHERE emp.deptno=dept.deptno AND job='MANAGER';
SELECT 
    ename, e.deptno, dname, loc 
FROM 
    emp e, dept d --���̺�� ��Ī�� �ο��� �� �ִ�
WHERE 
    e.deptno=d.deptno AND job='MANAGER';

--NON-EQUI JOIN : ���� �������� ���� �÷����� �� ���̺��� �����Ѵ�

SELECT * FROM salgrade;
SELECT emp.*, g.grade FROM emp, salgrade g WHERE emp.sal BETWEEN losal AND hisal;

--SELF JOIN : ���̺� �ϳ��� �����ϴ� ��(�ڱ� �ڽŰ� ����)   (a�ϳ��� b 12����..)*12

--�������� ������ �Ŵ����̸��� �Բ� ��ȸ
SELECT a.*, b.* FROM emp a, emp b;
--a���̺��� mgr�÷��� b���̺��� empno�÷��� ��ġ�Ѵٸ� b�� a�� �Ŵ����̴�
SELECT a.*, b.ename FROM emp a, emp b WHERE a.mgr=b.empno;


SELECT a.*, b.* FROM emp a, emp b WHERE a.mgr=b.empno;
--�������� : �Ŵ����� KING�� �������� �̸��� ���� ���
SELECT a.ename, a.job FROM emp a, emp b WHERE a.mgr=b.empno AND b.ename='KING';
--�������� : ALLEN�� ������ �ٹ���(depno)���� �ٹ��ϴ� ������ �̸��� ���
SELECT a.ename FROM emp a, emp b WHERE b.ename='ALLEN' AND a.deptno=b.deptno;

--OUTER JOIN : ������ ������Ű�� ���� ��ȸ���� �ʴ� ������ �Բ� ��ȸ�ϰ� ���� �� ����ϴ� ����
SELECT * FROM emp a, emp b WHERE a.mgr=b.empno; --KING�� �ȳ��� (KING�� mgr�� NULL�̶�..)
-- ���� ������ �ѹ��� ������Ű�� ���ؼ� �������� ���� ���� (+)�� ���� �ʿ� NULL�� �ٿ����� �����ش�
SELECT * FROM emp a, emp b WHERE a.mgr=b.empno(+);  --�Ŵ����� ��� ��ȸ���� �ʴ� �࿡ NULL�� �߰��ؼ� ��ȸ

SELECT * FROM emp a, emp b WHERE a.mgr(+)=b.empno;  --�����ϴ� ������ ��� ��ȸ���� �ʴ� �࿡ NULL�� �����ϴ� ������ �߰����༭ ��ȸ

--(+) : ���ο� ���� ���̺� �� ����� ���̺� NULL�� �߰��ؼ� ��ȸ�� �������� �����Ѵ�.

SELECT * FROM emp;
SELECT * FROM dept;
--�������� : EMP���̺�� DEPT���̺��� �����Ͽ� �����/�μ���ȣ/�μ����� ����ϰ�
--          ����� �Ѹ� ���� �μ��� ��� �ǵ��� �ϱ�
SELECT ename AS �����, e.deptno AS �μ���ȣ, dname AS �μ��� FROM emp e, dept d WHERE e.deptno(+)=d.deptno;

--�̱� ǥ�ؿ� ���� �� ������ ����

--1. CROSS JOIN
SELECT * FROM emp, dept;
SELECT * FROM emp CROSS JOIN dept;  --ANSI

--2. INNER JOIN (EQUI, SELF, NON-EQUI JOIN)
    --���ǿ� �´� �ุ �����ִ� ����
SELECT * FROM emp, dept WHERE emp.deptno=dept.deptno;
SELECT * FROM emp INNER JOIN dept ON emp.deptno=dept.deptno;    --ANSI
SELECT * FROM emp INNER JOIN dept USING (deptno);       --ANSI
SELECT * FROM emp a INNER JOIN emp b ON a.mgr=b.empno;  --ANSI SELF
SELECT * FROM emp INNER JOIN salgrade ON sal BETWEEN losal AND hisal;

--3. NATURAL JOIN(������ �̸��� �÷����� INNER JOIN�� �ϴ� ���) �˾Ƽ� ������ �÷��� ã����
SELECT * FROM emp NATURAL JOIN dept;

--4. OUTER JOIN(LEFT | RIGHT | FULL)
    --���ǿ� �����ʴ� �൵ �����ִ� ����
    
--RIGHT OUTER JOIN : ������ ���̺��� �ȳ��� ������ ���� ���̺� (+)�ؼ� ������� ��
SELECT * FROM emp RIGHT OUTER JOIN dept USING (deptno);
--LEFT OUTER JOIN : ���� ���̺��� �ȳ��� ������ ������ ���̺� (+)�ؼ� ������� ��
SELECT * FROM emp LEFT OUTER JOIN dept USING (deptno);
--FULL OUTER JOIN : ���ʿ� (+)�� �� ���� ���
SELECT * FROM emp FULL OUTER JOIN dept USING (deptno);
SELECT * FROM emp a FULL OUTER JOIN emp b ON a.mgr=b.empno;

