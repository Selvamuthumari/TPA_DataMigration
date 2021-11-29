/*PortalWorkflow_WorkflowAppliedTo Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY 

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Id) FROM [dbo].PortalWorkflow_WorkflowAppliedTo);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalWorkflow_WorkflowAppliedTo_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalWorkflow_WorkflowAppliedTo_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalWorkflow_WorkflowAppliedTo_ID_Mapping] OFF; 

--UPDATE TaskId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET TaskId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[PortalWorkflow_TasksLibrary_ID_Mapping] um ON bc.TaskId=um.Old_ID
WHERE bc.TaskId != -1

--UPDATE WorkflowId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET WorkflowId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[PortalWorkflow_Workflow_ID_Mapping] um ON bc.WorkflowId=um.Old_ID
WHERE bc.WorkflowId != -1

--UPDATE MilestoneId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET MilestoneId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[PortalWorkflow_MilestonesLibrary_ID_Mapping] um ON bc.MilestoneId=um.Old_ID
WHERE bc.MilestoneId != -1

--UPDATE ProcessId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET ProcessId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[PortalWorkflow_ProcessLibrary_ID_Mapping] um ON bc.ProcessId=um.Old_ID
WHERE bc.ProcessId != -1

--UPDATE TriggerId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET TriggerId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[PortalWorkflow_Triggers_ID_Mapping] um ON bc.TriggerId=um.Old_ID
WHERE bc.TriggerId != -1

--UPDATE Plan_Index_Id column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET PlanId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanId = um.Old_ID
WHERE bc.PlanId != -1

--UPDATE Client_Id column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET ClientId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.ClientId = um.Old_ID
WHERE bc.ClientId != -1

--UPDATE ChildReportingElementId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET ChildReportingElementId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[Portal_ReportingElement_ID_Mapping] um ON bc.ChildReportingElementId=um.Old_ID
WHERE bc.ChildReportingElementId != -1

--UPDATE ParentReportingElementId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET ParentReportingElementId = um.New_ID
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[Portal_ReportingElement_ID_Mapping] um ON bc.ParentReportingElementId=um.Old_ID
WHERE bc.ParentReportingElementId != -1

--UPDATE TpaUserId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET TpaUserId = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.TpaUserId=um.[MyPlans_SysUserID]
WHERE bc.TpaUserId != -1

--UPDATE UpdatedBy column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET UpdatedBy = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UpdatedBy=um.[MyPlans_SysUserID]
WHERE bc.UpdatedBy != -1

--UPDATE CreatedBy column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET CreatedBy = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.CreatedBy=um.[MyPlans_SysUserID]
WHERE bc.CreatedBy != -1

--UPDATE AssigneeId column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET AssigneeId = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssigneeId=um.[MyPlans_SysUserID]
WHERE bc.AssigneeId != -1

--UPDATE ReportingElementCompletedBy column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET ReportingElementCompletedBy = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ReportingElementCompletedBy=um.[MyPlans_SysUserID]
WHERE bc.ReportingElementCompletedBy != -1

--UPDATE QAUpdatedBy column
UPDATE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP]
SET QAUpdatedBy = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.QAUpdatedBy=um.[MyPlans_SysUserID]
WHERE bc.QAUpdatedBy != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalWorkflow_WorkflowAppliedTo]
SELECT TpaUserId,
ClientId,
PlanId,
PlanYear,
ElementId,
WorkflowId,
MilestoneId,
ProcessId,
TaskId,
RoleId,
AssigneeId,
TriggerId,
State,
StartDate,
ClientWaitDate,
CompletedDate,
ReopenDate,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate,
IsIndependent,
SequenceId,
IsAssignee,
IsDocumentTicket,
DocumentId,
IsClosed,
IsComplete,
IsNotApplicable,
NotApplicableNotes,
IsAssigneeApplicableForTask,
UniqueDescription,
ParentReportingElementId,
ChildReportingElementId,
IsReportingElementComplete,
ReportingElementCompletedDate,
ReportingElementCompletedBy,
IsQAConfirmed,
QAUpdatedDate,
QAUpdatedBy
FROM [PortalWorkflow_WorkflowAppliedTo_MP]

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