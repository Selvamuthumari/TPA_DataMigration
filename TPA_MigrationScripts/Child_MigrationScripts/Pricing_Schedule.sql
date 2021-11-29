/*Pricing_Schedule Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ServiceSchedule_Lib_ID
UPDATE [dbo].[Pricing_Schedule_MP]
SET ServiceSchedule_Lib_ID = um.New_ID
FROM [dbo].[Pricing_Schedule_MP] bc
JOIN [dbo].[ServiceSchedule_Lib_ID_Mapping] um ON bc.ServiceSchedule_Lib_ID=um.Old_ID
WHERE bc.ServiceSchedule_Lib_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[Pricing_Schedule_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[Pricing_Schedule_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE LockedByWho column
UPDATE [dbo].[Pricing_Schedule_MP]
SET LockedByWho = um.[PPC_SysUserID]
FROM [dbo].[Pricing_Schedule_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.LockedByWho=um.[MyPlans_SysUserID]
WHERE bc.LockedByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT [dbo].[Pricing_Schedule] ON;
INSERT INTO [dbo].[Pricing_Schedule]
(Pricing_Schedule_ID,
ServiceSchedule_Lib_ID,
First_Active_Year,
Last_Active_Year,
AdditionalService_Description,
Min_Participants,
Max_Participants,
Base_Fee,
Per_Participant_Fee,
Per_Key_Employee,
Per_Partner_Spouse,
Individual_Quote,
LastTouched,
ByWho,
Locked,
LockedByWho,
LockedWhen)
SELECT Pricing_Schedule_ID,
ServiceSchedule_Lib_ID,
First_Active_Year,
Last_Active_Year,
AdditionalService_Description,
Min_Participants,
Max_Participants,
Base_Fee,
Per_Participant_Fee,
Per_Key_Employee,
Per_Partner_Spouse,
Individual_Quote,
LastTouched,
ByWho,
Locked,
LockedByWho,
LockedWhen
FROM [Pricing_Schedule_MP]
SET IDENTITY_INSERT [dbo].[Pricing_Schedule] OFF;

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