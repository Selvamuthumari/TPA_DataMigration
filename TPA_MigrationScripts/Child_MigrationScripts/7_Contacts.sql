
/*Contacts Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[Contacts_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Contacts_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE Address column
UPDATE [dbo].[Contacts_MP]
SET [Address] = um.New_ID
FROM [dbo].[Contacts_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.Address = um.Old_ID
WHERE bc.Address != -1

--UPDATE MailAddress column
UPDATE [dbo].[Contacts_MP]
SET [MailAddress] = um.New_ID
FROM [dbo].[Contacts_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.MailAddress = um.Old_ID
WHERE bc.MailAddress != -1

--UPDATE Client_Id column
UPDATE [dbo].[Contacts_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[Contacts_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Contact_Method column
UPDATE [dbo].[Contacts_MP]
SET [Contact_Method] = um.New_ID
FROM [dbo].[Contacts_MP] bc
JOIN [dbo].[Contact_Method_ID_Mapping] um ON bc.Contact_Method = um.Old_ID
WHERE bc.Contact_Method != -1

--UPDATE Advisor_Notes column
UPDATE [dbo].[Contacts_MP]
SET Advisor_Notes = um.New_ID
FROM [dbo].[Contacts_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Advisor_Notes = um.Old_ID
WHERE bc.Advisor_Notes != -1

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Contact_ID) FROM [dbo].[Contacts]);--7998

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Contacts_ID_Mapping] ON; 
	INSERT INTO [dbo].[Contacts_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Contacts_ID_Mapping] OFF; 

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @ClientID NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Contacts_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Contacts_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   	SELECT @OldId = Contact_ID, @ClientID = Client_ID FROM [dbo].[Contacts_MP]  WHERE LoopId = @LoopCounter

	IF(@OldID != -1 AND (SELECT COUNT(*) FROM Client_Master WHERE Client_ID = @ClientID) > 0)	
	BEGIN
	INSERT INTO [dbo].[Contacts] OUTPUT Inserted.Contact_ID INTO @IdentityValue
		SELECT 	Client_ID,
				Contact_No,
				Contact_Type,
				Last_Name,
				MI,
				First_Name,
				Greeting,
				Credentials,
				Contact_Method,
				CommunicationPreference,
				Address,
				MailAddress,
				Advisor_Notes,
				CC,
				BoardMember,
				Trustee,
				StockHolder,
				StockPercent,
				PrimaryContact,
				CorporateOfficer,
				LastTouched,
				ByWho,
				Title,
				InvoiceContact,
				Sinor,
				PINConfirmed,
				RegistrationEmail,
				Date5500Signer,
				ASCSignerUpdated,
				DateASCSignerUpdate,
				BoardMemberSinceWhen,
				IsComplete,
				IsDeletedFromOutlook,
				AdministrativeContact,
				ByWho_Client,
				LastTouched_Client,
				prefix,
				suffix,
				EffectiveDate,
				IsPortalDeleted,
				PriorOwnerPercent,
				PriorOwnerYear,
				IsSameClientMainAddress,
				IsSameClientMailAddress,
				IsSameAsAboveAddress,
				IsLastUpdatedByAdvisor,
				OrignalPpcClientId,
				EffectiveDtCO,
				EffectiveDtBM,
				EffectiveDtTrustee,
				EffectiveDtSH,
				UDF1,
				UDF2,
				UDF3,
				UDF4,
				UDF5
   		FROM [dbo].[Contacts_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Contacts_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Contacts_MP]  WHERE LoopId > @LoopCounter

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