--procedure
Set serveroutput on;
create or replace PROCEDURE tien_phat(v_tentk in muonsach.tentk%TYPE)
is
mams_in muonsach.mams%TYPE;
matt_in muonsach.matt%TYPE;
tentk_in muonsach.tentk%TYPE;
loaitk_in taikhoan.loaitk%type;
chiphi_in trasach.chiphi%type;
tong decimal;
dem int; 
begin
select count(*)into dem 
from trasach,muonsach
where tentk=v_tentk and trasach.mams=muonsach.mams;
if(dem>0)
then
select sum (chiphi),tk.tentk
into chiphi_in,tentk_in
from taikhoan tk, muonsach ms, trasach ts
where tk.tentk = ms.tentk and ms.mams = ts.mams and tk.tentk=v_tentk
group by tk.tentk;
select ts.mams,ms.matt,tk.loaitk
into mams_in,matt_in,loaitk_in
from taikhoan tk, muonsach ms, trasach ts
where tk.tentk = ms.tentk and ms.mams = ts.mams and tk.tentk=v_tentk;
 if (chiphi_in=0)
 then
 DBMS_OUTPUT.PUT_LINE('TEN TAI KHOAN: '||v_tentk);
 DBMS_OUTPUT.PUT_LINE('MA MUON SACH: '||mams_in);
 DBMS_OUTPUT.PUT_LINE('MA THU THU: '||matt_in);
 else
 if(loaitk_in='vip')
 then
 tong:=chiphi_in*0.9;
 update trasach
 set chiphi=chiphi+tong
 where mams=mams_in;
 
 if(chiphi_in>50)
 then
 update taikhoan
 set loaitk='thuong'
 where tentk=v_tentk;
 end if;
 
 DBMS_OUTPUT.PUT_LINE('TEN TAI KHOAN: '||v_tentk);
 DBMS_OUTPUT.PUT_LINE('MA MUON SACH: '||mams_in);
 DBMS_OUTPUT.PUT_LINE('MA THU THU: '||matt_in);
 DBMS_OUTPUT.PUT_LINE('TIEN PHAT: '||tong);
 
 else
 tong:=chiphi_in;
 update trasach
 set chiphi=chiphi+tong
 where mams=mams_in;
 DBMS_OUTPUT.PUT_LINE('TEN TAI KHOAN: '||v_tentk);
 DBMS_OUTPUT.PUT_LINE('MA MUON SACH: '||mams_in);
 DBMS_OUTPUT.PUT_LINE('MA THU THU: '||matt_in);
 DBMS_OUTPUT.PUT_LINE('TIEN PHAT: '||tong);
 end if;
 end if;
else 
select count(*)into dem 
from hcm.trasach@qltv_dblink t,hcm.muonsach@qltv_dblink m
where tentk=v_tentk and t.mams=m.mams;
 if(dem>0)
 then
 select sum (chiphi),tk.tentk
 into chiphi_in,tentk_in
 from hcm.taikhoan@qltv_dblink tk, hcm.muonsach@qltv_dblink ms, 
hcm.trasach@qltv_dblink ts
 where tk.tentk = ms.tentk and ms.mams = ts.mams and tk.tentk=v_tentk
 group by tk.tentk;
 select ts.mams,ms.matt,tk.loaitk
 into mams_in,matt_in,loaitk_in
 from hcm.taikhoan@qltv_dblink tk, hcm.muonsach@qltv_dblink ms, 
hcm.trasach@qltv_dblink ts
 where tk.tentk = ms.tentk and ms.mams = ts.mams and tk.tentk=v_tentk;
 if (chiphi_in=0)
 then
 DBMS_OUTPUT.PUT_LINE('TEN TAI KHOAN: '||v_tentk);
 DBMS_OUTPUT.PUT_LINE('MA MUON SACH: '||mams_in);
 DBMS_OUTPUT.PUT_LINE('MA THU THU: '||matt_in);
 else
 if(loaitk_in='vip')
 then
 tong:=chiphi_in*0.9;
 update hcm.trasach@qltv_dblink
 set chiphi=chiphi+tong
 where mams=mams_in;
 
 if(chiphi_in>50)
 then
 update hcm.taikhoan@qltv_dblink
 set loaitk='thuong'
 where tentk=v_tentk;
 end if;
 
 DBMS_OUTPUT.PUT_LINE('TEN TAI KHOAN: '||v_tentk);
 DBMS_OUTPUT.PUT_LINE('MA MUON SACH: '||mams_in);
 DBMS_OUTPUT.PUT_LINE('MA THU THU: '||matt_in);
 DBMS_OUTPUT.PUT_LINE('TIEN PHAT: '||tong);
 else
 tong:=chiphi_in;
 update hcm.trasach@qltv_dblink
 set chiphi=chiphi+tong
 where mams=mams_in;
 DBMS_OUTPUT.PUT_LINE('TEN TAI KHOAN: '||v_tentk);
 DBMS_OUTPUT.PUT_LINE('MA MUON SACH: '||mams_in);
 DBMS_OUTPUT.PUT_LINE('MA THU THU: '||matt_in);
 DBMS_OUTPUT.PUT_LINE('TIEN PHAT: '||tong);
 DBMS_OUTPUT.PUT_LINE('Them thanh cong');
 end if;
 end if;
 end if;
end if;
end;
--===================================================

begin
tien_phat('DMQ123');
end;
--===================================================
--Function

