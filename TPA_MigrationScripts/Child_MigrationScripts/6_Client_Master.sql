
/*Client_Master Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Client_ID) FROM [dbo].[Client_Master]);--94193

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Client_Master_ID_Mapping] ON; 
	INSERT INTO [dbo].[Client_Master_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Client_Master_ID_Mapping] OFF; 

--UPDATE ByWho column
UPDATE [dbo].[Client_Master_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Client_Master_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE ReferedBy column
UPDATE [dbo].[Client_Master_MP]
SET [ReferedBy] = um.[PPC_SysUserID]
FROM [dbo].[Client_Master_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ReferedBy=um.[MyPlans_SysUserID]
WHERE bc.ReferedBy != -1

--UPDATE Contact_Method column
UPDATE [dbo].[Client_Master_MP]
SET [Contact_Method] = um.[New_ID]
FROM [dbo].[Client_Master_MP] bc
JOIN [dbo].[Contact_Method_ID_Mapping] um ON bc.Contact_Method=um.[Old_ID]
WHERE bc.Contact_Method != -1

--UPDATE Main_Address column
UPDATE [dbo].[Client_Master_MP]
SET [Main_Address] = um.[New_ID]
FROM [dbo].[Client_Master_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.Main_Address=um.[Old_ID]
WHERE bc.Main_Address != -1

--UPDATE Mail_Address column
UPDATE [dbo].[Client_Master_MP]
SET [Mail_Address] = um.[New_ID]
FROM [dbo].[Client_Master_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.Mail_Address=um.[Old_ID]
WHERE bc.Mail_Address != -1

--UPDATE Notes column
UPDATE [dbo].[Client_Master_MP]
SET [Client_Notes] = um.[New_ID]
FROM [dbo].[Client_Master_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Client_Notes=um.[Old_ID]
WHERE bc.Client_Notes != -1

--UPDATE PayrollProvider column
UPDATE [dbo].[Client_Master_MP]
SET [PayrollProvider] = um.[New_ID]
FROM [dbo].[Client_Master_MP] bc
JOIN [dbo].[PayrollProvider_ID_Mapping] um ON bc.PayrollProvider=um.[Old_ID]
WHERE bc.PayrollProvider != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Client_Master_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Client_Master_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   SET	@OldID = (SELECT TOP 1 Client_ID FROM [dbo].[Client_Master_MP]  WHERE LoopId = @LoopCounter)

	IF(@OldID != -1)	
	BEGIN
	INSERT INTO [dbo].[Client_Master] OUTPUT Inserted.Client_ID INTO @IdentityValue
		SELECT 	Client_Name,
				Alpha_Sort,
				Main_Address,
				Mail_Address,
				Contact_Method,
				Client_Notes,
				ReferedBy,
				ReferedByOther,
				EIN,
				PrimaryContact,
				Business_Type,
				Tax_YE,
				IncorpDate,
				GroupType,
				TaxedAs,
				PayrollProvider,
				Alias,
				Classification,
				Client_Hold,
				Client_Hold_Date,
				Segmentation,
				NatureOfBusiness,
				EmployeeCount,
				SIC_Code,
				IsActive,
				FilePath,
				AltIDNum1,
				AltIDNum2,
				IsDeadDate,
				IsDead,
				WebPage,
				Client_Link_ID,
				LastTouched,
				ByWho,
				NoPartnershipIncome,
				PreferredInvoiceMethod,
				PayrollFrequency,
				IsInfoGatheringRequired,
				IsSeparateBilling,
				FirstPlanYear,
				LastPlanYear,
				ByWho_Client,
				LastTouched_Client,
				IsTestClient,
				CurrCombinedValue,
				IsLastUpdatedByAdvisor,
				OverAllConfirm,
				UDF1,
				UDF2,
				UDF3,
				UDF4,
				UDF5,
				IsOverried,
				IsNewClientDate,
				NewClientDate,
				IsEngagementLetter,
				EngagementLetter,
				IsCongratulationDone
   		FROM [dbo].[Client_Master_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Client_Master_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Client_Master_MP]  WHERE LoopId > @LoopCounter

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