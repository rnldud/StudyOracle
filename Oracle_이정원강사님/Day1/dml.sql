/*
lprod : ��ǰ�з�����
prod : ��ǰ���� / �ŷ�ó, ��ǰ�з�
buyer : �ŷ�ó���� 
member : ȸ������
cart : ����(��ٱ���)���� / ȸ��, ��ǰ
buyprod : �԰��ǰ���� / ��ǰ����
remain : ����������
*/

-- ��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�
-- �з��ڵ�, �з���
-- IN �ȿ��� �ϳ��� �÷��� ���� ������(��)�� ��ȸ�� �� �ִ� ���·� �����Ǿ� ��
-- �������� �������
Select lprod_gu �з��ڵ�, lprod_nm �з���
From lprod
Where lprod_gu IN (Select prod_lgu From prod);

-- ��ǰ �з������Ϳ��� ���� ��ǰ���̺� �������� ���� �з��� �˻��Ͻÿ�.
-- ��Ī�� �з��ڵ�, �з���
Select lprod_gu �з��ڵ�, lprod_nm �з���
From lprod
Where lprod_gu NOT IN (Select prod_lgu From prod);

/*
[����]
�ѹ��� ������ ���� ���� ȸ��ID, �̸� ��ȸ
*/
Select mem_id ȸ��ID, mem_name ȸ���̸�
From member
Where mem_id NOT IN (Select cart_member From cart);

/*
������ ��ȸ�ϱ�
1. ���̺� ã��
2. ��ȸ�� Į�� ã��
3. ���� ���� Ȯ��
*/

/*
[����]
�ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ�Ϸ��� �Ѵ�.
�Ǹŵ� ���� ���� ��ǰ�̸��� ��ȸ���ּ���.
*/
Select prod_name ��ǰ��
From prod
Where prod_id NOT IN(Select cart_prod From cart);

/*
[����]
ȸ�� �� '������' ȸ���� ���ݱ��� �����ߴ� ��� ��ǰ���� ��ȸ���ֽÿ�.
*/
Select prod_name ��ǰ��
From prod
Where prod_id IN(Select cart_prod From cart
                        Where cart_member = 'a001');

Select prod_name ��ǰ��
From prod
Where prod_id 
    IN(Select cart_prod From cart
        Where cart_member 
            IN (Select mem_id From member
                Where mem_name = '������'));
                                                        
Select *
From member
Where mem_id = 'a001';

SELECT *
FROM CART;

-- ��ǰ �� �ǸŰ����� 10���� �̻�, 30���� ������ ��ǰ�� ��ȸ
-- ��ȸ �÷��� ��ǰ��, �ǸŰ���
-- ������ �ǸŰ����� �������� ��������
Select prod_name ��ǰ��, prod_sale ��ǰ����
From prod
Where prod_sale >= 100000
    AND prod_sale <= 300000
Order By prod_sale Desc;

Select prod_name ��ǰ��, prod_sale ��ǰ����
From prod
Where prod_sale Between 100000 AND 300000
Order By prod_sale Desc;

-- ȸ�� �� ������ 1975-01-01 ���� 1976-12-31 ���̿� �¾ ȸ���� �˻��Ͻÿ�.
-- ��Ī ȸ��ID, ȸ����, ����
Select mem_id ȸ��ID, mem_name ȸ����, mem_regno1 ����
From member
Where mem_regno1 Between 750101 AND 761231;

Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_bir Between '75-01-01' AND '76-12-31';

Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_bir Between '75/01/01' AND '76/12/31';

/*
[����]
�ŷ�ó ����� '������'���� ����ϴ� ��ǰ�� ������ ȸ���� ��ȸ
ȸ��ID, ȸ���̸��� ��ȸ
*/
Select mem_id ȸ��ID, mem_name ȸ���̸�
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_buyer
                    IN(Select buyer_id From buyer
                        Where buyer_charger = '������')));


Select *
From buyer;

select * from prod;

select * from lprod;

Select mem_id ȸ��ID, mem_name ȸ���̸�
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_lgu
                    IN(Select lprod_gu From lprod
                        Where lprod_gu
                        IN(Select buyer_lgu From buyer
                            Where buyer_charger = '������'))));

