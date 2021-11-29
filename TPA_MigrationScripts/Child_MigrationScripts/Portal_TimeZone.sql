/*Portal_TimeZone Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE UserID column
UPDATE [dbo].[Portal_TimeZone_MP]
SET UserID = um.[PPC_SysUserID]
FROM [dbo].[Portal_TimeZone_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.UserID=um.[MyPlans_SysUserID]
WHERE bc.UserID != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_TimeZone]
SELECT UserId,
SundayIsAvailble,
SundayInTime,
SundayOutTime,
MondayIsAvailble,
MondayInTime,
MondayOutTime,
TuesdayIsAvailble,
TuesdayInTime,
TuesdayOutTime,
WedIsAvailble,
WedInTime,
WedOutTime,
ThurIsAvailble,
ThurInTime,
ThurOutTime,
FriIsAvailble,
FriInTime,
FriOutTime,
SatAvailble,
SatInTime,
SatOutTime,
TimeZoneId,
TimeZoneText,
UpdatedBy
FROM [Portal_TimeZone_MP]

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