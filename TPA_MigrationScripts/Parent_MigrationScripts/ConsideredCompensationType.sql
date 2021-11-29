/*Migration Script*/
/*ConsideredCompensationType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ConsideredCompensationType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ConsideredCompensationType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ConsideredCompensationType_ID],
			@LibName = [ConsideredCompensationType_Text]
   FROM [dbo].[ConsideredCompensationType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[ConsideredCompensationType] T 
              WHERE T.ConsideredCompensationType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ConsideredCompensationType_ID FROM [dbo].[ConsideredCompensationType] T 
              WHERE T.ConsideredCompensationType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ConsideredCompensationType] OUTPUT Inserted.ConsideredCompensationType_ID INTO @IdentityValue
	  SELECT ConsideredCompensationType_Text
   		FROM [dbo].[ConsideredCompensationType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ConsideredCompensationType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ConsideredCompensationType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ConsideredCompensationType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.ConsideredCompensationType ON; 
INSERT INTO [dbo].[ConsideredCompensationType](ConsideredCompensationType_ID, ConsideredCompensationType_Text)
	SELECT ConsideredCompensationType_ID, ConsideredCompensationType_Text
   	FROM [dbo].[ConsideredCompensationType_MP] 
SET IDENTITY_INSERT dbo.ConsideredCompensationType OFF;
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