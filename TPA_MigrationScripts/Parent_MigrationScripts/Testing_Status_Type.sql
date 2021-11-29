/*Migration Script*/
/*Testing_Status_Type*/
BEGIN TRANSACTION;

BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
    @MaxId = MAX(LoopId)
FROM [dbo].[Testing_Status_Type_MP]

IF ((SELECT COUNT(*)
FROM [dbo].[Testing_Status_Type]) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN
        SELECT @OldID = [Testing_Status_Type_ID],
            @LibName = [Testing_Status_Type_Text]
        FROM [dbo].[Testing_Status_Type_MP]
        WHERE LoopId = @LoopCounter
        PRINT @LibName


        IF EXISTS(SELECT 1
        FROM [dbo].[Testing_Status_Type] T
        WHERE T.Testing_Status_Type_Text = @LibName) 
BEGIN
            SET @NewID = (SELECT Testing_Status_Type_ID
            FROM [dbo].[Testing_Status_Type] T
            WHERE T.Testing_Status_Type_Text = @LibName)
        END
ELSE
BEGIN
            INSERT INTO [dbo].[Testing_Status_Type]
            OUTPUT Inserted.Testing_Status_Type_ID INTO @IdentityValue
            SELECT Testing_Status_Type_Text, Testing_Color
            FROM [dbo].[Testing_Status_Type_MP]
            WHERE LoopId = @LoopCounter
            SET @NewID = (SELECT TOP 1
                ID
            FROM @IdentityValue);
            PRINT 'Data inserted'
            DELETE FROM @IdentityValue;
        END

        IF OBJECT_ID('dbo.Testing_Status_Type_ID_Mapping') IS NOT NULL
 BEGIN
            INSERT INTO [dbo].[Testing_Status_Type_ID_Mapping]
            VALUES(@OldID, @NewID)
        END

        SELECT @LoopCounter  = MIN(LoopId)
        FROM [dbo].[Testing_Status_Type_MP]
        WHERE LoopId > @LoopCounter

    END
END
ELSE
BEGIN
    SET IDENTITY_INSERT dbo.Testing_Status_Type ON;
    INSERT INTO [dbo].[Testing_Status_Type]
        (Testing_Status_Type_ID, Testing_Status_Type_Text, Testing_Color)
    SELECT Testing_Status_Type_ID, Testing_Status_Type_Text, Testing_Color
    FROM [dbo].[Testing_Status_Type_MP]
    SET IDENTITY_INSERT dbo.Testing_Status_Type OFF;
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