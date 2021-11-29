
/*Documents Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Document_ID) FROM [dbo].[Documents]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Documents_ID_Mapping] ON; 
	INSERT INTO [dbo].[Documents_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Documents_ID_Mapping] OFF; 

--UPDATE Client_Id column
UPDATE [dbo].[Documents_MP]
SET Client_ID = um.New_ID
FROM [dbo].[Documents_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_ID = um.Old_ID
WHERE bc.Client_ID != -1

--UPDATE Cluster_ID column
UPDATE [dbo].[Documents_MP]
SET Cluster_ID = um.New_ID
FROM [dbo].[Documents_MP] bc
JOIN [dbo].[Documents_Cluster_ID_Mapping] um ON bc.Cluster_ID = um.Old_ID
WHERE bc.Cluster_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[Documents_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Documents_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Documents_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Documents_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   SET	@OldID = (SELECT TOP 1 Document_ID FROM [dbo].[Documents_MP]  WHERE LoopId = @LoopCounter)

	IF(@OldID != -1)	
	BEGIN
	INSERT INTO [dbo].[Documents] OUTPUT Inserted.Document_ID INTO @IdentityValue
		SELECT 	Client_ID,
				Document_Name,
				Local_Name,
				Mime_Type,
				Category,
				SubCategory,
				Permission_Level,
				lastTouched,
				byWho,
				Plan_Stamp,
				Cluster_ID,
				IsLastUpdatedByAdvisor
   		FROM [dbo].[Documents_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Documents_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Documents_MP]  WHERE LoopId > @LoopCounter

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