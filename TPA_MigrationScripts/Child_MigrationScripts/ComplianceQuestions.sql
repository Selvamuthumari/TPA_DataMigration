/*ComplianceQuestions Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[ComplianceQuestions_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[ComplianceQuestions_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[ComplianceQuestions]
SELECT Questionnaire_Group,
Questionnaire_Type,
Plan_Restrictions,
BusinessType_Restrictions,
Effective_Year,
Last_Effective_Year,
Question_Text,
Question_Hint,
AskYN,
AskAmount,
AskText,
AskDate,
SectionLabel,
Position,
LastTouched,
ByWho
FROM ComplianceQuestions_MP

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