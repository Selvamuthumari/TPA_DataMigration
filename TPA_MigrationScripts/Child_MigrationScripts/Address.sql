
/*Address Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Address_ID) FROM [dbo].[Address]);--16330

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Address_ID_Mapping] ON; 
	INSERT INTO [dbo].[Address_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Address_ID_Mapping] OFF; 

--UPDATE ByWho column
UPDATE [dbo].[Address_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Address_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Address_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Address_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   SET	@OldID = (SELECT TOP 1 Address_ID FROM [dbo].[Address_MP]  WHERE LoopId = @LoopCounter)

	IF(@OldID != -1)	
	BEGIN
	INSERT INTO [dbo].[Address] OUTPUT Inserted.Address_ID INTO @IdentityValue
		SELECT 	Address1,
				Address2,
				City,
				State,
				Zip_Code,
				LastTouched,
				ByWho,
				ByWho_Client,
				LastTouched_Client,
				IsLastUpdatedByAdvisor
   		FROM [dbo].[Address_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Address_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Address_MP]  WHERE LoopId > @LoopCounter

END
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