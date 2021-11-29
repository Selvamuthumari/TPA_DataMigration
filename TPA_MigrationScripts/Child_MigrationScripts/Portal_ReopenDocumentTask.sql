/*Portal_ReopenDocumentTask Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Documents_ID_Mapping column
UPDATE [dbo].[Portal_ReopenDocumentTask_MP]
SET DocumentTrackingID = um.New_ID
FROM [dbo].[Portal_ReopenDocumentTask_MP] bc
JOIN [dbo].[Documents_ID_Mapping] um ON bc.DocumentTrackingID = um.Old_ID
WHERE bc.ClientId != -1

/*FinishedAssignee1*/
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET FinishedAssignee1=UM.PPC_SysUserID
FROM [dbo].[Portal_ReopenDocumentTask_MP] PMP
JOIN [dbo].[UserID_Mapping] UM ON PMP.FinishedAssignee1 = UM.MyPlans_SysUserID
WHERE PMP.FinishedAssignee1 != -1

/*FinishedAssignee2*/
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET FinishedAssignee2=UM.PPC_SysUserID
FROM [dbo].[Portal_ReopenDocumentTask_MP] PMP
JOIN [dbo].[UserID_Mapping] UM ON PMP.FinishedAssignee2 = UM.MyPlans_SysUserID
WHERE PMP.FinishedAssignee2 != -1

/*FinishedByWho1*/
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET FinishedByWho1=UM.PPC_SysUserID
FROM [dbo].[Portal_ReopenDocumentTask_MP] PMP
JOIN [dbo].[UserID_Mapping] UM ON PMP.FinishedByWho1 = UM.MyPlans_SysUserID
WHERE PMP.FinishedByWho1 != -1

/*FinishedByWho2*/
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET FinishedByWho2=UM.PPC_SysUserID
FROM [dbo].[Portal_ReopenDocumentTask_MP] PMP
JOIN [dbo].[UserID_Mapping] UM ON PMP.FinishedByWho2 = UM.MyPlans_SysUserID
WHERE PMP.FinishedByWho2 != -1

/*ReopenByWho1*/
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET ReopenByWho1=UM.PPC_SysUserID
FROM [dbo].[Portal_ReopenDocumentTask_MP] PMP
JOIN [dbo].[UserID_Mapping] UM ON PMP.ReopenByWho1 = UM.MyPlans_SysUserID
WHERE PMP.ReopenByWho1 != -1

/*ReopenByWho2*/
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET ReopenByWho2=UM.PPC_SysUserID
FROM [dbo].[Portal_ReopenDocumentTask_MP] PMP
JOIN [dbo].[UserID_Mapping] UM ON PMP.ReopenByWho2 = UM.MyPlans_SysUserID
WHERE PMP.ReopenByWho2 != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_ReopenDocumentTask]
SELECT DocumentTrackingId,
FinishedDate1,
FinishedAssignee1,
FinishedByWho1,
FinishedDate2,
FinishedAssignee2,
FinishedByWho2,
ReopenDate1,
ReopenByWho1,
ReopenDate2,
ReopenByWho2,
IsPortalDeleted
FROM Portal_ReopenDocumentTask_MP

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