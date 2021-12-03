/*ScheduleATracking Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(ScheduleATracking_ID) FROM [dbo].[ScheduleATracking]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[ScheduleATracking_ID_Mapping] ON; 
	INSERT INTO [dbo].[ScheduleATracking_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[ScheduleATracking_ID_Mapping] OFF; 

--UPDATE PlanIndexId column
UPDATE [dbo].[ScheduleATracking_MP]
SET Plans_Index_Id = um.New_ID
FROM [dbo].[ScheduleATracking_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_Id = um.Old_ID
WHERE bc.Plans_Index_Id != -1

--UPDATE AssetTracking_ID column
UPDATE [dbo].[ScheduleATracking_MP]
SET AssetTracking_ID = um.New_ID
FROM [dbo].[ScheduleATracking_MP] bc
JOIN [dbo].AssetTracking_ID_Mapping um ON bc.AssetTracking_ID = um.Old_ID
WHERE bc.AssetTracking_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[ScheduleATracking_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[ScheduleATracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE AssetConfirmedByWho column
UPDATE [dbo].[ScheduleATracking_MP]
SET AssetConfirmedByWho = um.[PPC_SysUserID]
FROM [dbo].[ScheduleATracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssetConfirmedByWho=um.[MyPlans_SysUserID]
WHERE bc.AssetConfirmedByWho != -1

--UPDATE InvestmentPlatform column
UPDATE [dbo].[ScheduleATracking_MP]
SET InvestmentPlatform = um.New_ID
FROM [dbo].[ScheduleATracking_MP] bc
JOIN [dbo].InvestmentPlatforms_Lib_ID_Mapping um ON bc.InvestmentPlatform = um.Old_ID
WHERE bc.InvestmentPlatform != -1

--UPDATE Advisor_Id column
UPDATE [dbo].[ScheduleATracking_MP]
SET [Advisor] = um.New_ID
FROM [dbo].[ScheduleATracking_MP] bc
JOIN [dbo].[Advisor_Id_Mapping] um ON bc.Advisor = um.Old_ID
WHERE bc.Advisor != -1

--UPDATE Notes column
UPDATE [dbo].[ScheduleATracking_MP]
SET Notes_ID = um.[New_ID]
FROM [dbo].[ScheduleATracking_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Notes_ID=um.[Old_ID]
WHERE bc.Notes_ID != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @AssetTrackingID INT, @Plans_Index_ID INT, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ScheduleATracking_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ScheduleATracking_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldID = ScheduleATracking_ID, 
	@AssetTrackingID = AssetTracking_ID, 
	@Plans_Index_ID = Plans_Index_ID  
	FROM [dbo].[ScheduleATracking_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1 
	 AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @Plans_Index_ID) > 0
	 AND (SELECT COUNT(*) FROM AssetTracking WHERE AssetTracking_ID = @AssetTrackingID) > 0)
	BEGIN
--Insert prepared data from temp table to target table
INSERT INTO [dbo].[ScheduleATracking]
OUTPUT Inserted.ScheduleATracking_ID INTO @IdentityValue
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
FROM [ScheduleATracking_MP]
WHERE LoopId = @LoopCounter

SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[ScheduleATracking_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ScheduleATracking_MP]  WHERE LoopId > @LoopCounter

END
END
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