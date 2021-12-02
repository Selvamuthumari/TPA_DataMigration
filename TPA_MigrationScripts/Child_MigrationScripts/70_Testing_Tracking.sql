/*Testing_Tracking Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE PlanIndexId column
UPDATE [dbo].[Testing_Tracking_MP]
SET Plans_Index_Id = um.New_ID
FROM [dbo].[Testing_Tracking_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_Id = um.Old_ID
WHERE bc.Plans_Index_Id != -1

--UPDATE ByWho column
UPDATE [dbo].[Testing_Tracking_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Testing_Tracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE Preparer_By column
UPDATE [dbo].[Testing_Tracking_MP]
SET Preparer_By = um.[PPC_SysUserID]
FROM [dbo].[Testing_Tracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Preparer_By=um.[MyPlans_SysUserID]
WHERE bc.Preparer_By != -1

--UPDATE Reviewed_By column
UPDATE [dbo].[Testing_Tracking_MP]
SET Reviewed_By = um.[PPC_SysUserID]
FROM [dbo].[Testing_Tracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Reviewed_By=um.[MyPlans_SysUserID]
WHERE bc.Reviewed_By != -1

--UPDATE Communicated_By column
UPDATE [dbo].[Testing_Tracking_MP]
SET Communicated_By = um.[PPC_SysUserID]
FROM [dbo].[Testing_Tracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Communicated_By=um.[MyPlans_SysUserID]
WHERE bc.Communicated_By != -1

--UPDATE Notes column
UPDATE [dbo].[Testing_Tracking_MP]
SET Notes_ID = um.[New_ID]
FROM [dbo].[Testing_Tracking_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Notes_ID=um.[Old_ID]
WHERE bc.Notes_ID != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Testing_Tracking]
SELECT Plans_Index_ID,
Plan_Year,
Testing_Index,
Testing_Type,
Testing_Status,
Preparer_By,
PreparerAssign,
PreparerDone,
Reviewed_By,
ReviewedAssign,
ReviewedDone,
Results,
Communicated_By,
CommunicatedAssign,
CommunicatedDone,
Waiting,
Decision,
Attachment_ID,
Notes_ID,
LastTouched,
ByWho
FROM [Testing_Tracking_MP]
WHERE Plans_Index_ID IN (SELECT Plans_Index_ID FROM PLANS)

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