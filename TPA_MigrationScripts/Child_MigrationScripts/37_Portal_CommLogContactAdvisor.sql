/*Portal_CommLogContactAdvisor Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE CommLogId column
UPDATE [dbo].[Portal_CommLogContactAdvisor_MP]
SET CommLogId = um.New_ID
FROM [dbo].[Portal_CommLogContactAdvisor_MP] bc
JOIN [dbo].[Comm_Log_ID_Mapping] um ON bc.CommLogId = um.Old_ID
WHERE bc.CommLogId != -1

--UPDATE ContactAdvisorId column
UPDATE [dbo].[Portal_CommLogContactAdvisor_MP]
SET ContactAdvisorId = um.New_ID
FROM [dbo].[Portal_CommLogContactAdvisor_MP] bc
JOIN [dbo].[Contacts_ID_Mapping] um ON bc.ContactAdvisorId = um.Old_ID
WHERE bc.ContactAdvisorId != -1 AND bc.IsContactAdvisor='Contact'

UPDATE [dbo].[Portal_CommLogContactAdvisor_MP]
SET ContactAdvisorId = um.New_ID
FROM [dbo].[Portal_CommLogContactAdvisor_MP] bc
JOIN [dbo].[Advisor_ID_Mapping] um ON bc.ContactAdvisorId = um.Old_ID
WHERE bc.ContactAdvisorId != -1 AND bc.IsContactAdvisor='Advisor'

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_CommLogContactAdvisor]
SELECT CommLogId,
ContactAdvisorId,
IsContactAdvisor,
IsSelected,
IsPortalDeleted
FROM Portal_CommLogContactAdvisor_MP
WHERE CommLogId IN (SELECT Comm_Log_ID FROM Comm_Log)

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