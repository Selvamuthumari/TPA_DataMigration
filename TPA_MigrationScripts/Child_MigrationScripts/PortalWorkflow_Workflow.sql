
/*PortalWorkflow_Workflow Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(WorkflowId) FROM [dbo].[PortalWorkflow_Workflow]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalWorkflow_Workflow_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalWorkflow_Workflow_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalWorkflow_Workflow_ID_Mapping] OFF; 

--UPDATE TriggerId column
UPDATE [dbo].[PortalWorkflow_Workflow_MP]
SET TriggerId = um.New_ID
FROM [dbo].[PortalWorkflow_Workflow_MP] bc
JOIN [dbo].[PortalWorkflow_Triggers_ID_Mapping] um ON bc.TriggerId=um.Old_ID
WHERE bc.TriggerId != -1

--UPDATE ChildReportingElement column
UPDATE [dbo].[PortalWorkflow_Workflow_MP]
SET ChildReportingElement = um.New_ID
FROM [dbo].[PortalWorkflow_Workflow_MP] bc
JOIN [dbo].[Portal_ReportingElement_ID_Mapping] um ON bc.ChildReportingElement=um.Old_ID
WHERE bc.ChildReportingElement != -1

--UPDATE ReportingElement column
UPDATE [dbo].[PortalWorkflow_Workflow_MP]
SET ReportingElement = um.New_ID
FROM [dbo].[PortalWorkflow_Workflow_MP] bc
JOIN [dbo].[Portal_ReportingElement_ID_Mapping] um ON bc.ReportingElement=um.Old_ID
WHERE bc.ReportingElement != -1

--UPDATE Assignee column
UPDATE [dbo].[PortalWorkflow_Workflow_MP]
SET Assignee = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_Workflow_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Assignee=um.[MyPlans_SysUserID]
WHERE bc.Assignee != -1

--UPDATE UpdatedBy column
UPDATE [dbo].[PortalWorkflow_Workflow_MP]
SET UpdatedBy = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_Workflow_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UpdatedBy=um.[MyPlans_SysUserID]
WHERE bc.UpdatedBy != -1

--UPDATE CreatedBy column
UPDATE [dbo].[PortalWorkflow_Workflow_MP]
SET CreatedBy = um.[PPC_SysUserID]
FROM [dbo].[PortalWorkflow_Workflow_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.CreatedBy=um.[MyPlans_SysUserID]
WHERE bc.CreatedBy != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PortalWorkflow_Workflow_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PortalWorkflow_Workflow_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   SET	@OldID = (SELECT TOP 1 WorkflowId FROM [dbo].[PortalWorkflow_Workflow_MP]  WHERE LoopId = @LoopCounter)

	IF(@OldID != -1)	
	BEGIN
	INSERT INTO [dbo].[PortalWorkflow_Workflow] OUTPUT Inserted.WorkflowId INTO @IdentityValue
		SELECT CONCAT(WorkflowName,'-B') AS WorkflowName,
Description,
Category,
Role,
Assignee,
TriggerId,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate,
IsPortalDeleted,
IsHiddenFromLibrary,
IsAssignee,
TicketTypeId,
IsDefault,
IsPlanAmmendment,
ReportingElement,
ChildReportingElement
   		FROM [dbo].[PortalWorkflow_Workflow_MP]  WHERE LoopId = @LoopCounter
		AND TriggerId IN (SELECT TriggerId FROM PortalWorkflow_Triggers)
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[PortalWorkflow_Workflow_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PortalWorkflow_Workflow_MP]  WHERE LoopId > @LoopCounter

END
END
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