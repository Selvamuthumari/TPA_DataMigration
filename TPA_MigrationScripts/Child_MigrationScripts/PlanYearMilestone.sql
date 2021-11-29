/*PlanYearMilestone Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE PlanIndexId column
UPDATE [dbo].[PlanYearMilestone_MP]
SET Plans_Index_Id = um.New_ID
FROM [dbo].[PlanYearMilestone_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_Id = um.Old_ID
WHERE bc.Plans_Index_Id != -1

--UPDATE ByWho column
UPDATE [dbo].[PlanYearMilestone_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[PlanYearMilestone_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PlanYearMilestone]
SELECT TrackingMilestone_Type_Id,
		PYE_Year,
		PYE_Month,
		Note_Id,
		DueDate,
		Completed,
		CompletedBy,
		CompletedDate,
		WaitingOnClient,
		WaitingOnClientDatetime,
		ReceivedFromclient,
		ReceivedFromClientDatetime,
		LastEdited,
		Plans_Index_ID,
		ByWho
FROM [PlanYearMilestone_MP]
WHERE Plans_Index_ID IN (SELECT Plans_Index_ID FROM Plans WHERE Plans_Index_ID != -1)

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