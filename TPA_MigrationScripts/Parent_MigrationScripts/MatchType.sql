/*Migration Script*/
/*MatchType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[MatchType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[MatchType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [MatchType_ID],
			@LibName = [MatchType_Text]
   FROM [dbo].[MatchType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 


IF EXISTS(SELECT 1 FROM [dbo].[MatchType] T 
              WHERE T.MatchType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT MatchType_ID FROM [dbo].[MatchType] T 
              WHERE T.MatchType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[MatchType] OUTPUT Inserted.MatchType_ID INTO @IdentityValue
	  SELECT MatchType_Text
   		FROM [dbo].[MatchType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.MatchType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[MatchType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[MatchType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.MatchType ON; 
INSERT INTO [dbo].[MatchType](MatchType_ID, MatchType_Text)
	SELECT MatchType_ID, MatchType_Text
   	FROM [dbo].[MatchType_MP] 
SET IDENTITY_INSERT dbo.MatchType OFF;
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