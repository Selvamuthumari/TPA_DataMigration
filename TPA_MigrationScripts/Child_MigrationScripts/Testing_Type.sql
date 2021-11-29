/*Testing_Type Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[Testing_Type_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Testing_Type_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[Testing_Type] ON;
INSERT INTO [dbo].[Testing_Type]
(Testing_Type_ID,
Testing_Type_Text,
Testing_Group,
Testing_Plan,
Testing_Communicate,
Testing_Decision,
Testing_Results,
LastTouched,
ByWho)
SELECT Testing_Type_ID,
Testing_Type_Text,
Testing_Group,
Testing_Plan,
Testing_Communicate,
Testing_Decision,
Testing_Results,
LastTouched,
ByWho
FROM [Testing_Type_MP]
SET IDENTITY_INSERT dbo.[Testing_Type] OFF;

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