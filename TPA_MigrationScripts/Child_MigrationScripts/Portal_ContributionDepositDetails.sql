/*Portal_ContributionDepositDetails Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ConfirmationOfContributionId column
UPDATE [dbo].[Portal_ContributionDepositDetails_MP]
SET ConfirmationOfContributionId = um.New_ID
FROM [dbo].[Portal_ContributionDepositDetails_MP] bc
JOIN [dbo].[Portal_ConfirmationOfContribution_ID_Mapping] um ON bc.ConfirmationOfContributionId = um.Old_ID
WHERE bc.ConfirmationOfContributionId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_ContributionDepositDetails]
SELECT ConfirmationOfContributionId,
DepositDate,
Investment,
AssetName
FROM Portal_ContributionDepositDetails_MP
WHERE ConfirmationOfContributionId IN (SELECT ConfirmationOfContributionId FROM Portal_ConfirmationOfContribution)

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