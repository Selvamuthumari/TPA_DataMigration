/*Portal_DocumentTracking Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE DocumentTrackId
UPDATE [dbo].[Portal_DocumentTracking_MP]
SET DocumentTrackId = um.New_ID
FROM [dbo].[Portal_DocumentTracking_MP] bc
JOIN [dbo].[Documents_ID_Mapping] um ON bc.Assignee=um.Old_ID
WHERE bc.DocumentTrackId != -1

--UPDATE PlanIndexId column
UPDATE [dbo].[Portal_DocumentTracking_MP]
SET PlanId = um.New_ID
FROM [dbo].[Portal_DocumentTracking_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanId = um.Old_ID
WHERE bc.PlanId != -1

--UPDATE Assignee column
UPDATE [dbo].[Portal_DocumentTracking_MP]
SET Assignee = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Assignee=um.[MyPlans_SysUserID]
WHERE bc.Assignee != -1

--UPDATE UpdatedBy column
UPDATE [dbo].[Portal_DocumentTracking_MP]
SET UpdatedBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UpdatedBy=um.[MyPlans_SysUserID]
WHERE bc.UpdatedBy != -1

--UPDATE DeliveredBy column
UPDATE [dbo].[Portal_DocumentTracking_MP]
SET DeliveredBy = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.DeliveredBy=um.[MyPlans_SysUserID]
WHERE bc.DeliveredBy != -1

--UPDATE AssigneeUserId column
UPDATE [dbo].[Portal_DocumentTracking_MP]
SET AssigneeUserId = um.[PPC_SysUserID]
FROM [dbo].[Portal_DocumentTracking_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssigneeUserId=um.[MyPlans_SysUserID]
WHERE bc.AssigneeUserId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_DocumentTracking]
SELECT DocumentTrackId,
PlanId,
DocumentType,
Assignee,
TaskId,
UpdatedBy,
UpdatedDate,
TaskStatus,
Start,
Pause,
ContinueOn,
Delay,
Finished,
TaskName,
TaskType,
IsTaskEnable,
TaskCategory,
Deadline,
Percentage,
IsDeliveredByAdd,
DeliveredBy,
IsPortalDeleted,
Ordering,
AssigneeUserId
FROM [Portal_DocumentTracking_MP]
WHERE PlanId IN (SELECT Plans_Index_ID FROM Plans WHERE Plans_Index_ID != -1)

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