-- ��ǰ �� ���԰��� 300,000~1,500,000�̰� �ǸŰ��� 800,000~2,000,000 �� ��ǰ�� �˻��Ͻÿ�.
-- ��Ī�� ��ǰ��, ���԰�, �ǸŰ�
Select prod_name ��ǰ��, prod_cost ���԰�, prod_sale �ǸŰ�
From prod
Where prod_cost Between 300000 AND 1500000
    AND prod_sale Between 800000 AND 2000000;
    
-- ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻��Ͻÿ�.
-- ��Ī�� ȸ��ID, ȸ����, ����
-- ���ϰ� �ֹι�ȣ��6�ڸ��� �ٸ� �� �ִ�.
Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_regno1 NOT Between 750101 AND 751231;

Select mem_id ȸ��ID, mem_name ȸ����, mem_bir ����
From member
Where mem_bir NOT Between '75-01-01' AND '75-12-31';

-- ȸ�����̺��� �达 ���� ���� ȸ���� �˻��Ͻÿ�.
-- ��Ī�� ȸ��ID, ����
Select mem_id ȸ��ID, mem_name ����
From member
Where mem_name Like '��%';

-- ȸ�����̺��� �ֹε�Ϲ�ȣ �������� �˻��Ͽ� 1975����� ������ ȸ���� �˻��Ͻÿ�.
-- ��Ī ȸ��ID, ����, �ֹε�Ϲ�ȣ
Select mem_id ȸ��ID, mem_name ����, mem_regno1 �ֹε�Ϲ�ȣ
From member
Where mem_regno1 NOT Like '75%';

-- CONCAT()
-- �ΰ��� ���ڿ��� ��ģ��.
Select CONCAT('My Name is ', mem_name) ����
From member;

-- CHR, ASCII
-- ASCII���� ���ڷ�, ���ڸ� ASCII������ ��ȯ
Select CHR(65) "CHR", ASCII('A') "ASCII"
From dual;

-- LOWER() = �ش� ���ڳ� ���ڿ��� �ҹ��ڷ� ��ȯ
-- UPPER() = �빮�ڷ� ��ȯ
-- INITCAP() = ù ���ڸ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
Select LOWER('DATA mainpulation Language') "LOWER",
        UPPER('DATA mainpulation Language') "UPPER",
        INITCAP('DATA mainpulation Language') "INITCAP"
From dual;

-- ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻��Ͻÿ�.
-- ��Ī�� ��ȯ �� ID, ��ȯ �� ID
Select mem_id ��ȯ��ID, UPPER(mem_id) ��ȯ��ID 
From member;

-- LPAD, RPAD() = ������ ���� n���� c1�� ä��� ���� ������ c2�� ä����

-- LTRIM(), RTRIM() = ����, ������ ���鹮�ڸ� ����
-- TRIM() = ������ ���鹮�� ����

-- SUBSTR( , , ) = ���ڿ��� �Ϻκ��� �����ؼ� ��ȸ

-- TRANSLATE(c1,c2,c3) = c1���ڿ��� ���Ե� ���� �� c2�� ������ ���ڰ� c3���ڷ� ���� ����

-- REPLACE() = ���ڳ� ���ڿ��� ġȯ
Select REPLACE('SQL Project', 'SQL', 'SSQQLL') ����ġȯ1,
    REPLACE('Java Flex Via', 'a') ����ġȯ2
From dual;

-- ȸ�����̺��� ȸ������ �� ���� '��' ---> '��' �� ġȯ�Ͽ� �ڿ� �̸��� ���� �� �˻��Ͻÿ�.
-- ��Ī�� ȸ����, ȸ����ġȯ
-- ��� '��' ---> '��'
Select mem_name ȸ����,
    REPLACE(mem_name, '��', '��') ȸ����ġȯ
From member;

Select mem_name ȸ����,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '��', '��'), SUBSTR(mem_name, 2)) ȸ����ġȯ
From member;

Select mem_name ȸ����,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '��', '��'), SUBSTR(mem_name, 2, 3)) ȸ����ġȯ
From member;

-- ROUND(n, l) = ������ �ڸ���(l) �ؿ��� �ݿø�
-- TRUNC(n, l) = ���� ����, �ݿø��� �ƴ϶� ����
-- ���� �ڸ� �� = 0 , �Ҽ��� ù°�ڸ� �� = 1 ....

