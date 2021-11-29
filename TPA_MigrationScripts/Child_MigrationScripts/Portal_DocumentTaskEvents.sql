/*Portal_DocumentTaskEvents Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE CreatedByWho
UPDATE [dbo].[Portal_DocumentTaskEvents_MP]
SET UpdatedBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTaskEvents_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UpdatedBy=um.[MyPlans_SysUserID]
WHERE bc.UpdatedBy != -1

--UPDATE CreatedByWho
UPDATE [dbo].[Portal_DocumentTaskEvents_MP]
SET CreatedBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTaskEvents_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.CreatedBy=um.[MyPlans_SysUserID]
WHERE bc.CreatedBy != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_DocumentTaskEvents]
SELECT TaskId,
EventType,
Action,
ExecuteTasks,
IsPortalDeleted,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate
FROM Portal_DocumentTaskEvents_MP

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