/*PortalDefaults_GridState Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE UserId column
UPDATE [dbo].[PortalDefaults_GridState_MP]
SET UserId = um.PPC_SysUserID
FROM [dbo].[PortalDefaults_GridState_MP] bc
JOIN [dbo].[UserId_Mapping] um ON bc.UserId = um.MyPlans_SysUserID
WHERE bc.UserId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalDefaults_GridState]
SELECT GridName,
GridState,
UserId
FROM PortalDefaults_GridState_MP

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