-- Define column to index.
DECLARE @coltoindex VARCHAR(20), @indexoptions VARCHAR(30)
SET @coltoindex = 'Id'
SET @indexoptions = 'UNIQUE'

USE database_name
--IF OBJECT_ID('tempdb..#tables') IS NOT NULL DROP TABLE #tables
SELECT table_schema, table_name INTO #tables FROM INFORMATION_SCHEMA.TABLES
DECLARE @schema VARCHAR(30), @table VARCHAR(20), @sqlCommand varchar(1000)
WHILE (SELECT COUNT(*) FROM #tables) > 0
BEGIN
    SELECT TOP 1 @schema = table_schema, @table = table_name FROM #tables
    SET @sqlCommand = '
        IF EXISTS(SELECT * FROM sys.columns  
        WHERE [name] = N''' + @coltoindex + ''' 
        AND [object_id] = OBJECT_ID(N''' + @schema + '.' + @table + ''')) 
        BEGIN 
            CREATE ' + @indexoptions + ' INDEX 
            idx_'  + @schema + '_' + @table + '_' + @coltoindex + '
            ON ' + @schema + '.' + @table + ' (' + @coltoindex + ')
        END'
    EXEC (@sqlCommand)
    DELETE FROM #tables WHERE table_schema = @schema AND table_name = @table
END