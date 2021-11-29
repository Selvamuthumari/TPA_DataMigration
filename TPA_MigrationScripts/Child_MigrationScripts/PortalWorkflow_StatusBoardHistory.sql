
/*PortalWorkflow_StatusBoardHistory Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY 

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Id) FROM [dbo].PortalWorkflow_StatusBoardHistory);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalWorkflow_StatusBoardHistory_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalWorkflow_StatusBoardHistory_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalWorkflow_StatusBoardHistory_ID_Mapping] OFF; 

--UPDATE ApplyWorkflowId column
UPDATE [dbo].[PortalWorkflow_StatusBoardHistory_MP]
SET ApplyWorkflowId = um.New_ID
FROM [dbo].[PortalWorkflow_StatusBoardHistory_MP] bc
JOIN [dbo].[PortalWorkflow_Workflow_ID_Mapping] um ON bc.ApplyWorkflowId=um.Old_ID
WHERE bc.ApplyWorkflowId != -1

--UPDATE ByWho column
UPDATE [dbo].[PortalWorkflow_StatusBoardHistory_MP]
SET ByWho = um.PPC_SysUserID
FROM [dbo].[PortalWorkflow_StatusBoardHistory_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalWorkflow_StatusBoardHistory]
SELECT ApplyWorkflowId,
ElementState,
ActionDate,
ByWho
FROM [PortalWorkflow_StatusBoardHistory_MP]

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