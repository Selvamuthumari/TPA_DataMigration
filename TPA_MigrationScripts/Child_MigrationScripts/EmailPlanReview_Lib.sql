/*EmailPlanReview_Lib Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[EmailPlanReview_Lib_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[EmailPlanReview_Lib_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE Plan_ID column
UPDATE [dbo].[EmailPlanReview_Lib_MP]
SET Plan_Index_ID = um.New_ID
FROM [dbo].[EmailPlanReview_Lib_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plan_Index_ID = um.Old_ID
WHERE bc.Plan_Index_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[EmailPlanReview_Lib_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[EmailPlanReview_Lib_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[EmailPlanReview_Lib]
SELECT Client_ID,
Plan_Index_ID,
PlanYear,
TotalPlanCount,
CheckedPlanCount,
LastTouched,
ByWho
FROM EmailPlanReview_Lib_MP

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