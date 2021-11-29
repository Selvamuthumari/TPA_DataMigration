/*Migration Script*/
/*DistFeeAmounts_Lib*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[DistFeeAmounts_Lib_MP]

IF ((SELECT COUNT(*) FROM [dbo].[DistFeeAmounts_Lib]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [DistFeeAmounts_Lib_ID],
			@LibName = [DistFeeAmounts_Lib_Text]
   FROM [dbo].[DistFeeAmounts_Lib_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[DistFeeAmounts_Lib] T 
              WHERE T.DistFeeAmounts_Lib_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT DistFeeAmounts_Lib_ID FROM [dbo].[DistFeeAmounts_Lib] T 
              WHERE T.DistFeeAmounts_Lib_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[DistFeeAmounts_Lib] OUTPUT Inserted.DistFeeAmounts_Lib_ID INTO @IdentityValue
	  SELECT DistFeeAmounts_Lib_Text
   		FROM [dbo].[DistFeeAmounts_Lib_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.DistFeeAmounts_Lib_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[DistFeeAmounts_Lib_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[DistFeeAmounts_Lib_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.DistFeeAmounts_Lib ON; 
INSERT INTO [dbo].[DistFeeAmounts_Lib](DistFeeAmounts_Lib_ID, DistFeeAmounts_Lib_Text)
	SELECT DistFeeAmounts_Lib_ID, DistFeeAmounts_Lib_Text
   	FROM [dbo].[DistFeeAmounts_Lib_MP] 
SET IDENTITY_INSERT dbo.DistFeeAmounts_Lib OFF;
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