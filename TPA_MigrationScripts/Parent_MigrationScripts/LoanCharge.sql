/*LoanCharge*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[LoanCharge_MP]

IF ((SELECT COUNT(*) FROM [dbo].[LoanCharge]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [ID],
			@LibName = [LoanChargeAmount]
   FROM [dbo].[LoanCharge_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[LoanCharge] T 
              WHERE T.[LoanChargeAmount] = @LibName) 
BEGIN
    SET @NewID = (SELECT TOP 1 [ID] FROM [dbo].[LoanCharge] T 
              WHERE T.[LoanChargeAmount] = @LibName)
	PRINT @NewID
END
ELSE
BEGIN
	IF(@OldID = -1)
	BEGIN
	SET IDENTITY_INSERT dbo.LoanCharge ON; 
	INSERT INTO [dbo].[LoanCharge]([ID], [LoanChargeAmount]) OUTPUT Inserted.[ID] INTO @IdentityValue
		SELECT [ID], [LoanChargeAmount]
   		FROM [dbo].[LoanCharge_MP]  WHERE LoopId = @LoopCounter
	SET IDENTITY_INSERT dbo.LoanCharge OFF;
	END
	ELSE
	BEGIN
	INSERT INTO [dbo].[LoanCharge] OUTPUT Inserted.[ID] INTO @IdentityValue
	  SELECT [LoanChargeAmount]
   		FROM [dbo].[LoanCharge_MP]  WHERE LoopId = @LoopCounter
	END
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;
	
END

 IF OBJECT_ID('dbo.LoanCharge_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[LoanCharge_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[LoanCharge_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.LoanCharge ON; 
INSERT INTO [dbo].[LoanCharge]([ID], [LoanChargeAmount])
	SELECT [ID], [LoanChargeAmount]
   	FROM [dbo].[LoanCharge_MP] 
SET IDENTITY_INSERT dbo.LoanCharge OFF;
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