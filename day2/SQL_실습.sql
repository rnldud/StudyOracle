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

SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE sal != 1000;    --<>,!=�� ���� ���� ^=���� �Ⱦ���


SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE NOT sal = 1000;

--IN
SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE sal IN (800,1600,5000);

SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE sal = 800 OR sal = 1600 OR sal =5000;


--BETWEEN A AND B
SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE sal>=1600 AND sal<= 2975;

SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE sal BETWEEN 1600 AND 2975;

-- LIKE
SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE ENAME = 'JONES';

SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE ENAME LIKE 'J%';

SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE ENAME LIKE '%ER';

SELECT ename, job, sal, sal*12 AS annual 
FROM emp
WHERE ename LIKE '__RD';             --J%, %ER, %E%, __RD

--NULL, �Լ��� NVL() ���߿� to be continued
SELECT ename,job,sal,comm
From emp
WHERE comm IS NULL ;

SELECT ename,job,sal,comm
From emp
WHERE comm IS NOT NULL ;

--����
SELECT empno, ename, job FROM emp
UNION 
SELECT deptno,dname,loc FROM dept;

SELECT empno, ename, job FROM emp
UNION ALL
SELECT deptno,dname,loc FROM dept;

SELECT empno, ename, job FROM emp
WHERE comm is NOT NULL
UNION ALL
SELECT deptno,dname,loc FROM dept;

