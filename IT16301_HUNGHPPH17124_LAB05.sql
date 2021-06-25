﻿--Bài 1:
IF OBJECT_ID('SP_BAI01') IS NOT NULL 
 DROP PROC SP_BAI01
 GO
 CREATE PROC SP_BAI01 @MA_NVIEN NVARCHAR(9),@MADA INT,@STT INT, @THOIGIAN FLOAT
AS
BEGIN
	IF(@MA_NVIEN IS NULL OR @MADA IS NULL  OR @STT IS NULL )
			BEGIN
				PRINT N'YÊU CẦU NGƯỜI DÙNG NHẬP DỮ LIỆU ĐẦY ĐỦ'
			END
	ELSE
	BEGIN TRY
			INSERT INTO PHANCONG
			VALUES (@MA_NVIEN,@MADA,@STT,@THOIGIAN)
			PRINT N'THÊM DỮ LIỆU THÀNH CÔNG'
	END TRY
	BEGIN CATCH
		PRINT'LỖI THÊM DỮ LIỆU'
	END CATCH
END

EXEC SP_BAI01 N'008',3,1,13.7

--Bài 2:


 IF OBJECT_ID('SP_BAI02') IS NOT NULL
DROP PROC SP_BAI02
GO
  CREATE PROC SP_BAI02 @MADA INT = 10
AS
SELECT * FROM PHANCONG
WHERE @MADA=MADA
GO
--GỌI THỦ TỤC
--C1:CÓ DÙNG GIÁ TRỊ MẶC ĐỊNH 
EXEC SP_BAI02
--C2:KHHONG DÙNG GIÁ TRỊ MẶC ĐỊNH
EXEC SP_BAI02 3
--Bài 3:
IF OBJECT_ID ('SP_BAI03') IS NOT NULL
DROP PROC SPSOCHAN
GO
	CREATE PROC SP_BAI03 @A INT,@B INT
AS
	BEGIN
		DECLARE @SUM INT = 0
		SET @SUM = @A + @B
	END
	PRINT N'TỔNG:' + CAST(@SUM AS VARCHAR)
EXEC SP_BAI03 5,7
 -- Bài 4:
IF OBJECT_ID('SP_BAI04') IS NOT NULL
	DROP PROC SP_BAI04
GO
CREATE PROC SP_BAI04 @MATP VARCHAR(5)
		
AS
	BEGIN
		SELECT HONV,TENNV,TENPHG,NHANVIEN.MANV,THANNHAN.* FROM NHANVIEN
		INNER JOIN PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG
		LEFT OUTER JOIN THANNHAN ON THANNHAN.MA_NVIEN = NHANVIEN.MANV
		WHERE THANNHAN.MA_NVIEN IS NULL AND TRPHG = @MATP
	END
EXEC SP_BAI04 '008'