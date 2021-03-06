CREATE FUNCTION [dbo].[F_Trim](@String NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
/*
======================================================================
概要    ：LTRIMとRTRIMしたした値を返します。
詳細    ：単語間の 1 個のスペース以外、テキストからすべてのスペースを削除します。
備考    ：
返却値  ：文字列
======================================================================
*/
AS
BEGIN
    RETURN LTRIM(RTRIM(@String));
END
GO
