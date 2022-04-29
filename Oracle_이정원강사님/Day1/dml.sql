/*
lprod : 상품분류정보
prod : 상품정보 / 거래처, 상품분류
buyer : 거래처정보 
member : 회원정보
cart : 구매(장바구니)정보 / 회원, 상품
buyprod : 입고상품정보 / 상품정보
remain : 재고수불정보
*/

-- 상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색
-- 분류코드, 분류명
-- IN 안에는 하나의 컬럼에 많은 데이터(열)를 조회할 수 있는 형태로 구성되야 함
-- 서브쿼리 사용형태
Select lprod_gu 분류코드, lprod_nm 분류명
From lprod
Where lprod_gu IN (Select prod_lgu From prod);

-- 상품 분류데이터에서 현재 상품테이블에 존재하지 않은 분류만 검색하시오.
-- 별칭은 분류코드, 분류명
Select lprod_gu 분류코드, lprod_nm 분류명
From lprod
Where lprod_gu NOT IN (Select prod_lgu From prod);

/*
[문제]
한번도 구매한 적이 없는 회원ID, 이름 조회
*/
Select mem_id 회원ID, mem_name 회원이름
From member
Where mem_id NOT IN (Select cart_member From cart);

/*
데이터 조회하기
1. 테이블 찾기
2. 조회할 칼럼 찾기
3. 조건 유무 확인
*/

/*
[문제]
한번도 판매된 적이 없는 상품을 조회하려고 한다.
판매된 적이 없는 상품이름을 조회해주세요.
*/
Select prod_name 상품명
From prod
Where prod_id NOT IN(Select cart_prod From cart);

/*
[문제]
회원 중 '김은대' 회원이 지금까지 구매했던 모든 상품명을 조회해주시오.
*/
Select prod_name 상품명
From prod
Where prod_id IN(Select cart_prod From cart
                        Where cart_member = 'a001');

Select prod_name 상품명
From prod
Where prod_id 
    IN(Select cart_prod From cart
        Where cart_member 
            IN (Select mem_id From member
                Where mem_name = '김은대'));
                                                        
Select *
From member
Where mem_id = 'a001';

SELECT *
FROM CART;

-- 상품 중 판매가격이 10만원 이상, 30만원 이하인 상품을 조회
-- 조회 컬럼은 상품명, 판매가격
-- 정렬은 판매가격을 기준으로 내림차순
Select prod_name 상품명, prod_sale 상품가격
From prod
Where prod_sale >= 100000
    AND prod_sale <= 300000
Order By prod_sale Desc;

Select prod_name 상품명, prod_sale 상품가격
From prod
Where prod_sale Between 100000 AND 300000
Order By prod_sale Desc;

-- 회원 중 생일이 1975-01-01 에서 1976-12-31 사이에 태어난 회원을 검색하시오.
-- 별칭 회원ID, 회원명, 생일
Select mem_id 회원ID, mem_name 회원명, mem_regno1 생일
From member
Where mem_regno1 Between 750101 AND 761231;

Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_bir Between '75-01-01' AND '76-12-31';

Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_bir Between '75/01/01' AND '76/12/31';

/*
[문제]
거래처 당담자 '강남구'씨가 당담하는 상품을 구매한 회원을 조회
회원ID, 회원이름을 조회
*/
Select mem_id 회원ID, mem_name 회원이름
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_buyer
                    IN(Select buyer_id From buyer
                        Where buyer_charger = '강남구')));


Select *
From buyer;

select * from prod;

select * from lprod;

Select mem_id 회원ID, mem_name 회원이름
From member
Where mem_id 
    IN (Select cart_member From cart
        Where cart_prod 
            IN(Select prod_id From prod
                Where prod_lgu
                    IN(Select lprod_gu From lprod
                        Where lprod_gu
                        IN(Select buyer_lgu From buyer
                            Where buyer_charger = '강남구'))));

-- 상품 중 매입가가 300,000~1,500,000이고 판매가가 800,000~2,000,000 인 상품을 검색하시오.
-- 별칭은 상품명, 매입가, 판매가
Select prod_name 상품명, prod_cost 매입가, prod_sale 판매가
From prod
Where prod_cost Between 300000 AND 1500000
    AND prod_sale Between 800000 AND 2000000;
    
-- 회원 중 생일이 1975년도 생이 아닌 회원을 검색하시오.
-- 별칭은 회원ID, 회원명, 생일
-- 생일과 주민번호앞6자리는 다를 수 있다.
Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_regno1 NOT Between 750101 AND 751231;

