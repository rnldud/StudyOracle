-- ������ �Է� INSERT
INSERT INTO bonus (
    ename,
    job,
    sal,
    comm
) VALUES (
    'JACK',
    'SALESMAN',
    4000,
    NULL
);

COMMIT;    --��������
ROLLBACK;   --���
         
-- TEST ���̺� �Է� ����
INSERT INTO test 
         (idx, title , descs)
VALUES 
         ( 1, '��������', NULL )
         
INSERT INTO test 
         (idx, title , descs  )
VALUES 
         ( 2, '��������2', '���볻�볻��' );
         
INSERT INTO test 
         (idx, title , descs, regdate )
VALUES 
         ( 3, '��������3', '���볻�볻��3', SYSDATE);
         
         
 INSERT INTO test 
         (idx, title , descs, regdate )
VALUES 
         ( 4, '��������4', '���볻�볻��4', TO_DATE('2021-12-31','yyyy-mm-dd'));
         
-- ������
SELECT SEQ_TEST. CURRVAL FROM dual; -- 1
SELECT SEQ_TEST. NEXTVAL FROM dual; -- 2

INSERT INTO test 
         (idx, title , descs, regdate )
VALUES 
         ( SEQ_TEST. NEXTVAL, '��������5', '���볻�볻��5', SYSDATE);
         
INSERT INTO test 
         (idx, title , descs, regdate )
VALUES 
         ( SEQ_TEST. NEXTVAL, '��������6','���볻�볻��6', SYSDATE);


-- UPDATE

UPDATE test
       SET title = '���������?'  
         , descs = '������ ����˴ϴ�'
    WHERE idx = 5;
    
-- DELETE
DELTE FROM test
  WHERE idx = 100;
    
    
--��������
SELECT ROWNUM, su.ename, su.job, su.sal, su.comm FROM(
     SELECT ename,  job,  sal, comm FROM emp
      ORDER BY sal DESC
) su
     WHERE ROWNUM = 1;
    
        
           


