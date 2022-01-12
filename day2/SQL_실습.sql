--행단위로 조회하는 셀렉션
SELECT * FROM emp
WHERE sal = 5000;

SELECT * FROM emp
WHERE job = 'CLERK';

SELECT * FROM emp
WHERE comm = 0 OR comm IS NULL ;


-- 보너스가 NULL이고 직업이 ANALYST인 사람만 셀렉션
SELECT * FROM emp
WHERE comm IS NULL  AND job = 'ANALYST';

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 30;                  

--조인, 두 개 이상의 테이블을 하나의 테이블 처럼 조회하는 방법
SELECT e.empno, e.ename, e.job, e.hiredate, e.sal , d.deptno, d.dname 
    FROM emp e
    JOIN dept d 
    ON e.deptno = d.deptno;

--DISTNCT 복습
SELECT DISTINCT job FROM emp;

--별칭 ALIAS
SELECT ename, job, sal, sal*12 AS annual 
FROM emp
ORDER BY sal DESC;    --ASC 오름차순 / DESC 내림차순




