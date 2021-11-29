/*Migration Script*/
/*ElementDataTypes*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ElementDataTypes_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ElementDataTypes]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ElementDataTypes_ID],
			@LibName = [ElementDataTypes_Text]
   FROM [dbo].[ElementDataTypes_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[ElementDataTypes] T 
              WHERE T.ElementDataTypes_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ElementDataTypes_ID FROM [dbo].[ElementDataTypes] T 
              WHERE T.ElementDataTypes_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ElementDataTypes] OUTPUT Inserted.ElementDataTypes_ID INTO @IdentityValue
	  SELECT ElementDataTypes_Text
   		FROM [dbo].[ElementDataTypes_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ElementDataTypes_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ElementDataTypes_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ElementDataTypes_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.ElementDataTypes ON; 
INSERT INTO [dbo].[ElementDataTypes](ElementDataTypes_ID, ElementDataTypes_Text)
	SELECT ElementDataTypes_ID, ElementDataTypes_Text
   	FROM [dbo].[ElementDataTypes_MP] 
SET IDENTITY_INSERT dbo.ElementDataTypes OFF;
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