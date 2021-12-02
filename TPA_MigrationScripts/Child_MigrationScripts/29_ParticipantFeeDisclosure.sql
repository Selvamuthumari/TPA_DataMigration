/*ParticipantFeeDisclosure Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[ParticipantFeeDisclosure_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[ParticipantFeeDisclosure_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[ParticipantFeeDisclosure]
SELECT loan_org_change,
		loan_on_sdbac,
		refinanced_loan_org,
		distribution,
		distribution_on_sdbac,
		1099R_preparation,
		qdro_consulting,
		client_id,
		is_dc_plan,
		is_db_plan,
		created_date,
		NoticeDueDate
FROM [ParticipantFeeDisclosure_MP]
WHERE client_id IN (SELECT Client_ID FROM Client_Master WHERE Client_ID != -1)

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