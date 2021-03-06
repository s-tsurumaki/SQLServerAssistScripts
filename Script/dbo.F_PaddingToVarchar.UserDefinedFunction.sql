CREATE FUNCTION [dbo].[F_PaddingToVarchar]
(
 @Padding CHAR(1) = '0' -- 何で埋めるのか。初期値はゼロ
,@Length  INT           -- 埋める長さ
,@String  NVARCHAR(MAX) -- 文字列
)
RETURNS NVARCHAR(MAX)
/*
======================================================================
概要    ：指定した文字と長さで文字列を埋めていきます。
詳細    ：
備考    ：
返却値  ：
======================================================================
*/
AS
BEGIN
	DECLARE @LengthItem NVARCHAR(MAX)
	SET @LengthItem = '';

    DECLARE @Cnt INT
	SET @Cnt = 1

	WHILE @Cnt <= @Length 
	BEGIN
		SET @LengthItem += @Padding
		SET @Cnt += 1
	END

    RETURN RIGHT(@LengthItem + @String, @Length)
END



GO
