/*Migration Script*/
/*Questionnaire_Group*/
BEGIN TRANSACTION;

BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[Questionnaire_Group_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Questionnaire_Group_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
    @MaxId = MAX(LoopId)
FROM [dbo].[Questionnaire_Group_MP]

IF ((SELECT COUNT(*)
FROM [dbo].[Questionnaire_Group]) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN
        SELECT @OldID = [Questionnaire_Group_ID],
            @LibName = [Questionnaire_Group_Text]
        FROM [dbo].[Questionnaire_Group_MP]
        WHERE LoopId = @LoopCounter
        PRINT @LibName


        IF EXISTS(SELECT 1
        FROM [dbo].[Questionnaire_Group] T
        WHERE T.Questionnaire_Group_Text = @LibName) 
BEGIN
            SET @NewID = (SELECT Questionnaire_Group_ID
            FROM [dbo].[Questionnaire_Group] T
            WHERE T.Questionnaire_Group_Text = @LibName)
        END
ELSE
BEGIN
            INSERT INTO [dbo].[Questionnaire_Group]
            OUTPUT Inserted.Questionnaire_Group_ID INTO @IdentityValue
            SELECT 
Questionnaire_Group_Text,
Plan_Year,
LastTouched,
ByWho
            FROM [dbo].[Questionnaire_Group_MP]
            WHERE LoopId = @LoopCounter
            SET @NewID = (SELECT TOP 1
                ID
            FROM @IdentityValue);
            PRINT 'Data inserted'
            DELETE FROM @IdentityValue;
        END

        IF OBJECT_ID('dbo.Questionnaire_Group_ID_Mapping') IS NOT NULL
 BEGIN
            INSERT INTO [dbo].[Questionnaire_Group_ID_Mapping]
            VALUES(@OldID, @NewID)
        END

        SELECT @LoopCounter  = MIN(LoopId)
        FROM [dbo].[Questionnaire_Group_MP]
        WHERE LoopId > @LoopCounter

    END
END
ELSE
BEGIN
    SET IDENTITY_INSERT dbo.Questionnaire_Group ON;
    INSERT INTO [dbo].[Questionnaire_Group]
        (Questionnaire_Group_ID,
		Questionnaire_Group_Text,
Plan_Year,
LastTouched,
ByWho)
    SELECT Questionnaire_Group_ID,
	Questionnaire_Group_Text,
Plan_Year,
LastTouched,
ByWho
    FROM [dbo].[Questionnaire_Group_MP]
    SET IDENTITY_INSERT dbo.Questionnaire_Group OFF;
END
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

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO  