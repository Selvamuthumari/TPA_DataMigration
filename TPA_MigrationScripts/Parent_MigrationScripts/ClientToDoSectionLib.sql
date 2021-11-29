/*Migration Script*/
/*ClientToDoSectionLib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ClientToDoSectionLib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ClientToDoSectionLib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ClientToDoSectionLib_ID],
			@LibName = [ClientToDoSectionLib_Text]
   FROM [dbo].[ClientToDoSectionLib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[ClientToDoSectionLib] T 
              WHERE T.ClientToDoSectionLib_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ClientToDoSectionLib_ID FROM [dbo].[ClientToDoSectionLib] T 
              WHERE T.ClientToDoSectionLib_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ClientToDoSectionLib] OUTPUT Inserted.ClientToDoSectionLib_ID INTO @IdentityValue
	  SELECT ClientToDoSectionLib_Text, ClientToDoSectionLib_TableName
   		FROM [dbo].[ClientToDoSectionLib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ClientToDoSectionLib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ClientToDoSectionLib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ClientToDoSectionLib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.ClientToDoSectionLib ON; 
INSERT INTO [dbo].[ClientToDoSectionLib](ClientToDoSectionLib_ID, ClientToDoSectionLib_Text, ClientToDoSectionLib_TableName)
	SELECT ClientToDoSectionLib_ID, ClientToDoSectionLib_Text, ClientToDoSectionLib_TableName
   	FROM [dbo].[ClientToDoSectionLib_MP] 
SET IDENTITY_INSERT dbo.ClientToDoSectionLib OFF;
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