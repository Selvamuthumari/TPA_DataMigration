/*Portal_Timeline Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY 

--UPDATE Client_Id column
UPDATE [dbo].[Portal_Timeline_MP]
SET Client_ID = um.New_ID
FROM [dbo].[Portal_Timeline_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_ID = um.Old_ID
WHERE bc.Client_ID != -1 

--UPDATE PlanIndexId column
UPDATE [dbo].[Portal_Timeline_MP]
SET Plan_ID = um.New_ID
FROM [dbo].[Portal_Timeline_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plan_ID = um.Old_ID
WHERE bc.Plan_ID != -1

--UPDATE DoneByWho column
UPDATE [dbo].[Portal_Timeline_MP]
SET DoneByWho = um.[PPC_SysUserID]
FROM [dbo].[Portal_Timeline_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.DoneByWho=um.[MyPlans_SysUserID]
WHERE bc.DoneByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_Timeline]
SELECT Client_ID,
Plan_ID,
PYE_Year,
Task,
Requirement,
DueDate,
Type,
IsDone,
Task_Id,
isDeleted,
DoneByWho,
IsSharefile,
DoneDateClient,
IsLastUpdatedByAdvisor
FROM [Portal_Timeline_MP]
WHERE Plan_ID IN (SELECT Plans_Index_ID FROM Plans WHERE Plan_ID != -1)

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