/*Migration Script*/
/*PricingUnitOfMeasure*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PricingUnitOfMeasure_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PricingUnitOfMeasure]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [PricingUnitOfMeasure_ID],
			@LibName = [PricingUnitOfMeasure_Text]
   FROM [dbo].[PricingUnitOfMeasure_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[PricingUnitOfMeasure] T 
              WHERE T.PricingUnitOfMeasure_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT PricingUnitOfMeasure_ID FROM [dbo].[PricingUnitOfMeasure] T 
              WHERE T.PricingUnitOfMeasure_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[PricingUnitOfMeasure] OUTPUT Inserted.PricingUnitOfMeasure_ID INTO @IdentityValue
	  SELECT PricingUnitOfMeasure_Text
   		FROM [dbo].[PricingUnitOfMeasure_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.PricingUnitOfMeasure_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[PricingUnitOfMeasure_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PricingUnitOfMeasure_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.PricingUnitOfMeasure ON; 
INSERT INTO [dbo].[PricingUnitOfMeasure](PricingUnitOfMeasure_ID, PricingUnitOfMeasure_Text)
	SELECT PricingUnitOfMeasure_ID, PricingUnitOfMeasure_Text
   	FROM [dbo].[PricingUnitOfMeasure_MP] 
SET IDENTITY_INSERT dbo.PricingUnitOfMeasure OFF;
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