/*Migration Script*/
/*ManditoryAutoRolloverProvisions_Lib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ManditoryAutoRolloverProvisions_Lib_MP]

WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ManditoryAutoRolloverProvisions_Lib_ID],
			@LibName = [ManditoryAutoRolloverProvisions_Lib_Text]
   FROM [dbo].[ManditoryAutoRolloverProvisions_Lib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[ManditoryAutoRolloverProvisions_Lib] T 
              WHERE T.ManditoryAutoRolloverProvisions_Lib_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ManditoryAutoRolloverProvisions_Lib_ID FROM [dbo].[ManditoryAutoRolloverProvisions_Lib] T 
              WHERE T.ManditoryAutoRolloverProvisions_Lib_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ManditoryAutoRolloverProvisions_Lib] OUTPUT Inserted.ManditoryAutoRolloverProvisions_Lib_ID INTO @IdentityValue
	  SELECT ManditoryAutoRolloverProvisions_Lib_Text
   		FROM [dbo].[ManditoryAutoRolloverProvisions_Lib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ManditoryAutoRolloverProvisions_Lib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ManditoryAutoRolloverProvisions_Lib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ManditoryAutoRolloverProvisions_Lib_MP]  WHERE LoopId > @LoopCounter

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