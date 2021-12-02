/*Relationships Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Contact_Id column
UPDATE [dbo].[Relationships_MP]
SET [Contact_Id] = um.New_ID
FROM [dbo].[Relationships_MP] bc
JOIN [dbo].[Contacts_Id_Mapping] um ON bc.Contact_Id = um.Old_ID
WHERE bc.Contact_Id != -1

--UPDATE ByWho column
UPDATE [dbo].[Relationships_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Relationships_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Relationships]
SELECT Contact_ID,
Relative,
RelRelationship,
RelTermDate,
LastEdited,
ByWho
FROM [Relationships_MP]
WHERE Contact_ID IN (SELECT Contact_ID FROM Contacts)

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