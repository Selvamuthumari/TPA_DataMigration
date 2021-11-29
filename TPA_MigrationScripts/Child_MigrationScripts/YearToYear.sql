/*YearToYear tables Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[YearToYear_Answers_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[YearToYear_Answers_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

INSERT INTO [dbo].[YearToYear_Answers]
SELECT YearToYear_Header_ID,
YearToYear_Questions_ID,
Text_Res,
YN_Res,
Int_Res,
Float_Res,
DateTime_Res,
LastTouched,
ByWho FROM [dbo].[YearToYear_Answers_MP]

INSERT INTO [dbo].[YearToYear_Group]
SELECT YearToYear_Group_Label,
PlanRestriction,
LastTouched,
ByWho FROM [dbo].[YearToYear_Group_MP]

--UPDATE PlanIndexId column
UPDATE [dbo].[YearToYear_Header_MP]
SET Plans_Index_Id = um.New_ID
FROM [dbo].[YearToYear_Header_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_Id = um.Old_ID
WHERE bc.Plans_Index_Id != -1

INSERT INTO [dbo].[YearToYear_Header]
SELECT Plans_Index_ID,
PYE_Year,
ActivePlanYear,
LastTouched,
ByWho FROM [dbo].[YearToYear_Header_MP]

--UPDATE ByWho column
UPDATE [dbo].[YearToYear_Questions_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[YearToYear_Questions_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

INSERT INTO [dbo].[YearToYear_Questions]
SELECT YearToYear_Group_ID,
YearToYear_Questions_Label,
YearToYear_Questions_Hint,
YearToYear_Questions_Type,
YearToYear_Questions_Ref,
YearToYear_Questions_Param,
EffectiveYear,
FinalYear,
Position,
LastTouched,
ByWho FROM [dbo].[YearToYear_Questions_MP]

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