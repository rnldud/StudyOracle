-- ���ڿ� �Լ�


-- �빮��
SELECT * FROM emp
WHERE job = UPPER('analyst') ; 

SELECT UPPER('analyst') FROM dual;

SELECT LOWER(ename) ename, 
            INITCAP(job) job 
FROM emp
WHERE comm IS NOT NULL ;


--LENGTH ����
SELECT ename, LENGTH(ename) ���ڼ�, LENGTHB(ename) ����Ʈ��
FROM emp;


--SUBSTRING ���� �ڸ� �� ����
SELECT SUBSTR('�ȳ��ϼ���. �Ѱ���IT�����п� �����͹��Դϴ�', 18,5)phase FROM dual;


--REPLACE ���� ��ü
SELECT REPLACE('�ȳ��ϼ���. �Ѱ���IT�����п� �����͹��Դϴ�', '�ȳ��ϼ���','����������')phase 
FROM dual;

SELECT 'A' || 'B' FROM dual;
SELECT CONCAT('A','B') FROM dual;


--TRIM
SELECT '     �ȳ��ϼ���     ' FROM dual;
SELECT LTRIM('     �ȳ��ϼ���     ')FROM dual;
SELECT RTRIM('     �ȳ��ϼ���     ') FROM dual;
SELECT TRIM('     �ȳ��ϼ���     ') FROM dual;

--ROUND
SELECT ROUND(15.193,1)FROM dual;

-- SYSDATE 
SELECT SYSDATE FROM dual;

--TO_CHAR
SELECT ename, hiredate, TO_CHAR(hiredate, 'yyyy-mm-dd'), TO_CHAR(sal) || '$' FROM emp;

--TO_NUMBER
SELECT TO_NUMBER(REPLACE('2400$','$','')) + 100 FROM dual;

SELECT TO_NUMBER('��õ���') + 100 FROM dual;

--TO_DATE
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22', 'mm/dd/yy') FROM dual;

--NVL
SELECT ename, job, sal, sal*12 AS annual, NVL(comm,0) comm
FROM emp
ORDER BY sal DESC;  

SELECT ename, job, sal, NVL(comm,0) comm,
        (sal*12) +  NVL(comm,0) AS annual
FROM emp
ORDER BY sal DESC;  


-- �����Լ� SUM, COUNT, MIN, MAX, AVG
SELECT sal, NVL(comm,0) FROM emp;
SELECT SUM(sal) totalsal FROM emp;
SELECT SUM(NVL(comm,0)) totalcommision FROM emp;

SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal),0) sal_avg FROM emp;

--GROUP BY
SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
FROM emp
GROUP BY job ;

--HAVING 
SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
FROM emp
GROUP BY job 
HAVING MAX(sal) > 4000;

SELECT deptno, job, AVG(sal),MAX(sal),MIN(sal),COUNT(*)
FROM emp
GROUP BY deptno,job
HAVING AVG(sal)>=1000
ORDER BY deptno DESC, job ;

--ROLLUP 
SELECT deptno, NVL(job,'�հ�') JOB, ROUND(AVG(sal),0) �޿���� ,MAX(sal) �޿��ִ� ,
            SUM(sal) �޿��հ� ,COUNT(*) �׷캰������ 
FROM emp
GROUP BY ROLLUP(deptno,job);
--HAVING AVG(sal)>=1000

