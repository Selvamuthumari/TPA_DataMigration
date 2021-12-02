/*Portal_ClientContactType Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[Portal_ClientContactType_MP]
SET [ClientId] = um.New_ID
FROM [dbo].[Portal_ClientContactType_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.[ClientId] = um.Old_ID
WHERE bc.[ClientId] != -1

--UPDATE ContactId column
UPDATE [dbo].[Portal_ClientContactType_MP]
SET ContactId = um.New_ID
FROM [dbo].[Portal_ClientContactType_MP] bc
JOIN [dbo].[Contacts_ID_Mapping] um ON bc.ContactId = um.Old_ID
WHERE bc.ContactId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_ClientContactType]
SELECT ClientId,
ContactId,
ContactType,
ContactTypeText
FROM Portal_ClientContactType_MP
WHERE ClientId IN (SELECT Client_ID FROM Client_Master Where Client_ID!=-1)

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