/*MarketValuationTracking Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Plans_Index_ID column
UPDATE [dbo].[MarketValuationTracking_MP]
SET Plans_Index_ID = um.New_ID
FROM [dbo].[MarketValuationTracking_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_ID = um.Old_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE AssetTracking_ID column
UPDATE [dbo].[MarketValuationTracking_MP]
SET AssetTracking_ID = um.[New_ID]
FROM [dbo].[MarketValuationTracking_MP] bc
JOIN [dbo].[AssetTracking_ID_Mapping] um ON bc.AssetTracking_ID=um.[Old_ID]
WHERE bc.AssetTracking_ID != -1

--UPDATE Advisor_ID column
UPDATE [dbo].[MarketValuationTracking_MP]
SET Advisor = um.[New_ID]
FROM [dbo].[MarketValuationTracking_MP] bc
JOIN [dbo].[Advisor_ID_Mapping] um ON bc.Advisor=um.[Old_ID]
WHERE bc.Advisor != -1

--UPDATE Notes_ID column
UPDATE [dbo].[MarketValuationTracking_MP]
SET Notes_ID = um.[New_ID]
FROM [dbo].[MarketValuationTracking_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Notes_ID=um.[Old_ID]
WHERE bc.Notes_ID != -1

--UPDATE InvestmentPlatform column
UPDATE [dbo].[MarketValuationTracking_MP]
SET InvestmentPlatform = um.[New_ID]
FROM [dbo].[MarketValuationTracking_MP] bc
JOIN [dbo].[InvestmentPlatforms_Lib_ID_Mapping] um ON bc.InvestmentPlatform=um.[Old_ID]
WHERE bc.InvestmentPlatform != -1

--UPDATE ByWho column
UPDATE [dbo].[MarketValuationTracking_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[MarketValuationTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE AssetConfirmedByWho
UPDATE [dbo].[MarketValuationTracking_MP]
SET AssetConfirmedByWho = um.[PPC_SysUserID]
FROM [dbo].[MarketValuationTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssetConfirmedByWho=um.[MyPlans_SysUserID]
WHERE bc.AssetConfirmedByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[MarketValuationTracking]
SELECT Plans_Index_ID,
PYE_Year,
PYE_Month,
Asset_Index,
Money_Type,
Account_Type,
Record_Keeper,
RK_Account_No,
Custodian,
C_Account_No,
Statement_Delivery,
Advisor,
Notes,
More,
Same_As,
Sch_A_Required,
LastEdited,
ByWho,
Notes_ID,
QBSAction,
InvestmentPlatform,
AssetConfirmed,
AssetConfirmedByWho,
AssetConfirmedByType,
AssetConfirmedWhen,
Kind,
AccountClosed,
LastStatementDate,
FirstStatementDate,
NonQualifiedAsset,
Download,
AssetTracking_ID,
IsPortalDeleted
FROM MarketValuationTracking_MP
WHERE AssetTracking_ID in (SELECT AssetTracking_ID FROM AssetTracking)

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