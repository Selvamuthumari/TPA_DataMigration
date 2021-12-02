/*Portal_DocumentTemplateMapping Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE UpdatedByWho
UPDATE [dbo].[Portal_DocumentTemplateMapping_MP]
SET UpdatedByWho = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTemplateMapping_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UpdatedByWho=um.[MyPlans_SysUserID]
WHERE bc.UpdatedByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_DocumentTemplateMapping]
SELECT PlanTypeId,
DocumentTypeId,
TemplateTypeId,
LastUpdated,
UpdatedByWho,
IsPortalDeleted
FROM Portal_DocumentTemplateMapping_MP

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