Select mem_id 회원ID, mem_name 회원명, mem_bir 생일
From member
Where mem_bir NOT Between '75-01-01' AND '75-12-31';

-- 회원테이블에서 김씨 성을 가진 회원을 검색하시오.
-- 별칭은 회원ID, 성명
Select mem_id 회원ID, mem_name 성명
From member
Where mem_name Like '김%';

-- 회원테이블에서 주민등록번호 앞지리를 검색하여 1975년생을 제외한 회원을 검색하시오.
-- 별칭 회원ID, 성명, 주민등록번호
Select mem_id 회원ID, mem_name 성명, mem_regno1 주민등록번호
From member
Where mem_regno1 NOT Like '75%';

-- CONCAT()
-- 두개의 문자열을 합친다.
Select CONCAT('My Name is ', mem_name) 성명
From member;

-- CHR, ASCII
-- ASCII값을 문자로, 문자를 ASCII값으로 반환
Select CHR(65) "CHR", ASCII('A') "ASCII"
From dual;

-- LOWER() = 해당 문자나 문자열을 소문자로 변환
-- UPPER() = 대문자로 변환
-- INITCAP() = 첫 글자를 대문자로 나머지는 소문자로 변환
Select LOWER('DATA mainpulation Language') "LOWER",
        UPPER('DATA mainpulation Language') "UPPER",
        INITCAP('DATA mainpulation Language') "INITCAP"
From dual;

-- 회원테이블의 회원ID를 대문자로 변환하여 검색하시오.
-- 별칭은 변환 전 ID, 변환 후 ID
Select mem_id 변환전ID, UPPER(mem_id) 변환후ID 
From member;

-- LPAD, RPAD() = 지정된 길이 n에서 c1을 채우고 남은 공간을 c2로 채워라

-- LTRIM(), RTRIM() = 좌측, 우측의 공백문자를 제거
-- TRIM() = 양쪽의 공백문자 제거

-- SUBSTR( , , ) = 문자열의 일부분을 선택해서 조회

-- TRANSLATE(c1,c2,c3) = c1문자열에 포함된 문자 중 c2에 지정된 문자가 c3문자로 각각 변경

-- REPLACE() = 문자나 문자열을 치환
Select REPLACE('SQL Project', 'SQL', 'SSQQLL') 문자치환1,
    REPLACE('Java Flex Via', 'a') 문자치환2
From dual;

-- 회원테이블의 회원성명 중 성씨 '이' ---> '리' 로 치환하여 뒤에 이름을 붙인 후 검색하시오.
-- 별칭은 회원명, 회원명치환
-- 모든 '이' ---> '리'
Select mem_name 회원명,
    REPLACE(mem_name, '이', '리') 회원명치환
From member;

Select mem_name 회원명,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '이', '리'), SUBSTR(mem_name, 2)) 회원명치환
From member;

Select mem_name 회원명,
    CONCAT(REPLACE(SUBSTR(mem_name, 1, 1), '이', '리'), SUBSTR(mem_name, 2, 3)) 회원명치환
From member;

-- ROUND(n, l) = 지정된 자릿수(l) 밑에서 반올림
-- TRUNC(n, l) = 위와 같음, 반올림이 아니라 절삭
-- 일의 자리 수 = 0 , 소수점 첫째자리 수 = 1 ....

-- MOD(c, n) = n으로 나눈 나머지

-- 날짜 함수
-- SYSDATE = 시스템에서 제공하는 현재 날자와 시간 값
-- dual = 더미 테이블 
Select sysdate -1
From dual;

-- ADD_MONTHS(data, n) = date에 월을 더한 날짜
-- NEXT_DAY(data, char) = 해당 날짜 이후 가장 빠른 요일의 날짜
-- LAST_DAY(date) = 월의 마지막 날짜
Select NEXT_DAY(SYSDATE, '월요일'),
        LAST_DAY(SYSDATE)
From dual;

-- 이번달이 며칠 남아있는지?
Select LAST_DAY(SYSDATE) - SYSDATE 남은일수
From dual;

-- EXTRACT(fmf FROM data) = 날짜에서 필요한 부분만 추출
Select EXTRACT(YEAR FROM SYSDATE) "년도",
    EXTRACT(MONTH FROM SYSDATE) "월",
    EXTRACT(DAY FROM SYSDATE) "일"
From dual;

