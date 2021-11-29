/*Portal_PlanQuestionnarieAnswers Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE PlanIndexId column
UPDATE [dbo].[Portal_PlanQuestionnarieAnswers_MP]
SET PlanId = um.New_ID
FROM [dbo].[Portal_PlanQuestionnarieAnswers_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanId = um.Old_ID
WHERE bc.PlanId != -1

--UPDATE Client_Id column
UPDATE [dbo].[Portal_PlanQuestionnarieAnswers_MP]
SET ClientId = um.New_ID
FROM [dbo].[Portal_PlanQuestionnarieAnswers_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.ClientId = um.Old_ID
WHERE bc.ClientId != -1

/*Portal_PlanQuestionnarieAnswers --> ByWho_Client*/
UPDATE [dbo].[Portal_PlanQuestionnarieAnswers_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_PlanQuestionnarieAnswers_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[Portal_PlanQuestionnarieAnswers_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_PlanQuestionnarieAnswers_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_PlanQuestionnarieAnswers]
SELECT ClientId,
PlanYear,
QuqetionId,
QuestionGroup,
PlanId,
Answer,
SubAnswerId,
ByWho_Client,
LastedUpdated_Client,
isFiedilityBond,
IsLastUpdatedByAdvisor
FROM [Portal_PlanQuestionnarieAnswers_MP]
WHERE ClientId IN (SELECT Client_ID FROM Client_Master WHERE Client_ID != -1)
AND QuqetionId IN (SELECT Id FROM Portal_PlanQuestionnarie)
AND QuestionGroup IN (SELECT PlanQuestionGroup_Id FROM Portal_PlanQuestionsGroup)

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