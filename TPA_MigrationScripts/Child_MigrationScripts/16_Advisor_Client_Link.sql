
/*Advisor_Client_Link Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Advisor_Client_Link_ID) FROM [dbo].[Advisor_Client_Link]);--9276

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Advisor_Client_Link_ID_Mapping] ON; 
	INSERT INTO [dbo].[Advisor_Client_Link_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Advisor_Client_Link_ID_Mapping] OFF; 

--UPDATE Client_Id column
UPDATE [dbo].[Advisor_Client_Link_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[Advisor_Client_Link_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Advisor_Id column
UPDATE [dbo].[Advisor_Client_Link_MP]
SET [Advisor_Id] = um.New_ID
FROM [dbo].[Advisor_Client_Link_MP] bc
JOIN [dbo].[Advisor_Id_Mapping] um ON bc.Advisor_Id = um.Old_ID
WHERE bc.Advisor_Id != -1

--UPDATE Plan_Index_Id column
UPDATE [dbo].[Advisor_Client_Link_MP]
SET Plans_Index_ID = um.New_ID
FROM [dbo].[Advisor_Client_Link_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_ID = um.Old_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE Plan_Number column
UPDATE [dbo].[Advisor_Client_Link_MP]
SET Plan_Number = um.Plan_Number
FROM [dbo].[Advisor_Client_Link_MP] bc
JOIN [dbo].[Plans_MP] um ON bc.Plans_Index_ID = um.Plans_Index_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[Advisor_Client_Link_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Advisor_Client_Link_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @ClientID INT, @Plans_Index_ID INT, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Advisor_Client_Link_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Advisor_Client_Link_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldId = Advisor_Client_Link_ID, @ClientID = Client_ID, @Plans_Index_ID = Plans_Index_ID  FROM [dbo].[Advisor_Client_Link_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1 AND (SELECT COUNT(*) FROM Client_Master WHERE Client_ID = @ClientID) > 0
	 AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @Plans_Index_ID) > 0)	
	BEGIN
	INSERT INTO [dbo].[Advisor_Client_Link]
	 OUTPUT Inserted.Advisor_Client_Link_ID INTO @IdentityValue
		SELECT 	Client_ID,
				Plan_Number,
				Advisor_Type_ID,
				Advisor_ID,
				LastTouched,
				ByWho,
				CC,
				Plans_Index_ID,
				ByWho_Client,
				LastTouched_Client,
				IsPortalDeleted,
				IsEnableByBoyce,
				IsLastUpdatedByAdvisor
   		FROM [dbo].[Advisor_Client_Link_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Advisor_Client_Link_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Advisor_Client_Link_MP]  WHERE LoopId > @LoopCounter

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