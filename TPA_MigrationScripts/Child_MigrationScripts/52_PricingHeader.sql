/*PricingHeader Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[PricingHeader_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[PricingHeader_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[PricingHeader] ON;
INSERT INTO [dbo].[PricingHeader]
(PricingHeader_ID,
PricingHeader_Label,
PricingGroup_ID,
EffectiveYear,
PlanTypeRestriction,
LastTouched,
ByWho)
SELECT PricingHeader_ID,
PricingHeader_Label,
PricingGroup_ID,
EffectiveYear,
PlanTypeRestriction,
LastTouched,
ByWho
FROM [PricingHeader_MP]
SET IDENTITY_INSERT dbo.[PricingHeader] OFF;

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