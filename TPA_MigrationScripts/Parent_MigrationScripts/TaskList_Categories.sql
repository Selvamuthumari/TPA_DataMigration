/*Migration Script*/
/*TaskList_Categories*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[TaskList_Categories_MP]

IF ((SELECT COUNT(*) FROM [dbo].[TaskList_Categories]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [TaskCategory_ID],
			@LibName = [TaskCategory_Text]
   FROM [dbo].[TaskList_Categories_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 


IF EXISTS(SELECT 1 FROM [dbo].[TaskList_Categories] T 
              WHERE T.TaskCategory_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT TaskCategory_ID FROM [dbo].[TaskList_Categories] T 
              WHERE T.TaskCategory_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[TaskList_Categories] OUTPUT Inserted.TaskCategory_ID INTO @IdentityValue
	  SELECT TaskCategory_Text
   		FROM [dbo].[TaskList_Categories_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.TaskCategory_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[TaskCategory_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[TaskList_Categories_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.TaskList_Categories ON; 
INSERT INTO [dbo].[TaskList_Categories](TaskCategory_ID, TaskCategory_Text)
	SELECT TaskCategory_ID, TaskCategory_Text
   	FROM [dbo].[TaskList_Categories_MP] 
SET IDENTITY_INSERT dbo.TaskList_Categories OFF;
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