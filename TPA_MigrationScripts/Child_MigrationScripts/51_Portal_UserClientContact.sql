/*Portal_UserClientContact Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE PortalUser_ID column
UPDATE [dbo].[Portal_UserClientContact_MP]
SET PortalUser_ID = um.[PPC_SysUserID]
FROM [dbo].[Portal_UserClientContact_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.PortalUser_ID=um.[MyPlans_SysUserID]
WHERE bc.PortalUser_ID != -1

--UPDATE Client_Id column
UPDATE [dbo].[Portal_UserClientContact_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[Portal_UserClientContact_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Contact_ID column
UPDATE [dbo].[Portal_UserClientContact_MP]
SET Contact_ID = um.[New_ID]
FROM [dbo].[Portal_UserClientContact_MP] bc
JOIN [dbo].[Contacts_ID_Mapping] um ON bc.Contact_ID=um.[Old_ID]
WHERE bc.Contact_ID != -1

--UPDATE Advisor_ID column
UPDATE [dbo].[Portal_UserClientContact_MP]
SET AdvisorID = um.[New_ID]
FROM [dbo].[Portal_UserClientContact_MP] bc
JOIN [dbo].[Advisor_ID_Mapping] um ON bc.AdvisorID=um.[Old_ID]
WHERE bc.AdvisorID != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_UserClientContact]
SELECT PortalUser_ID,
Client_ID,
Contact_ID,
AdvisorID
FROM [Portal_UserClientContact_MP]
WHERE PortalUser_ID IN (SELECT UserId FROM [dbo].[Portal_Users])

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