/*Migration Script*/
/*NormRetireDateNear_Type*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[NormRetireDateNear_Type_MP]

IF ((SELECT COUNT(*) FROM [dbo].[NormRetireDateNear_Type]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [NormRetireDateNear_Type_ID],
			@LibName = [NormRetireDateNear_Type_Text]
   FROM [dbo].[NormRetireDateNear_Type_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 


IF EXISTS(SELECT 1 FROM [dbo].[NormRetireDateNear_Type] T 
              WHERE T.NormRetireDateNear_Type_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT NormRetireDateNear_Type_ID FROM [dbo].[NormRetireDateNear_Type] T 
              WHERE T.NormRetireDateNear_Type_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[NormRetireDateNear_Type] OUTPUT Inserted.NormRetireDateNear_Type_ID INTO @IdentityValue
	  SELECT NormRetireDateNear_Type_Text
   		FROM [dbo].[NormRetireDateNear_Type_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.NormRetireDateNear_Type_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[NormRetireDateNear_Type_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[NormRetireDateNear_Type_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.NormRetireDateNear_Type ON; 
INSERT INTO [dbo].[NormRetireDateNear_Type](NormRetireDateNear_Type_ID, NormRetireDateNear_Type_Text)
	SELECT NormRetireDateNear_Type_ID, NormRetireDateNear_Type_Text
   	FROM [dbo].[NormRetireDateNear_Type_MP] 
SET IDENTITY_INSERT dbo.NormRetireDateNear_Type OFF;
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