-- 생일이 3월인 회원을 검색하시오.
Select mem_name 회원명, EXTRACT(MONTH From mem_bir) 월생
From member
Where EXTRACT(MONTH From mem_bir) = '3';

/*
[문제]
회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회
- 조회 컬럼 : 상품명
- 단, 상품명에 삼성이 포함된 상품만 조회. 조회 결과는 중복 제거
*/
-- 못함.. 강사님꺼 
-- 조건 = EXTRACT(YEAR FROM mem_bir) = 1973
Select DISTINCT prod_name 상품명
From prod
Where prod_id 
    IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where mem_bir Between '73-01-01' AND '73-12-31'
                        AND prod_name LIKE '%삼성%'))
Order By prod_name ASC;

Select DISTINCT prod_name 상품명
From prod
Where prod_name LIKE '%삼성%'  
    AND prod_id 
        IN (Select cart_prod From cart
            Where cart_member
                IN(Select mem_id From member
                    Where EXTRACT(YEAR FROM mem_bir) = 1973))
Order By prod_name ASC;

-- CAST(expr AS type) = 명시적으로 형 변환
-- TO_CHAR() = 숫자, 문자, 날짜를 지정한 형식의 문자열 변환
-- TO_NUMBER() =  숫자형식의 문자열을 숫자로 변환
-- TO_DATE() = 날짜 형식의 문자열을 날짜로 변환
Select TO_CHAR(CAST('2008-12-25' AS DATE), 'YYYY.MM.DD HH24:MI')
From dual;

Select TO_CHAR(SYSDATE, 'AD YYYY, CC "세기"')
From dual;

-- 상품테이블에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색하시오
-- 별칭 = 상품명, 상품판매가, 입고일
Select prod_name 상품명, prod_sale 상품판매가, 
        TO_CHAR(prod_insdate, 'YYYY-MM-DD') 입고일
From prod;

-- 회원이름과 생일로 다음처럼 출력되게 작성하시오.
-- 김은대님은 1976년 1월 출생이고 태어난 요일은 목요일
Select CONCAT(CONCAT(mem_name, '님 은'), TO_CHAR(mem_bir,'YYYY'))
From member;

Select (mem_name || '님은' || 
        TO_CHAR(mem_bir,'YYYY') || '년 ' || 
        TO_CHAR(mem_bir,'D') ||'월 출생이고 태어난 요일은 ' ||  
        TO_CHAR(mem_bir, 'day') || '입니다.'
        ) as sumStr
From member;

-- 숫자
-- 9는 유효한 숫자, 0은 무효한 숫자 = 의미없는 자리수
-- $, L = 달러 및 지역 화폐 기호
-- MI = 음수인 경우 우측에 마이너스 표시, 우측에 표시
-- PR = 음수인 경우 "<>"괄호로 묶는다. 우측에 표시
-- X = 해당 숫자를 16진수로 표현
Select TO_CHAR(1234.6, '999,999.00')
From dual;

Select TO_CHAR(-1234.6, 'L999,999.00PR')
From dual;

Select TO_CHAR(255, 'XXX')
From dual;

-- 상품테이블에서 상품코드, 상품명, 매입가격, 소비자가격, 판매가격을 출력하시오
-- 단, 가격은 천단위 구분 및 원화표시
Select prod_id 상품코드, prod_name 상품명, 
        TO_CHAR(prod_cost,'L9,999,999') 매입가격, 
        TO_CHAR(prod_sale,'L9,999,999') 소비자가격, 
        TO_CHAR(prod_price,'L9,999,999') 판매가격
From prod;

-- TO_NUMBER() =  숫자형식의 문자열을 숫자로 변환

-- 회원테이블에서 '이쁜이'회원의 회원ID 2~4 문자열을 숫자형으로 치환한 후 10을 더하여 새로운 회원ID를 조합하시오.
-- 별칭 = 회원ID, 조합회원ID
-- 못함...

Select mem_id 회원ID,
        Substr(mem_id, 1, 2) ||
        (Substr(mem_id, 3, 4) + 10)
From member
Where mem_name = '이쁜이';

-- 상품테이블의 상품분류별 매입가격 평균 값
-- AVG() = 그룹함수
/*
[규칙]!!
일반 컬럼과 그룹 함수를 같이 사용할 경우에는
꼭 Group By절을 넣어 주어여 합니다.
그리고 Group By절에는 일반 컬럼이 모두 들어가야 합니다.
*/
Select prod_lgu "상품 분류",
        ROUND(AVG(prod_cost), 2) "매입가격 평균"
From prod
Group By prod_lgu;

