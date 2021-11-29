/*Migration Script*/
/*DeliveryModeLib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[DeliveryModeLib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[DeliveryModeLib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [DeliveryMode_ID],
			@LibName = [DeliveryMode_Text]
   FROM [dbo].[DeliveryModeLib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[DeliveryModeLib] T 
              WHERE T.DeliveryMode_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT DeliveryMode_ID FROM [dbo].[DeliveryModeLib] T 
              WHERE T.DeliveryMode_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[DeliveryModeLib] OUTPUT Inserted.DeliveryMode_ID INTO @IdentityValue
	  SELECT DeliveryMode_Text
   		FROM [dbo].[DeliveryModeLib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.DeliveryMode_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[DeliveryMode_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[DeliveryModeLib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.DeliveryModeLib ON; 
INSERT INTO [dbo].[DeliveryModeLib](DeliveryMode_ID, DeliveryMode_Text)
	SELECT DeliveryMode_ID, DeliveryMode_Text
   	FROM [dbo].[DeliveryModeLib_MP] 
SET IDENTITY_INSERT dbo.DeliveryModeLib OFF;
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