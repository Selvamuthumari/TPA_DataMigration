/*Migration Script*/
/*DistribServiceOptionsType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[DistribServiceOptionsType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[DistribServiceOptionsType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [DistribServiceOptionsType_ID],
			@LibName = [DistribServiceOptionsType_Text]
   FROM [dbo].[DistribServiceOptionsType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[DistribServiceOptionsType] T 
              WHERE T.DistribServiceOptionsType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT DistribServiceOptionsType_ID FROM [dbo].[DistribServiceOptionsType] T 
              WHERE T.DistribServiceOptionsType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[DistribServiceOptionsType] OUTPUT Inserted.DistribServiceOptionsType_ID INTO @IdentityValue
	  SELECT DistribServiceOptionsType_Text
   		FROM [dbo].[DistribServiceOptionsType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.DistribServiceOptionsType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[DistribServiceOptionsType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[DistribServiceOptionsType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.DistribServiceOptionsType ON; 
INSERT INTO [dbo].[DistribServiceOptionsType](DistribServiceOptionsType_ID, DistribServiceOptionsType_Text)
	SELECT DistribServiceOptionsType_ID, DistribServiceOptionsType_Text
   	FROM [dbo].[DistribServiceOptionsType_MP] 
SET IDENTITY_INSERT dbo.DistribServiceOptionsType OFF;
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