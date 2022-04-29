-- 주석, 아래의 select 구문을 실행
SELECT * FROM emp;

--컬럼을 구분해서 SELECT
SELECT ename, job, hiredate
FROM emp; 

SELECT DISTINCT deptno
FROM emp;


-- 이 경우는 중복 제거 불가
SELECT DISTINCT empno,deptno
FROM emp;


SELECT DISTINCT job,deptno
FROM emp;

--조건절 WHERE
SELECT * FROM emp
WHERE empno = 7499;


SELECT * FROM emp
WHERE ename = '홍길동';

SELECT * FROM emp
WHERE job = 'CLERK';

--급여 SAL 1500이상인 사람 조회
SELECT * FROM emp
WHERE sal >= 1500 ; 
