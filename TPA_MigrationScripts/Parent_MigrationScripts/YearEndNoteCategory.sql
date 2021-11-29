/*YearEndNoteCategory*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[YearEndNoteCategory_MP]

IF ((SELECT COUNT(*) FROM [dbo].[YearEndNoteCategory]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [YearEndNoteCategory_ID],
			@LibName = [YearEndNoteCategory_Text]
   FROM [dbo].[YearEndNoteCategory_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[YearEndNoteCategory] T 
              WHERE T.[YearEndNoteCategory_Text] = @LibName) 
BEGIN
    SET @NewID = (SELECT TOP 1 [YearEndNoteCategory_ID] FROM [dbo].[YearEndNoteCategory] T 
              WHERE T.[YearEndNoteCategory_Text] = @LibName)
	PRINT @NewID
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.YearEndNoteCategory ON; 
	INSERT INTO [dbo].[YearEndNoteCategory]([YearEndNoteCategory_ID], [YearEndNoteCategory_Text]) OUTPUT Inserted.[YearEndNoteCategory_ID] INTO @IdentityValue
		SELECT [YearEndNoteCategory_ID], [YearEndNoteCategory_Text]
   		FROM [dbo].[YearEndNoteCategory_MP]  WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.YearEndNoteCategory OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[YearEndNoteCategory] OUTPUT Inserted.[YearEndNoteCategory_ID] INTO @IdentityValue
	  SELECT [YearEndNoteCategory_Text]
   		FROM [dbo].[YearEndNoteCategory_MP]  WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
	
END

 IF OBJECT_ID('dbo.YearEndNoteCategory_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[YearEndNoteCategory_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[YearEndNoteCategory_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.YearEndNoteCategory ON; 
INSERT INTO [dbo].[YearEndNoteCategory]([YearEndNoteCategory_ID], [YearEndNoteCategory_Text])
	SELECT [YearEndNoteCategory_ID], [YearEndNoteCategory_Text]
   	FROM [dbo].[YearEndNoteCategory_MP] 
SET IDENTITY_INSERT dbo.YearEndNoteCategory OFF;
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
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO  