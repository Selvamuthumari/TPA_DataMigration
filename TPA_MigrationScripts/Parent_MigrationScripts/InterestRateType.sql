/*Migration Script*/
/*InterestRateType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[InterestRateType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[InterestRateType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [InterestRateType_ID],
			@LibName = [InterestRateType_Text]
   FROM [dbo].[InterestRateType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[InterestRateType] T 
              WHERE T.InterestRateType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT InterestRateType_ID FROM [dbo].[InterestRateType] T 
              WHERE T.InterestRateType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[InterestRateType] OUTPUT Inserted.InterestRateType_ID INTO @IdentityValue
	  SELECT InterestRateType_Text
   		FROM [dbo].[InterestRateType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.InterestRateType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[InterestRateType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[InterestRateType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.InterestRateType ON; 
INSERT INTO [dbo].[InterestRateType](InterestRateType_ID, InterestRateType_Text)
	SELECT InterestRateType_ID, InterestRateType_Text
   	FROM [dbo].[InterestRateType_MP] 
SET IDENTITY_INSERT dbo.InterestRateType OFF;
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