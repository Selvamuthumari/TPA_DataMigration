/*Portal_AdvisorNotes Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(NotesId) FROM [dbo].[Portal_AdvisorNotes]);--4

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Portal_AdvisorNotes_ID_Mapping] ON; 
	INSERT INTO [dbo].[Portal_AdvisorNotes_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Portal_AdvisorNotes_ID_Mapping] OFF; 

--UPDATE Client_Id column
UPDATE [dbo].[Portal_AdvisorNotes_MP]
SET [ClientId] = um.New_ID
FROM [dbo].[Portal_AdvisorNotes_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.[ClientId] = um.Old_ID
WHERE bc.[ClientId] != -1

--UPDATE Plan_ID column
UPDATE [dbo].[Portal_AdvisorNotes_MP]
SET PlanID = um.New_ID
FROM [dbo].[Portal_AdvisorNotes_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanID = um.Old_ID
WHERE bc.PlanID != -1

--UPDATE AdvisorID column
UPDATE [dbo].[Portal_AdvisorNotes_MP]
SET AdvisorID = um.New_ID
FROM [dbo].[Portal_AdvisorNotes_MP] bc
JOIN [dbo].[Advisor_ID_Mapping] um ON bc.AdvisorID=um.Old_ID
WHERE bc.AdvisorID != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @OldID INT, @NewID INT, @PlanID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Portal_AdvisorNotes_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Portal_AdvisorNotes_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldId = NotesID, @PlanID = PlanID FROM [dbo].[Portal_AdvisorNotes_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1
	AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @PlanID) > 0)	
	BEGIN
	INSERT INTO [dbo].[Portal_AdvisorNotes] OUTPUT Inserted.NotesID INTO @IdentityValue
		SELECT NotesText,
				LastTouched,
				AdvisorID,
				ClientID,
				PlanID
				FROM Portal_AdvisorNotes_MP  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Portal_AdvisorNotes_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Portal_AdvisorNotes_MP]  WHERE LoopId > @LoopCounter

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