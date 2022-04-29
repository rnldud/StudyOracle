-- EXIST
SELECT prod_id, prod_name, prod_lgu
FROM prod
WHERE prod_lgu IN(SELECT lprod_gu
                            FROM lprod
                            WHERE lprod_nm = '������ȭ');
                            
SELECT prod_id,prod_name,prod_lgu
FROM prod
WHERE EXISTS(SELECT lprod_gu
                      FROM lprod
                      WHERE lprod_gu = prod.prod_lgu
                      AND lprod_gu = 'P301');
                    
SELECT *
FROM prod;

-- RDB �ٽ�
-- ������ DB�� ���� ū ������ ���� table�� join�Ͽ� ���ϴ� ����� ���� �ϴµ� �ִ� 
-- Equi JOIN �Ϲ��� JOIN ������ ��ġ�ϴ� �÷��� ��Ī(�ַ�PK�� FK)
-- OUTER JOIN ������ ��ġ�����ʴ��� ������� �˻��ϰ��� �� �� ��� 
--SELF JOIN �����̺� �� JOIN

--ANSI JOIN 
-- Cross Join
-- Natural Join �����̺� ������ �̸��� �÷��� ������ �� �ڵ��� �������� ����ȴ�
-- inner join 
-- outer join

-- �ټ����� Tavle�� ���� ���յ� ����� �߻��Ѵ�.
-- ��� ��, ��� �÷��� ���յȴ�
-- Ư���� ���� �̿ܿ��� ���Ǵ� ���� ���Ǿ���
-- ���� ������ �߸� �־��� ���� cartesian Product �� �߻�
SELECT *
FROM lprod,prod;

SELECT COUNT(*)
FROM lprod,prod,buyer;

----------����----------
--cross ����
-- [�Ϲ� ���]
Select m.mem_id, c.cart_member, p.prod_id
FROM member m, cart c, prod p, lprod lp, buyer b;
-- [���� ǥ�� ���]
SELECT *
FROM member cross join cart
                        cross join prod
                        cross join lprod
                        cross join buyer;
                        
-- ��ǰ���̺��� ��ǰ�ڵ�,��ǰ��,�з��� ��ȸ
-- ��ǰ���̺�: prod
-- �з����̺�: lprod
SELECT prod.prod_id "��ǰ�ڵ�",
           prod.prod_name "��ǰ��",
           lprod.lprod_nm "�з���"
FROM prod,lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

--[���� ǥ�� ���]
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
FROM prod INNER JOIN lprod  -- ����ǥ�ع���� where�� x �Ϲ����Ǹ� ����
                On(prod.prod_lgu = lprod.lprod_gu);
                
-- ALIAS�� ����� ���(�Ϲݹ��)
SELECT A.prod_id "��ǰ�ڵ�",
          A.prod_name "��ǰ��",
          B.lprod_nm "�з���",
          C.buyer_name "�ŷ�ó��"
FROM prod A, lprod B, buyer C
WHERE A.prod_lgu = B.lprod_gu
AND A.prod_buyer = C.buyer_id;

--ANSI ���� ǥ�� ���
SELECT A.prod_id "��ǰ�ڵ�",
          A.prod_name "��ǰ��",
          B.lprod_nm "�з���",
          C.buyer_name "�ŷ�ó��"
FROM prod A INNER JOIN lprod B
                On(A.prod_lgu = B.lprod_gu)
                INNER JOIN buyer C
                On(A.prod_buyer = C.buyer_id);
/*
[����]
ȸ���� ������ �ŷ�ó ������ ��ȸ�Ϸ� �Ѵ�.
ȸ�����̵�,ȸ�� �̸�, ��ǰ�ŷ�ó��,
��ǰ�з����� ��ȸ���ּ���..
*/

-- [ALIAS]�� ����� �Ϲݹ��
SELECT A.mem_id "ȸ��ID", 
            A.mem_name "ȸ���̸�",
            B.buyer_name "��ǰ�ŷ�ó��",
            C.lprod_nm "��ǰ�з���"
FROM member A, buyer B, lprod C, prod D, CART E
WHERE  A.mem_id = E.cart_member
AND E.cart_prod = D.prod_id
AND C.lprod_gu = D.prod_lgu 
AND B.buyer_lgu = C.lprod_gu;

--[ANSI]���� ǥ�� ���
SELECT  A.mem_id "ȸ��ID", 
            A.mem_name "ȸ���̸�",
            B.buyer_name "��ǰ�ŷ�ó��",
            C.lprod_nm "��ǰ�з���"
