
/*AssetTracking Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(AssetTracking_ID) FROM [dbo].[AssetTracking]);--10218

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[AssetTracking_ID_Mapping] ON; 
	INSERT INTO [dbo].[AssetTracking_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[AssetTracking_ID_Mapping] OFF; 

--UPDATE Advisor_Id column
UPDATE [dbo].[AssetTracking_MP]
SET [Advisor] = um.New_ID
FROM [dbo].[AssetTracking_MP] bc
JOIN [dbo].[Advisor_Id_Mapping] um ON bc.Advisor = um.Old_ID
WHERE bc.Advisor != -1

--UPDATE [InvestmentPlatform] column
UPDATE [dbo].[AssetTracking_MP]
SET [InvestmentPlatform] = um.New_ID
--SELECT *
FROM [dbo].[AssetTracking_MP] bc
JOIN [dbo].[InvestmentPlatforms_Lib_ID_Mapping] um ON bc.InvestmentPlatform = um.Old_ID
WHERE -- AssetTracking_ID > (SELECT Old_ID FROM AssetTracking_ID_Mapping WHERE MapId=-1) AND 
InvestmentPlatform !=-1

--UPDATE Plan_Index_Id column
UPDATE [dbo].[AssetTracking_MP]
SET Plans_Index_ID = um.New_ID
FROM [dbo].[AssetTracking_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_ID = um.Old_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE Notes column
UPDATE [dbo].[AssetTracking_MP]
SET Notes_ID = um.[New_ID]
FROM [dbo].[AssetTracking_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Notes_ID=um.[Old_ID]
WHERE bc.Notes_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[AssetTracking_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[AssetTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE AssetConfirmedByWho column
UPDATE [dbo].[AssetTracking_MP]
SET AssetConfirmedByWho = um.[PPC_SysUserID]
FROM [dbo].[AssetTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssetConfirmedByWho=um.[MyPlans_SysUserID]
WHERE bc.AssetConfirmedByWho != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @Plans_Index_ID INT, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[AssetTracking_MP]

IF ((SELECT COUNT(*) FROM [dbo].[AssetTracking_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldId = AssetTracking_ID, @Plans_Index_ID = Plans_Index_ID  FROM [dbo].[AssetTracking_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1 
	 AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @Plans_Index_ID) > 0)	
	BEGIN
	INSERT INTO [dbo].[AssetTracking]
	 OUTPUT Inserted.AssetTracking_ID INTO @IdentityValue
		SELECT 	Plans_Index_ID,
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
				IsPortalDeleted,
				UDF1,
				UDF2,
				UDF3,
				UDF4,
				UDF5
   		FROM [dbo].[AssetTracking_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[AssetTracking_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[AssetTracking_MP]  WHERE LoopId > @LoopCounter

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