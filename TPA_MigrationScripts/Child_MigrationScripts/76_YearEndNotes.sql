/*YearEndNotes Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[YearEndNotes_MP]
SET Client_ID = um.New_ID
FROM [dbo].[YearEndNotes_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_ID = um.Old_ID
WHERE bc.Client_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[YearEndNotes_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[YearEndNotes_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--CreatedByWho
UPDATE [dbo].[YearEndNotes_MP]
SET CreatedByWho = um.[PPC_SysUserID]
FROM [dbo].[YearEndNotes_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.CreatedByWho=um.[MyPlans_SysUserID]
WHERE bc.CreatedByWho != -1

--Reviewed_ByWho
UPDATE [dbo].[YearEndNotes_MP]
SET Reviewed_ByWho = um.[PPC_SysUserID]
FROM [dbo].[YearEndNotes_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Reviewed_ByWho=um.[MyPlans_SysUserID]
WHERE bc.Reviewed_ByWho != -1


--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[YearEndNotes] ON;
INSERT INTO [dbo].[YearEndNotes]
(YearEndNotes_ID,
Client_ID,
PYE_Year,
Plan_Number,
YEN_Category,
Reviewed_ByWho,
Reviewed_When,
General_Notes,
Action_Required,
Reviewer_Notes,
Resolved,
Carry_Over,
CreatedByWho,
CreatedWhen,
LastTouched,
ByWho)
SELECT YearEndNotes_ID,
Client_ID,
PYE_Year,
Plan_Number,
YEN_Category,
Reviewed_ByWho,
Reviewed_When,
General_Notes,
Action_Required,
Reviewer_Notes,
Resolved,
Carry_Over,
CreatedByWho,
CreatedWhen,
LastTouched,
ByWho
FROM [YearEndNotes_MP]
SET IDENTITY_INSERT dbo.[YearEndNotes] OFF;

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