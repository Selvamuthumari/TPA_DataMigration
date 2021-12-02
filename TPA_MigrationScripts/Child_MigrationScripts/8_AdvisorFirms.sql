
/*AdvisorFirms Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[AdvisorFirms_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[AdvisorFirms_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE Address column
UPDATE [dbo].[AdvisorFirms_MP]
SET [Address] = um.New_ID
FROM [dbo].[AdvisorFirms_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.Address = um.Old_ID
WHERE bc.Address != -1

--UPDATE MailAddress column
UPDATE [dbo].[AdvisorFirms_MP]
SET [MailAddress] = um.New_ID
FROM [dbo].[AdvisorFirms_MP] bc
JOIN [dbo].[Address_ID_Mapping] um ON bc.MailAddress = um.Old_ID
WHERE bc.MailAddress != -1

--UPDATE Contact_Method column
UPDATE [dbo].[AdvisorFirms_MP]
SET [Contact_Method] = um.New_ID
FROM [dbo].[AdvisorFirms_MP] bc
JOIN [dbo].[Contact_Method_ID_Mapping] um ON bc.Contact_Method = um.Old_ID
WHERE bc.Contact_Method != -1

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Advisor_Firm_ID) FROM [dbo].[AdvisorFirms]);--3000

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[AdvisorFirms_ID_Mapping] ON; 
	INSERT INTO [dbo].[AdvisorFirms_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[AdvisorFirms_ID_Mapping] OFF; 

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[AdvisorFirms_MP]

IF ((SELECT COUNT(*) FROM [dbo].[AdvisorFirms_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   	SELECT @OldId = Advisor_Firm_ID, @LibName = Firm_Name FROM [dbo].[AdvisorFirms_MP]  WHERE LoopId = @LoopCounter

	IF EXISTS(SELECT 1 FROM [dbo].[AdvisorFirms] T 
              WHERE TRIM(T.Firm_Name) = TRIM(@LibName)) 
	BEGIN
    SET @NewID = (SELECT TOP 1 Advisor_Firm_ID FROM [dbo].[AdvisorFirms] T 
              WHERE TRIM(T.Firm_Name) = TRIM(@LibName))
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[AdvisorFirms] OUTPUT Inserted.Advisor_Firm_ID INTO @IdentityValue
	  SELECT Advisor_Firm_Type,
			Firm_Name,
			Attention,
			Address,
			MailAddress,
			Contact_Method,
			IsClient,
			LastTouched,
			ByWho,
			UDF1,
			UDF2,
			UDF3,
			UDF4,
			UDF5,
			IsSameAsAbove
   		FROM [dbo].[AdvisorFirms_MP]  WHERE LoopId = @LoopCounter

	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
	END

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[AdvisorFirms_ID_Mapping]
	VALUES(@OldID, @NewID)
	
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[AdvisorFirms_MP]  WHERE LoopId > @LoopCounter

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