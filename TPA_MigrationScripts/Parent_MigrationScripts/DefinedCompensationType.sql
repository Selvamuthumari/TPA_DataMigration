/*Migration Script*/
/*DefinedCompensationType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[DefinedCompensationType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[DefinedCompensationType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [DefinedCompensationType_ID],
			@LibName = [DefinedCompensationType_Text]
   FROM [dbo].[DefinedCompensationType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[DefinedCompensationType] T 
              WHERE T.DefinedCompensationType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT DefinedCompensationType_ID FROM [dbo].[DefinedCompensationType] T 
              WHERE T.DefinedCompensationType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[DefinedCompensationType] OUTPUT Inserted.DefinedCompensationType_ID INTO @IdentityValue
	  SELECT DefinedCompensationType_Text
   		FROM [dbo].[DefinedCompensationType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.DefinedCompensationType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[DefinedCompensationType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[DefinedCompensationType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.DefinedCompensationType ON; 
INSERT INTO [dbo].[DefinedCompensationType](DefinedCompensationType_ID, DefinedCompensationType_Text)
	SELECT DefinedCompensationType_ID, DefinedCompensationType_Text
   	FROM [dbo].[DefinedCompensationType_MP] 
SET IDENTITY_INSERT dbo.DefinedCompensationType OFF;
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