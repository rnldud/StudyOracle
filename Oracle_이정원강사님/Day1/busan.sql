-- ���̺� �����ϱ�

Create Table lprod(
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_Iprod Primary Key (lprod_gu)
);


-- ��ȸ�ϱ�
Select lprod_id, lprod_gu, lprod_nm
From lprod;


-- ������ �Է��ϱ�
Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    1, 'P101', '��ǻ����ǰ'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    2, 'P102', '������ǰ'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    3, 'P201', '����ĳ���'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    4, 'P202', '����ĳ���'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    5, 'P301', '������ȭ'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    6, 'P302', 'ȭ��ǰ'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    7, 'P401', '����/CD'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    8, 'P402', '����'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    9, 'P403', '������'
);
Select lprod_id, lprod_gu, lprod_nm
From lprod;


-- ��ǰ�з��������� ��ǰ�з� �ڵ��� ���� 
-- p201�� �����͸� ��ȸ���ּ��� 

Select *
From lprod

-- ���� �߰�
Where lprod_gu = 'P201';

-- ��ǰ�з��ڵ尡 p102�� ���ؼ� 
-- ��ǰ�з����� ���� �׼��� �������ּ���...
Select * 
From lprod
Where lprod_gu = 'P102';

Update lprod
    SET lprod_nm = '���'
    Where lprod_gu = 'P102';

-- ������ Ȯ��
Select * From lprod;


--��ǰ�з� �������� ��ǰ�з��ڵ尡 P202�� ���� �����͸� �������ּ���
Select *
From lprod
Where lprod_gu = 'P202';

Delete From lprod
Where lprod_gu = 'P202';

commit;

-- �ŷ�ó �������̺� ����
Create Table buyer(
    buyer_id char(6) NOT NULL,
    buyer_name varchar2(40) NOT NULL,
    buyer_lgu char(4) NOT NULL,
    buyer_bank varchar2(60),
    buyer_bakno varchar2(60),
    buyer_bankname varchar2(15),
    buyer_zip char(7),
    buyer_add1 varchar2(100),
    buyer_add2 varchar2(70),
    buyer_comtel varchar2(14) NOT NULL,
    buyer_fax varchar2(20)  NOT NULL);
    
    
ALTER TABLE buyer ADD(buyer_mail varchar(60) NOT NULL,
                                                buyer_charger varchar2(20),
                                                buyer_telext varchar2(2));
                                                
ALTER TABLE buyer MODIFY(buyer_name varchar(60));

ALTER TABLE buyer 
    ADD(Constraint pk_buyer Primary Key(buyer_id),
            Constraint fr_butyer_lprod ForeIgn key(buyer_lgu)
            References lprod(lprod_gu)) ;

Select* From user_cons_columns 
