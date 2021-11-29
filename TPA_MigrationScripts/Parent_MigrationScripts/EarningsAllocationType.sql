/*Migration Script*/
/*EarningsAllocationType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[EarningsAllocationType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[EarningsAllocationType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [EarningsAllocationType_ID],
			@LibName = [EarningsAllocationType_Text]
   FROM [dbo].[EarningsAllocationType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[EarningsAllocationType] T 
              WHERE T.EarningsAllocationType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT EarningsAllocationType_ID FROM [dbo].[EarningsAllocationType] T 
              WHERE T.EarningsAllocationType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[EarningsAllocationType] OUTPUT Inserted.EarningsAllocationType_ID INTO @IdentityValue
	  SELECT EarningsAllocationType_Text
   		FROM [dbo].[EarningsAllocationType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.EarningsAllocationType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[EarningsAllocationType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[EarningsAllocationType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.EarningsAllocationType ON; 
INSERT INTO [dbo].[EarningsAllocationType](EarningsAllocationType_ID, EarningsAllocationType_Text)
	SELECT EarningsAllocationType_ID, EarningsAllocationType_Text
   	FROM [dbo].[EarningsAllocationType_MP] 
SET IDENTITY_INSERT dbo.EarningsAllocationType OFF;
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