-- EXIST
SELECT prod_id, prod_name, prod_lgu
FROM prod
WHERE prod_lgu IN(SELECT lprod_gu
                            FROM lprod
                            WHERE lprod_nm = '피혁잡화');
                            
SELECT prod_id,prod_name,prod_lgu
FROM prod
WHERE EXISTS(SELECT lprod_gu
                      FROM lprod
                      WHERE lprod_gu = prod.prod_lgu
                      AND lprod_gu = 'P301');
                    
SELECT *
FROM prod;

-- RDB 핵심
-- 관계형 DB의 가장 큰 장점은 많은 table을 join하여 원하는 결과를 도출 하는데 있다 
-- Equi JOIN 일반적 JOIN 조건이 일치하는 컬럼을 매칭(주로PK와 FK)
-- OUTER JOIN 조건이 일치하지않더라도 모든행을 검색하고자 할 때 사용 
--SELF JOIN 한테이블 내 JOIN

--ANSI JOIN 
-- Cross Join
-- Natural Join 각테이블에 동일한 이름의 컬럼이 존재할 때 자동을 ㅗ조건이 적용된다
-- inner join 
-- outer join

-- 다수개의 Tavle로 부터 조합된 결과가 발생한다.
-- 모든 행, 모든 컬럼이 조합된다
-- 특별한 목적 이외에는 사용되는 일이 거의없다
-- 조인 조건을 잘못 주었을 때도 cartesian Product 가 발생
SELECT *
FROM lprod,prod;

SELECT COUNT(*)
FROM lprod,prod,buyer;

----------조인----------
--cross 조인
-- [일반 방식]
Select m.mem_id, c.cart_member, p.prod_id
FROM member m, cart c, prod p, lprod lp, buyer b;
-- [국제 표준 방식]
SELECT *
FROM member cross join cart
                        cross join prod
                        cross join lprod
                        cross join buyer;
                        
-- 상품테이블에서 상품코드,상품명,분류명 조회
-- 상품테이블: prod
-- 분류테이블: lprod
SELECT prod.prod_id "상품코드",
           prod.prod_name "상품명",
           lprod.lprod_nm "분류명"
FROM prod,lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

--[국제 표준 방식]
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
FROM prod INNER JOIN lprod  -- 국제표준방식은 where절 x 일반조건만 존재
                On(prod.prod_lgu = lprod.lprod_gu);
                
-- ALIAS를 사용한 방법(일반방식)
SELECT A.prod_id "상품코드",
          A.prod_name "상품명",
          B.lprod_nm "분류명",
          C.buyer_name "거래처명"
FROM prod A, lprod B, buyer C
WHERE A.prod_lgu = B.lprod_gu
AND A.prod_buyer = C.buyer_id;

--ANSI 국제 표준 방식
SELECT A.prod_id "상품코드",
          A.prod_name "상품명",
          B.lprod_nm "분류명",
          C.buyer_name "거래처명"
FROM prod A INNER JOIN lprod B
                On(A.prod_lgu = B.lprod_gu)
                INNER JOIN buyer C
                On(A.prod_buyer = C.buyer_id);
/*
[문제]
회원이 구매한 거래처 정보를 조회하려 한다.
회원아이디,회원 이름, 상품거래처명,
상품분류명을 조회해주세요..
*/

-- [ALIAS]를 사용한 일반방식
SELECT A.mem_id "회원ID", 
            A.mem_name "회원이름",
            B.buyer_name "상품거래처명",
            C.lprod_nm "상품분류명"
FROM member A, buyer B, lprod C, prod D, CART E
WHERE  A.mem_id = E.cart_member
AND E.cart_prod = D.prod_id
AND C.lprod_gu = D.prod_lgu 
AND B.buyer_lgu = C.lprod_gu;

--[ANSI]국제 표준 방식
SELECT  A.mem_id "회원ID", 
            A.mem_name "회원이름",
            B.buyer_name "상품거래처명",
            C.lprod_nm "상품분류명"
FROM member A INNER JOIN cart E
                On(A.mem_id = E.cart_member)
                INNER JOIN prod D
                On(E.cart_prod = D.prod_id)
                INNER JOIN lprod C
                On(C.lprod_gu = D.prod_lgu)
                INNER JOIN buyer B
                On(B.buyer_lgu = C.lprod_gu);
                
Select M.mem_id 회원ID,
        M.mem_name 회원이름,
        B.buyer_name 상품거래처명,
        L.lprod_nm 상품분류명
From member M Inner join cart C
                    ON(M.mem_id = C.cart_member)
                        Inner join prod P
                    ON(C.cart_prod = P.prod_id)
                        Inner join buyer B
                    ON(P.prod_buyer = B.buyer_id)
                        Inner join lprod L
                    ON(p.prod_lgu = L.lprod_gu);

/*
[문제]
거래처가 '삼성전자'인 자료에 대한
상품코드,상품명,거래처명 조회
*/
-- [ALIAS]를 사용한 일반방식
SELECT A.prod_id "상품코드",
           A.prod_name "상품명",
           B.buyer_name "거래처명"
FROM prod A, buyer B
WHERE A.prod_buyer = B.buyer_id
AND B.buyer_name = '삼성전자';


--[ANSI]국제 표준 방식
SELECT A.prod_id "상품코드",
           A.prod_name "상품명",
           B.buyer_name "거래처명"
FROM prod A INNER JOIN buyer b 
                    ON(A.prod_buyer = B.buyer_id
                    AND B.buyer_name = '삼성전자');
--WHERE B.buyer_name = '삼성전자';