FROM member A INNER JOIN cart E
                On(A.mem_id = E.cart_member)
                INNER JOIN prod D
                On(E.cart_prod = D.prod_id)
                INNER JOIN lprod C
                On(C.lprod_gu = D.prod_lgu)
                INNER JOIN buyer B
                On(B.buyer_lgu = C.lprod_gu);
                
Select M.mem_id ȸ��ID,
        M.mem_name ȸ���̸�,
        B.buyer_name ��ǰ�ŷ�ó��,
        L.lprod_nm ��ǰ�з���
From member M Inner join cart C
                    ON(M.mem_id = C.cart_member)
                        Inner join prod P
                    ON(C.cart_prod = P.prod_id)
                        Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id)
                        Inner join lprod L
                    ON(p.prod_lgu = L.lprod_gu);

/*
[����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�,��ǰ��,�ŷ�ó�� ��ȸ
*/
-- [ALIAS]�� ����� �Ϲݹ��
SELECT A.prod_id "��ǰ�ڵ�",
           A.prod_name "��ǰ��",
           B.buyer_name "�ŷ�ó��"
FROM prod A, buyer B
WHERE A.prod_buyer = B.buyer_id
AND B.buyer_name = '�Ｚ����';


--[ANSI]���� ǥ�� ���
SELECT A.prod_id "��ǰ�ڵ�",
           A.prod_name "��ǰ��",
           B.buyer_name "�ŷ�ó��"
FROM prod A INNER JOIN buyer b 
                    ON(A.prod_buyer = B.buyer_id
                    AND B.buyer_name = '�Ｚ����');
--WHERE B.buyer_name = '�Ｚ����';

--��ǰ���̺��� ��ǰ�ڵ�,��ǰ��,�з���,�ŷ�ó��,�ŷ�ó�ּ� ��ȸ
--1)�ǸŰ����� 10���� �����̰�
--2) �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
-- [ALIAS]�� ����� �Ϲݹ��
SELECT  A.prod_id "��ǰ�ڵ�",
            A.prod_name "��ǰ��",
            C.lprod_nm "�з���",
            B.buyer_name "�ŷ�ó��",
            B.buyer_add1 "�ŷ�ó�ּ�"
FROM prod A, buyer B, lprod C 
WHERE A.prod_buyer = B.buyer_id
AND A.prod_lgu = C.lprod_gu
AND A.prod_sale < 100000
AND SUBSTR(B.buyer_add1,1,2) = '�λ�';

--[ANSI]���� ǥ�� ���
SELECT A.prod_id "��ǰ�ڵ�",
            A.prod_name "��ǰ��",
            C.lprod_nm "�з���",
            B.buyer_name "�ŷ�ó��",
            B.buyer_add1 "�ŷ�ó�ּ�"
FROM prod A INNER JOIN buyer B
              ON(A.prod_buyer = B.buyer_id)
              INNER JOIN lprod C
              ON(A.prod_lgu = C.lprod_gu
              AND A.prod_sale < 100000
              AND SUBSTR(B.buyer_add1,1,2) = '�λ�');
              -- AND buyer_add1 like '%�λ�%'
              
/*
[����]
��ǰ�з��ڵ尡 p101�ΰͿ� ����
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó �����, ȸ�����̵�, �ֹ����� ��ȸ
��, ��ǰ�з����� �������� ��������, ��ǰ���̵� �������� ��������
*/
-- [ALIAS]�� ����� �Ϲݹ��
SELECT A.lprod_nm "��ǰ�з���",
            B.prod_id "��ǰ�ڵ�",
            B.prod_sale "�ǸŰ�",
            C.buyer_charger "�ŷ�ó�����",
            D.mem_id "ȸ�����̵�",
            E.cart_qty "�ֹ�����"
FROM lprod A, prod B, buyer C, member D, cart E 
WHERE B.prod_lgu = A.lprod_gu
AND B.prod_buyer = C.buyer_id
AND B.prod_id = E.cart_prod
AND E.cart_member = D.mem_id
AND prod_lgu = 'P101'

ORDER BY lprod_nm desc, prod_id asc;


--[ANSI]���� ǥ�� ���
SELECT A.lprod_nm "��ǰ�з���",
            B.prod_id "��ǰ�ڵ�",
            B.prod_sale "�ǸŰ�",
            C.buyer_charger "�ŷ�ó�����",
            D.mem_id "ȸ�����̵�",
            E.cart_qty "�ֹ�����"
