/*Documents_Cluster Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE UserID column
UPDATE [dbo].[Documents_Cluster_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[Documents_Cluster_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Documents_Cluster]
SELECT DocumentCluster_ID,
Document_ID,
LastTouched,
ByWho,
IsLastUpdatedByAdvisor
FROM [Documents_Cluster_MP]

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