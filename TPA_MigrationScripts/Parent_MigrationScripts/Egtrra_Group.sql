/*Migration Script*/
/*Egtrra_Group*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Egtrra_Group_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Egtrra_Group]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [Egtrra_Group_ID],
			@LibName = [Egtrra_Text]
   FROM [dbo].[Egtrra_Group_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[Egtrra_Group] T 
              WHERE T.Egtrra_Text = @LibName) 
BEGIN
    SET @NewID = (SELECT Egtrra_Group_ID FROM [dbo].[Egtrra_Group] T 
              WHERE T.Egtrra_Text = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[Egtrra_Group] OUTPUT Inserted.Egtrra_Group_ID INTO @IdentityValue
	  SELECT Egtrra_Text, FlagRequired, LastEdited, ByWho
   		FROM [dbo].[Egtrra_Group_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.Egtrra_Group_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[Egtrra_Group_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Egtrra_Group_MP]  WHERE LoopId > @LoopCounter

END
END
ELSE
BEGIN
SET IDENTITY_INSERT dbo.Egtrra_Group ON; 
INSERT INTO [dbo].[Egtrra_Group](Egtrra_Group_ID, Egtrra_Text, FlagRequired, LastEdited, ByWho)
	SELECT Egtrra_Group_ID, Egtrra_Text, FlagRequired, LastEdited, ByWho
   	FROM [dbo].[Egtrra_Group_MP] 
SET IDENTITY_INSERT dbo.Egtrra_Group OFF;
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