
/*Portal_DocumentDetails Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(DocTrackTicketId) FROM [dbo].[Portal_DocumentDetails]);--780

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Portal_DocumentDetails_ID_Mapping] ON; 
	INSERT INTO [dbo].[Portal_DocumentDetails_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Portal_DocumentDetails_ID_Mapping] OFF; 

--UPDATE Plan_ID column
UPDATE [dbo].[Portal_DocumentDetails_MP]
SET PlansIndexId = um.New_ID
FROM [dbo].[Portal_DocumentDetails_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlansIndexId = um.Old_ID
WHERE bc.PlansIndexId != -1

--UPDATE DocumentWork_ID	
UPDATE [dbo].[Portal_DocumentDetails_MP]
SET DocumentWorkId = um.New_ID
FROM [dbo].[Portal_DocumentDetails_MP] bc
JOIN [dbo].[DocumentWorkLib_ID_Mapping] um ON bc.DocumentWorkId = um.Old_ID
WHERE bc.DocumentWorkId != -1

--UPDATE AmendingWhat column
UPDATE [dbo].[Portal_DocumentDetails_MP]
SET AmendingWhatId = um.New_ID
FROM [dbo].[Portal_DocumentDetails_MP] bc
JOIN [dbo].[AmendingTypeLib_ID_Mapping] um ON bc.AmendingWhatId = um.Old_ID
WHERE bc.AmendingWhatId != -1

--UPDATE Notes column
UPDATE [dbo].[Portal_DocumentDetails_MP]
SET NoteId = um.[New_ID]
FROM [dbo].[Portal_DocumentDetails_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.NoteId=um.[Old_ID]
WHERE bc.NoteId != -1

--UPDATE ByWho column
UPDATE [dbo].[Portal_DocumentDetails_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentDetails_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE RequestCanceledByWho
UPDATE [dbo].[Portal_DocumentDetails_MP]
SET RequestCanceledByWho = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentDetails_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.RequestCanceledByWho=um.[MyPlans_SysUserID]
WHERE bc.RequestCanceledByWho != -1

--UPDATE ManagementApprovalGivenByWho
UPDATE [dbo].[Portal_DocumentDetails_MP]
SET ManagementApprovalGivenByWho = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentDetails_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ManagementApprovalGivenByWho=um.[MyPlans_SysUserID]
WHERE bc.ManagementApprovalGivenByWho != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Portal_DocumentDetails_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Portal_DocumentDetails_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   SET	@OldID = (SELECT TOP 1 DocTrackTicketId FROM [dbo].[Portal_DocumentDetails_MP]  WHERE LoopId = @LoopCounter)

	IF(@OldID != -1)	
	BEGIN
	INSERT INTO [dbo].[Portal_DocumentDetails] OUTPUT Inserted.DocTrackTicketId INTO @IdentityValue
		SELECT 	PlansIndexId,
				DocumentName,
				DocumentPurpose,
				DocumentWorkId,
				RequestDate,
				EffectiveDate,
				Consultant,
				RequestCanceled,
				RequestCanceledDate,
				RequestCanceledByWho,
				AmendingWhatId,
				AmendmentNumber,
				Deadline,
				DateClientNotifiedOfFee,
				DateClientApprovedOfFee,
				FeeEstimateCharges,
				InvoiceCharges,
				InvoiceNumber,
				InvoiceDate,
				ManagementApprovalRequired,
				ManagementApprovalGivenWhen,
				ManagementApprovalGivenByWho,
				NoteId,
				ByWho,
				LastEdited,
				IsPortalDeleted,
				AttachmentId
   		FROM [dbo].[Portal_DocumentDetails_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Portal_DocumentDetails_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Portal_DocumentDetails_MP]  WHERE LoopId > @LoopCounter

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