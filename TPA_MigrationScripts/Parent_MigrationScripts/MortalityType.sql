/*Migration Script*/
/*MortalityType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[MortalityType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[MortalityType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [MortalityType_ID],
			@LibName = [MortalityType_Text]
   FROM [dbo].[MortalityType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 


IF EXISTS(SELECT 1 FROM [dbo].[MortalityType] T 
              WHERE T.MortalityType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT MortalityType_ID FROM [dbo].[MortalityType] T 
              WHERE T.MortalityType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[MortalityType] OUTPUT Inserted.MortalityType_ID INTO @IdentityValue
	  SELECT MortalityType_Text
   		FROM [dbo].[MortalityType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.MortalityType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[MortalityType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[MortalityType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.MortalityType ON; 
INSERT INTO [dbo].[MortalityType](MortalityType_ID, MortalityType_Text)
	SELECT MortalityType_ID, MortalityType_Text
   	FROM [dbo].[MortalityType_MP] 
SET IDENTITY_INSERT dbo.MortalityType OFF;
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