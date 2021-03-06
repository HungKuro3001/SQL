--BIẾN BẢNG
DECLARE @BAITAP03 TABLE
(	TENPHG	NVARCHAR(50), 
	SLNV	INT)
INSERT INTO @BAITAP03 
	SELECT TENPHG, COUNT(MANV) AS SLNV
	FROM PHONGBAN JOIN NHANVIEN ON PHONGBAN.MAPHG = NHANVIEN.PHG
	WHERE 30000 < (SELECT AVG(LUONG) FROM NHANVIEN)
	GROUP BY TENPHG
UPDATE @BAITAP03
SET TENPHG = 'NCKH'
WHERE TENPHG = N'NGHIÊN CỨU'
DELETE FROM @BAITAP03
WHERE TENPHG = N'QUẢN LÝ'
SELECT * FROM @BAITAP03

SELECT * FROM PHONGBAN
--4.
DECLARE @BAITAP04 TABLE
(	TENPHG	NVARCHAR(30),
	SLDA	INT)
INSERT INTO @BAITAP04
	SELECT TENPHG, COUNT(MADA) AS SLDA
	FROM PHONGBAN JOIN DEAN ON PHONGBAN.MAPHG = DEAN.PHONG
GROUP BY TENPHG
SELECT * FROM @BAITAP04

