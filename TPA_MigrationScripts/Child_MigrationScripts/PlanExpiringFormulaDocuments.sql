/*PlanExpiringFormulaDocuments Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE PlanIndexId column
UPDATE [dbo].[PlanExpiringFormulaDocuments_MP]
SET PlanIndexId = um.New_ID
FROM [dbo].[PlanExpiringFormulaDocuments_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.PlanIndexId = um.Old_ID
WHERE bc.PlanIndexId != -1

--UPDATE documentId
UPDATE [dbo].[PlanExpiringFormulaDocuments_MP]
SET documentId = um.New_ID
FROM [dbo].[PlanExpiringFormulaDocuments_MP] bc
JOIN [dbo].[Documents_ID_Mapping] um ON bc.documentId = um.Old_ID
WHERE bc.documentId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PlanExpiringFormulaDocuments]
SELECT PlanIndexId,
		PlanYear,
		documentId,
		documentTypeId,
		CreatedDate,
		UpdatedDate
FROM [PlanExpiringFormulaDocuments_MP]
WHERE PlanIndexId IN (SELECT PlanIndexId FROM Plans WHERE PlanIndexId != -1)

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