/*Migration Script*/
/*Portal_ReportingElement*/
BEGIN TRANSACTION;

BEGIN TRY  
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
    @MaxId = MAX(LoopId)
FROM [dbo].[Portal_ReportingElement_MP]

IF ((SELECT COUNT(*)
FROM [dbo].[Portal_ReportingElement]) > 0)
BEGIN
    WHILE ( @LoopCounter IS NOT NULL
        AND @LoopCounter <= @MaxId)
BEGIN
        SELECT @OldID = ID,
            @LibName = ReportingElement
        FROM [dbo].[Portal_ReportingElement_MP]
        WHERE LoopId = @LoopCounter
        PRINT @LibName


        IF EXISTS(SELECT 1
        FROM [dbo].[Portal_ReportingElement] T
        WHERE T.ReportingElement = @LibName) 
BEGIN
            SET @NewID = (SELECT ID
            FROM [dbo].[Portal_ReportingElement] T
            WHERE T.ReportingElement = @LibName)
        END
ELSE
BEGIN
            INSERT INTO [dbo].[Portal_ReportingElement]
            OUTPUT Inserted.ID INTO @IdentityValue
            SELECT 
ReportingElement,
ShortText,
ShowToClient,
AllowManualUpdate,
Weight,
SequenceReportingElement,
IsDeleted,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate,
Version,
ParentId,
RequiredForDBPlans,
RequiredForDCPlans
            FROM [dbo].[Portal_ReportingElement_MP]
            WHERE LoopId = @LoopCounter
            SET @NewID = (SELECT TOP 1
                ID
            FROM @IdentityValue);
            PRINT 'Data inserted'
            DELETE FROM @IdentityValue;
        END

        IF OBJECT_ID('dbo.Portal_ReportingElement_ID_Mapping') IS NOT NULL
 BEGIN
            INSERT INTO [dbo].[Portal_ReportingElement_ID_Mapping]
            VALUES(@OldID, @NewID)
        END

        SELECT @LoopCounter  = MIN(LoopId)
        FROM [dbo].[Portal_ReportingElement_MP]
        WHERE LoopId > @LoopCounter

    END
END
ELSE
BEGIN
    SET IDENTITY_INSERT dbo.Portal_ReportingElement ON;
    INSERT INTO [dbo].[Portal_ReportingElement]
        (ID,
ReportingElement,
ShortText,
ShowToClient,
AllowManualUpdate,
Weight,
SequenceReportingElement,
IsDeleted,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate,
Version,
ParentId,
RequiredForDBPlans,
RequiredForDCPlans)
    SELECT ID,
ReportingElement,
ShortText,
ShowToClient,
AllowManualUpdate,
Weight,
SequenceReportingElement,
IsDeleted,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate,
Version,
ParentId,
RequiredForDBPlans,
RequiredForDCPlans
    FROM [dbo].[Portal_ReportingElement_MP]
    SET IDENTITY_INSERT dbo.Portal_ReportingElement OFF;
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