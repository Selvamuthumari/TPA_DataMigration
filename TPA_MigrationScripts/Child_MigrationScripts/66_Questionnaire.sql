/*Questionnaire Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[Questionnaire_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Questionnaire_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[Questionnaire] ON;
INSERT INTO [dbo].[Questionnaire]
(Questionnaire_ID,
Questionnaire_Group,
Questionnaire_Index,
Questionnaire_Label,
Questionnaire_Text,
AskYN,
AskOther,
PlanType_Qualifier,
LastTouched,
ByWho,
Questionnaire_Hint)
SELECT 
Questionnaire_ID,
Questionnaire_Group,
Questionnaire_Index,
Questionnaire_Label,
Questionnaire_Text,
AskYN,
AskOther,
PlanType_Qualifier,
LastTouched,
ByWho,
Questionnaire_Hint
FROM [Questionnaire_MP]
SET IDENTITY_INSERT dbo.[Questionnaire] OFF;

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