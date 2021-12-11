/*TAP TRUNG + CHUA TOI UU*/
SELECT /*+ gather_plan_statistics */ MaMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM Sach_chitiet,Sach_soluot, ThuThu, DocGia, TaiKhoan, MuonSach
WHERE TinhTrang='Available'
	AND CongNo >=0
	AND TheLoai = 'Light Novel'
	AND DiaChi = 'HA NOI'
	AND ThuThu.MaTT = MuonSach.MaTT
    AND SACH_CHITIET.ISBN=SACH_SOLUOT.ISBN
	AND Sach_soluot.ISBN=MuonSach.ISBN
	AND DocGia.MADG=TaiKhoan.MaDG
	AND TaiKhoan.TenTK=MuonSach.TenTK
UNION
SELECT MAMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM Sach_chitiet,Sach_soluot, ThuThu, DocGia, TaiKhoan, MuonSach
WHERE TinhTrang='Available'
	AND CongNo >=0
	AND TheLoai = 'English Book'
	AND DiaChi = 'TP.HCM'
	AND ThuThu.MaTT = MuonSach.MaTT
    AND SACH_CHITIET.ISBN=SACH_SOLUOT.ISBN
	AND Sach_SOLUOT.ISBN=MuonSach.ISBN
	AND DocGia.MADG=TaiKhoan.MaDG
	AND TaiKhoan.TenTK=MuonSach.TenTK;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST +cost +bytes'));
/*TAP TRUNG + TOI UU*/
SELECT /*+ gather_plan_statistics */ MaMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM 
	((SELECT TenDG, MaDG
	FROM DocGia
	WHERE DiaChi='HA NOI') DG INNER JOIN
	(SELECT TenTK, MaDG
	FROM TaiKhoan
	WHERE CongNo>=0) TK ON DG.MaDG=TK.MADG INNER 	JOIN
	(SELECT MaMS, TenTK, ISBN, MaTT, NgMuon, NgHetHan
	FROM MuonSach)MS ON TK.TenTK=MS.TenTK INNER JOIN
	(SELECT TenTT, MaTT
	FROM ThuThu) TT ON TT.MaTT=MS.MaTT INNER JOIN
	(SELECT ISBN 
	FROM Sach_SoLuot
	WHERE  TinhTrang='Available') S1 ON S1.ISBN=MS.ISBN INNER 	JOIN
    	(SELECT ISBN, TenSach, TheLoai
    	FROM Sach_ChiTiet
    	WHERE TheLoai='Light Novel') S2 ON S1.ISBN=S2.ISBN)
UNION
SELECT MaMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM 
	((SELECT TenDG, MaDG
	FROM DOCGIA
	WHERE DiaChi='TP.HCM') DG INNER JOIN
	(SELECT TenTK, MaDG
	FROM TAIKHOAN
	WHERE CongNo>=0) TK ON DG.MaDG=TK.MADG INNER 	JOIN
	(SELECT MaMS, TenTK, ISBN, MaTT, NgMuon, NgHetHan
	FROM MUONSACH)MS ON TK.TenTK=MS.TenTK INNER JOIN
	(SELECT TenTT, MaTT
	FROM THUTHU) TT ON TT.MaTT=MS.MaTT INNER JOIN
	(SELECT ISBN 
	FROM SACH_SOLUOT
	WHERE  TinhTrang='Available') S1 ON S1.ISBN=MS.ISBN INNER 	JOIN
    	(SELECT ISBN, TenSach, TheLoai
    	FROM SACH_CHITIET
    	WHERE TheLoai='English Book') S2 ON S1.ISBN=S2.ISBN);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST +cost +bytes'));
/*PHAN TAN + CHUA TOI UU*/
SELECT /*+ gather_plan_statistics */ MAMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM Sach_SoLuot, Sach_ChiTiet, ThuThu, DocGia, TaiKhoan, MuonSach
WHERE TinhTrang='Available'
	AND CongNo >=0
	AND TheLoai = 'Light Novel'
	AND DiaChi = 'HA NOI'
	AND ThuThu.MaTT = MuonSach.MaTT
	AND Sach_SoLuot.ISBN=MuonSach.ISBN
	AND Sach_ChiTiet.ISBN=Sach_SoLuot.ISBN
	AND DocGia.MADG=TaiKhoan.MaDG
	AND TaiKhoan.TenTK=MuonSach.TenTK
UNION
SELECT MAMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM hcm.SACH_SOLUOT@qltv_dblink, hcm.SACH_CHITIET@qltv_dblink, ThuThu,  
hcm.DocGia@qltv_dblink,  hcm.TaiKhoan@qltv_dblink, hcm.MuonSach@qltv_dblink
WHERE TinhTrang='Available'
	AND CongNo >=0
	AND TheLoai = 'English Book'
	AND DiaChi = 'TP.HCM'
	AND ThuThu.MaTT = MuonSach.MaTT
	AND Sach_SoLuot.ISBN=MuonSach.ISBN
	AND Sach_ChiTiet.ISBN=Sach_SoLuot.ISBN
	AND DocGia.MADG=TaiKhoan.MaDG
	AND TaiKhoan.TenTK=MuonSach.TenTK;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST +cost +bytes'));
/*PHAN TAN + TOI UU*/
SELECT /*+ gather_plan_statistics */ MaMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM 
	((SELECT TenDG, MaDG
	FROM DocGia
	WHERE DiaChi='HA NOI') DG INNER JOIN
	(SELECT TenTK, MaDG
	FROM TaiKhoan
	WHERE CongNo>=0) TK ON DG.MaDG=TK.MADG INNER 	JOIN
	(SELECT MaMS, TenTK, ISBN, MaTT, NgMuon, NgHetHan
	FROM MuonSach)MS ON TK.TenTK=MS.TenTK INNER JOIN
	(SELECT TenTT, MaTT
	FROM ThuThu) TT ON TT.MaTT=MS.MaTT INNER JOIN
	(SELECT ISBN 
	FROM Sach_SoLuot
	WHERE  TinhTrang='Available') S1 ON S1.ISBN=MS.ISBN INNER 	JOIN
    	(SELECT ISBN, TenSach, TheLoai
    	FROM Sach_ChiTiet
    	WHERE TheLoai='Light Novel') S2 ON S1.ISBN=S2.ISBN)
UNION
SELECT MaMS, TenDG, NgMuon, NgHetHan, TenSach, TheLoai, TenTT
FROM 
	((SELECT TenDG, MaDG
	FROM hcm.DocGia@qltv_dblink
	WHERE DiaChi='TP.HCM') DG INNER JOIN
	(SELECT TenTK, MaDG
	FROM hcm.TaiKhoan@qltv_dblink
	WHERE CongNo>=0) TK ON DG.MaDG=TK.MADG INNER 	JOIN
	(SELECT MaMS, TenTK, ISBN, MaTT, NgMuon, NgHetHan
	FROM hcm.MuonSach@qltv_dblink)MS ON TK.TenTK=MS.TenTK INNER JOIN
	(SELECT TenTT, MaTT
	FROM hcm.ThuThu@qltv_dblink) TT ON TT.MaTT=MS.MaTT INNER JOIN
	(SELECT ISBN 
	FROM hcm.SACH_SOLUOT@qltv_dblink
	WHERE  TinhTrang='Available') S1 ON S1.ISBN=MS.ISBN INNER 	JOIN
    	(SELECT ISBN, TenSach, TheLoai
    	FROM hcm.SACH_CHITIET@qltv_dblink
    	WHERE TheLoai='English Book') S2 ON S1.ISBN=S2.ISBN);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST +cost +bytes'));
COMMIT;