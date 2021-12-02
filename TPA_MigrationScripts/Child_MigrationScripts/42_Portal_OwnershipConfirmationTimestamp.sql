/*Portal_OwnershipConfirmationTimestamp Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET [ClientId] = um.New_ID
FROM [dbo].[Portal_OwnershipConfirmationTimestamp_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.ClientId = um.Old_ID
WHERE bc.ClientId != -1

/*OwnershipLastUpdatedBy*/
UPDATE [dbo].[Portal_OwnershipConfirmationTimestamp_MP]
SET OwnershipLastUpdatedBy=UM.PPC_SysUserID
FROM [dbo].[Portal_OwnershipConfirmationTimestamp_MP] PMP
JOIN [dbo].[UserID_Mapping] UM ON PMP.OwnershipLastUpdatedBy = UM.MyPlans_SysUserID
WHERE PMP.OwnershipLastUpdatedBy != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_OwnershipConfirmationTimestamp]
SELECT ClientId,
OwnershipLastUpdatedBy,
OwnershipLastUpdatedDate,
IsLastUpdateByAdvisor
FROM Portal_OwnershipConfirmationTimestamp_MP
WHERE ClientID IN (SELECT Client_ID FROM Client_Master)

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