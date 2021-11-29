/*Migration Script*/
/*PricingScriptRestrictions*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PricingScriptRestrictions_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PricingScriptRestrictions]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [PricingScriptRestrictions_ID],
			@LibName = [PricingScript]
   FROM [dbo].[PricingScriptRestrictions_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[PricingScriptRestrictions] T 
              WHERE T.PricingScript = @LibName) 
BEGIN
    SET @NewID = (SELECT PricingScriptRestrictions_ID FROM [dbo].[PricingScriptRestrictions] T 
              WHERE T.PricingScript = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[PricingScriptRestrictions] OUTPUT Inserted.PricingScriptRestrictions_ID INTO @IdentityValue
	  SELECT PricingScript, ExclusionHash
   		FROM [dbo].[PricingScriptRestrictions_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.PricingScriptRestrictions_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[PricingScriptRestrictions_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PricingScriptRestrictions_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.PricingScriptRestrictions ON; 
INSERT INTO [dbo].[PricingScriptRestrictions](PricingScriptRestrictions_ID, PricingScript, ExclusionHash)
	SELECT PricingScriptRestrictions_ID, PricingScript, ExclusionHash
   	FROM [dbo].[PricingScriptRestrictions_MP] 
SET IDENTITY_INSERT dbo.PricingScriptRestrictions OFF;
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