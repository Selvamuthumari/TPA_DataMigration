/*Migration Script*/
/*PricingGroupsLib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PricingGroupsLib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PricingGroupsLib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [PricingGroupsLib_ID],
			@LibName = [PricingGroupsLib_Text]
   FROM [dbo].[PricingGroupsLib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[PricingGroupsLib] T 
              WHERE T.PricingGroupsLib_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT PricingGroupsLib_ID FROM [dbo].[PricingGroupsLib] T 
              WHERE T.PricingGroupsLib_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[PricingGroupsLib] OUTPUT Inserted.PricingGroupsLib_ID INTO @IdentityValue
	  SELECT PricingGroupsLib_Text, EffectiveYear
   		FROM [dbo].[PricingGroupsLib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.PricingGroupsLib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[PricingGroupsLib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PricingGroupsLib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.PricingGroupsLib ON; 
INSERT INTO [dbo].[PricingGroupsLib](PricingGroupsLib_ID, PricingGroupsLib_Text, EffectiveYear)
	SELECT PricingGroupsLib_ID, PricingGroupsLib_Text, EffectiveYear
   	FROM [dbo].[PricingGroupsLib_MP] 
SET IDENTITY_INSERT dbo.PricingGroupsLib OFF;
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