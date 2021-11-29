/*special_instructions Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE company_id column
UPDATE [dbo].[special_instructions_MP]
SET company_id = um.New_ID
FROM [dbo].[special_instructions_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.company_id = um.Old_ID
WHERE bc.company_id != -1

--UPDATE [user_id] column
UPDATE [dbo].[special_instructions_MP]
SET [user_id] = um.[PPC_SysUserID]
FROM [dbo].[special_instructions_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.[user_id]=um.[MyPlans_SysUserID]
WHERE bc.[user_id] != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[special_instructions]
SELECT company_id,
description,
initiated,
expires,
user_id,
importance,
IsWarning
FROM [special_instructions_MP]
WHERE company_id IN (SELECT CLIENT_ID FROM Client_Master)

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