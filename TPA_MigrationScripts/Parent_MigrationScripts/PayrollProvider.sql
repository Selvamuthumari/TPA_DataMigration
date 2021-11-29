/*STEP 3: Migrate MyPlans data to PPC parent tables*/
/*PayrollProvider*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PayrollProvider_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PayrollProvider]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [PayrollProvider_ID],
			@LibName = [PayrollProvider_Text]
   FROM [dbo].[PayrollProvider_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[PayrollProvider] T 
              WHERE TRIM(T.PayrollProvider_Text) = TRIM(@LibName)) 
BEGIN
    SET @NewID = (SELECT TOP 1 PayrollProvider_ID FROM [dbo].[PayrollProvider] T 
              WHERE TRIM(T.PayrollProvider_Text) = TRIM(@LibName))
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.[PayrollProvider] ON; 
	INSERT INTO [dbo].[PayrollProvider](PayrollProvider_ID, PayrollProvider_Text) OUTPUT Inserted.PayrollProvider_ID INTO @IdentityValue
		SELECT PayrollProvider_ID, PayrollProvider_Text
   		FROM [dbo].[PayrollProvider_MP]  WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.[PayrollProvider] OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[PayrollProvider] OUTPUT Inserted.PayrollProvider_ID INTO @IdentityValue
	  SELECT [PayrollProvider_Text]
   		FROM [dbo].[PayrollProvider_MP]  WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
END

	IF OBJECT_ID('dbo.PayrollProvider_ID_Mapping') IS NOT NULL
	BEGIN
	INSERT INTO [dbo].[PayrollProvider_ID_Mapping]
	VALUES(@OldID, @NewID)
	END
 
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PayrollProvider_MP]  WHERE LoopId > @LoopCounter
END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.[PayrollProvider] ON; 
INSERT INTO [dbo].[PayrollProvider](PayrollProvider_ID, PayrollProvider_Text)
	SELECT PayrollProvider_ID, PayrollProvider_Text
   	FROM [dbo].[PayrollProvider_MP] 
SET IDENTITY_INSERT dbo.PayrollProvider OFF;
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
  
GO  