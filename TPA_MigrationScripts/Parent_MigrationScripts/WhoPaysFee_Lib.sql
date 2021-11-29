/*Migration Script*/
/*WhoPaysFee_Lib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[WhoPaysFee_Lib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[WhoPaysFee_Lib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [WhoPaysFee_Lib_ID],
			@LibName = [WhoPaysFee_Lib_Text]
   FROM [dbo].[WhoPaysFee_Lib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[WhoPaysFee_Lib] T 
              WHERE T.[WhoPaysFee_Lib_Text] = @LibName) 
BEGIN
	PRINT 'Data exists already'
    SET @NewID = (SELECT TOP 1 [WhoPaysFee_Lib_ID] FROM [dbo].[WhoPaysFee_Lib] T 
              WHERE T.[WhoPaysFee_Lib_Text] = @LibName)
	PRINT @NewID
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.WhoPaysFee_Lib ON; 
	INSERT INTO [dbo].[WhoPaysFee_Lib]([WhoPaysFee_Lib_ID], [WhoPaysFee_Lib_Text], [PlanRestriction]) OUTPUT Inserted.[WhoPaysFee_Lib_ID] INTO @IdentityValue
		SELECT [WhoPaysFee_Lib_ID], [WhoPaysFee_Lib_Text], [PlanRestriction]
   		FROM [dbo].[WhoPaysFee_Lib_MP]  WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.WhoPaysFee_Lib OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[WhoPaysFee_Lib] OUTPUT Inserted.[WhoPaysFee_Lib_ID] INTO @IdentityValue
	  SELECT [WhoPaysFee_Lib_Text], [PlanRestriction]
   		FROM [dbo].[WhoPaysFee_Lib_MP]  WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
	
END

 IF OBJECT_ID('dbo.WhoPaysFee_Lib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[WhoPaysFee_Lib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[WhoPaysFee_Lib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.WhoPaysFee_Lib ON; 
INSERT INTO [dbo].[WhoPaysFee_Lib]([WhoPaysFee_Lib_ID], [WhoPaysFee_Lib_Text], [PlanRestriction])
	SELECT [WhoPaysFee_Lib_ID], [WhoPaysFee_Lib_Text], [PlanRestriction]
   	FROM [dbo].[WhoPaysFee_Lib_MP] 
SET IDENTITY_INSERT dbo.WhoPaysFee_Lib OFF;
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
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO  