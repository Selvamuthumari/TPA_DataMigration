/*Migration Script*/
/*Doc_Types*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Doc_Types_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Doc_Types]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [DocType_ID],
			@LibName = [DocType_Text]
   FROM [dbo].[Doc_Types_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[Doc_Types] T 
              WHERE T.DocType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT DocType_ID FROM [dbo].[Doc_Types] T 
              WHERE T.DocType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[Doc_Types] OUTPUT Inserted.DocType_ID INTO @IdentityValue
	  SELECT DocType_Text
   		FROM [dbo].[Doc_Types_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.Doc_Types_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[Doc_Types_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Doc_Types_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.Doc_Types ON; 
INSERT INTO [dbo].[Doc_Types](DocType_ID, DocType_Text)
	SELECT DocType_ID, DocType_Text
   	FROM [dbo].[Doc_Types_MP] 
SET IDENTITY_INSERT dbo.Doc_Types OFF;
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