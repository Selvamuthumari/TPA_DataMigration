
/*ProspectPlan Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[ProspectPlan_MP]
SET Client_ID = um.New_ID
FROM [dbo].[ProspectPlan_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_ID = um.Old_ID
WHERE bc.Client_ID != -1

--UPDATE PlanIndexId column
UPDATE [dbo].[ProspectPlan_MP]
SET PlanIndex = um.New_ID
FROM [dbo].[ProspectPlan_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanIndex = um.Old_ID
WHERE bc.PlanIndex != -1

--UPDATE ByWho column
UPDATE [dbo].[ProspectPlan_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[ProspectPlan_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[ProspectPlan]
SELECT 
Client_ID,
PlanIndex,
Plan_Name,
PlanOrigin,
PlanType,
PYE_Year,
NumParticipants,
PlanYE,
Type5500,
Analyst,
Reviewer,
SafeHarbor,
SafeHarbor_Type,
ACA,
ACA_Type,
ACA_MIN_PERC,
ACA_MAX_PERC,
PBGC_Covered,
NoAdpTesting_Required,
NoAcpTesting_Required,
BaseFee,
PerParticipantFee,
NonParticipantFee,
LoanFee,
DistributionFee,
BondRequired,
NewComparability,
ProfitSharing,
GeneralTested,
Pooled,
FBOAccounts,
Rollover,
LastUpdated,
ByWho,
Plan_Name_2,
PlanOrigin_2,
PlanType_2,
NextProspectPlan,
FeeOverride
FROM [ProspectPlan_MP]

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