-- MOD(c, n) = n���� ���� ������

-- ��¥ �Լ�
-- SYSDATE = �ý��ۿ��� �����ϴ� ���� ���ڿ� �ð� ��
-- dual = ���� ���̺� 
Select sysdate -1
From dual;

-- ADD_MONTHS(data, n) = date�� ���� ���� ��¥
-- NEXT_DAY(data, char) = �ش� ��¥ ���� ���� ���� ������ ��¥
-- LAST_DAY(date) = ���� ������ ��¥
Select NEXT_DAY(SYSDATE, '������'),
        LAST_DAY(SYSDATE)
From dual;

-- �̹����� ��ĥ �����ִ���?
Select LAST_DAY(SYSDATE) - SYSDATE �����ϼ�
From dual;

-- EXTRACT(fmf FROM data) = ��¥���� �ʿ��� �κи� ����
Select EXTRACT(YEAR FROM SYSDATE) "�⵵",
    EXTRACT(MONTH FROM SYSDATE) "��",
    EXTRACT(DAY FROM SYSDATE) "��"
From dual;

-- ������ 3���� ȸ���� �˻��Ͻÿ�.
Select mem_name ȸ����, EXTRACT(MONTH From mem_bir) ����
From member
Where EXTRACT(MONTH From mem_bir) = '3';

/*
[����]
ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ
- ��ȸ �÷� : ��ǰ��
- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ. ��ȸ ����� �ߺ� ����
*/
-- ����.. ����Բ� 
-- ���� = EXTRACT(YEAR FROM mem_bir) = 1973
Select DISTINCT prod_name ��ǰ��
From prod
Where prod_id 
    IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where mem_bir Between '73-01-01' AND '73-12-31'
                        AND prod_name LIKE '%�Ｚ%'))
Order By prod_name ASC;

Select DISTINCT prod_name ��ǰ��
From prod
Where prod_name LIKE '%�Ｚ%'  
    AND prod_id 
        IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where EXTRACT(YEAR FROM mem_bir) = 1973))
Order By prod_name ASC;

-- CAST(expr AS type) = ��������� �� ��ȯ
-- TO_CHAR() = ����, ����, ��¥�� ������ ������ ���ڿ� ��ȯ
-- TO_NUMBER() =  ���������� ���ڿ��� ���ڷ� ��ȯ
-- TO_DATE() = ��¥ ������ ���ڿ��� ��¥�� ��ȯ
Select TO_CHAR(CAST('2008-12-25' AS DATE), 'YYYY.MM.DD HH24:MI')
From dual;

Select TO_CHAR(SYSDATE, 'AD YYYY, CC "����"')
From dual;

-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻��Ͻÿ�
-- ��Ī = ��ǰ��, ��ǰ�ǸŰ�, �԰���
Select prod_name ��ǰ��, prod_sale ��ǰ�ǸŰ�, 
        TO_CHAR(prod_insdate, 'YYYY-MM-DD') �԰���
From prod;

-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�.
-- ��������� 1976�� 1�� ����̰� �¾ ������ �����
Select CONCAT(CONCAT(mem_name, '�� ��'), TO_CHAR(mem_bir,'YYYY'))
From member;

Select (mem_name || '����' || 
        TO_CHAR(mem_bir,'YYYY') || '�� ' || 
        TO_CHAR(mem_bir,'D') ||'�� ����̰� �¾ ������ ' ||  
        TO_CHAR(mem_bir, 'day') || '�Դϴ�.'
        ) as sumStr
From member;

-- ����
-- 9�� ��ȿ�� ����, 0�� ��ȿ�� ���� = �ǹ̾��� �ڸ���
-- $, L = �޷� �� ���� ȭ�� ��ȣ
-- MI = ������ ��� ������ ���̳ʽ� ǥ��, ������ ǥ��
-- PR = ������ ��� "<>"��ȣ�� ���´�. ������ ǥ��
-- X = �ش� ���ڸ� 16������ ǥ��
Select TO_CHAR(1234.6, '999,999.00')
From dual;

Select TO_CHAR(-1234.6, 'L999,999.00PR')
From dual;