Set serveroutput on;
CREATE OR REPLACE FUNCTION TINH_CHI_PHI
(
V_TENTK TAIKHOAN.TENTK%TYPE,
V_MAMS MUONSACH.MAMS%TYPE
)RETURN DECIMAL
IS
V_NGHETHAN MUONSACH.NGHETHAN%TYPE;
V_NGTRA TRASACH.NGTRA%TYPE;
V_CHIPHI TRASACH.CHIPHI%TYPE;
V_LOAITK TAIKHOAN.LOAITK%TYPE;
TONG DECIMAL;
DEM INT;
V_THANGQUAHAN NUMBER;
BEGIN 
SELECT COUNT(MATS)INTO DEM
FROM TRASACH
WHERE TRASACH.MAMS=V_MAMS;
IF(DEM=1)THEN
SELECT LOAITK INTO V_LOAITK 
FROM TAIKHOAN T
WHERE V_TENTK=T.TENTK;
SELECT M.NGHETHAN, T.NGTRA, T.CHIPHI INTO V_NGHETHAN, 
V_NGTRA, V_CHIPHI
FROM TRASACH T, MUONSACH M
WHERE T.MAMS=M.MAMS AND M.TENTK=V_TENTK AND 
V_MAMS=M.MAMS;
 
 IF(V_NGHETHAN<V_NGTRA)
 THEN
 
V_THANGQUAHAN:=TRUNC(MONTHS_BETWEEN(V_NGTRA,V_NGHETHA
N))+1;
 
 IF(V_LOAITK= 'VIP')
 THEN
 TONG:=(V_THANGQUAHAN*5);
 UPDATE TRASACH
 SET CHIPHI=TONG
 WHERE TRASACH.MAMS=V_MAMS;
 --RETURN TONG;
 
 ELSE
 TONG:=(V_THANGQUAHAN*10);
 UPDATE TRASACH
 SET CHIPHI=TONG
 WHERE TRASACH.MAMS=V_MAMS;
 --RETURN TONG;
 END IF; 
 ELSE
 TONG:=V_CHIPHI;
 UPDATE TAIKHOAN
 SET CONGNO=TONG
 WHERE TAIKHOAN.TENTK=V_TENTK;
 --RETURN TONG; 
 END IF;
ELSE
SELECT COUNT(MATS)INTO DEM
FROM hcm.trasach@qltv_dblink
WHERE MAMS=V_MAMS;
IF(DEM>1)THEN
 IF(V_NGHETHAN<V_NGTRA)
 THEN
 
V_THANGQUAHAN:=TRUNC(MONTHS_BETWEEN(V_NGTRA,V_NGHETHA
N))+1;
 
 IF(V_LOAITK= 'VIP')
 THEN
 TONG:=(V_THANGQUAHAN*5);
 UPDATE hcm.trasach@qltv_dblink
 SET CHIPHI=TONG
 WHERE MAMS=V_MAMS;
 --RETURN TONG;
 
 ELSE
 TONG:=(V_THANGQUAHAN*10);
 UPDATE hcm.trasach@qltv_dblink
 SET CHIPHI=TONG
 WHERE MAMS=V_MAMS;
 --RETURN TONG;
 END IF; 
 ELSE
 TONG:=V_CHIPHI;
 UPDATE hcm.taikhoan@qltv_dblink
 SET CONGNO=TONG
 WHERE TENTK=V_TENTK;
 --RETURN TONG;
 END IF;
 END IF;
END IF;
RETURN TONG;
END;

--===================================================

declare
a decimal;
begin
a:= TINH_CHI_PHI('DMQ123','MS002');
DBMS_OUTPUT.PUT_LINE('SO CHI PHI: '|| a);
end

--===================================================
--trigger
CREATE OR REPLACE TRIGGER kiem_tra_MuonSach
BEFORE INSERT OR UPDATE ON MUONSACH
FOR EACH ROW
DECLARE
 SoLanMuon int;
 SoLanTra int;
 V_LOAITK TAIKHOAN.LOAITK%TYPE;
BEGIN
 SELECT LOAITK INTO V_LOAITK
 FROM TAIKHOAN T
 WHERE T.TENTK=:NEW.TENTK;
 
IF(V_LOAITK='VIP')THEN
 SELECT COUNT(*) INTO SoLanMuon
 FROM MUONSACH
 WHERE TENTK = :NEW.TENTK;
 
 SELECT COUNT(*) INTO SoLanTra
 FROM MUONSACH m, TRASACH t
 WHERE m.MAMS = t.MAMS AND TENTK = :NEW.TENTK;
 
 IF ((SoLanMuon-SoLanTra) >= 30) 
 THEN
 RAISE_APPLICATION_ERROR(-20000, 'so cuon muon khong qua 30');
 ELSE
 DBMS_OUTPUT.PUT_LINE('Them thanh cong');
 END IF;
else
 SELECT COUNT(*) INTO SoLanMuon
 FROM MUONSACH
 WHERE TENTK = :NEW.TENTK;
 
 SELECT COUNT(*) INTO SoLanTra
 FROM MUONSACH m, TRASACH t
 WHERE m.MAMS = t.MAMS AND TENTK = :NEW.TENTK;
 
 IF ((SoLanMuon-SoLanTra) >= 10) 
 THEN
 RAISE_APPLICATION_ERROR(-20000, 'so cuon muon khong qua 10');
 ELSE
 DBMS_OUTPUT.PUT_LINE('Them thanh cong');
 END IF;
end if;
END;
