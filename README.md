# これはなに？
 SQLServerで利用する関数郡

## UserDefinedFunction

### F_ToSeireki(@Date,@GetItem,@ZeroPadding)

日付型を西暦の文字列に変換します。

#### 引数について
| 引数            | 型               | 備考                 | 値                 | 
| --------------- |:---------------:| -------------------- | -------------------- | 
| @Date           | Date            | 変換したい日付        |変換したい日付        |
| @GetItem        | INT             | 取得する日付 |0：年月日 1:年2:月3:日 |
| @ZeroPadding    | INT            | 月と日をゼロ詰め指定     | ゼロ詰めする場合は1を指定     | 



```sql
          SELECT dbo.F_ToSeireki (GETDATE(),0,0) AS F_ToSeireki -- 2017年1月24日
UNION ALL SELECT dbo.F_ToSeireki (GETDATE(),1,0) AS F_ToSeireki -- 2017年
UNION ALL SELECT dbo.F_ToSeireki (GETDATE(),2,0) AS F_ToSeireki -- 1月
UNION ALL SELECT dbo.F_ToSeireki (GETDATE(),3,0) AS F_ToSeireki -- 24日
UNION ALL SELECT dbo.F_ToSeireki (GETDATE(),0,1) AS F_ToSeireki -- 2017年01月24日
UNION ALL SELECT dbo.F_ToSeireki (GETDATE(),1,1) AS F_ToSeireki -- 2017年
UNION ALL SELECT dbo.F_ToSeireki (GETDATE(),2,1) AS F_ToSeireki -- 01月
UNION ALL SELECT dbo.F_ToSeireki (GETDATE(),3,1) AS F_ToSeireki -- 24日
```
## StoredProcedure

### P_RefreshViewAll

依存関係がある全てのviewに[sp_refreshview](https://technet.microsoft.com/ja-jp/library/ms187821(v=sql.110).aspx)を実行します。
