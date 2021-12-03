
/*PlanYearEnd Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(PYE_ID) FROM [dbo].[PlanYearEnd]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PlanYearEnd_ID_Mapping] ON; 
	INSERT INTO [dbo].[PlanYearEnd_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PlanYearEnd_ID_Mapping] OFF; 

--UPDATE Plans_Index_ID column
UPDATE [dbo].[PlanYearEnd_MP]
SET Plans_Index_ID = um.New_ID
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_ID = um.Old_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE Initially_Received_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Initially_Received_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Initially_Received_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Initially_Received_ByWho != -1

--UPDATE More_Requested_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET More_Requested_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.More_Requested_ByWho=um.[MyPlans_SysUserID]
WHERE bc.More_Requested_ByWho != -1

--UPDATE More_Received_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET More_Received_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.More_Received_ByWho=um.[MyPlans_SysUserID]
WHERE bc.More_Received_ByWho != -1

--UPDATE Reviewed_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Reviewed_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Reviewed_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Reviewed_ByWho != -1

--UPDATE Request_Init_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Request_Init_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Request_Init_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Request_Init_ByWho != -1

--UPDATE Request_Follow_1_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Request_Follow_1_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Request_Follow_1_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Request_Follow_1_ByWho != -1

--UPDATE Request_Follow_2_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Request_Follow_2_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Request_Follow_2_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Request_Follow_2_ByWho != -1

--UPDATE Request_Follow_3_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Request_Follow_3_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Request_Follow_3_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Request_Follow_3_ByWho != -1

--UPDATE Request_Follow_4_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Request_Follow_4_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Request_Follow_4_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Request_Follow_4_ByWho != -1

--UPDATE NotRequiredByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET NotRequiredByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.NotRequiredByWho=um.[MyPlans_SysUserID]
WHERE bc.NotRequiredByWho != -1

--UPDATE VerifiedByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET VerifiedByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.VerifiedByWho=um.[MyPlans_SysUserID]
WHERE bc.VerifiedByWho != -1

--UPDATE Date_Invoice_Mailed_ByWho
UPDATE [dbo].[PlanYearEnd_MP]
SET Date_Invoice_Mailed_ByWho = um.[PPC_SysUserID]
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Date_Invoice_Mailed_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Date_Invoice_Mailed_ByWho != -1

--UPDATE Notes_ID
UPDATE [dbo].[PlanYearEnd_MP]
SET Notes_ID = um.New_ID
FROM [dbo].[PlanYearEnd_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Notes_ID=um.Old_ID
WHERE bc.Notes_ID != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @OldID INT, @NewID INT, @Plans_Index_ID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PlanYearEnd_MP]

--5- Schedule A
UPDATE PlanYearEnd_MP
SET TrackingDoc_Type_Add = STM.New_ID
--SELECT *
FROM PlanYearEnd_MP PYE
JOIN ScheduleATracking_ID_Mapping STM
ON PYE.TrackingDoc_Type_Add = STM.Old_ID
WHERE TrackingDoc_Type_ID=5 AND TrackingDoc_Type_Add != -1 AND TrackingDoc_Type_Add != -2

--11- Asset
UPDATE PlanYearEnd_MP
SET TrackingDoc_Type_Add = STM.New_ID
--SELECT *
FROM PlanYearEnd_MP PYE
JOIN AssetTracking_ID_Mapping STM
ON PYE.TrackingDoc_Type_Add = STM.Old_ID
WHERE TrackingDoc_Type_ID=11 AND TrackingDoc_Type_Add != -1 AND TrackingDoc_Type_Add != -2

--15- Market Valuation
UPDATE PlanYearEnd_MP
SET TrackingDoc_Type_Add = STM.New_ID
--SELECT *
FROM PlanYearEnd_MP PYE
JOIN MarketValuationTracking_ID_Mapping STM
ON PYE.TrackingDoc_Type_Add = STM.Old_ID
WHERE TrackingDoc_Type_ID=15 AND TrackingDoc_Type_Add != -1 AND TrackingDoc_Type_Add != -2

IF ((SELECT COUNT(*) FROM [dbo].[PlanYearEnd_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldId = PYE_ID, @Plans_Index_ID=Plans_Index_ID FROM [dbo].[PlanYearEnd_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1
	AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @Plans_Index_ID) > 0)	
	BEGIN
	INSERT INTO [dbo].[PlanYearEnd] OUTPUT Inserted.PYE_ID INTO @IdentityValue
		SELECT 	PYE_Year,
				PYE_Month,
				PYE_Cycle,
				PYE_Period,
				Plans_Index_ID,
				TrackingDoc_Type_ID,
				TrackingDoc_Type_Add,
				Request_From,
				Request_Delivery_Type,
				Request_Init,
				Request_Init_Type,
				Request_Init_Doc,
				Request_Follow_1,
				Request_Follow_1_Type,
				Request_Follow_1_Doc,
				Request_Follow_2,
				Request_Follow_2_Type,
				Request_Follow_2_Doc,
				Request_Follow_3,
				Request_Follow_3_Type,
				Request_Follow_3_Doc,
				Request_Follow_4,
				Request_Follow_4_Type,
				Request_Follow_4_Doc,
				Initially_Received,
				Checked,
				More_Requested,
				More_Received,
				Reviewed,
				Actual_Document,
				LastEdited,
				ByWho,
				Notes_ID,
				Initially_Received_ByWho,
				More_Requested_ByWho,
				More_Received_ByWho,
				Reviewed_ByWho,
				Request_Init_ByWho,
				Request_Follow_1_ByWho,
				Request_Follow_2_ByWho,
				Request_Follow_3_ByWho,
				Request_Follow_4_ByWho,
				NotRequired,
				NotRequiredByWho,
				NotRequiredDate,
				Verified,
				VerifiedByWho,
				VerifiedWhen,
				Date_Invoice_Mailed,
				Date_Invoice_Mailed_ByWho,
				IsPortalDeleted,
				DownloadFrom,
				Download,
				IsLastUpdatedByAdvisor,
				IsCompletedByTPA
   		FROM [dbo].[PlanYearEnd_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[PlanYearEnd_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PlanYearEnd_MP]  WHERE LoopId > @LoopCounter

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