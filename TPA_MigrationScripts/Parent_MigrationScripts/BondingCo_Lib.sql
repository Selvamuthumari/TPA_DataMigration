
/*BondingCo_Lib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[BondingCo_Lib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[BondingCo_Lib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = BondingCo_ID,
			@LibName = BondingCo_Text
   FROM [dbo].[BondingCo_Lib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[BondingCo_Lib] T 
              WHERE TRIM(T.BondingCo_Text) = TRIM(@LibName)) 
BEGIN
    SET @NewID = (SELECT TOP 1 BondingCo_ID FROM [dbo].[BondingCo_Lib] T 
              WHERE TRIM(T.BondingCo_Text) = TRIM(@LibName))
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.[BondingCo_Lib] ON; 
	INSERT INTO [dbo].[BondingCo_Lib](BondingCo_ID, BondingCo_Text, LastTouched, ByWho) OUTPUT Inserted.BondingCo_ID INTO @IdentityValue
		SELECT BondingCo_ID, BondingCo_Text, LastTouched, ByWho
   		FROM [dbo].[BondingCo_Lib_MP]  WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.[BondingCo_Lib] OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[BondingCo_Lib] OUTPUT Inserted.BondingCo_ID INTO @IdentityValue
	  SELECT BondingCo_Text, LastTouched, ByWho
   		FROM [dbo].[BondingCo_Lib_MP]  WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
END

	IF OBJECT_ID('dbo.BondingCo_Lib_ID_Mapping') IS NOT NULL
	BEGIN
	INSERT INTO [dbo].[BondingCo_Lib_ID_Mapping]
	VALUES(@OldID, @NewID)
	END
 
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[BondingCo_Lib_MP]  WHERE LoopId > @LoopCounter
END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.[BondingCo_Lib] ON; 
INSERT INTO [dbo].[BondingCo_Lib](BondingCo_ID, BondingCo_Text, LastTouched, ByWho)
	SELECT BondingCo_ID, BondingCo_Text, LastTouched, ByWho
   	FROM [dbo].[BondingCo_Lib_MP] 
SET IDENTITY_INSERT dbo.[BondingCo_Lib] OFF;
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