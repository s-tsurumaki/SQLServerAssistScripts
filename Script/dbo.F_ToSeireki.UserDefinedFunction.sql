USE [SQLServerAssistScripts]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[F_ToSeireki](
  @Date        DATE
, @GetItem     INT -- 0：年月日 1:年2:月3:日
, @ZeroPadding INT -- 月と日をゼロ詰めする場合は1
)
RETURNS NVARCHAR(11)
/*
======================================================================
概要    ：
詳細    ：
備考    ：
返却値  ：
======================================================================
*/
AS
BEGIN
	DECLARE @Ret   NVARCHAR(11)
	DECLARE @Year  NVARCHAR(5)
	DECLARE @Month NVARCHAR(3)
	DECLARE @Day   NVARCHAR(3)

	SET @Ret   = '';
	SET @Year  = CONVERT(NVARCHAR,YEAR(@Date))  + '年';
	SET @Month = CONVERT(NVARCHAR,MONTH(@Date));
	SET @Day   = CONVERT(NVARCHAR,DAY(@Date));

	-- ゼロ埋め処理
    IF(@ZeroPadding = 1)
	BEGIN
	    SET @Month = CONVERT(NVARCHAR,FORMAT(CONVERT(INT,@Month),'00'));
	    SET @Day   = CONVERT(NVARCHAR,FORMAT(CONVERT(INT,@Day),'00'));
	END

	SET @Month += '月';
	SET @Day   += '日'; 

	     IF(@GetItem = 0) BEGIN SET @Ret = @Year + @Month + @Day; END
	ELSE IF(@GetItem = 1) BEGIN SET @Ret = @Year;                 END
	ELSE IF(@GetItem = 2) BEGIN SET @Ret = @Month;                END
	ELSE IF(@GetItem = 3) BEGIN SET @Ret = @Day;                  END

    RETURN @Ret;
END



GO
