--UPDATE Comm_Log_Id column
UPDATE [dbo].[AdHocTodo]
SET Comm_Log_Id = um.New_ID
FROM [dbo].[AdHocTodo] bc
JOIN [dbo].[Comm_Log_ID_Mapping] um ON bc.Comm_Log_Id = um.Old_ID
WHERE bc.Comm_Log_Id != -1
AND bc.AdHocTodo_ID > (SELECT Old_ID from AdHocToDo_ID_Mapping WHERE MapId=-1)