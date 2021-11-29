/*Migration Script*/
/*AmendingTypeLib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[AmendingTypeLib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[AmendingTypeLib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [AmendingType_ID],
			@LibName = [AmendingType_Text]
   FROM [dbo].[AmendingTypeLib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[AmendingTypeLib] T 
              WHERE T.AmendingType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT AmendingType_ID FROM [dbo].[AmendingTypeLib] T 
              WHERE T.AmendingType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[AmendingTypeLib] OUTPUT Inserted.AmendingType_ID INTO @IdentityValue
	  SELECT AmendingType_Text, IsPortalDeleted
   		FROM [dbo].[AmendingTypeLib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.AmendingTypeLib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[AmendingTypeLib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[AmendingTypeLib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.AmendingTypeLib ON; 
INSERT INTO [dbo].[AmendingTypeLib](AmendingType_ID, AmendingType_Text, IsPortalDeleted)
	SELECT AmendingType_ID, AmendingType_Text, IsPortalDeleted
   	FROM [dbo].[AmendingTypeLib_MP] 
SET IDENTITY_INSERT dbo.AmendingTypeLib OFF;
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