FROM lprod A INNER JOIN prod B
                    ON(B.prod_lgu = A.lprod_gu)
                    INNER JOIN buyer C
                    ON(B.prod_buyer = C.buyer_id)
                    INNER JOIN cart E
                    ON(B.prod_id = E.cart_prod)
                    INNER JOIN member D
                    ON(E.cart_member = D.mem_id
                    AND prod_lgu = 'P101')
ORDER BY lprod_nm desc, prod_id asc;

/*[1������]
'����ĳ�־�'�̸鼭 ��ǰ �̸��� '����'�� ���� ��ǰ�̰�, 
���Լ����� 30���̻��̸鼭 6���� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ��ȸ�Ͻÿ�
Alias �̸�,�ǸŰ���, �ǸŰ���+���ϸ���
*/
SELECT prod_name ��ǰ��,
             prod_sale �ǸŰ���,
             prod_sale + NVL(prod_mileage,0) ���ϸ���New
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                                 FROM lprod
                                WHERE lprod_nm = '����ĳ�־�')
      AND prod_name like '%����%'
      AND prod_id IN (SELECT buy_prod
                                FROM buyprod
                              WHERE buy_qty >= 30
                                   AND EXTRACT(month FROM buy_date) = 6);
                                   


/*
[2������]
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/
SELECT  mem_name as ȸ����,
            mem_mileage as ���ϸ���,
            CASE 
            WHEN mem_mileage > = 2500 THEN '���ȸ��'
            ELSE '�Ϲ�ȸ��' 
            END as �����÷�
FROM member
WHERE mem_id IN (SELECT cart_member
                            FROM cart
                            WHERE cart_prod IN (SELECT prod_id 
                                                            FROM prod
                                                            WHERE prod_buyer IN (SELECT buyer_id
                                                                                            FROM buyer 
                                                                                            WHERE buyer_id LIKE 'P20%' ) 
                                                           AND prod_insdate > = '05/01/31'
                                                           AND prod_cost > 200000)
                                                );                                                                                     

/* 
[3�� ����]
6���� ����(5���ޱ���)�� �԰�� ��ǰ �߿� 
���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� 
�Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
�达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/
  
SELECT mem_name as �̸�,
            mem_mileage as �������ϸ���,
            DECODE(substr(mem_regno2,1,1),1,'��','��') as ����
FROM member 
WHERE mem_id IN(SELECT cart_member 
                            FROM cart
                            WHERE cart_prod IN(
                                                    SELECT prod_id
                                                    FROM prod 
                                                    WHERE  prod_id IN(
                                                                                SELECT buy_prod
                                                                                FROM buyprod
                                                                                WHERE extract(month from buy_date) < 6)
                                                                                AND prod_delivery = '��Ź ����'
                                                                                AND prod_color is NULL )
                                                                                                                                                             
AND cart_qty >= (select AVG(cart_qty) FROM cart))
AND mem_name like '��%';

/*
[2������]
��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
                     #��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
�����Ͽ� ù��°�� ������ ȸ���� 

ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�. 
-cart buyer mem 
*/
SELECT mem_id,
           mem_name,
           round(avg(mem_mileage),2) 
FROM member
WHERE mem_id IN(
                            SELECT cart_member  
                            FROM cart
                            WHERE cart_prod IN(
                                                            SELECT prod_id
                                                            FROM prod
                                                            WHERE prod_buyer IN(
                                                                                            SELECT buyer_id
                                                                                            FROM buyer
                                                                                            Where buyer_add1 like '��õ%'
                                                                                            AND buyer_lgu like 'P1%')))
AND mem_memorial = '��ȥ�����'
AND extract(month from mem_memorialday) != '8'   
AND mem_mileage < (SELECT avg(mem_mileage) FROM member) 
GROUP BY mem_id, mem_name;

/*
[���� �����]
��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
�����Ͽ� ù��°�� ������ ȸ���� 
ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�.  
*/

/*
[���� �����]
�ּ����� ������ �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
�������� ���� ���� ���� ȸ�� �߿� 12���� ��ȥ������� �ִ�
ȸ�� ���̵�, ȸ�� �̸� ��ȸ 
�̸� �������� ���� 
*/

/*
[���� �����]
��ǻ����ǰ�� �ְ��ϸ� ������(����,��õ)�� ��� �ּҿ� '��' �� �� ���� ��� ����ڰ� ����ϴ�
��ǰ �߿��� �ǸŰ����� ��ü�ǸŰ��� �̻��� ��ǰ�� ������ ȸ������ ��� ��(����)��  �з��ϰ�
������ ȸ������ �����ϴ� ����Ϻ� ���� ���� ������� ������� �˾Ƴ��ÿ�
--����: ������
--�泲, ���� : ��û�� �������� ���
*/
                                                                           