Select ROUND(AVG(prod_cost), 2) "매입가격 평균"
From prod;

-- 상품테이블의 총 판매가격 평균 값을 구하시오,
-- 별칭 = 상품판매가격평균
Select ROUND(AVG(prod_sale), 2) "상품판매가격평균"
From prod;

-- 상품테이블의 상품분류별 판매가격 평균값
Select prod_lgu,  
        ROUND(AVG(prod_sale), 2) "상품판매가격평균"
From prod
Group By prod_lgu;

Select prod_lgu,  
        AVG(prod_sale) as avg_sale
From prod
Group By prod_lgu;

-- COUNT(col/*) = 조회 범위 내 해당 컬럼들의 자료수

-- 장바구니테이블의 회원별 COUNT집계 하시오.
-- 별칭 = 회원ID, 자료수(DISTINCT), 자료수, 자료수(*)
Select cart_member , COUNT(cart_member) as avg_member
From cart
Group By cart_member;

/*
[문제]
구매수량의 전체평균 이상을 구매한 회원들의 아이디와 이름을 조회.
*/
-- 못 함.. 
Select mem_id 회원ID, mem_name 회원명
From member
Where mem_id 
    IN(Select cart_member From cart
        Where cart_qty >= (
            Select AVG(cart_qty) -- 원하는 쿼리를 밖에서 실행해보고 ()[괄호]를 이용해서 추가해보자..!!!!
            From cart
            )
        )
Order By mem_regno1 ASC;

Select cart_member 회원ID, AVG(cart_qty) 평균
From cart
Group By cart_member;

Select AVG(cart_qty) 평균
From cart;

-- COUNT(*) 선택된 자료의수 *조회 대상 컬럼에서 NULL 은 대상 외 
SELECT COUNT(DISTINCT prod_cost),COUNT(All prod_cost),COUNT(prod_cost),COUNT(*)
FROM prod;

/*문제
구매내역(장바구니) 정보에서 회원 아이디 별로 주문[수량]에 대한 평균울 조회해주세요
회원아디를 기준으로 내림차순 
*/

SELECT cart_member , AVG(cart_qty) 구매수량
FROM cart 
GROUP By cart_member
ORDER BY cart_member;

/*[문제]
상품 정보에서 판매가격의 평균값을 구해주세요.
단, 평균값은 소수점 2째자리 까지 표현 해주세요
*/
SELECT round(AVG(prod_sale),2) avg_sale
FROM prod;

/*[문제]
상품정보에서 상품분류별 판매가격의 평균값을 구하시오
조회칼럼은 상품분류코드,상품분류별 판매가격의 평균
단, 평균값은 소수점 2째자리까지 표현
*/
-- 상품분류코드: prod_lgu
SELECT prod_lgu, 
            round(AVG(prod_sale),2) AS avg_sale
FROM prod
group by prod_lgu;

-- 회원 테이블의 취미 종류수를 COUNT 집계하시오? (ALIAS는 취미WHDFBTN)
SELECT COUNT(DISTINCT mem_like) 취미종류수
FROM member;

-- 회원 테이블의 취미별 count 집계하시오 (취키,자료수,자료수(*)
SELECT mem_like 취미,
COUNT(mem_like) 자료수, COUNT(*) "자료수(*)"
FROM member
GROUP BY mem_like;

-- 회원 테이블의 직업 종류수를 count하시오 
SELECT COUNT(Distinct(mem_job)) 직업종류수
FROM member;

-- 해당 직업별 
SELECT mem_job, COUNT(mem_job) 직업종류수
FROM member
GROUP BY mem_job 
ORDER BY mem_job desc;

/*
[문제]
회원 전체의 마일리지 평균보다 큰 회원에 대한
아이디, 이름, 마일리지 조회
정렬은 마일리지가 높은순
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
오늘이 2005년도 7월 11일이라 가정하고 장바구니 테이블에 발생될
추가 주문번호 검색하시오
(alias는 현재 년원일 기준 가장 높은 주문번호, 추가주문번호)
*/

SELECT MAX(cart_no) AS "가장높은 주문번호" , MAX(CART_NO)+1 AS "추가주문번호"
FROM cart
Where cart_no LIKE '20050711%';

/*
[문제]
구매정보에서 년도별로 판매된 상품의 갯수,
평균 구매수량 조회
정렬은 년도를 기준으로 내림차순
*/

SELECT substr(cart_no,1,4) as yyyy,   
            sum(cart_qty) as sum_qty, 
            avg(cart_qty) as avg_qty
FROM cart
group by substr(cart_no,1,4)
order by yyyy desc;

/*
구매정보에서 년도별, 상품분류코드별로 상품의 갯수 조회
정렬은 년도를 기준으로 내림차순
*/
--일반 컬럼은 무조건 group by해야함
-- count는 그룹함수

SELECT substr(cart_no,1,4) as sub_no,
           count(cart_qty) as sub_prod,
           substr(cart_prod,1,4) as cnt_prod
FROM cart
GROUP BY substr(cart_no,1,4), substr(cart_prod,1,4)
ORDER BY sub_no desc;

/*
회원 테이블의 회원전체의 마일리지 평균,마일리지 합계
최고마일리지,최소마일리지, 인원수를 검색하시오?
 alias 마일리지평균,마일리지합계 최고마일리지 최소마일리지 인원수
 */
 SELECT AVG(mem_mileage),
            SUM(mem_mileage),
            MAX(mem_mileage),
            MIN(mem_mileage),
            COUNT(mem_mileage) 
FROM member;

/*
상품테이블에서 상품분류별 판매가 전체의 
평균,합계,최고값,최저값,자료수를
검색하시오?
*/
--조건 자료수가 20개 이상인 것..
SELECT prod_lgu, 
           AVG(prod_sale) as prod_AVG,
           SUM(prod_sale) AS prod_SUM, 
           MAX(prod_sale) AS prod_MAX,
           MIN(prod_sale) AS prod_MIN,
           COUNT(prod_sale) AS prod_count
FROM prod
GROUP by prod_lgu
HAVING COUNT(prod_sale) >= 20;  --자료수 추출시 사용방법

-- WHERE 절 : 일반조건
-- HAVING 절: 그룹조건만 (그룹함수를 사용한  조건처리)

/* 
회원 테이블에서 지역(주소1의 2자리), 생일년도 별로 마일리지 평균,
마일리지 합계, 최고마일리지, 최소마일리지,자료수 검색)
ALIAS ; 지역, 생일연도, 마일리지평균,마일리지합계, 최고마일리지,최소마일리지, 자료수
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
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
WHERE buyer_charger LIKE '김%';

UPDATE buyer SET buyer_charger = NULL
WHERE buyer_charger LIKE '김%';

UPDATE buyer SET buyer_charger = ''
WHERE buyer_charger LIKE '성%';

-- NVL(C,R) C가 NULL이 아니면 C값으로 NULL이면 R반환 
-- IS NULL: NULL값인지 아닌지 비교

-- 해당 컬럼이 NULL값 비교 조회
-- NULL을 이용 NULL 값 비교
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
WHERE buyer_charger = NULL; 

-- NULL인것 뽑으샴
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
WHERE buyer_charger IS NULL;

-- NULL 아닌거 뽑으샴
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
WHERE buyer_charger IS NOT NULL; 

-- 해당 칼럼이 NULL일 경우에 대신할 문자나 숫자 치환
-- NULL 이 존재하는 상태로 조회
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer;
-- NVL을 이용 NULL값일 경우만 없다로 치환
SELECT buyer_name 거래처,
            NVL(BUYER_CHARGER,'없다') 
FROM buyer;

--NULL은 계산불가니 0으로 변경 NVL(--,변경값)

--회원 마일리지에 100을 더한 수치를 검색하시오
SELECT mem_name as "성명",
            mem_mileage as "마일리지",
            NVL(mem_mileage,0)+100 as "변경마일리지"
FROM member;

--회원 마일리지가 있으면 정상회원 null일 경우 비정상회원
SELECT mem_name as "성명",
            mem_mileage as "마일리지",
            NVL2(mem_mileage,'정상회원','비정상회원') as "회원상태"
FROM member; 

--DECODE
SELECT DECODE(9,10,'A',9,'B',8,'C','D')
FROM dual;

SELECT DECODE( SUBSTR(prod_lgu,1,2),
                        'P1','컴퓨터/전자제품',
                        'P2','의류',
                        'P3','잡화', '기타')
FROM prod;

/*
상품분류중 앞의 두글자가 P1이면 판매가를 10%인상하고
P2이면 판매가를 15%인상하고 나머지는 동일 판매가로 검색하시오
decode 사용, 상품명,판매가,변경판매가
*/
SELECT prod_name as "상품명", 
           prod_sale as "판매가",
            DECODE(SUBSTR(prod_lgu,1,2),
                        'P1', prod_sale + (prod_sale * 10/100),
                        'p2', 'prod_sale + (prod_sale * 15/100)'
                        ) as "변경판매가"
FROM prod;

From prod;

-- CASE WHEN THEN 
-- ELSE END RESULT

-- CASE WHEN THEN 
-- ELSE END

-- 회원정보테이블의 주민등록 뒷자리(7자리중 첫번째)에서 성별 구분을 검색
-- CASE 구문 사용
-- 별칭 = 회원명, 주민등록번호(주민1, 주민2), 성별
Select mem_name 회원명, 
        SUBSTR(mem_regno2,1,1) 주민등록번호, 
        CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '남성'
                WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '여성' 
                END "성별"   
From member;

Select mem_name 회원명, 
        SUBSTR(mem_regno2,1,1) 주민등록번호, 
        CASE 
                WHEN SUBSTR(mem_regno2,1,1) = '1' 
                            THEN '남성'
                ELSE
                    '여성' 
                END "성별"   
From member;


-- 가장 어려운 문제 3개 제작하기 

--[1문제]
--주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
--뒤 두글자가 01이면 판매가를 10%인하하고
--02면 판매가를 5%인상 나머지는 동일 판매가로 도출
--(변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오. (원화표기 및 천단위구분))
--(alias 상품분류, 판매가, 변경판매가)

Select prod_name,
         prod_lgu,
         TO_CHAR(prod_sale,'L9,999,999'),
         TO_CHAR(DECODE(SUBSTR(prod_lgu,3,4),
                        '01', prod_sale - (prod_sale * 10/100),
                        '02', prod_sale + (prod_sale * 5/100)),'L9,999,999') as "변경판매가"                       
From prod
Where prod_id IN(SELECT cart_prod 
                            From cart
                            WHERE cart_member IN (SELECT mem_id
                                                                FROM member    
                                                                Where EXTRACT(MONTH From mem_bir) = '1' ))                                                          
and prod_sale Between 500000 AND 1000000;

-- [ALIAS]를 사용한 일반방식
SELECT P.prod_name "상품명",
           P.prod_lgu "상품분류",
           TO_CHAR(P.prod_sale,'L9,999,999'),
           TO_CHAR(DECODE(SUBSTR(P.prod_lgu,3,4),
                        '01', P.prod_sale - (P.prod_sale * 10/100),
                        '02', P.prod_sale + (P.prod_sale * 5/100)),'L9,999,999') "변경판매가"                        
FROM prod P, cart C, member M
WHERE P.prod_id = C.cart_prod
AND C.cart_member = M.mem_id
AND EXTRACT(MONTH From mem_bir) = '1' 
And prod_sale Between 500000 AND 1000000;


--[ANSI]국제 표준 방식
SELECT P.prod_name "상품명",
           P.prod_lgu "상품분류",
           TO_CHAR(P.prod_sale,'L9,999,999'),
           TO_CHAR(DECODE(SUBSTR(P.prod_lgu,3,4),
                        '01', P.prod_sale - (P.prod_sale * 10/100),
                        '02', P.prod_sale + (P.prod_sale * 5/100)),'L9,999,999') "변경판매가"    
FROM prod P INNER JOIN cart C
                    ON(P.prod_id = C.cart_prod)
                    INNER JOIN member M
                    ON(C.cart_member = M.mem_id
                    AND EXTRACT(MONTH From mem_bir) = '1' 
                    And prod_sale Between 500000 AND 1000000);
                    

/*[문제2]
회원중 1975년생이고 대전 주소의 회원이 구매했던 모든상품 중에 
판매가가 판매가의 전체평균보다 높은 제품만 검색해보세요.
단 
1. 판매가를 기준으로 내림차순하고, 판매가는 천단위 구분표시
2. 상품색상중 NULL값은 '검정'으로 처리
*/

SELECT prod_id 상품코드,
             prod_name 상품명,
             to_char(prod_sale,'999,999,999') 판매가,
             NVL(prod_color,'검정') 상품색상,
             COUNT(prod_color) 색깔별갯수
   FROM prod
 WHERE prod_sale > (SELECT AVG(prod_sale)
                                 FROM prod)
             AND prod_id IN(SELECT cart_prod 
                                     FROM cart
                                    WHERE cart_member IN(SELECT mem_id
                                                                        FROM member
                                                                      WHERE EXTRACT(year from mem_bir) = 1975
                                                                           AND SUBSTR(mem_add1,1,2) = '대전'));
                                                                           
