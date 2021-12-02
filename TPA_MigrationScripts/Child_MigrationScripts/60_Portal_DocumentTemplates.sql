/*Portal_DocumentTemplates Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Assignee column
UPDATE [dbo].[Portal_DocumentTemplates_MP]
SET Assignee = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTemplates_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Assignee=um.[MyPlans_SysUserID]
WHERE bc.Assignee != -1

--UPDATE CreatedBy column
UPDATE [dbo].[Portal_DocumentTemplates_MP]
SET CreatedBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTemplates_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.CreatedBy=um.[MyPlans_SysUserID]
WHERE bc.CreatedBy != -1

--UPDATE UpdatedBy column
UPDATE [dbo].[Portal_DocumentTemplates_MP]
SET UpdatedBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTemplates_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UpdatedBy=um.[MyPlans_SysUserID]
WHERE bc.UpdatedBy != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_DocumentTemplates]
SELECT TemplateType,
DocumentType,
TaskId,
Assignee,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate,
IsPortalDeleted,
Deadline,
Percentage,
TaskType,
BudgetedTime,
IsCreateToDo,
IsSendEmail,
TemplateCompletionStatus,
IsDeliveryAdd,
Ordering
FROM [Portal_DocumentTemplates_MP]

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