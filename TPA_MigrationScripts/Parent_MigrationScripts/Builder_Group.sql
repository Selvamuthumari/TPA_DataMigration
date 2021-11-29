/*Migration Script*/
/*Builder_Group*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Builder_Group_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Builder_Group]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [Builder_Group_ID],
			@LibName = [Builder_Group_Text]
   FROM [dbo].[Builder_Group_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[Builder_Group] T 
              WHERE T.Builder_Group_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT Builder_Group_ID FROM [dbo].[Builder_Group] T 
              WHERE T.Builder_Group_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[Builder_Group] OUTPUT Inserted.Builder_Group_ID INTO @IdentityValue
	  SELECT Builder_Group_Text, LastTouched, ByWho
   		FROM [dbo].[Builder_Group_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.Builder_Group_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[Builder_Group_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Builder_Group_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.Builder_Group ON; 
INSERT INTO [dbo].[Builder_Group](Builder_Group_ID, Builder_Group_Text, LastTouched, ByWho)
	SELECT Builder_Group_ID, Builder_Group_Text, LastTouched, ByWho
   	FROM [dbo].[Builder_Group_MP] 
SET IDENTITY_INSERT dbo.Builder_Group OFF;
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