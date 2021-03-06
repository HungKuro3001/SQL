--1
CREATE DATABASE QLBDS
GO
USE QLBDS
GO
CREATE TABLE VANPHONG (
MAVP VARCHAR(10) NOT NULL,
TENVP NVARCHAR(30) NULL,
DIENTHOAI VARCHAR (13) NULL,
EMAIL VARCHAR(30) NULL,
TRUONGPHONG NVARCHAR(50) NULL,
CONSTRAINT PK_VANPHONG PRIMARY KEY(MAVP)
)
CREATE TABLE BDS(
MABDS VARCHAR(10) NOT NULL,
TENBDS NVARCHAR(50) NULL,
DIACHI NVARCHAR(50) NULL,
MACHS VARCHAR(20) NULL,
MAVP VARCHAR (10) NULL,
CONSTRAINT PK_BDS PRIMARY KEY(MABDS)

)--KHÓA NGOẠI
ALTER TABLE BDS ADD CONSTRAINT FK_VANPHONG_BDS FOREIGN KEY (MAVP) REFERENCES VANPHONG(MAVP);
--2
IF OBJECT_ID('SP1')IS NOT NULL
DROP PROC SP1
GO
CREATE PROC SP1
@MAVP VARCHAR(10),@TENVP NVARCHAR(30),@DIENTHOAI VARCHAR (13),@EMAIL VARCHAR(30),
@TRUONGPHONG NVARCHAR(50)
AS
IF @MAVP IS NULL OR @TENVP IS NULL OR @DIENTHOAI IS NULL OR @EMAIL IS NULL OR @TRUONGPHONG IS NULL
PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
 ELSE
 INSERT INTO VANPHONG VALUES (@MAVP,@TENVP,@DIENTHOAI,@EMAIL,@TRUONGPHONG)
 GO
 EXEC SP1 'VP01',N'PHÒNG IT','0949325099','VP01@GMAIL.COM',N'NGUYỄN VĂN A'
  EXEC SP1 'VP02',N'PHÒNG LAB','0387490099','VP02@GMAIL.COM',N'NGUYỄN THỊ B'

SELECT *FROM VANPHONG

--TẠO  BDS
IF OBJECT_ID('SP2')IS NOT NULL
DROP PROC SP2
GO
CREATE PROC SP2

@MABDS VARCHAR(10) ,@TENBDS NVARCHAR(50),@DIACHI NVARCHAR(50),@MACHS VARCHAR(20),@MAVP VARCHAR (10)
AS
IF
@MABDS IS NULL OR @TENBDS IS NULL OR @DIACHI IS NULL OR @MACHS IS NULL OR @MAVP IS NULL 
PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
 ELSE
 INSERT INTO BDS VALUES (@MABDS,@TENBDS,@DIACHI,@MACHS,@MAVP)
 GO
 EXEC SP2 'BDS01',N'BDS XỊN',N'HÀ NỘI','CSH01','VP01'
  EXEC SP2 'BDS02',N'BDS THƯỜNG',N'HÀ NAM','CHS02','VP02'
  SELECT * FROM BDS
  --3
IF OBJECT_ID('SP3')IS NOT NULL
DROP FUNCTION SP3
GO
CREATE FUNCTION SP3 (@MAVP VARCHAR(10))
RETURNS @BAI3 TABLE(MAVP VARCHAR(10),TENVP NVARCHAR(30),TENBDS NVARCHAR(50),DIACHI NVARCHAR(50))
AS
BEGIN
	INSERT INTO @BAI3
	SELECT VANPHONG.MAVP,TENVP,TENBDS,DIACHI FROM BDS  JOIN VANPHONG
	ON VANPHONG.MAVP = BDS.MAVP
	WHERE VANPHONG.MAVP = @MAVP
	RETURN
END
GO
SELECT *  FROM SP3('VP01')
-- 4
IF OBJECT_ID('SP4') IS NOT NULL
DROP PROC SP4
GO
CREATE PROC SP4 @MAVP VARCHAR(10)
AS
BEGIN TRY
	   BEGIN TRAN
      --XÓA KHÓA NGOẠI
      DELETE BDS WHERE MAVP=@MAVP
      --XÓA KHÓA CHÍNH
       DELETE VANPHONG WHERE MAVP=@MAVP
         COMMIT TRAN
END TRY
	   
BEGIN CATCH
	ROLLBACK TRAN
END CATCH
EXEC SP4'VP02'
select * from VANPHONG
-- 5
IF OBJECT_ID('cau5') IS NOT NULL
    DROP VIEW cau5
	GO
CREATE VIEW cau5
AS
SELECT * FROM VANPHONG WHERE MAVP in
(SELECT TOP 2  MAVP FROM BDS
GROUP BY MABDS, MAVP
ORDER BY COUNT(MABDS) 
DESC)

SELECT * FROM cau5
