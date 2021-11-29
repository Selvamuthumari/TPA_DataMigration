/*Portal_ToDoAssigneeHistory Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE AssignedBy
UPDATE [dbo].[Portal_ToDoAssigneeHistory_MP]
SET AssignedBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_ToDoAssigneeHistory_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssignedBy=um.[MyPlans_SysUserID]
WHERE bc.AssignedBy != -1

--UPDATE PreparedBy
UPDATE [dbo].[Portal_ToDoAssigneeHistory_MP]
SET PreparedBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_ToDoAssigneeHistory_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.PreparedBy=um.[MyPlans_SysUserID]
WHERE bc.PreparedBy != -1

--UPDATE TicketId
UPDATE [dbo].[Portal_ToDoAssigneeHistory_MP]
SET TicketId = um.New_ID
FROM [dbo].[Portal_ToDoAssigneeHistory_MP] bc
JOIN [dbo].[AdHocToDo_ID_Mapping] um ON bc.TicketId=um.Old_ID
WHERE bc.TicketId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_ToDoAssigneeHistory]
SELECT TicketId,
PreviousAssignedId,
CurrentAssignedId,
AssignedDate,
AssignedBy,
PreparedBy,
PreparedDate
FROM Portal_ToDoAssigneeHistory_MP
WHERE TicketId IN (SELECT AdHocTodo_ID FROM AdHocTodo)

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
END TRY  
BEGIN CATCH  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
    INSERT INTO dbo.DataMigration_Errors
    VALUES
  (SUSER_SNAME(),
   ERROR_NUMBER(),
   ERROR_STATE(),
   ERROR_SEVERITY(),
   ERROR_LINE(),
   ERROR_PROCEDURE(),
   ERROR_MESSAGE(),
   GETDATE());    
END CATCH;  
  
GO