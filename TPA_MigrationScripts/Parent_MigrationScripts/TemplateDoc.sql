/*Migration Script*/
/*TemplateDoc*/
BEGIN TRANSACTION;

BEGIN TRY  

--UPDATE ByWho column
UPDATE [dbo].[TemplateDoc_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[TemplateDoc_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
    @MaxId = MAX(LoopId)
FROM [dbo].[TemplateDoc_MP]

IF ((SELECT COUNT(*)
FROM [dbo].[TemplateDoc]) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN
        SELECT @OldID = [Template_ID],
            @LibName = [Document_Type]
        FROM [dbo].[TemplateDoc_MP]
        WHERE LoopId = @LoopCounter
        PRINT @LibName


        IF EXISTS(SELECT 1
        FROM [dbo].[TemplateDoc] T
        WHERE T.Document_Type = @LibName) 
BEGIN
            SET @NewID = (SELECT Template_ID
            FROM [dbo].[TemplateDoc] T
            WHERE T.Document_Type = @LibName)
        END
ELSE
BEGIN
            INSERT INTO [dbo].[TemplateDoc]
            OUTPUT Inserted.Template_ID INTO @IdentityValue
            SELECT 
Document_Type,
Document_Text,
lastTouched,
byWho
            FROM [dbo].[TemplateDoc_MP]
            WHERE LoopId = @LoopCounter
            SET @NewID = (SELECT TOP 1
                ID
            FROM @IdentityValue);
            PRINT 'Data inserted'
            DELETE FROM @IdentityValue;
        END

        IF OBJECT_ID('dbo.TemplateDoc_ID_Mapping') IS NOT NULL
 BEGIN
            INSERT INTO [dbo].[TemplateDoc_ID_Mapping]
            VALUES(@OldID, @NewID)
        END

        SELECT @LoopCounter  = MIN(LoopId)
        FROM [dbo].[TemplateDoc_MP]
        WHERE LoopId > @LoopCounter

    END
END
ELSE
BEGIN
    SET IDENTITY_INSERT dbo.TemplateDoc ON;
    INSERT INTO [dbo].[TemplateDoc]
        (Template_ID,
Document_Type,
Document_Text,
lastTouched,
byWho)
    SELECT Template_ID,
Document_Type,
Document_Text,
lastTouched,
byWho
    FROM [dbo].[TemplateDoc_MP]
    SET IDENTITY_INSERT dbo.TemplateDoc OFF;
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