/*Question Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[Question_MP]
SET Client_ID = um.New_ID
FROM [dbo].[Question_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_ID = um.Old_ID
WHERE bc.Client_ID != -1

--UPDATE PlanIndexId column
UPDATE [dbo].[Question_MP]
SET Plans_Index_ID = um.New_ID
FROM [dbo].[Question_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_ID = um.Old_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[Question_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Question_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[Question] ON;
INSERT INTO [dbo].[Question]
(Question_ID,
Client_ID,
Plans_Index_ID,
Plan_Year,
Questionnaire_ID,
YN_Result,
Other_Result,
LastTouched,
ByWho,
Questionnaire_Group_ID)
SELECT 
Question_ID,
Client_ID,
Plans_Index_ID,
Plan_Year,
Questionnaire_ID,
YN_Result,
Other_Result,
LastTouched,
ByWho,
Questionnaire_Group_ID
FROM [Question_MP]
SET IDENTITY_INSERT dbo.[Question] OFF;

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