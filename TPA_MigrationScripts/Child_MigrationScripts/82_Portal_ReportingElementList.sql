
/*Portal_ReportingElementList Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE ParentRepotingElementId column
UPDATE [dbo].[Portal_ReportingElementList_MP]
SET ParentRepotingElementId = um.New_ID
FROM [dbo].[Portal_ReportingElementList_MP] bc
JOIN [dbo].[Portal_ReportingElement_ID_Mapping] um ON bc.ParentRepotingElementId = um.Old_ID
WHERE bc.ParentRepotingElementId != -1

--UPDATE ChildRepotingElementId column
UPDATE [dbo].[Portal_ReportingElementList_MP]
SET ChildRepotingElementId = um.New_ID
FROM [dbo].[Portal_ReportingElementList_MP] bc
JOIN [dbo].[Portal_ReportingElement_ID_Mapping] um ON bc.ChildRepotingElementId = um.Old_ID
WHERE bc.ChildRepotingElementId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_ReportingElementList]
SELECT ElementId,
ElementActualId,
ElementName,
ParentRepotingElementId,
ParentRepotingElementName,
ChildRepotingElementId,
ChildRepotingElementName
FROM [Portal_ReportingElementList_MP]

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