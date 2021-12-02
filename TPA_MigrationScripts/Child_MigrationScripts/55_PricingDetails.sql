/*PricingDetails Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE PlanIndexId column
UPDATE [dbo].[PricingDetails_MP]
SET Plans_Index_Id = um.New_ID
FROM [dbo].[PricingDetails_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_Id = um.Old_ID
WHERE bc.Plans_Index_Id != -1

--UPDATE ByWho column
UPDATE [dbo].[PricingDetails_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[PricingDetails_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE LockedByWho column
UPDATE [dbo].[PricingDetails_MP]
SET LockedByWho = um.[PPC_SysUserID]
FROM [dbo].[PricingDetails_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.LockedByWho=um.[MyPlans_SysUserID]
WHERE bc.LockedByWho != -1

--Insert prepared data from temp table to target table

INSERT INTO [dbo].[PricingDetails]
SELECT Plans_Index_ID,
PYE_Year,
PYE_Partial,
Participant_Count,
Pricing_Schedule_ID,
Balance_Forward,
General_Testing,
Plan_Audit_Fee,
Multiple_Employer_CO,
Number_Employer_CO,
Benefit_Formula_Redesign,
Num_KeysForBenFormRedesign,
Multiple_Owner_Funding_Analysis,
AnnualAdministration,
LoansDistributions,
AssetReconciliation,
RushCharges,
DocumentWork,
OtherCharges,
CreditDiscountRevShare,
TotalFeesBilled,
LastTouched,
ByWho,
Locked,
LockedByWho,
LockedWhen
FROM [PricingDetails_MP]

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