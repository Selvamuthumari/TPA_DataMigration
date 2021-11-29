/*Migration Script*/
/*TemplateEmail*/
BEGIN TRANSACTION;

BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[TemplateEmail_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[TemplateEmail_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
    @MaxId = MAX(LoopId)
FROM [dbo].[TemplateEmail_MP]

IF ((SELECT COUNT(*)
FROM [dbo].[TemplateEmail]) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN
        SELECT @OldID = [Template_ID],
            @LibName = [Template_Type]
        FROM [dbo].[TemplateEmail_MP]
        WHERE LoopId = @LoopCounter
        PRINT @LibName


        IF EXISTS(SELECT 1
        FROM [dbo].[TemplateEmail] T
        WHERE T.Template_Type = @LibName) 
BEGIN
            SET @NewID = (SELECT Template_ID
            FROM [dbo].[TemplateEmail] T
            WHERE T.Template_Type = @LibName)
        END
ELSE
BEGIN
            INSERT INTO [dbo].[TemplateEmail]
            OUTPUT Inserted.Template_ID INTO @IdentityValue
            SELECT 
Template_Type,
Template_Text,
Email_Sub,
lastTouched,
byWho
            FROM [dbo].[TemplateEmail_MP]
            WHERE LoopId = @LoopCounter
            SET @NewID = (SELECT TOP 1
                ID
            FROM @IdentityValue);
            PRINT 'Data inserted'
            DELETE FROM @IdentityValue;
        END

        IF OBJECT_ID('dbo.TemplateEmail_ID_Mapping') IS NOT NULL
 BEGIN
            INSERT INTO [dbo].[TemplateEmail_ID_Mapping]
            VALUES(@OldID, @NewID)
        END

        SELECT @LoopCounter  = MIN(LoopId)
        FROM [dbo].[TemplateEmail_MP]
        WHERE LoopId > @LoopCounter

    END
END
ELSE
BEGIN
    SET IDENTITY_INSERT dbo.TemplateEmail ON;
    INSERT INTO [dbo].[TemplateEmail]
        (Template_ID,
Template_Type,
Template_Text,
Email_Sub,
lastTouched,
byWho)
    SELECT Template_ID,
Template_Type,
Template_Text,
Email_Sub,
lastTouched,
byWho
    FROM [dbo].[TemplateEmail_MP]
    SET IDENTITY_INSERT dbo.TemplateEmail OFF;
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