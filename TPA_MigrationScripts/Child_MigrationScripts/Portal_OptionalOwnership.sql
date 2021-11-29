/*Portal_OptionalOwnership Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[Portal_OptionalOwnership_MP]
SET [ClientId] = um.New_ID
FROM [dbo].[Portal_OptionalOwnership_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.ClientId = um.Old_ID
WHERE bc.ClientId != -1

/*ByWhoClient*/
UPDATE [dbo].[Portal_OptionalOwnership_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[Portal_OptionalOwnership_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.ByWhoClient = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1

UPDATE [dbo].[Portal_OptionalOwnership_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[Portal_OptionalOwnership_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.ByWhoClient = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_OptionalOwnership]
SELECT ClientId,
PlanYear,
OwnerName,
Title,
PriorOwnerPercent,
CurrentOwnerPercent,
EffectiveDate,
ByWhoClient,
LastUpdatedClient,
IsLastUpdatedByAdvisor
FROM Portal_OptionalOwnership_MP
WHERE ClientID IN (SELECT Client_ID FROM Client_Master)

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