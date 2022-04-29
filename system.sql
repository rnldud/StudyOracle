CREATE USER busan IDENTIFIED BY dbdb;

---생성한 사용자의 비밀번호 변경 
ALTER USER busan IDENTIFIED BY dbdb;

--- 사용자 삭제하기 
--Drop User busan;

-- 생성한 사용자에게 권한 부여하기 
-- 접속권한, 관리자 권한 모두 부여
GRANT CONNECT,RESOURCE,DBA TO busan;

-- 권한 회수하기
--REVOKE DBA FROM busan;