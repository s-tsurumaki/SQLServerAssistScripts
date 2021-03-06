/*
======================================================================
概要    ：テーブルの中身をコピーします。
詳細　　：以下のSQLと同等です
    　　：SELECT * INTO Table FROM CopyTable
備考　　：
======================================================================
*/
CREATE PROCEDURE [dbo].[P_CopyTable]
(
  -- データベース オブジェクトの制限でテーブル名128文字まで
  @OriginalTableName NVARCHAR(128) = NULL -- コピー元のテーブル名
 ,@CreateTableName   NVARCHAR(128) = NULL -- コピー先のテーブル名
)
AS
BEGIN
	--■■■■■■■■■
	--引数チェック
	--■■■■■■■■■
	-- メッセージID,重大度,State, %s に入る文字
	IF(@OriginalTableName = null) BEGIN RAISERROR ('@OriginalTableNameが無効です：%s',10,1,@OriginalTableName); RETURN; END;
	IF(@CreateTableName   = null) BEGIN RAISERROR ('@CreateTableNameが無効です：%s'  ,10,1,@CreateTableName);   RETURN; END;
	
    Exec ('SELECT * INTO ' + @CreateTableName + ' FROM ' + @OriginalTableName); -- テーブルをコピーする。

END



GO
