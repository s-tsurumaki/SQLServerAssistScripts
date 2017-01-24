# SQLServerAssistScripts
 SQLServerで利用する関数郡


### F_ToSeireki

日付型を西暦の文字列に変換します。


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
