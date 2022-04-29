-- 테이블 생성하기

Create Table lprod(
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_Iprod Primary Key (lprod_gu)
);


-- 조회하기
Select lprod_id, lprod_gu, lprod_nm
From lprod;


-- 데이터 입력하기
Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    1, 'P101', '컴퓨터제품'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    2, 'P102', '전자제품'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    3, 'P201', '여성캐쥬얼'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    4, 'P202', '남성캐쥬얼'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    5, 'P301', '피혁잡화'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    6, 'P302', '화장품'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    7, 'P401', '음반/CD'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    8, 'P402', '도서'
);

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values ( 
    9, 'P403', '문구류'
);
Select lprod_id, lprod_gu, lprod_nm
From lprod;


-- 상품분류정보에서 상품분류 코드의 값이 
-- p201인 데이터를 조회해주세요 

Select *
From lprod

-- 조건 추가
Where lprod_gu = 'P201';

-- 상품분류코드가 p102에 대해서 
-- 상품분류명의 값을 항수로 수정해주세요...
Select * 
From lprod
Where lprod_gu = 'P102';

Update lprod
    SET lprod_nm = '향수'
    Where lprod_gu = 'P102';

-- 수정값 확인
Select * From lprod;


--상품분류 정보에서 상품분류코드가 P202에 대한 데이터를 삭제해주세요
Select *
From lprod
Where lprod_gu = 'P202';

Delete From lprod
Where lprod_gu = 'P202';

commit;

-- 거래처 정보테이블 생성
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
