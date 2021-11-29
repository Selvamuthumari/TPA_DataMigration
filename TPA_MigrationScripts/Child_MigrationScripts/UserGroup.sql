/*UserGroup Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE SysUserID column
UPDATE [dbo].[UserGroup_MP]
SET SysUserID = um.[PPC_SysUserID]
FROM [dbo].[UserGroup_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.SysUserID=um.[MyPlans_SysUserID]
WHERE bc.SysUserID != -1

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT dbo.[UserGroup] ON;
INSERT INTO [dbo].[UserGroup]
(UserGroup_ID,
UserGroupCollection_ID,
SysUserID,
SysUserIDType)
SELECT UserGroup_ID,
UserGroupCollection_ID,
SysUserID,
SysUserIDType
FROM [UserGroup_MP]
SET IDENTITY_INSERT dbo.[UserGroup] OFF;

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