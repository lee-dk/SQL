--09_SEQUENCE.sql

--�⺻ Ű (Private Key) : �� ���� �����ϰ� ���� �� �� �ִ� �÷�
--�⺻Ű�� ������ ���� ������ �ϴµ�, ����ڰ� �װ��� �Ź� ���� �����Ϸ��� �ʹ� �����ϴ�
--�⺻Ű�� ����� �������� �ڵ����� ��ġ�� �ʴ� ���ڸ� �����ϴ� ���α׷��� ������ ���� ���� DB�� ��������� �Ѵ�
--��, �������� �ڵ� ��ȣ �߻����̴�

/*
        CREATE SEQUENCE ��������
                        INCREMENT BY ��������       --�⺻�� +1, ���/���� ��� ��밡��,��
                        START WITH ���ۼ���            --���۰��� ������ �� �ִ�, ���� ���� �ʴ� ��� �⺻���� ������ �� MINVALUE, (�����϶��� MAX������ -1)������ �� MAXVALUE
                        MINVALUE �ּҰ� : �������� �ּҰ��� �����Ѵ�
                        MAXVALUE �ִ밪 : �������� �ִ밪�� �����Ѵ�
                        CYCLE   |   NOCYCLE  : Cycle�� ��� �ִ밪�� �����ϸ� �ּҰ�����  �ٽ� ���� 
                        CACHE    |   NOCACHE : ���� ��ȣ�� �̸� ������ ������ ������ �����Ѵ�
*/
--������ ������ ��ųʸ�
SELECT * FROM all_sequences;
SELECT * FROM user_sequences;

SELECT * FROM my_member;
DELETE FROM my_member;
COMMIT;

--������ ����
CREATE SEQUENCE my_member_memno_seq NOCYCLE NOCACHE;

--�������� ����� ������ �߰�
INSERT INTO my_member(mem_no, mem_name, mem_age) VALUES (my_member_memno_seq.NEXTVAL, 'tester', 10);    --��������.NEXTVAL : ���� ���ڸ� ������ ����Ѵ�. ���ڸ� �����Ѵ�

--���������� �̿��� �����͸� �����ϸ鼭 ������ �̿�
INSERT INTO my_member(mem_no, mem_name. mem_age) 
(SELECT my_member_memno_seq.NEXTVAL, mem_name, mem_age FROM my_member);

--DUAL : �׽�Ʈ�� ���̺�
SELECT my_member_memno_seq.CURRVAL FROM DUAL;


/*
    ������ ����
    ALTER SEQUENCE ��������
                INCREMENT BY ��������
                START WITH ���ۼ���
                MINVALUE �ּҰ�
                MAXVALUE �ִ밪
                CYCLY   |   NOCYCLE
                CACHE   |   NOCACHE
            **�ѹ� ���������� ���������� �������� �������� ����
*/

DESC HEALTH_MEMBER;
SELECT * FROM HEALTH_MEMBER;
--�������� : ������ ���̺� �������� �߰��ϰ� INSERT�� �����͸� ������ �߰��ϱ�
    --1. �������� ����� ������ �÷��� ���� (���ٸ� ALTER TABLE�� �߰�)
    --2. ������ ����
    --3. ������ ����
CREATE SEQUENCE health_member_memno_seq NOCYCLE NOCACHE;
INSERT INTO health_member(mem_no, mem_name, mem_age,joindate, mem_inbody) VALUES (health_member_memno_seq.NEXTVAL, '�ѹΰ�', 38, '', 0); 

