/*Portal_UserSignatures Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE UserId column
UPDATE [dbo].[Portal_UserSignatures_MP]
SET UserId = um.[PPC_SysUserID]
FROM [dbo].[Portal_UserSignatures_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UserId=um.[MyPlans_SysUserID]
WHERE bc.UserId != -1

--UPDATE ByWho column
UPDATE [dbo].[Portal_UserSignatures_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[Portal_UserSignatures_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho = um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE LOCAL_NAME column
UPDATE [dbo].[Portal_UserSignatures_MP]
SET LOCAL_NAME =REPLACE(LOCAL_NAME, MyPlans_SysUserID, PPC_SysUserID)
FROM [dbo].[Portal_UserSignatures_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UserId = um.[PPC_SysUserID]
WHERE bc.UserId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_UserSignatures]
SELECT UserId,
SignatureName,
Local_Name,
MimeType,
LastTouched,
ByWho
FROM [Portal_UserSignatures_MP]
WHERE UserId IN (SELECT UserId FROM [dbo].[Portal_Users])

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