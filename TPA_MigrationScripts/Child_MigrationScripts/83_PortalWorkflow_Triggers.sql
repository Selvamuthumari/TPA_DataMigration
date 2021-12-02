/*PortalWorkflow_Triggers*/
BEGIN TRANSACTION;

BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT, @TRIGGER_ID_COUNT INT, @PPC_TRIGGER_ID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SET @PPC_TRIGGER_ID = (select max(TriggerId) as MAXIMUM_TRIGGER_ID from dbo.PortalWorkflow_Triggers_MP) ---  2352   Old 1 New Id 2353

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Id) FROM [dbo].[PortalWorkflow_Triggers_MP]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalWorkflow_Triggers_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalWorkflow_Triggers_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalWorkflow_Triggers_ID_Mapping] OFF; 

SELECT @LoopCounter = MIN(TriggerId), ---- 1 
    @MaxId = MAX(TriggerId)     ---- 3952
FROM dbo.PortalWorkflow_Triggers_MP WHERE TriggerId != -1

IF ((SELECT COUNT(*)
FROM dbo.PortalWorkflow_Triggers_MP) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN 
        SET @PPC_TRIGGER_ID = @PPC_TRIGGER_ID + 1 --2353

        IF (@LoopCounter != -1)
        BEGIN
            PRINT @LoopCounter
            Insert into [dbo].[PortalWorkflow_Triggers] 
            select @PPC_TRIGGER_ID, StateId, IsTodo,IsEmail from dbo.PortalWorkflow_Triggers_MP where TriggerId = @LoopCounter
            IF OBJECT_ID('dbo.PortalWorkflow_Triggers_ID_Mapping') IS NOT NULL
            BEGIN
                INSERT INTO [dbo].[PortalWorkflow_Triggers_ID_Mapping]
                VALUES(@LoopCounter, @PPC_TRIGGER_ID)   
            END
        END
    
        SELECT @LoopCounter  = MIN(TriggerId)
        FROM  dbo.PortalWorkflow_Triggers_MP 
        WHERE TriggerId > @LoopCounter
        --PRINT @LoopCounter
    END
END
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

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO  
