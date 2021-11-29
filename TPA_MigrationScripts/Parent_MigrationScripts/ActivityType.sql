/*Migration Script*/
/*ActivityType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ActivityType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ActivityType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
��������AND� @LoopCounter <= @MaxId)
BEGIN
���SELECT	@OldID = [ActivityType_ID],
			@LibName = [ActivityType_Text]
���FROM [dbo].[ActivityType_MP]� WHERE LoopId = @LoopCounter
���PRINT @LibName�

IF EXISTS(SELECT 1 FROM [dbo].[ActivityType] T 
              WHERE T.ActivityType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ActivityType_ID FROM [dbo].[ActivityType] T 
              WHERE T.ActivityType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ActivityType] OUTPUT Inserted.ActivityType_ID INTO @IdentityValue
	  SELECT ActivityType_Text
���		FROM [dbo].[ActivityType_MP]� WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ActivityType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ActivityType_ID_Mapping]
	VALUES(@OldID, @NewID)���
END

SELECT @LoopCounter� = MIN(LoopId) 
���FROM [dbo].[ActivityType_MP]� WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.ActivityType ON; 
INSERT INTO [dbo].[ActivityType](ActivityType_ID, ActivityType_Text)
	SELECT ActivityType_ID, ActivityType_Text
���	FROM [dbo].[ActivityType_MP]�
SET IDENTITY_INSERT dbo.ActivityType OFF;
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