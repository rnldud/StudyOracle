CREATE USER busan IDENTIFIED BY dbdb;

---������ ������� ��й�ȣ ���� 
ALTER USER busan IDENTIFIED BY dbdb;

--- ����� �����ϱ� 
--Drop User busan;

-- ������ ����ڿ��� ���� �ο��ϱ� 
-- ���ӱ���, ������ ���� ��� �ο�
GRANT CONNECT,RESOURCE,DBA TO busan;

-- ���� ȸ���ϱ�
--REVOKE DBA FROM busan;