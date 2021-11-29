/*WhoRemitsWithholding_Lib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[WhoRemitsWithholding_Lib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[WhoRemitsWithholding_Lib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [WhoRemitsWithholding_Lib_ID],
			@LibName = [WhoRemitsWithholding_Lib_Text]
   FROM [dbo].[WhoRemitsWithholding_Lib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[WhoRemitsWithholding_Lib] T 
              WHERE T.[WhoRemitsWithholding_Lib_Text] = @LibName) 
BEGIN
	PRINT 'Data exists already'
    SET @NewID = (SELECT TOP 1 [WhoRemitsWithholding_Lib_ID] FROM [dbo].[WhoRemitsWithholding_Lib] T 
              WHERE T.[WhoRemitsWithholding_Lib_Text] = @LibName)
	PRINT @NewID
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.WhoRemitsWithholding_Lib ON; 
	INSERT INTO [dbo].[WhoRemitsWithholding_Lib]([WhoRemitsWithholding_Lib_ID], [WhoRemitsWithholding_Lib_Text]) OUTPUT Inserted.[WhoRemitsWithholding_Lib_ID] INTO @IdentityValue
		SELECT [WhoRemitsWithholding_Lib_ID], [WhoRemitsWithholding_Lib_Text]
   		FROM [dbo].[WhoRemitsWithholding_Lib_MP]  WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.WhoRemitsWithholding_Lib OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[WhoRemitsWithholding_Lib] OUTPUT Inserted.[WhoRemitsWithholding_Lib_ID] INTO @IdentityValue
	  SELECT [WhoRemitsWithholding_Lib_Text]
   		FROM [dbo].[WhoRemitsWithholding_Lib_MP]  WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
	
END

 IF OBJECT_ID('dbo.WhoRemitsWithholding_Lib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[WhoRemitsWithholding_Lib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[WhoRemitsWithholding_Lib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.WhoRemitsWithholding_Lib ON; 
INSERT INTO [dbo].[WhoRemitsWithholding_Lib]([WhoRemitsWithholding_Lib_ID], [WhoRemitsWithholding_Lib_Text])
	SELECT [WhoRemitsWithholding_Lib_ID], [WhoRemitsWithholding_Lib_Text]
   	FROM [dbo].[WhoRemitsWithholding_Lib_MP] 
SET IDENTITY_INSERT dbo.WhoRemitsWithholding_Lib OFF;
END  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;   
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