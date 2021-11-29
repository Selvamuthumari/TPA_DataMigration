/*Portal_ClientUpdateInfo Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET [ClientId] = um.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.[ClientId] = um.Old_ID
WHERE bc.[ClientId] != -1

--UPDATE Plan_ID column
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET PlanID = um.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanID = um.Old_ID
WHERE bc.PlanID != -1

--UPDATE AdvisorID column
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET AdvisorID = um.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] bc
JOIN [dbo].[Advisor_ID_Mapping] um ON bc.AdvisorID = um.Old_ID
WHERE bc.AdvisorID != -1

--UPDATE ContactID column
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET ContactID = um.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] bc
JOIN [dbo].[Contacts_ID_Mapping] um ON bc.ContactID = um.Old_ID
WHERE bc.ContactID != -1

--UPDATE OwnerId column
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET OwnerId = um.PPC_SysUserID
FROM [dbo].[Portal_ClientUpdateInfo_MP] bc
JOIN [dbo].[UserId_Mapping] um ON bc.OwnerId = um.MyPlans_SysUserID
WHERE bc.OwnerId != -1

--UPDATE ByWho column
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET ByWho = um.PPC_SysUserID
FROM [dbo].[Portal_ClientUpdateInfo_MP] bc
JOIN [dbo].[UserId_Mapping] um ON bc.ByWho = um.MyPlans_SysUserID
WHERE bc.ByWho != -1

/*Portal_ClientUpdateInfo --> ByWhoClient*/
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.ByWhoClient = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.ByWhoClient = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_ClientUpdateInfo]
SELECT ClientId,
AdvisorId,
ContactId,
OwnerId,
PlanId,
ColumnName,
ColumnValue,
IsClient,
IsAdvisor,
IsContact,
IsOwner,
ByWhoClient,
LastUpdatedClient,
ByWho,
LastUpdated,
IsChange,
IsLastUpdatedByAdvisor
FROM Portal_ClientUpdateInfo_MP

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