/*Migration Script*/
/*ProfitSharingAllocationType*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ProfitSharingAllocationType_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ProfitSharingAllocationType]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ProfitSharingAllocationType_ID],
			@LibName = [ProfitSharingAllocationType_Text]
   FROM [dbo].[ProfitSharingAllocationType_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[ProfitSharingAllocationType] T 
              WHERE T.ProfitSharingAllocationType_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ProfitSharingAllocationType_ID FROM [dbo].[ProfitSharingAllocationType] T 
              WHERE T.ProfitSharingAllocationType_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ProfitSharingAllocationType] OUTPUT Inserted.ProfitSharingAllocationType_ID INTO @IdentityValue
	  SELECT ProfitSharingAllocationType_Text
   		FROM [dbo].[ProfitSharingAllocationType_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ProfitSharingAllocationType_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ProfitSharingAllocationType_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ProfitSharingAllocationType_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.ProfitSharingAllocationType ON; 
INSERT INTO [dbo].[ProfitSharingAllocationType](ProfitSharingAllocationType_ID, ProfitSharingAllocationType_Text)
	SELECT ProfitSharingAllocationType_ID, ProfitSharingAllocationType_Text
   	FROM [dbo].[ProfitSharingAllocationType_MP] 
SET IDENTITY_INSERT dbo.ProfitSharingAllocationType OFF;
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