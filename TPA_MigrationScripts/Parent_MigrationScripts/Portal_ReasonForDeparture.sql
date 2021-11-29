
/*Portal_ReasonForDeparture*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Portal_ReasonForDeparture_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Portal_ReasonForDeparture]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
��������AND� @LoopCounter <= @MaxId)
BEGIN
���SELECT	@OldID = [Id],
			@LibName = [ReasonForDepartureText]
���FROM [dbo].[Portal_ReasonForDeparture_MP]� WHERE LoopId = @LoopCounter
���PRINT @LibName�

IF EXISTS(SELECT 1 FROM [dbo].[Portal_ReasonForDeparture] T 
              WHERE TRIM(T.ReasonForDepartureText) = TRIM(@LibName)) 
BEGIN
    SET @NewID = (SELECT TOP 1 Id FROM [dbo].[Portal_ReasonForDeparture] T 
              WHERE TRIM(T.ReasonForDepartureText) = TRIM(@LibName))
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.[Portal_ReasonForDeparture] ON; 
	INSERT INTO [dbo].[Portal_ReasonForDeparture](Id, ReasonForDepartureText) OUTPUT Inserted.Id INTO @IdentityValue
		SELECT Id, ReasonForDepartureText
���		FROM [dbo].[Portal_ReasonForDeparture_MP]� WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.[Portal_ReasonForDeparture] OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[Portal_ReasonForDeparture] OUTPUT Inserted.Id INTO @IdentityValue
	  SELECT [ReasonForDepartureText]
���		FROM [dbo].[Portal_ReasonForDeparture_MP]� WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
END

	IF OBJECT_ID('dbo.Portal_ReasonForDeparture_ID_Mapping') IS NOT NULL
	BEGIN
	INSERT INTO [dbo].[Portal_ReasonForDeparture_ID_Mapping]
	VALUES(@OldID, @NewID)
	END
 
���SELECT @LoopCounter� = MIN(LoopId) 
���FROM [dbo].[Portal_ReasonForDeparture_MP]� WHERE LoopId > @LoopCounter
END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.[Portal_ReasonForDeparture] ON; 
INSERT INTO [dbo].[Portal_ReasonForDeparture](Id, ReasonForDepartureText)
	SELECT Id, ReasonForDepartureText
���	FROM [dbo].[Portal_ReasonForDeparture_MP]�
SET IDENTITY_INSERT dbo.Portal_ReasonForDeparture OFF;
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