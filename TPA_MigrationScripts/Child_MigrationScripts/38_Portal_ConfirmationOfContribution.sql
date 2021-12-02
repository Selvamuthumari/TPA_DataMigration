
/*Portal_ConfirmationOfContribution Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(ConfirmationOfContributionId) FROM [dbo].[Portal_ConfirmationOfContribution]);--2

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Portal_ConfirmationOfContribution_ID_Mapping] ON; 
	INSERT INTO [dbo].[Portal_ConfirmationOfContribution_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Portal_ConfirmationOfContribution_ID_Mapping] OFF; 

--UPDATE PlanIndexId column
UPDATE [dbo].[Portal_ConfirmationOfContribution_MP]
SET PlanIndexId = um.New_ID
FROM [dbo].[Portal_ConfirmationOfContribution_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanIndexId = um.Old_ID
WHERE bc.PlanIndexId != -1

--UPDATE ByWho column
UPDATE [dbo].[Portal_ConfirmationOfContribution_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Portal_ConfirmationOfContribution_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(MAX), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Portal_ConfirmationOfContribution_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Portal_ConfirmationOfContribution_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
   SET	@OldID = (SELECT TOP 1 ConfirmationOfContributionId FROM [dbo].[Portal_ConfirmationOfContribution_MP]  WHERE LoopId = @LoopCounter)

	IF(@OldID != -1)	
	BEGIN
	INSERT INTO [dbo].[Portal_ConfirmationOfContribution] OUTPUT Inserted.ConfirmationOfContributionId INTO @IdentityValue
		SELECT 	PlanIndexId,
				PlanYear,
				ContributionNotes,
				ByWho,
				LastUpdated,
				IsPortalDeleted
   		FROM [dbo].[Portal_ConfirmationOfContribution_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Portal_ConfirmationOfContribution_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Portal_ConfirmationOfContribution_MP]  WHERE LoopId > @LoopCounter

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