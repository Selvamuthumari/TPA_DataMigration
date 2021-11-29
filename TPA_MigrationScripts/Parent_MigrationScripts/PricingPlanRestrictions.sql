/*Migration Script*/
/*PricingPlanRestrictions*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PricingPlanRestrictions_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PricingPlanRestrictions]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [PricingPlanRestrictions_ID],
			@LibName = [PricingPlanName]
   FROM [dbo].[PricingPlanRestrictions_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[PricingPlanRestrictions] T 
              WHERE T.[PricingPlanName] = @LibName) 
BEGIN
    SET @NewID = (SELECT PricingPlanRestrictions_ID FROM [dbo].[PricingPlanRestrictions] T 
              WHERE T.[PricingPlanName] = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[PricingPlanRestrictions] OUTPUT Inserted.PricingPlanRestrictions_ID INTO @IdentityValue
	  SELECT [PricingPlanName]
   		FROM [dbo].[PricingPlanRestrictions_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.PricingPlanRestrictions_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[PricingPlanRestrictions_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PricingPlanRestrictions_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.PricingPlanRestrictions ON; 
INSERT INTO [dbo].[PricingPlanRestrictions](PricingPlanRestrictions_ID, [PricingPlanName])
	SELECT PricingPlanRestrictions_ID, [PricingPlanName]
   	FROM [dbo].[PricingPlanRestrictions_MP] 
SET IDENTITY_INSERT dbo.PricingPlanRestrictions OFF;
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