---------------------------------Chi nhanh HCM-------------------------------------------
-------------Xem mu?c cô l?p------------------
 declare 
           trans_id Varchar2(100);
        begin
           trans_id := dbms_transaction.local_transaction_id( TRUE );
        end;
------------Xem m?c cô l?p hi?n t?i--------------
SELECT s.sid, s.serial#,
       CASE BITAND(t.flag, POWER(2, 28))
          WHEN 0 THEN 'READ COMMITTED'
          ELSE 'SERIALIZABLE'
       END AS isolation_level
    FROM v$transaction t 
    JOIN v$session s ON t.addr = s.taddr AND s.sid = sys_context('USERENV', 'SID');
-----------Set m?cc cô l?p----------------------
ALTER SESSION SET ISOLATION_LEVEL= SERIALIZABLE;
ALTER SESSION SET ISOLATION_LEVEL= READ COMMITTED;
------------non-repeatable----------------------
select * from hcm.thuthu@qltv_dblink;

commit;
-------------phantom-------
select * from hcm.thuthu@qltv_dblink;

commit;
----------lost update-------------
select * from hcm.trasach@qltv_dblink;
update hcm.trasach@qltv_dblink
set CHIPHI = 1234
where MATS = 'TS001';


update hcm.trasach@qltv_dblink
set CHIPHI = 5678
where MATS = 'TS001';

commit;
------------------deadlock---------
select* from hcm.taikhoan@qltv_dblink;
update hcm.taikhoan@qltv_dblink
set CONGNO = 1111
where MADG = 'DG005';

update hcm.taikhoan@qltv_dblink
set CONGNO = 3333
where MADG = 'DG006';

commit;

update hcm.taikhoan@qltv_dblink
set CONGNO = 5555
where MADG = 'DG005';

update hcm.taikhoan@qltv_dblink
set CONGNO = 7777
where MADG = 'DG006';





---------------------------------Chi nhanh HaNoi----------------------------------------
-------------Xem mu?c cô l?p------------------
 declare 
           trans_id Varchar2(100);
        begin
           trans_id := dbms_transaction.local_transaction_id( TRUE );
        end;
--------------------------------------------------------------------------------
-------------Xem mu?c cô l?p------------------
 declare 
           trans_id Varchar2(100);
        begin
           trans_id := dbms_transaction.local_transaction_id( TRUE );
        end;
------------Xem m?c cô l?p hi?n t?i--------------
SELECT s.sid, s.serial#,
       CASE BITAND(t.flag, POWER(2, 28))
          WHEN 0 THEN 'READ COMMITTED'
          ELSE 'SERIALIZABLE'
       END AS isolation_level
    FROM v$transaction t 
    JOIN v$session s ON t.addr = s.taddr AND s.sid = sys_context('USERENV', 'SID');
-----------Set m?cc cô l?p----------------------
ALTER SESSION SET ISOLATION_LEVEL= SERIALIZABLE;
ALTER SESSION SET ISOLATION_LEVEL= READ COMMITTED;

----------non-repeatable--------------------
update thuthu
set MAKHAU = '123'
where MATT = '19521407';

update thuthu
set MAKHAU = '456'
where MATT = '19521407';
commit;
----------------phantom-------
insert into thuthu values('19521112','NGUYEN VAN A','NAM','NVA');
insert into thuthu values('19521113','NGUYEN THI B','NU','NTB');
commit;
--------------lost update--------
select * from TRASACH
update TRASACH
set CHIPHI = 4321
where MATS = 'TS001';

update TRASACH
set CHIPHI = 8765
where MATS = 'TS001';

commit;
------------------deadlock---------
select * from TAIKHOAN;
update TAIKHOAN
set CONGNO = 2222
where MADG = 'DG006';

update TAIKHOAN
set CONGNO = 4444
where MADG = 'DG005';

commit;

update TAIKHOAN
set CONGNO = 6666
where MADG = 'DG006';

update TAIKHOAN
set CONGNO = 8888
where MADG = 'DG005';