Select TO_CHAR(255, 'XXX')
From dual;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ����� ����Ͻÿ�
-- ��, ������ õ���� ���� �� ��ȭǥ��
Select prod_id ��ǰ�ڵ�, prod_name ��ǰ��, 
        TO_CHAR(prod_cost,'L9,999,999') ���԰���, 
        TO_CHAR(prod_sale,'L9,999,999') �Һ��ڰ���, 
        TO_CHAR(prod_price,'L9,999,999') �ǸŰ���
From prod;

-- TO_NUMBER() =  ���������� ���ڿ��� ���ڷ� ��ȯ

-- ȸ�����̺��� '�̻���'ȸ���� ȸ��ID 2~4 ���ڿ��� ���������� ġȯ�� �� 10�� ���Ͽ� ���ο� ȸ��ID�� �����Ͻÿ�.
-- ��Ī = ȸ��ID, ����ȸ��ID
-- ����...

Select mem_id ȸ��ID,
        Substr(mem_id, 1, 2) ||
        (Substr(mem_id, 3, 4) + 10)
From member
Where mem_name = '�̻���';

-- ��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��
-- AVG() = �׷��Լ�
/*
[��Ģ]!!
�Ϲ� �÷��� �׷� �Լ��� ���� ����� ��쿡��
�� Group By���� �־� �־ �մϴ�.
�׸��� Group By������ �Ϲ� �÷��� ��� ���� �մϴ�.
*/
Select prod_lgu "��ǰ �з�",
        ROUND(AVG(prod_cost), 2) "���԰��� ���"
From prod
Group By prod_lgu;

Select ROUND(AVG(prod_cost), 2) "���԰��� ���"
From prod;

-- ��ǰ���̺��� �� �ǸŰ��� ��� ���� ���Ͻÿ�,
-- ��Ī = ��ǰ�ǸŰ������
Select ROUND(AVG(prod_sale), 2) "��ǰ�ǸŰ������"
From prod;

-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��հ�
Select prod_lgu,  
        ROUND(AVG(prod_sale), 2) "��ǰ�ǸŰ������"
From prod
Group By prod_lgu;

Select prod_lgu,  
        AVG(prod_sale) as avg_sale
From prod
Group By prod_lgu;

-- COUNT(col/*) = ��ȸ ���� �� �ش� �÷����� �ڷ��

-- ��ٱ������̺��� ȸ���� COUNT���� �Ͻÿ�.
-- ��Ī = ȸ��ID, �ڷ��(DISTINCT), �ڷ��, �ڷ��(*)
Select cart_member , COUNT(cart_member) as avg_member
From cart
Group By cart_member;

/*
[����]
���ż����� ��ü��� �̻��� ������ ȸ������ ���̵�� �̸��� ��ȸ.
*/
-- �� ��.. 
Select mem_id ȸ��ID, mem_name ȸ����
From member
Where mem_id 
    IN(Select cart_member From cart
        Where cart_qty >= (
            Select AVG(cart_qty) -- ���ϴ� ������ �ۿ��� �����غ��� ()[��ȣ]�� �̿��ؼ� �߰��غ���..!!!!
            From cart
            )
        )
Order By mem_regno1 ASC;

Select cart_member ȸ��ID, AVG(cart_qty) ���
From cart
Group By cart_member;

Select AVG(cart_qty) ���
From cart;

-- COUNT(*) ���õ� �ڷ��Ǽ� *��ȸ ��� �÷����� NULL �� ��� �� 
SELECT COUNT(DISTINCT prod_cost),COUNT(All prod_cost),COUNT(prod_cost),COUNT(*)
FROM prod;

/*����
���ų���(��ٱ���) �������� ȸ�� ���̵� ���� �ֹ�[����]�� ���� ��տ� ��ȸ���ּ���
ȸ���Ƶ� �������� �������� 
*/

SELECT cart_member , AVG(cart_qty) ���ż���
FROM cart 
GROUP By cart_member
ORDER BY cart_member;

/*[����]
��ǰ �������� �ǸŰ����� ��հ��� �����ּ���.
��, ��հ��� �Ҽ��� 2°�ڸ� ���� ǥ�� ���ּ���
*/
SELECT round(AVG(prod_sale),2) avg_sale
FROM prod;

/*[����]
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� ���Ͻÿ�
��ȸĮ���� ��ǰ�з��ڵ�,��ǰ�з��� �ǸŰ����� ���
��, ��հ��� �Ҽ��� 2°�ڸ����� ǥ��
*/
-- ��ǰ�з��ڵ�: prod_lgu
SELECT prod_lgu, 
            round(AVG(prod_sale),2) AS avg_sale
FROM prod
group by prod_lgu;

-- ȸ�� ���̺��� ��� �������� COUNT �����Ͻÿ�? (ALIAS�� ���WHDFBTN)
SELECT COUNT(DISTINCT mem_like) ���������
FROM member;

-- ȸ�� ���̺��� ��̺� count �����Ͻÿ� (��Ű,�ڷ��,�ڷ��(*)
SELECT mem_like ���,
COUNT(mem_like) �ڷ��, COUNT(*) "�ڷ��(*)"
FROM member
GROUP BY mem_like;

-- ȸ�� ���̺��� ���� �������� count�Ͻÿ� 
SELECT COUNT(Distinct(mem_job)) ����������
FROM member;

-- �ش� ������ 
SELECT mem_job, COUNT(mem_job) ����������
FROM member
GROUP BY mem_job 
ORDER BY mem_job desc;

/*
[����]
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ����
���̵�, �̸�, ���ϸ��� ��ȸ
������ ���ϸ����� ������
*/

SELECT mem_id, mem_name, mem_mileage
FROM member
WHERE mem_mileage >= (
                                        Select avg(mem_mileage)
                                        FROM member)
ORDER BY mem_mileage Desc;

SELECT *
FROM cart;
/*
������ 2005�⵵ 7�� 11���̶� �����ϰ� ��ٱ��� ���̺� �߻���
�߰� �ֹ���ȣ �˻��Ͻÿ�
(alias�� ���� ����� ���� ���� ���� �ֹ���ȣ, �߰��ֹ���ȣ)
*/

SELECT MAX(cart_no) AS "������� �ֹ���ȣ" , MAX(CART_NO)+1 AS "�߰��ֹ���ȣ"
FROM cart
Where cart_no LIKE '20050711%';

/*
[����]
������������ �⵵���� �Ǹŵ� ��ǰ�� ����,
��� ���ż��� ��ȸ
������ �⵵�� �������� ��������
*/

SELECT substr(cart_no,1,4) as yyyy,   
            sum(cart_qty) as sum_qty, 
            avg(cart_qty) as avg_qty
FROM cart
group by substr(cart_no,1,4)
order by yyyy desc;

/*
������������ �⵵��, ��ǰ�з��ڵ庰�� ��ǰ�� ���� ��ȸ
������ �⵵�� �������� ��������
*/
--�Ϲ� �÷��� ������ group by�ؾ���
-- count�� �׷��Լ�

SELECT substr(cart_no,1,4) as sub_no,
           count(cart_qty) as sub_prod,
           substr(cart_prod,1,4) as cnt_prod
FROM cart
GROUP BY substr(cart_no,1,4), substr(cart_prod,1,4)
ORDER BY sub_no desc;

/*
ȸ�� ���̺��� ȸ����ü�� ���ϸ��� ���,���ϸ��� �հ�
�ְ��ϸ���,�ּҸ��ϸ���, �ο����� �˻��Ͻÿ�?
 alias ���ϸ������,���ϸ����հ� �ְ��ϸ��� �ּҸ��ϸ��� �ο���
 */
 SELECT AVG(mem_mileage),
            SUM(mem_mileage),
            MAX(mem_mileage),
            MIN(mem_mileage),
            COUNT(mem_mileage) 
FROM member;

/*
��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü�� 
���,�հ�,�ְ�,������,�ڷ����
�˻��Ͻÿ�?
*/
--���� �ڷ���� 20�� �̻��� ��..
SELECT prod_lgu, 
           AVG(prod_sale) as prod_AVG,
           SUM(prod_sale) AS prod_SUM, 
           MAX(prod_sale) AS prod_MAX,
           MIN(prod_sale) AS prod_MIN,
           COUNT(prod_sale) AS prod_count
FROM prod
GROUP by prod_lgu
HAVING COUNT(prod_sale) >= 20;  --�ڷ�� ����� �����

-- WHERE �� : �Ϲ�����
-- HAVING ��: �׷����Ǹ� (�׷��Լ��� �����  ����ó��)

/* 
ȸ�� ���̺��� ����(�ּ�1�� 2�ڸ�), ���ϳ⵵ ���� ���ϸ��� ���,
���ϸ��� �հ�, �ְ��ϸ���, �ּҸ��ϸ���,�ڷ�� �˻�)
ALIAS ; ����, ���Ͽ���, ���ϸ������,���ϸ����հ�, �ְ��ϸ���,�ּҸ��ϸ���, �ڷ��
*/
SELECT substr((mem_add1),1,2) AS sub_add,
            TO_CHAR(mem_bir, 'yyyy') AS mem_Bir, 
            avg(mem_mileage),
            sum(mem_mileage), 
            max(mem_mileage), 
            min(mem_mileage), 
            count(mem_mileage) 
FROM member 
GROUP BY substr((mem_add1),1,2), TO_CHAR(mem_bir, 'yyyy') ;

-- NULL 
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
WHERE buyer_charger LIKE '��%';

UPDATE buyer SET buyer_charger = NULL
WHERE buyer_charger LIKE '��%';

UPDATE buyer SET buyer_charger = ''
WHERE buyer_charger LIKE '��%';

-- NVL(C,R) C�� NULL�� �ƴϸ� C������ NULL�̸� R��ȯ 
-- IS NULL: NULL������ �ƴ��� ��

-- �ش� �÷��� NULL�� �� ��ȸ
-- NULL�� �̿� NULL �� ��
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
WHERE buyer_charger = NULL; 

-- NULL�ΰ� ������
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
WHERE buyer_charger IS NULL;

-- NULL �ƴѰ� ������
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
WHERE buyer_charger IS NOT NULL; 

-- �ش� Į���� NULL�� ��쿡 ����� ���ڳ� ���� ġȯ
-- NULL �� �����ϴ� ���·� ��ȸ
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer;
-- NVL�� �̿� NULL���� ��츸 ���ٷ� ġȯ
SELECT buyer_name �ŷ�ó,
            NVL(BUYER_CHARGER,'����') 
FROM buyer;

--NULL�� ���Ұ��� 0���� ���� NVL(--,���氪)

--ȸ�� ���ϸ����� 100�� ���� ��ġ�� �˻��Ͻÿ�
SELECT mem_name as "����",
            mem_mileage as "���ϸ���",
            NVL(mem_mileage,0)+100 as "���渶�ϸ���"
FROM member;

--ȸ�� ���ϸ����� ������ ����ȸ�� null�� ��� ������ȸ��
SELECT mem_name as "����",
            mem_mileage as "���ϸ���",
            NVL2(mem_mileage,'����ȸ��','������ȸ��') as "ȸ������"
FROM member; 

--DECODE
SELECT DECODE(9,10,'A',9,'B',8,'C','D')
FROM dual;

SELECT DECODE( SUBSTR(prod_lgu,1,2),
                        'P1','��ǻ��/������ǰ',
                        'P2','�Ƿ�',
                        'P3','��ȭ', '��Ÿ')
FROM prod;

/*
��ǰ�з��� ���� �α��ڰ� P1�̸� �ǸŰ��� 10%�λ��ϰ�
P2�̸� �ǸŰ��� 15%�λ��ϰ� �������� ���� �ǸŰ��� �˻��Ͻÿ�
decode ���, ��ǰ��,�ǸŰ�,�����ǸŰ�
*/
SELECT prod_name as "��ǰ��", 
           prod_sale as "�ǸŰ�",
            DECODE(SUBSTR(prod_lgu,1,2),
                        'P1', prod_sale + (prod_sale * 10/100),
                        'p2', 'prod_sale + (prod_sale * 15/100)'
                        ) as "�����ǸŰ�"
FROM prod;

From prod;

-- CASE WHEN THEN 
-- ELSE END RESULT

-- CASE WHEN THEN 
-- ELSE END

-- ȸ���������̺��� �ֹε�� ���ڸ�(7�ڸ��� ù��°)���� ���� ������ �˻�
-- CASE ���� ���
-- ��Ī = ȸ����, �ֹε�Ϲ�ȣ(�ֹ�1, �ֹ�2), ����
Select mem_name ȸ����, 
        SUBSTR(mem_regno2,1,1) �ֹε�Ϲ�ȣ, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '����'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '����' 
                END "����"   
From member;

Select mem_name ȸ����, 
        SUBSTR(mem_regno2,1,1) �ֹε�Ϲ�ȣ, 
        CASE 
                WHEN SUBSTR(mem_regno2,1,1) = '1' 
                            THEN '����'
                ELSE
                    '����' 
                END "����"   
From member;


-- ���� ����� ���� 3�� �����ϱ� 

--[1����]
--�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
--�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
--02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
--(�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�. (��ȭǥ�� �� õ��������))
--(alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)

Select prod_name,
         prod_lgu,
         TO_CHAR(prod_sale,'L9,999,999'),
         TO_CHAR(DECODE(SUBSTR(prod_lgu,3,4),
                        '01', prod_sale - (prod_sale * 10/100),
                        '02', prod_sale + (prod_sale * 5/100)),'L9,999,999') as "�����ǸŰ�"                       
From prod
Where prod_id IN(SELECT cart_prod 
                            From cart
                            WHERE cart_member IN (SELECT mem_id
                                                                FROM member    
                                                                Where EXTRACT(MONTH From mem_bir) = '1' ))                                                          
and prod_sale Between 500000 AND 1000000;

-- [ALIAS]�� ����� �Ϲݹ��
SELECT P.prod_name "��ǰ��",
           P.prod_lgu "��ǰ�з�",
           TO_CHAR(P.prod_sale,'L9,999,999'),
           TO_CHAR(DECODE(SUBSTR(P.prod_lgu,3,4),
                        '01', P.prod_sale - (P.prod_sale * 10/100),
                        '02', P.prod_sale + (P.prod_sale * 5/100)),'L9,999,999') "�����ǸŰ�"                        
FROM prod P, cart C, member M
WHERE P.prod_id = C.cart_prod
AND C.cart_member = M.mem_id
AND EXTRACT(MONTH From mem_bir) = '1' 
And prod_sale Between 500000 AND 1000000;


--[ANSI]���� ǥ�� ���
SELECT P.prod_name "��ǰ��",
           P.prod_lgu "��ǰ�з�",
           TO_CHAR(P.prod_sale,'L9,999,999'),
           TO_CHAR(DECODE(SUBSTR(P.prod_lgu,3,4),
                        '01', P.prod_sale - (P.prod_sale * 10/100),
                        '02', P.prod_sale + (P.prod_sale * 5/100)),'L9,999,999') "�����ǸŰ�"    
FROM prod P INNER JOIN cart C
                    ON(P.prod_id = C.cart_prod)
                    INNER JOIN member M
                    ON(C.cart_member = M.mem_id
                    AND EXTRACT(MONTH From mem_bir) = '1' 
                    And prod_sale Between 500000 AND 1000000);
                    

/*[����2]
ȸ���� 1975����̰� ���� �ּ��� ȸ���� �����ߴ� ����ǰ �߿� 
�ǸŰ��� �ǸŰ��� ��ü��պ��� ���� ��ǰ�� �˻��غ�����.
�� 
1. �ǸŰ��� �������� ���������ϰ�, �ǸŰ��� õ���� ����ǥ��
2. ��ǰ������ NULL���� '����'���� ó��
*/

SELECT prod_id ��ǰ�ڵ�,
             prod_name ��ǰ��,
             to_char(prod_sale,'999,999,999') �ǸŰ�,
             NVL(prod_color,'����') ��ǰ����,
             COUNT(prod_color) ���򺰰���
   FROM prod
 WHERE prod_sale > (SELECT AVG(prod_sale)
                                 FROM prod)
             AND prod_id IN(SELECT cart_prod 
                                     FROM cart
                                    WHERE cart_member IN(SELECT mem_id
                                                                        FROM member
                                                                      WHERE EXTRACT(year from mem_bir) = 1975
                                                                           AND SUBSTR(mem_add1,1,2) = '����'));
                                                                           
