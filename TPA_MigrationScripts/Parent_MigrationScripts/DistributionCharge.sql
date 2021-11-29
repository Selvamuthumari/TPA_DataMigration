/*Migration Script*/
/*DistributionCharge*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName MONEY, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[DistributionCharge_MP]

IF ((SELECT COUNT(*) FROM [dbo].[DistributionCharge]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ID],
			@LibName = [DistributionChargeAmount]
   FROM [dbo].[DistributionCharge_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[DistributionCharge] T 
              WHERE T.[DistributionChargeAmount] = @LibName) 
BEGIN
	PRINT 'Data exists already'
    SET @NewID = (SELECT TOP 1 ID FROM [dbo].[DistributionCharge] T 
              WHERE T.[DistributionChargeAmount] = @LibName)
	PRINT @NewID
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.DistributionCharge ON; 
	INSERT INTO [dbo].[DistributionCharge](ID, [DistributionChargeAmount]) OUTPUT Inserted.ID INTO @IdentityValue
		SELECT ID, [DistributionChargeAmount]
   		FROM [dbo].[DistributionCharge_MP]  WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.DistributionCharge OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[DistributionCharge] OUTPUT Inserted.ID INTO @IdentityValue
	  SELECT [DistributionChargeAmount]
   		FROM [dbo].[DistributionCharge_MP]  WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
	
END

 IF OBJECT_ID('dbo.DistributionCharge_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[DistributionCharge_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[DistributionCharge_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.DistributionCharge ON; 
INSERT INTO [dbo].[DistributionCharge](ID, [DistributionChargeAmount])
	SELECT ID, [DistributionChargeAmount]
   	FROM [dbo].[DistributionCharge_MP] 
SET IDENTITY_INSERT dbo.DistributionCharge OFF;
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