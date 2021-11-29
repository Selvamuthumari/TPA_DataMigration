/*Migration Script*/
/*EntryDateNear_Type*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[EntryDateNear_Type_MP]

IF ((SELECT COUNT(*) FROM [dbo].[EntryDateNear_Type]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [EntryDateNear_Type_ID],
			@LibName = [EntryDateNear_Type_Text]
   FROM [dbo].[EntryDateNear_Type_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[EntryDateNear_Type] T 
              WHERE T.EntryDateNear_Type_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT EntryDateNear_Type_ID FROM [dbo].[EntryDateNear_Type] T 
              WHERE T.EntryDateNear_Type_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[EntryDateNear_Type] OUTPUT Inserted.EntryDateNear_Type_ID INTO @IdentityValue
	  SELECT EntryDateNear_Type_Text
   		FROM [dbo].[EntryDateNear_Type_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.EntryDateNear_Type_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[EntryDateNear_Type_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[EntryDateNear_Type_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.EntryDateNear_Type ON; 
INSERT INTO [dbo].[EntryDateNear_Type](EntryDateNear_Type_ID, EntryDateNear_Type_Text)
	SELECT EntryDateNear_Type_ID, EntryDateNear_Type_Text
   	FROM [dbo].[EntryDateNear_Type_MP] 
SET IDENTITY_INSERT dbo.EntryDateNear_Type OFF;
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