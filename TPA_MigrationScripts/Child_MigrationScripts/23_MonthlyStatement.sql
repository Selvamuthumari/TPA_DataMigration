/*MonthlyStatement Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(MonthlyStatement_ID) FROM [dbo].[MonthlyStatement]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[MonthlyStatement_ID_Mapping] ON; 
	INSERT INTO [dbo].[MonthlyStatement_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[MonthlyStatement_ID_Mapping] OFF; 


--UPDATE ByWho
UPDATE [dbo].[MonthlyStatement_MP]
SET ByWho = um.[PPC_SysUserID]
FROM [dbo].[MonthlyStatement_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE PYE_ID
UPDATE [dbo].[MonthlyStatement_MP]
SET PYE_ID = um.New_ID
FROM [dbo].[MonthlyStatement_MP] bc
JOIN [dbo].[PlanYearEnd_ID_Mapping] um ON bc.PYE_ID=um.Old_ID
WHERE bc.PYE_ID != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[MonthlyStatement]
SELECT PYE_ID,
PYE_Day,
Month01,
Received01,
Month02,
Received02,
Month03,
Received03,
Month04,
Received04,
Month05,
Received05,
Month06,
Received06,
Month07,
Received07,
Month08,
Received08,
Month09,
Received09,
Month10,
Received10,
Month11,
Received11,
Month12,
Received12,
LastEdited,
ByWho,
Month01Doc,
Month02Doc,
Month03Doc,
Month04Doc,
Month05Doc,
Month06Doc,
Month07Doc,
Month08Doc,
Month09Doc,
Month10Doc,
Month11Doc,
Month12Doc,
IsPortalDeleted,
IsLastUpdatedByAdvisor
FROM MonthlyStatement_MP
WHERE PYE_ID IN (SELECT PYE_ID FROM PlanYearEnd)

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