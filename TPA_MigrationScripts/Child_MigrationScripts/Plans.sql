
/*Plans Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Plans_Index_ID) FROM [dbo].[Plans]);--9276

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Plans_ID_Mapping] ON; 
	INSERT INTO [dbo].[Plans_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Plans_ID_Mapping] OFF; 

--UPDATE Client_Id column
UPDATE [dbo].[Plans_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE DocType column
UPDATE [dbo].[Plans_MP]
SET DocType = um.New_ID
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[Doc_Types_ID_Mapping] um ON bc.DocType = um.Old_ID
WHERE bc.DocType != -1

--UPDATE TakeOverFromId column
UPDATE [dbo].[Plans_MP]
SET TakeOverFromId = um.New_ID
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[Portal_TakeOverFrom_ID_Mapping] um ON bc.TakeOverFromId = um.Old_ID
WHERE bc.TakeOverFromId != -1

--UPDATE ServiceSchedule_Lib_ID column
UPDATE [dbo].[Plans_MP]
SET ServiceSchedule_Lib_ID = um.New_ID
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[ServiceSchedule_Lib_ID_Mapping] um ON bc.ServiceSchedule_Lib_ID = um.Old_ID
WHERE bc.ServiceSchedule_Lib_ID != -1

--UPDATE ReasonForDepartureId column
UPDATE [dbo].[Plans_MP]
SET ReasonForDepartureId = um.New_ID
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[Portal_ReasonForDeparture_ID_Mapping] um ON bc.ReasonForDepartureId = um.Old_ID
WHERE bc.ReasonForDepartureId != -1

--UPDATE ByWho column
UPDATE [dbo].[Plans_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE NotifiedOfDepartureToWho
UPDATE [dbo].[Plans_MP]
SET NotifiedOfDepartureToWho = um.[PPC_SysUserID]
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.NotifiedOfDepartureToWho=um.[MyPlans_SysUserID]
WHERE bc.NotifiedOfDepartureToWho != -1

--UPDATE LastDepartureUpdatedByWho
UPDATE [dbo].[Plans_MP]
SET LastDepartureUpdatedByWho = um.[PPC_SysUserID]
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.LastDepartureUpdatedByWho=um.[MyPlans_SysUserID]
WHERE bc.LastDepartureUpdatedByWho != -1

--UPDATE NewTpaFirmId
UPDATE [dbo].[Plans_MP]
SET NewTpaFirmId = um.New_ID
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[Portal_NewTPAFirm_ID_Mapping] um ON bc.NewTpaFirmId=um.Old_ID
WHERE bc.NewTpaFirmId != -1

--UPDATE DocResponsible
UPDATE [dbo].[Plans_MP]
SET DocResponsible = um.New_ID
FROM [dbo].[Plans_MP] bc
JOIN [dbo].[Portal_DocMaintainedBy_ID_Mapping] um ON bc.DocResponsible=um.Old_ID
WHERE bc.DocResponsible != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @ClientID INT, @Plans_Index_ID INT, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Plans_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Plans_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldId = Plans_Index_ID, @ClientID = Client_ID, @Plans_Index_ID = Plans_Index_ID  FROM [dbo].[Plans_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1 AND (SELECT COUNT(*) FROM Client_Master WHERE Client_ID = @ClientID) > 0
	 AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @Plans_Index_ID) > 0)	
	BEGIN
	INSERT INTO [dbo].[Plans]
	 OUTPUT Inserted.Plans_Index_ID INTO @IdentityValue
		SELECT 	Client_ID,
				Plan_Number,
				Plan_Name,
				PlanYE,
				Plan_Type_Code,
				ServiceType,
				BillingType,
				DocType,
				TrustId,
				InvestmentPlatform,
				DocResponsible,
				AssetType,
				PlanStatus,
				Consultant,
				CSR,
				Acquired_Date,
				FirstYrRespon,
				PlanOrigin,
				TakeOverFrom,
				DocCreatedBy,
				SvcAgreementDate,
				LastAmendmentDate,
				PlanEffectiveDate,
				PlanRestatementDate,
				DateNotifiedOfDeparture,
				NotifiedOfDepartureToWho,
				PlanTerminationDate,
				DepartureTPAFirm,
				LastYearResponsible,
				LastEdited,
				ByWho,
				SafeHarborProvision,
				LinkedPlan_ID,
				ServiceSchedule_Lib_ID,
				LinkedPlanIndexID,
				PlanYB,
				ShortPlanYear,
				ShortPlanYearEndDate,
				DateOfLastWork,
				prev_plan_status,
				ReasonForDeparture,
				LastDepartureUpdated,
				LastDepartureUpdatedByWho,
				TakeOverFromId,
				ReasonForDepartureId,
				NewTpaFirmId,
				OrignalPpcClientId,
				ReportingCycle,
				Client_Name,
				UDF1,
				UDF2,
				UDF3,
				UDF4,
				UDF5,
				ClientPlanId
   		FROM [dbo].[Plans_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Plans_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Plans_MP]  WHERE LoopId > @LoopCounter

END
END

-- LinkedPlan_ID
UPDATE [dbo].[Plans]
SET LinkedPlan_ID = um.New_ID
FROM [dbo].[Plans] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.LinkedPlan_ID=um.Old_ID
WHERE bc.LinkedPlan_ID != -1
AND bc.Plans_index_ID > (SELECT Old_ID FROM [Plans_ID_Mapping] WHERE MapId=-1)

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