/*PortalWorkflow_ToDo Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY 

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Id) FROM [dbo].PortalWorkflow_ToDo);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalWorkflow_ToDo_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalWorkflow_ToDo_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalWorkflow_ToDo_ID_Mapping] OFF; 

----UPDATE TaskId column
--Fails: Cannot insert the value NULL into column 'TaskId', table 'TestDB-PPC-23Nov.dbo.PortalWorkflow_ToDo_MP'; column does not allow nulls. UPDATE fails.
--UPDATE [dbo].[PortalWorkflow_ToDo_MP]
--SET TaskId = um.New_ID
--FROM [dbo].[PortalWorkflow_ToDo_MP] bc
--JOIN [dbo].[PortalWorkflow_TasksLibrary_ID_Mapping] um ON bc.TaskId=um.Old_ID
--WHERE bc.TaskId != -1 

--UPDATE WorkflowId column
UPDATE [dbo].[PortalWorkflow_ToDo_MP]
SET WorkflowId = um.New_ID
FROM [dbo].[PortalWorkflow_ToDo_MP] bc
JOIN [dbo].[PortalWorkflow_Workflow_ID_Mapping] um ON bc.WorkflowId=um.Old_ID
WHERE bc.WorkflowId != -1

--UPDATE MilestoneId column
UPDATE [dbo].[PortalWorkflow_ToDo_MP]
SET MilestoneId = um.New_ID
FROM [dbo].[PortalWorkflow_ToDo_MP] bc
JOIN [dbo].[PortalWorkflow_MilestonesLibrary_ID_Mapping] um ON bc.MilestoneId=um.Old_ID
WHERE bc.MilestoneId != -1

--UPDATE ProcessId column
UPDATE [dbo].[PortalWorkflow_ToDo_MP]
SET ProcessId = um.New_ID
FROM [dbo].[PortalWorkflow_ToDo_MP] bc
JOIN [dbo].[PortalWorkflow_ProcessLibrary_ID_Mapping] um ON bc.ProcessId=um.Old_ID
WHERE bc.ProcessId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalWorkflow_ToDo]
SELECT ElementId,
StateId,
WorkflowId,
MilestoneId,
ProcessId,
TaskId,
IsDefault,
ToDoSubject,
ToDoDescription,
Category,
BudgetedTime,
Deadline,
EmailBodyContents,
DynamicFields,
IsPortalDeleted
FROM [PortalWorkflow_ToDo_MP]

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