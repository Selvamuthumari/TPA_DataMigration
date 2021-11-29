/*Migration Script*/
/*ProfitSharingClasses*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[ProfitSharingClasses_MP]

IF ((SELECT COUNT(*) FROM [dbo].[ProfitSharingClasses]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ProfitSharingClasses_ID],
			@LibName = [ProfitSharingClasses_Text]
   FROM [dbo].[ProfitSharingClasses_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[ProfitSharingClasses] T 
              WHERE T.ProfitSharingClasses_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT ProfitSharingClasses_ID FROM [dbo].[ProfitSharingClasses] T 
              WHERE T.ProfitSharingClasses_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[ProfitSharingClasses] OUTPUT Inserted.ProfitSharingClasses_ID INTO @IdentityValue
	  SELECT ProfitSharingClasses_Text
   		FROM [dbo].[ProfitSharingClasses_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.ProfitSharingClasses_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[ProfitSharingClasses_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[ProfitSharingClasses_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.ProfitSharingClasses ON; 
INSERT INTO [dbo].[ProfitSharingClasses](ProfitSharingClasses_ID, ProfitSharingClasses_Text)
	SELECT ProfitSharingClasses_ID, ProfitSharingClasses_Text
   	FROM [dbo].[ProfitSharingClasses_MP] 
SET IDENTITY_INSERT dbo.ProfitSharingClasses OFF;
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