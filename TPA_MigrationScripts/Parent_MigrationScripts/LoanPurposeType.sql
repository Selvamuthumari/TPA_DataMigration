/*Migration Script*/
/*LoanPurposeType*/
BEGIN TRANSACTION;

BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
    @MaxId = MAX(LoopId)
FROM [dbo].[LoanPurposeType_MP]

IF ((SELECT COUNT(*)
FROM [dbo].[LoanPurposeType]) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN
        SELECT @OldID = [LoanPurposeType_ID],
            @LibName = [LoanPurposeType_Text]
        FROM [dbo].[LoanPurposeType_MP]
        WHERE LoopId = @LoopCounter
        PRINT @LibName


        IF EXISTS(SELECT 1
        FROM [dbo].[LoanPurposeType] T
        WHERE T.LoanPurposeType_Text = @LibName) 
BEGIN
            SET @NewID = (SELECT LoanPurposeType_ID
            FROM [dbo].[LoanPurposeType] T
            WHERE T.LoanPurposeType_Text = @LibName)
        END
ELSE
BEGIN
            INSERT INTO [dbo].[LoanPurposeType]
            OUTPUT Inserted.LoanPurposeType_ID INTO @IdentityValue
            SELECT LoanPurposeType_Text
            FROM [dbo].[LoanPurposeType_MP]
            WHERE LoopId = @LoopCounter
            SET @NewID = (SELECT TOP 1
                ID
            FROM @IdentityValue);
            PRINT 'Data inserted'
            DELETE FROM @IdentityValue;
        END

        IF OBJECT_ID('dbo.LoanPurposeType_ID_Mapping') IS NOT NULL
 BEGIN
            INSERT INTO [dbo].[LoanPurposeType_ID_Mapping]
            VALUES(@OldID, @NewID)
        END

        SELECT @LoopCounter  = MIN(LoopId)
        FROM [dbo].[LoanPurposeType_MP]
        WHERE LoopId > @LoopCounter

    END
END
ELSE
BEGIN
    SET IDENTITY_INSERT dbo.LoanPurposeType ON;
    INSERT INTO [dbo].[LoanPurposeType]
        (LoanPurposeType_ID, LoanPurposeType_Text)
    SELECT LoanPurposeType_ID, LoanPurposeType_Text
    FROM [dbo].[LoanPurposeType_MP]
    SET IDENTITY_INSERT dbo.LoanPurposeType OFF;
END
END TRY  
BEGIN CATCH  
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
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO  