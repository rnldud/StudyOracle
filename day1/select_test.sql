-- �ּ�, �Ʒ��� select ������ ����
SELECT * FROM emp;

--�÷��� �����ؼ� SELECT
SELECT ename, job, hiredate
FROM emp; 

SELECT DISTINCT deptno
FROM emp;


-- �� ���� �ߺ� ���� �Ұ�
SELECT DISTINCT empno,deptno
FROM emp;


SELECT DISTINCT job,deptno
FROM emp;

--������ WHERE
SELECT * FROM emp
WHERE empno = 7499;


SELECT * FROM emp
WHERE ename = 'ȫ�浿';

SELECT * FROM emp
WHERE job = 'CLERK';

--�޿� SAL 1500�̻��� ��� ��ȸ
SELECT * FROM emp
WHERE sal >= 1500 ; 
