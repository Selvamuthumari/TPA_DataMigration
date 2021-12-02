/*Portal_InfoGatheredTriggers Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(ID) FROM [dbo].[Portal_InfoGatheredTriggers]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Portal_InfoGatheredTriggers_ID_Mapping] ON; 
	INSERT INTO [dbo].[Portal_InfoGatheredTriggers_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Portal_InfoGatheredTriggers_ID_Mapping] OFF; 


--UPDATE Client_Id column
UPDATE [dbo].[Portal_InfoGatheredTriggers_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[Portal_InfoGatheredTriggers_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Plan_ID column
UPDATE [dbo].[Portal_InfoGatheredTriggers_MP]
SET Plan_ID = um.New_ID
FROM [dbo].[Portal_InfoGatheredTriggers_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plan_ID = um.Old_ID
WHERE bc.Plan_ID != -1

--UPDATE DoneByWho
UPDATE [dbo].[Portal_InfoGatheredTriggers_MP]
SET DoneByWho = um.[PPC_SysUserID]
FROM [dbo].[Portal_InfoGatheredTriggers_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.DoneByWho=um.[MyPlans_SysUserID]
WHERE bc.DoneByWho != -1

--UPDATE CreatedByWho
UPDATE [dbo].[Portal_InfoGatheredTriggers_MP]
SET CreatedByWho = um.[PPC_SysUserID]
FROM [dbo].[Portal_InfoGatheredTriggers_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.CreatedByWho=um.[MyPlans_SysUserID]
WHERE bc.CreatedByWho != -1

/*ByWhoClient*/
UPDATE [dbo].[Portal_InfoGatheredTriggers_MP]
SET DoneByWho_Client=UM.New_ID
FROM [dbo].[Portal_InfoGatheredTriggers_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.DoneByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1

UPDATE [dbo].[Portal_InfoGatheredTriggers_MP]
SET DoneByWho_Client=UM.New_ID
FROM [dbo].[Portal_InfoGatheredTriggers_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.DoneByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_InfoGatheredTriggers]
SELECT Client_ID,
Plan_Id,
Plan_Year,
Task,
Description,
StartDate,
DueDate,
Type,
SubType,
TriggerFor,
IsDone,
DoneByWho,
DoneLastUpdated,
IsDeleted,
DoneByWho_Client,
DoneLastUpdated_Client,
CreatedByWho,
LastCreateddate,
TrackingDocTypeID,
TrackingDocTypeAdd,
IsLastUpdatedByAdvisor
FROM Portal_InfoGatheredTriggers_MP
WHERE Client_ID IN (SELECT Client_ID FROM Client_Master)
AND Plan_ID IN (SELECT Plans_Index_ID FROM Plans)

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