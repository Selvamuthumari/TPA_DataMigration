/*CnAPacketInfo Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--UPDATE Client_Id column
UPDATE [dbo].[CnAPacketInfo_MP]
SET [Client_Id] = um.New_ID
FROM [dbo].[CnAPacketInfo_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_Id = um.Old_ID
WHERE bc.Client_Id != -1

--UPDATE ByWho column
UPDATE [dbo].[CnAPacketInfo_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[CnAPacketInfo_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[CnAPacketInfo]
SELECT 	Client_ID,[Year],CnAPacketSentDate,ByWho
FROM CnAPacketInfo_MP

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