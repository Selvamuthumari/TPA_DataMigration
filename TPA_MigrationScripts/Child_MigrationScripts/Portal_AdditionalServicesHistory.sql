/*Portal_AdditionalServicesHistory Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE PlanIndexId column
UPDATE [dbo].[Portal_AdditionalServicesHistory_MP]
SET PlanId = um.New_ID
FROM [dbo].[Portal_AdditionalServicesHistory_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanId = um.Old_ID
WHERE bc.PlanId != -1

--UPDATE Client_Id column
UPDATE [dbo].[Portal_AdditionalServicesHistory_MP]
SET ClientId = um.New_ID
FROM [dbo].[Portal_AdditionalServicesHistory_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.ClientId = um.Old_ID
WHERE bc.ClientId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_AdditionalServicesHistory]
SELECT ClientId,
PlanId,
AdditionalServiceId
FROM [Portal_AdditionalServicesHistory_MP]
WHERE PlanId IN (SELECT Plans_Index_ID FROM Plans WHERE Plans_Index_ID != -1)

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