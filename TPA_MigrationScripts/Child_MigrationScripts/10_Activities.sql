/*Activities Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[Activities_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Activities_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE ScheduledBy column
UPDATE [dbo].[Activities_MP]
SET ScheduledBy = um.[PPC_SysUserID]
FROM [dbo].[Activities_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ScheduledBy=um.[MyPlans_SysUserID]
WHERE bc.ScheduledBy != -1

--UPDATE Notes column
UPDATE [dbo].[Activities_MP]
SET Notes_ID = um.[New_ID]
FROM [dbo].[Activities_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Notes_ID=um.[Old_ID]
WHERE bc.Notes_ID != -1

--UPDATE Client_ID column
UPDATE [dbo].[Activities_MP]
SET Client_ID = um.[New_ID]
FROM [dbo].[Activities_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_ID=um.[Old_ID]
WHERE bc.Client_ID != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Activities]
SELECT Activity_Type,
StartDate,
StartTime,
Duration,
DurationUnits,
ScheduleWith,
ScheduleWithType,
Client_ID,
Regarding,
LocationCode,
Location,
ScheduledBy,
ScheduledDate,
ScheduledForGroup,
ShowAlarm,
AlarmDelay,
AlarmDelayUnits,
Recurrence_ID,
Original_Activity_ID,
Result,
LinkedActivity,
Notes_ID,
LastTouched,
ByWho,
IsDeletedFromOutlook,
IsLastUpdatedByAdvisor
FROM Activities_MP

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