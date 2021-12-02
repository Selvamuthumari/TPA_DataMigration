/*PortalWorkflow_YearEndTrackingPlanCompliance Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY 

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Id) FROM [dbo].PortalWorkflow_YearEndTrackingPlanCompliance);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalWorkflow_YearEndTrackingPlanCompliance_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalWorkflow_YearEndTrackingPlanCompliance_ID_Mapping] OFF; 

--UPDATE WorkflowId column
UPDATE [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP]
SET WorkflowId = um.New_ID
FROM [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP] bc
JOIN [dbo].[PortalWorkflow_Workflow_ID_Mapping] um ON bc.WorkflowId=um.Old_ID
WHERE bc.WorkflowId != -1

--UPDATE Plan_Index_Id column
UPDATE [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP]
SET PlanId = um.New_ID
FROM [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanId = um.Old_ID
WHERE bc.PlanId != -1

--UPDATE Client_Id column
UPDATE [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP]
SET ClientId = um.New_ID
FROM [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.ClientId = um.Old_ID
WHERE bc.ClientId != -1

--UPDATE LastUpdatedByWho column
UPDATE [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP]
SET LastUpdatedByWho = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.LastUpdatedByWho=um.[MyPlans_SysUserID]
WHERE bc.LastUpdatedByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance]
SELECT ClientId,
PlanId,
PlanYear,
ReasonForDelay,
WorkflowId,
UniqueDiscription,
LastUpdatedDate,
LastUpdatedByWho,
IsSelected
FROM [PortalWorkflow_YearEndTrackingPlanCompliance_MP]

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