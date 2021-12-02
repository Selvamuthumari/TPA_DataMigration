
/*AdHocTodo Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(AdHocTodo_ID) FROM [dbo].[AdHocTodo]);--25708

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[AdHocTodo_ID_Mapping] ON; 
	INSERT INTO [dbo].[AdHocTodo_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[AdHocTodo_ID_Mapping] OFF; 

--UPDATE Client_Id column
UPDATE [dbo].[AdHocTodo_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Advisor_Id column
UPDATE [dbo].[AdHocTodo_MP]
SET [Advisor_Id] = um.New_ID
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[Advisor_Id_Mapping] um ON bc.Advisor_Id = um.Old_ID
WHERE bc.Advisor_Id != -1

--UPDATE Contact_Id column
UPDATE [dbo].[AdHocTodo_MP]
SET [Contact_Id] = um.New_ID
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[Contacts_Id_Mapping] um ON bc.Contact_Id = um.Old_ID
WHERE bc.Contact_Id != -1

--UPDATE Plan_Index_Id column
UPDATE [dbo].[AdHocTodo_MP]
SET Plan_Index_Id = um.New_ID
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plan_Index_Id = um.Old_ID
WHERE bc.Plan_Index_Id != -1

--UPDATE Comm_Log_Id column
UPDATE [dbo].[AdHocTodo_MP]
SET Comm_Log_Id = um.New_ID
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[Comm_Log_ID_Mapping] um ON bc.Comm_Log_Id = um.Old_ID
WHERE bc.Comm_Log_Id != -1

--UPDATE ByWho column
UPDATE [dbo].[AdHocTodo_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE Assigned_To_ID column
UPDATE [dbo].[AdHocTodo_MP]
SET Assigned_To_ID = um.[PPC_SysUserID]
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Assigned_To_ID=um.[MyPlans_SysUserID]
WHERE bc.Assigned_To_ID != -1

--UPDATE WhoComplete column
UPDATE [dbo].[AdHocTodo_MP]
SET WhoComplete = um.[PPC_SysUserID]
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.WhoComplete=um.[MyPlans_SysUserID]
WHERE bc.WhoComplete != -1

--UPDATE WhoCreated column
UPDATE [dbo].[AdHocTodo_MP]
SET WhoCreated = um.[PPC_SysUserID]
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.WhoCreated=um.[MyPlans_SysUserID]
WHERE bc.WhoCreated != -1

--UPDATE InitiallyAassigned_To_ID
UPDATE [dbo].[AdHocTodo_MP]
SET InitiallyAassigned_To_ID = um.[PPC_SysUserID]
FROM [dbo].[AdHocTodo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.InitiallyAassigned_To_ID=um.[MyPlans_SysUserID]
WHERE bc.InitiallyAassigned_To_ID != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @ClientID INT, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[AdHocTodo_MP]

IF ((SELECT COUNT(*) FROM [dbo].[AdHocTodo_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
    SELECT @OldId = AdHocTodo_ID, @ClientID = Client_ID FROM [dbo].[AdHocTodo_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1 AND (SELECT COUNT(*) FROM Client_Master WHERE Client_ID = @ClientID) > 0)	
	BEGIN
	INSERT INTO [dbo].[AdHocTodo]
			([Subject]
           ,[Description]
           ,[Client_ID]
           ,[Advisor_ID]
           ,[Contact_ID]
           ,[Plan_Index_ID]
           ,[Comm_Log_ID]
           ,[MainCategory]
           ,[SubCategory]
           ,[Create_Date]
           ,[Budget_Time]
           ,[Actual_Time]
           ,[Promised_Date]
           ,[Deadline]
           ,[Assigned_To_ID]
           ,[Completed]
           ,[lastTouch]
           ,[byWho]
           ,[WhoComplete]
           ,[WhoCreated]
           ,[Attachment_ID]
           ,[Flag]
           ,[IsDeletedFromOutlook]
           ,[AssignedDate]
           ,[IsPortalDeleted]
           ,[IsCreatedByAdvisor]
           ,[IsReassigned]
           ,[InitiallyAassigned_To_ID]
           ,[InitialAssignedDate])
	 OUTPUT Inserted.AdHocTodo_ID INTO @IdentityValue
		SELECT 	[Subject],
				[Description],
				Client_ID,
				Advisor_ID,
				Contact_ID,
				Plan_Index_ID,
				Comm_Log_ID,
				MainCategory,
				SubCategory,
				Create_Date,
				Budget_Time,
				Actual_Time,
				Promised_Date,
				Deadline,
				Assigned_To_ID,
				Completed,
				lastTouch,
				byWho,
				WhoComplete,
				WhoCreated,
				Attachment_ID,
				Flag,
				IsDeletedFromOutlook,
				AssignedDate,
				IsPortalDeleted,
				IsCreatedByAdvisor,
				IsReassigned,
				InitiallyAassigned_To_ID,
				InitialAssignedDate
   		FROM [dbo].[AdHocTodo_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[AdHocTodo_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[AdHocTodo_MP]  WHERE LoopId > @LoopCounter

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