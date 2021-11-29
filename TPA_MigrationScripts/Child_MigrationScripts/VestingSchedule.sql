/*VestingSchedule Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[VestingSchedule_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[VestingSchedule_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[VestingSchedule] ON;
INSERT INTO [dbo].[VestingSchedule]
(VestingSchedule_ID,
VestingSchedule_Name,
Vesting_Set_1,
Vesting_Percent_1,
Vesting_Set_2,
Vesting_Percent_2,
Vesting_Set_3,
Vesting_Percent_3,
Vesting_Set_4,
Vesting_Percent_4,
Vesting_Set_5,
Vesting_Percent_5,
Vesting_Set_6,
Vesting_Percent_6,
Vesting_Set_7,
Vesting_Percent_7,
LastEdited,
ByWho)
SELECT VestingSchedule_ID,
VestingSchedule_Name,
Vesting_Set_1,
Vesting_Percent_1,
Vesting_Set_2,
Vesting_Percent_2,
Vesting_Set_3,
Vesting_Percent_3,
Vesting_Set_4,
Vesting_Percent_4,
Vesting_Set_5,
Vesting_Percent_5,
Vesting_Set_6,
Vesting_Percent_6,
Vesting_Set_7,
Vesting_Percent_7,
LastEdited,
ByWho
FROM [VestingSchedule_MP]
SET IDENTITY_INSERT dbo.[VestingSchedule] OFF;

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