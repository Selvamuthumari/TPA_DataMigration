/*TaskList Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE [RequestedByWho] column
UPDATE [dbo].[TaskList_MP]
SET RequestedByWho = um.[PPC_SysUserID]
FROM [dbo].[TaskList_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.RequestedByWho=um.[MyPlans_SysUserID]
WHERE bc.RequestedByWho != -1

--UPDATE [AssignedToWho] column
UPDATE [dbo].[TaskList_MP]
SET AssignedToWho = um.[PPC_SysUserID]
FROM [dbo].[TaskList_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssignedToWho=um.[MyPlans_SysUserID]
WHERE bc.AssignedToWho != -1

--UPDATE [ByWho] column
UPDATE [dbo].[TaskList_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[TaskList_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[TaskList] ON;
INSERT INTO [dbo].[TaskList]
(TaskList_ID,
Category,
FirstPostedStamp,
RequestedByWho,
RequiredByStamp,
IsCompleted,
DateReopenedStamp,
DateCompletedStamp,
TaskPriority,
TaskSubject,
TaskDescription,
AssignedToWho,
LastEdited,
ByWho)
SELECT TaskList_ID,
Category,
FirstPostedStamp,
RequestedByWho,
RequiredByStamp,
IsCompleted,
DateReopenedStamp,
DateCompletedStamp,
TaskPriority,
TaskSubject,
TaskDescription,
AssignedToWho,
LastEdited,
ByWho
FROM [TaskList_MP]
SET IDENTITY_INSERT dbo.[TaskList] OFF;

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