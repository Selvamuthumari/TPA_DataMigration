
/*Comm_Log Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Comm_Log_ID) FROM [dbo].[Comm_Log_MP]);--59636

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Comm_Log_ID_Mapping] ON; 
	INSERT INTO [dbo].[Comm_Log_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Comm_Log_ID_Mapping] OFF; 

--UPDATE Client_Id column
UPDATE [dbo].[Comm_Log_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[Comm_Log_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Plan_ID column
UPDATE [dbo].[Comm_Log_MP]
SET Plan_ID = um.New_ID
FROM [dbo].[Comm_Log_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plan_ID = um.Old_ID
WHERE bc.Plan_ID != -1

--UPDATE AdHocToDo column
UPDATE [dbo].[Comm_Log_MP]
SET AdHocToDo = um.New_ID
FROM [dbo].[Comm_Log_MP] bc
JOIN [dbo].[AdHocToDo_ID_Mapping] um ON bc.AdHocToDo = um.Old_ID
WHERE bc.AdHocToDo != -1

--UPDATE ByWho column
UPDATE [dbo].[Comm_Log_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Comm_Log_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE CreatedByWho
UPDATE [dbo].[Comm_Log_MP]
SET CreatedByWho = um.[PPC_SysUserID]
FROM [dbo].[Comm_Log_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.CreatedByWho=um.[MyPlans_SysUserID]
WHERE bc.CreatedByWho != -1

--UPDATE ByWhoClient
UPDATE [dbo].[Comm_Log_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[Comm_Log_MP] CMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON CMP.ByWhoClient = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 1

UPDATE [dbo].[Comm_Log_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[Comm_Log_MP] CMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON CMP.ByWhoClient = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 0

--UPDATE Comm_Log_Category (value as -1 instead of 0)
UPDATE [dbo].[Comm_Log_MP]
SET Comm_Log_Category = -1
FROM [dbo].[Comm_Log_MP]
WHERE Comm_Log_Category = 0
 
--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @ClientID INT, @Plan_ID INT, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Comm_Log_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Comm_Log_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldId = Comm_Log_ID, @ClientID = Client_ID, @Plan_ID = Plan_ID  FROM [dbo].[Comm_Log_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1 AND (SELECT COUNT(*) FROM Client_Master WHERE Client_ID = @ClientID) > 0
	 AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @Plan_ID) > 0)	
	BEGIN
	INSERT INTO [dbo].[Comm_Log]
	 OUTPUT Inserted.Comm_Log_ID INTO @IdentityValue
		SELECT 	Client_ID,
				Comm_Log_Type,
				Comm_Log_Origination,
				Comm_Log_Category,
				Sub_Category,
				Comm_Log_Status,
				Plan_ID,
				Project_ID,
				AdHocToDo,
				Title,
				CommContact1,
				CommContact2,
				CommContact3,
				Attachment_ID,
				Comm_Log_Text,
				Duplicate,
				Internal_Use_Only,
				OriginDate,
				LastTouched,
				ByWho,
				Actual_Time,
				CreatedByWho,
				IsDeletedFromOutlook,
				IsPortalDeleted,
				ByWhoClient,
				LastTouchedClient,
				IsLastUpdatedByAdvisor
   		FROM [dbo].[Comm_Log_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Comm_Log_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Comm_Log_MP]  WHERE LoopId > @LoopCounter

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