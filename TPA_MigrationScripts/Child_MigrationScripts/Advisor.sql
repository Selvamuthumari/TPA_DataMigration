
/*Advisor Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[Advisor_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Advisor_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE Address column
UPDATE [dbo].[Advisor_MP]
SET [Address] = um.New_ID
FROM [dbo].[Advisor_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.Address = um.Old_ID
WHERE bc.Address != -1

--UPDATE MailAddress column
UPDATE [dbo].[Advisor_MP]
SET [MailAddress] = um.New_ID
FROM [dbo].[Advisor_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.MailAddress = um.Old_ID
WHERE bc.MailAddress != -1

--UPDATE Contact_Method column
UPDATE [dbo].[Advisor_MP]
SET [Contact_Method] = um.New_ID
FROM [dbo].[Advisor_MP] bc
JOIN [dbo].[Contact_Method_ID_Mapping] um ON bc.Contact_Method = um.Old_ID
WHERE bc.Contact_Method != -1

--UPDATE Advisor_Firm_ID column
UPDATE [dbo].[Advisor_MP]
SET [Advisor_Firm_ID] = um.New_ID
FROM [dbo].[Advisor_MP] bc
JOIN [dbo].[AdvisorFirms_ID_Mapping] um ON bc.Advisor_Firm_ID = um.Old_ID
WHERE bc.Advisor_Firm_ID != -1

--UPDATE Advisor_Notes column
UPDATE [dbo].[Advisor_MP]
SET Advisor_Notes = um.[New_ID]
FROM [dbo].[Advisor_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Advisor_Notes=um.[Old_ID]
WHERE bc.Advisor_Notes != -1

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Advisor_ID) FROM [dbo].[Advisor]);--315268

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Advisor_ID_Mapping] ON; 
	INSERT INTO [dbo].[Advisor_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Advisor_ID_Mapping] OFF; 

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Advisor_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Advisor_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	 SET	@OldID = (SELECT TOP 1 Advisor_ID FROM [dbo].[Advisor_MP]  WHERE LoopId = @LoopCounter)

	IF(@OldID != -1)	
	BEGIN
	INSERT INTO [dbo].[Advisor] OUTPUT Inserted.Advisor_ID INTO @IdentityValue
		SELECT 	Advisor_Firm_ID,
				Last_Name,
				MI,
				First_Name,
				Credentials,
				Contact_Method,
				Address,
				MailAddress,
				Advisor_Notes,
				CC,
				CommunicationPreference,
				LastTouched,
				ByWho,
				IsComplete,
				IsDeletedFromOutlook,
				ByWho_Client,
				LastTouched_Client,
				prefix,
				suffix,
				IsEnableByBoyce,
				IsSameFirmMainAddress,
				IsSameFirmMailAddress,
				IsSameAsAboveAddress,
				orignal_ID,
				UDF1,
				UDF2,
				UDF3,
				UDF4,
				UDF5
   		FROM [dbo].[Advisor_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Advisor_ID_Mapping]
	VALUES(@OldID, @NewID)   	

END
	
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Advisor_MP]  WHERE LoopId > @LoopCounter

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