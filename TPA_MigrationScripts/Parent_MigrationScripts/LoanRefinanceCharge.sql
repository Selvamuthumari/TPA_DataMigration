/*Migration Script*/
/*LoanRefinanceCharge*/
BEGIN TRANSACTION;

BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
    @MaxId = MAX(LoopId)
FROM [dbo].[LoanRefinanceCharge_MP]

IF ((SELECT COUNT(*)
FROM [dbo].[LoanRefinanceCharge]) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN
        SELECT @OldID = [ID],
            @LibName = [LoanRefinanceChargeAmount]
        FROM [dbo].[LoanRefinanceCharge_MP]
        WHERE LoopId = @LoopCounter
        PRINT @LibName


        IF EXISTS(SELECT 1
        FROM [dbo].[LoanRefinanceCharge] T
        WHERE T.LoanRefinanceChargeAmount = @LibName) 
BEGIN
            SET @NewID = (SELECT ID
            FROM [dbo].[LoanRefinanceCharge] T
            WHERE T.LoanRefinanceChargeAmount = @LibName)
        END
ELSE
BEGIN
            INSERT INTO [dbo].[LoanRefinanceCharge]
            OUTPUT Inserted.ID INTO @IdentityValue
            SELECT LoanRefinanceChargeAmount
            FROM [dbo].[LoanRefinanceCharge_MP]
            WHERE LoopId = @LoopCounter
            SET @NewID = (SELECT TOP 1
                ID
            FROM @IdentityValue);
            PRINT 'Data inserted'
            DELETE FROM @IdentityValue;
        END

        IF OBJECT_ID('dbo.LoanRefinanceCharge_ID_Mapping') IS NOT NULL
 BEGIN
            INSERT INTO [dbo].[LoanRefinanceCharge_ID_Mapping]
            VALUES(@OldID, @NewID)
        END

        SELECT @LoopCounter  = MIN(LoopId)
        FROM [dbo].[LoanRefinanceCharge_MP]
        WHERE LoopId > @LoopCounter

    END
END
ELSE
BEGIN
    SET IDENTITY_INSERT dbo.LoanRefinanceCharge ON;
    INSERT INTO [dbo].[LoanRefinanceCharge]
        (ID, LoanRefinanceChargeAmount)
    SELECT ID, LoanRefinanceChargeAmount
    FROM [dbo].[LoanRefinanceCharge_MP]
    SET IDENTITY_INSERT dbo.LoanRefinanceCharge OFF;
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