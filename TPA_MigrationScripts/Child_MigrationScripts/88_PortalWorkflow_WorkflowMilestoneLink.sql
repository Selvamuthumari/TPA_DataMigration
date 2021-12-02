/*PortalWorkflow_WorkflowMilestoneLink Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY 

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(WorkflowMilestoneLinkId) FROM [dbo].PortalWorkflow_WorkflowMilestoneLink);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalWorkflow_WorkflowMilestoneLink_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalWorkflow_WorkflowMilestoneLink_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalWorkflow_WorkflowMilestoneLink_ID_Mapping] OFF; 

--UPDATE WorkflowId column
UPDATE [dbo].[PortalWorkflow_WorkflowMilestoneLink_MP]
SET WorkflowId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowMilestoneLink_MP] bc
JOIN [dbo].[PortalWorkflow_Workflow_ID_Mapping] um ON bc.WorkflowId=um.Old_ID
WHERE bc.WorkflowId != -1

--UPDATE MilestoneId column
UPDATE [dbo].[PortalWorkflow_WorkflowMilestoneLink_MP]
SET MilestoneId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowMilestoneLink_MP] bc
JOIN [dbo].[PortalWorkflow_MilestonesLibrary_ID_Mapping] um ON bc.MilestoneId=um.Old_ID
WHERE bc.MilestoneId != -1


--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalWorkflow_WorkflowMilestoneLink]
SELECT WorkflowId,
MilestoneId,
MilestoneSequenceId,
IsPortalDeleted
FROM [PortalWorkflow_WorkflowMilestoneLink_MP]

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