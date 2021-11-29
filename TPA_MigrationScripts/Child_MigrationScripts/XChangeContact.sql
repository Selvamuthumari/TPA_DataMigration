/*XChangeContact Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

INSERT INTO [dbo].[XChangeContact]
(Name,
ClassType,
Tel,
ForeignId,
DirectoryId,
TenantId)
SELECT 
Name,
ClassType,
Tel,
ForeignId,
DirectoryId,
TenantId
FROM [XChangeContact_MP]

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