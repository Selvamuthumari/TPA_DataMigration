/*WaitingItem Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Client_Id column
UPDATE [dbo].[WaitingItem_MP]
SET Client_ID = um.New_ID
FROM [dbo].[WaitingItem_MP] bc
JOIN [dbo].[Client_Master_ID_Mapping] um ON bc.Client_ID = um.Old_ID
WHERE bc.Client_ID != -1

--UPDATE PlanIndexId column
UPDATE [dbo].[WaitingItem_MP]
SET Plans_Index_Id = um.New_ID
FROM [dbo].[WaitingItem_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_Id = um.Old_ID
WHERE bc.Plans_Index_Id != -1

--UPDATE ByWho column
UPDATE [dbo].[WaitingItem_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[WaitingItem_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[WaitingItem] ON;
INSERT INTO [dbo].[WaitingItem]
(WaitingItem_ID,
Client_ID,
Plans_Index_ID,
ContactAdvisor,
Subject_Line,
Response_Date,
Expiration_Date,
Completed,
Notes,
lastTouched,
ByWho)
SELECT WaitingItem_ID,
Client_ID,
Plans_Index_ID,
ContactAdvisor,
Subject_Line,
Response_Date,
Expiration_Date,
Completed,
Notes,
lastTouched,
ByWho
FROM [WaitingItem_MP]
SET IDENTITY_INSERT dbo.[WaitingItem] OFF;

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