--상품테이블에서 상품코드,상품명,분류명,거래처명,거래처주소 조회
--1)판매가격이 10만원 이하이고
--2) 거래처 주소가 부산인 경우만 조회
-- [ALIAS]를 사용한 일반방식
SELECT  A.prod_id "상품코드",
            A.prod_name "상품명",
            C.lprod_nm "분류명",
            B.buyer_name "거래처명",
            B.buyer_add1 "거래처주소"
FROM prod A, buyer B, lprod C 
WHERE A.prod_buyer = B.buyer_id
AND A.prod_lgu = C.lprod_gu
AND A.prod_sale < 100000
AND SUBSTR(B.buyer_add1,1,2) = '부산';

--[ANSI]국제 표준 방식
SELECT A.prod_id "상품코드",
            A.prod_name "상품명",
            C.lprod_nm "분류명",
            B.buyer_name "거래처명",
            B.buyer_add1 "거래처주소"
FROM prod A INNER JOIN buyer B
              ON(A.prod_buyer = B.buyer_id)
              INNER JOIN lprod C
              ON(A.prod_lgu = C.lprod_gu
              AND A.prod_sale < 100000
              AND SUBSTR(B.buyer_add1,1,2) = '부산');
              -- AND buyer_add1 like '%부산%'
              
/*
[문제]
상품분류코드가 p101인것에 대한
상품분류명, 상품아이디, 판매가, 거래처 담당자, 회원아이디, 주문수량 조회
단, 상품분류명을 기준으로 내림차순, 상품아이디를 기준으로 오름차순
*/
-- [ALIAS]를 사용한 일반방식
SELECT A.lprod_nm "상품분류명",
            B.prod_id "상품코드",
            B.prod_sale "판매가",
            C.buyer_charger "거래처담당자",
            D.mem_id "회원아이디",
            E.cart_qty "주문수량"
FROM lprod A, prod B, buyer C, member D, cart E 
WHERE B.prod_lgu = A.lprod_gu
AND B.prod_buyer = C.buyer_id
AND B.prod_id = E.cart_prod
AND E.cart_member = D.mem_id
AND prod_lgu = 'P101'

ORDER BY lprod_nm desc, prod_id asc;


--[ANSI]국제 표준 방식
SELECT A.lprod_nm "상품분류명",
            B.prod_id "상품코드",
            B.prod_sale "판매가",
            C.buyer_charger "거래처담당자",
            D.mem_id "회원아이디",
            E.cart_qty "주문수량"
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

/*[1번문제]
'여성캐주얼'이면서 제품 이름에 '여름'이 들어가는 상품이고, 
매입수량이 30개이상이면서 6월에 입고한 제품의
마일리지와 판매가를 합한 값을 조회하시오
Alias 이름,판매가격, 판매가격+마일리지
*/
SELECT prod_name 상품명,
             prod_sale 판매가격,
             prod_sale + NVL(prod_mileage,0) 마일리지New
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                                 FROM lprod
                                WHERE lprod_nm = '여성캐주얼')
      AND prod_name like '%여름%'
      AND prod_id IN (SELECT buy_prod
                                FROM buyprod
                              WHERE buy_qty >= 30
                                   AND EXTRACT(month FROM buy_date) = 6);
                                   


/*
[2번문제]
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/
SELECT  mem_name as 회원명,
            mem_mileage as 마일리지,
            CASE 
            WHEN mem_mileage > = 2500 THEN '우수회원'
            ELSE '일반회원' 
            END as 변경컬럼
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
[3번 문제]
6월달 이전(5월달까지)에 입고된 상품 중에 
배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 
판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/
  
SELECT mem_name as 이름,
            mem_mileage as 보유마일리지,
            DECODE(substr(mem_regno2,1,1),1,'남','여') as 성별
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
                                                                                AND prod_delivery = '세탁 주의'
                                                                                AND prod_color is NULL )
                                                                                                                                                             
AND cart_qty >= (select AVG(cart_qty) FROM cart))
AND mem_name like '김%';

/*
[2번문제]
취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
회원의 결혼기념일이 8월달이 아니면서 
                     #평균마일리지(소수두째자리까지) 미만이면서 
구매일에 첫번째로 구매한 회원의 

회원ID, 회원이름, 회원마일리지를 검색하시오. 
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
                                                                                            Where buyer_add1 like '인천%'
                                                                                            AND buyer_lgu like 'P1%')))
AND mem_memorial = '결혼기념일'
AND extract(month from mem_memorialday) != '8'   
AND mem_mileage < (SELECT avg(mem_mileage) FROM member) 
GROUP BY mem_id, mem_name;

/*
[문제 만들기]
취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
회원의 결혼기념일이 8월달이 아니면서 
평균마일리지(소수두째자리까지) 미만이면서 
구매일에 첫번째로 구매한 회원의 
회원ID, 회원이름, 회원마일리지를 검색하시오.  
*/

/*
[문제 만들기]
주소지가 대전인 거래처 담당자가 담당하는 상품을 
구매하지 않은 대전 여성 회원 중에 12월에 결혼기념일이 있는
회원 아이디, 회원 이름 조회 
이름 오름차순 정렬 
*/

/*
[문제 만들기]
컴퓨터제품을 주관하며 수도권(서울,인천)에 살고 주소에 '마' 가 들어간 곳에 사는 담당자가 담당하는
제품 중에서 판매가격이 전체판매가격 이상인 상품을 구매한 회원들이 사는 곳(지역)을  분류하고
지역별 회원들이 생각하는 기념일별 가장 많은 기념일은 어떤것인지 알아내시오
--서울: 수도권
--충남, 대전 : 충청도 나머지는 경상도
*/
                                                                           