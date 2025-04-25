EXEC sp_MSforeachdb 'DBCC SHRINKDATABASE (''?'' , 0)'
