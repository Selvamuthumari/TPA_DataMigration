/*Migration Script*/
/*InServiceNotes_Lib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[InServiceNotes_Lib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[InServiceNotes_Lib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [InServiceNotes_Lib_ID],
			@LibName = [InServiceNotes_Lib_Text]
   FROM [dbo].[InServiceNotes_Lib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[InServiceNotes_Lib] T 
              WHERE T.InServiceNotes_Lib_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT InServiceNotes_Lib_ID FROM [dbo].[InServiceNotes_Lib] T 
              WHERE T.InServiceNotes_Lib_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[InServiceNotes_Lib] OUTPUT Inserted.InServiceNotes_Lib_ID INTO @IdentityValue
	  SELECT InServiceNotes_Lib_Text
   		FROM [dbo].[InServiceNotes_Lib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.InServiceNotes_Lib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[InServiceNotes_Lib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[InServiceNotes_Lib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.InServiceNotes_Lib ON; 
INSERT INTO [dbo].[InServiceNotes_Lib](InServiceNotes_Lib_ID, InServiceNotes_Lib_Text)
	SELECT InServiceNotes_Lib_ID, InServiceNotes_Lib_Text
   	FROM [dbo].[InServiceNotes_Lib_MP] 
SET IDENTITY_INSERT dbo.InServiceNotes_Lib OFF;
END
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