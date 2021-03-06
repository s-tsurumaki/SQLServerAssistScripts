USE [SQLServerAssistScripts]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[P_RefreshViewAll]
AS
BEGIN

  DECLARE @ViewName NVARCHAR(128);
  DECLARE @ExecSql  NVARCHAR(150);

  DECLARE ViewCursor CURSOR FOR SELECT Name FROM sysobjects WHERE xtype = 'V';

  OPEN ViewCursor;

  FETCH NEXT FROM ViewCursor INTO @ViewName

  -- viewテーブル分ループ
  WHILE (@@fetch_status = 0)
  BEGIN

    PRINT 'View:' + @ViewName

    DECLARE @referencing_entity AS sysname = @ViewName;

    -- viewの依存順序からsp_refreshviewのSQLコマンドを作成する
    DECLARE ExecCursor cursor FOR
    WITH W_Depends
    (
      referenced_entity_name
    , referenced_id
    , Dependence_Order
    )
    AS
    (
        SELECT
              MAIN_T.referenced_entity_name
            , MAIN_T.referenced_id
            , 0 AS DependenceOrder
        FROM sys.sql_expression_dependencies AS MAIN_T
        WHERE
            OBJECT_NAME(MAIN_T.referencing_id) = @ViewName
        UNION ALL
        SELECT
              sed.referenced_entity_name
            , sed.referenced_id
            , WiTH_T.Dependence_Order + 1 AS DependenceOrder
        FROM W_Depends AS WiTH_T INNER JOIN sys.sql_expression_dependencies AS sed ON sed.referencing_id = WiTH_T.referenced_id
    )

    SELECT
         T.ExecSql
    FROM
    (
        SELECT
              'EXEC sp_refreshview ''' + referenced_entity_name + '''' AS ExecSql
            , Dependence_Order
            , ROW_NUMBER() OVER (PARTITION BY referenced_entity_name ORDER BY referenced_entity_name , Dependence_Order DESC) AS RowNo
        FROM W_Depends W INNER JOIN sysobjects S ON W.referenced_id = S.id
        WHERE S.xtype = 'V'
    ) AS T
    WHERE T.RowNo = 1
    ORDER BY T.Dependence_Order DESC;

    OPEN ExecCursor;

    FETCH NEXT FROM ExecCursor INTO @ExecSql;
    
    WHILE (@@fetch_status = 0)
    BEGIN
      PRINT  @ExecSql;
      EXEC  (@ExecSql);
      
      FETCH NEXT FROM ExecCursor INTO @ExecSql;
    END

    CLOSE      ExecCursor;
    DEALLOCATE ExecCursor;

    FETCH NEXT FROM ViewCursor INTO @ViewName;
  END

  CLOSE      ViewCursor;
  DEALLOCATE ViewCursor;

END

GO
