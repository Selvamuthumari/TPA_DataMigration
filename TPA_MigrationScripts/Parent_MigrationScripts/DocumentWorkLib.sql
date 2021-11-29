/*Migration Script*/
/*DocumentWorkLib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[DocumentWorkLib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[DocumentWorkLib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [DocumentWork_ID],
			@LibName = [DocumentWork_Text]
   FROM [dbo].[DocumentWorkLib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[DocumentWorkLib] T 
              WHERE T.DocumentWork_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT DocumentWork_ID FROM [dbo].[DocumentWorkLib] T 
              WHERE T.DocumentWork_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[DocumentWorkLib] OUTPUT Inserted.DocumentWork_ID INTO @IdentityValue
	  SELECT DocumentWork_Text, IsPortalDeleted
   		FROM [dbo].[DocumentWorkLib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.DocumentWorkLib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[DocumentWorkLib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[DocumentWorkLib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.DocumentWorkLib ON; 
INSERT INTO [dbo].[DocumentWorkLib](DocumentWork_ID, DocumentWork_Text, IsPortalDeleted)
	SELECT DocumentWork_ID, DocumentWork_Text, IsPortalDeleted
   	FROM [dbo].[DocumentWorkLib_MP] 
SET IDENTITY_INSERT dbo.DocumentWorkLib OFF;
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