/*EmailRecord Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[EmailRecord_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[EmailRecord_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Contact_ID column
UPDATE [dbo].[EmailRecord_MP]
SET Contact_ID = um.[New_ID]
FROM [dbo].[EmailRecord_MP] bc
JOIN [dbo].[Contacts_ID_Mapping] um ON bc.Contact_ID=um.[Old_ID]
WHERE bc.Contact_ID != -1

--UPDATE Advisor_ID column
UPDATE [dbo].[EmailRecord_MP]
SET Advisor_ID = um.[New_ID]
FROM [dbo].[EmailRecord_MP] bc
JOIN [dbo].[Advisor_ID_Mapping] um ON bc.Advisor_ID=um.[Old_ID]
WHERE bc.Advisor_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[EmailRecord_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[EmailRecord_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

/*EmailRecord --> ByWhoClient*/
UPDATE [dbo].[EmailRecord_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[EmailRecord_MP] EMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON EMP.ByWhoClient = UM.Old_ID
WHERE EMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[EmailRecord_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[EmailRecord_MP] EMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON EMP.ByWhoClient = UM.Old_ID
WHERE EMP.IsLastUpdatedByAdvisor = 0 

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[EmailRecord]
SELECT Email_From,
Email_To,
Email_CC,
Email_Subject,
Email_Text,
Client_ID,
Contact_ID,
Advisor_ID,
LastTouched,
ByWho,
Email_Attachment,
IsDeletedFromOutlook,
ByWhoClient,
LastTouchedClient,
IsLastUpdatedByAdvisor,
NULL AS ScheduleId,
StatusId,
EmailTypeId,
ResponseCode,
CCStatus,
CCResponseCode
FROM EmailRecord_MP

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