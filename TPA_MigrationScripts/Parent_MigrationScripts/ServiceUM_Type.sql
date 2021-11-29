/*Migration Script*/
/*ServiceUM_Type*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ServiceUM_Type_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ServiceUM_Type]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ServiceUM_Type],
			@LibName = [ServiceUM_Text]
   FROM [dbo].[ServiceUM_Type_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 


IF EXISTS(SELECT 1 FROM [dbo].[ServiceUM_Type] T 
              WHERE T.ServiceUM_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ServiceUM_Type FROM [dbo].[ServiceUM_Type] T 
              WHERE T.ServiceUM_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ServiceUM_Type] OUTPUT Inserted.ServiceUM_Type INTO @IdentityValue
	  SELECT ServiceUM_Text
   		FROM [dbo].[ServiceUM_Type_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ServiceUM_Type_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ServiceUM_Type_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ServiceUM_Type_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.ServiceUM_Type ON; 
INSERT INTO [dbo].[ServiceUM_Type](ServiceUM_Type, ServiceUM_Text)
	SELECT ServiceUM_Type, ServiceUM_Text
   	FROM [dbo].[ServiceUM_Type_MP] 
SET IDENTITY_INSERT dbo.ServiceUM_Type OFF;
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