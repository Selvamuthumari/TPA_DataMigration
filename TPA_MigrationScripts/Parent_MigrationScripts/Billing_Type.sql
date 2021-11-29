/*Migration Script*/
/*Billing_Type*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Billing_Type_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Billing_Type]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [Billing_Type_ID],
			@LibName = [Billing_Type_Text]
   FROM [dbo].[Billing_Type_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[Billing_Type] T 
              WHERE T.Billing_Type_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT Billing_Type_ID FROM [dbo].[Billing_Type] T 
              WHERE T.Billing_Type_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[Billing_Type] OUTPUT Inserted.Billing_Type_ID INTO @IdentityValue
	  SELECT Billing_Type_Text
   		FROM [dbo].[Billing_Type_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.Billing_Type_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[Billing_Type_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Billing_Type_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.Billing_Type ON; 
INSERT INTO [dbo].[Billing_Type](Billing_Type_ID, Billing_Type_Text)
	SELECT Billing_Type_ID, Billing_Type_Text
   	FROM [dbo].[Billing_Type_MP] 
SET IDENTITY_INSERT dbo.Billing_Type OFF;
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