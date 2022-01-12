--������� ��ȸ�ϴ� ������
SELECT * FROM emp
WHERE sal = 5000;

SELECT * FROM emp
WHERE job = 'CLERK';

SELECT * FROM emp
WHERE comm = 0 OR comm IS NULL ;


-- ���ʽ��� NULL�̰� ������ ANALYST�� ����� ������
SELECT * FROM emp
WHERE comm IS NULL  AND job = 'ANALYST';

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 30;                  

--����, �� �� �̻��� ���̺��� �ϳ��� ���̺� ó�� ��ȸ�ϴ� ���
SELECT e.empno, e.ename, e.job, e.hiredate, e.sal , d.deptno, d.dname 
    FROM emp e
    JOIN dept d 
    ON e.deptno = d.deptno;

--DISTNCT ����
SELECT DISTINCT job FROM emp;

--��Ī ALIAS
SELECT ename, job, sal, sal*12 AS annual 
FROM emp
ORDER BY sal DESC;    --ASC �������� / DESC ��������




