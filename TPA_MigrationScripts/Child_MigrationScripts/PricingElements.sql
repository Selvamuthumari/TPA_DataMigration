/*PricingElements Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[PricingElements_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[PricingElements_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[PricingElements] ON;
INSERT INTO [dbo].[PricingElements]
(PricingElements_ID,
ParentElement_ID,
PricingElements_Label,
PricingElements_Hint,
PricingHeader_ID,
Fee,
MinPart,
MaxPart,
PricingScriptRestrictionsList,
PricingPlanRestrictionsList,
UnitOfMeasure,
LastTouched,
ByWho)
SELECT PricingElements_ID,
ParentElement_ID,
PricingElements_Label,
PricingElements_Hint,
PricingHeader_ID,
Fee,
MinPart,
MaxPart,
PricingScriptRestrictionsList,
PricingPlanRestrictionsList,
UnitOfMeasure,
LastTouched,
ByWho
FROM [PricingElements_MP]
SET IDENTITY_INSERT dbo.[PricingElements] OFF;

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