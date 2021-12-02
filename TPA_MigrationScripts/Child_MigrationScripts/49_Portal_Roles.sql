/*Portal_Roles Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT [dbo].[Portal_Roles] ON;
INSERT INTO [dbo].[Portal_Roles]
(Id, Name)
SELECT Id,
Name
FROM [Portal_Roles_MP]
SET IDENTITY_INSERT [dbo].[Portal_Roles] OFF;

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