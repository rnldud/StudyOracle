## 2일차 학습
### WHERE절

```sql 
SELECT ename, job, sal, sal*12 AS annual 
  FROM emp
  WHERE sal*12 >= 10000;