-- 02_WHERE.sql

-- WHERE�� : �����͸� ��ȸ�� �� ������ ������ �� �ִ�
-- SELECT �÷� FROM ���̺� WHERE ����;

/*

    = : ����
    !=, <>, ^= : �ٸ���
    >, <, >=, <= :��

*/


SELECT * FROM emp;
SELECT * FROM emp WHERE sal = 1600;

--������ 1600�� �ƴ� ���� ��ȸ
SELECT * FROM emp WHERE sal != 1600;
SELECT * FROM emp WHERE sal <> 1600;
SELECT * FROM emp WHERE sal ^= 1600;    -- !=, <>, ^= ���� ��

--������ 1600 �̻�, ������ ���� ��ȸ
SELECT * FROM emp WHERE sal >= 1600;
SELECT * FROM emp WHERE sal <= 1600;

--���� Ȥ�� ��¥ �����͵� ũ�� �񱳰� �����ϴ�
SELECT * FROM emp WHERE ename >= 'D';
SELECT * FROM emp WHERE ename >= 'M';
SELECT * FROM emp WHERE hiredate < '81/05/05';  --��¥ũ�Ⱑ �� �۴ٴ� ���� �����ƴ�
SELECT * FROM emp WHERE hiredate >= '81/05/05';  --��¥ũ�Ⱑ �� ũ�ٴ� ���� �ֽ��̴�

--�������� : �޿��� 1500������ ����� �����ȣ/����̸�/�޿� ���
SELECT empno,ename,sal FROM emp WHERE sal <= 1500;

--�������� : ����̸��� 'MARTIN'�� ����� �����ȣ/�̸�/�޿��� ���
SELECT empno,ename,sal FROM emp WHERE ename = 'MARTIN';

--AND, OR, NOT
SELECT * FROM emp;
--�޿��� 1500�̻��̰� ������ 'salesman'�� ��� ��ȸ
SELECT * FROM emp WHERE sal  >= 1500 AND job = 'SALESMAN';
--10�� �μ��� ������ ���� ���� ��ȸ
SELECT * FROM emp WHERE NOT deptno = 10;
--�޿��� 2õ�̻� 3õ������ ���� ��ȸ
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 3000;
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;

--�̸��� 'A'���� ũ�� 'D'���� ���� ��� ��ȸ
SELECT * FROM emp WHERE ename BETWEEN 'A' AND 'D';

--IN (A, B,C, ...)
--EX) �޿��� 800�̰ų� 1600�̰ų� 2850�� ���� ��ȸ
SELECT * FROM emp WHERE sal = 800 OR sal=1600 OR sal=2850;
SELECT * FROM emp WHERE sal IN(800, 1600, 2850);

SELECT * FROM emp;
--�������� : �����ȣ�� 7521�̰ų� 7654�̰ų� 7844�� ������ �����ȣ/�̸�/������� ���
SELECT empno,ename,hiredate FROM emp WHERE empno IN(7521, 7654, 7844);

--�������� : �����ȣ�� 7521�� �ƴϰ� 7654�� �ƴϰ� 7844�� �ƴ� ��� ��ȸ
SELECT * FROM emp WHERE empno!=7521 AND empno!=7654 AND empno!=7844;
SELECT * FROM emp WHERE empno NOT IN(7521, 7654, 7844);

--LIKE �����ڿ� ���ϵ�ī��
--  _ : �ϳ��� �����ڰ� �ƹ��ų� �͵� �ȴ�
--  % : �ϳ� �̻��� ���ڰ� �ƹ��ų� ����־�ǰ� �ƹ����ڰ� �͵� �ȴ�

--�̸��� 'E'�� ���� ������ ��ȸ
SELECT * FROM emp WHERE ename LIKE '%E%';
--�ڿ��� �� ��° ���ڰ� E�� ����� ��ȸ
SELECT * FROM emp WHERE ename LIKE '%E_';
--�տ��� �� ��° ���ڰ� L�� ����� ��ȸ
SELECT * FROM emp WHERE ename LIKE '_L%';
--�տ��� �� ��° ���ڰ� L�� ����� ��ȸ
SELECT * FROM emp WHERE ename LIKE '__L%';

--�������� : �̸��� K�� �����ϴ� ������ �����ȣ/�̸� ��ȸ
SELECT empno,ename FROM emp WHERE ename LIKE 'K%';
--�������� : �̸��� K�� ���� ������ �����ȣ/�̸� ��ȸ
SELECT empno,ename FROM emp WHERE ename LIKE '%K%';
--�������� : �̸��� K�� ������ ������ �����ȣ/�̸� ��ȸ
SELECT empno,ename FROM emp WHERE ename LIKE '%K';
--�������� : �̸��� K�� �ȵ��� ������ �����ȣ/�̸� ��ȸ
SELECT empno,ename FROM emp WHERE ename NOT LIKE '%K%';

--���ʽ��� NULL�� ��� ��ȸ
SELECT * FROM emp WHERE comm=NULL;
--NULL�� �񱳿����ڷ� �� �Ұ���
SELECT * FROM emp WHERE comm IS NULL;
--���ʽ��� NULL�� �ƴ� ��� ��ȸ
SELECT * FROM emp WHERE comm IS NOT NULL;

--�Ŵ����� ���� ���� ��ȸ
SELECT * FROM emp WHERE mgr IS NULL;