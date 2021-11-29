/*Migration Script*/
/*NormRetireDateUM_Type*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[NormRetireDateUM_Type_MP]

IF ((SELECT COUNT(*) FROM [dbo].[NormRetireDateUM_Type]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [NormRetireDateUM_Type_ID],
			@LibName = [NormRetireDateUM_Type_Text]
   FROM [dbo].[NormRetireDateUM_Type_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 


IF EXISTS(SELECT 1 FROM [dbo].[NormRetireDateUM_Type] T 
              WHERE T.NormRetireDateUM_Type_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT NormRetireDateUM_Type_ID FROM [dbo].[NormRetireDateUM_Type] T 
              WHERE T.NormRetireDateUM_Type_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[NormRetireDateUM_Type] OUTPUT Inserted.NormRetireDateUM_Type_ID INTO @IdentityValue
	  SELECT NormRetireDateUM_Type_Text
   		FROM [dbo].[NormRetireDateUM_Type_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.NormRetireDateUM_Type_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[NormRetireDateUM_Type_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[NormRetireDateUM_Type_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.NormRetireDateUM_Type ON; 
INSERT INTO [dbo].[NormRetireDateUM_Type](NormRetireDateUM_Type_ID, NormRetireDateUM_Type_Text)
	SELECT NormRetireDateUM_Type_ID, NormRetireDateUM_Type_Text
   	FROM [dbo].[NormRetireDateUM_Type_MP] 
SET IDENTITY_INSERT dbo.NormRetireDateUM_Type OFF;
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