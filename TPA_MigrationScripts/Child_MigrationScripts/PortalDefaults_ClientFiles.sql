/*PortalDefaults_ClientFiles*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

IF OBJECT_ID('dbo.Client_Master_ID_Mapping') IS NOT NULL
BEGIN
UPDATE PortalDefaults_ClientFiles_MP
SET ClientID = Cim.New_ID, FilePath = REPLACE(FilePath, CAST(Cim.Old_ID as varchar(10))+'/', CAST(Cim.New_ID as varchar(10))+'/')
FROM PortalDefaults_ClientFiles_MP Pmp
JOIN Client_Master_ID_Mapping Cim on Cim.Old_ID = Pmp.ClientID
END

/* Update table query */
IF OBJECT_ID('dbo.PortalDefaults_ClientFolders_ID_Mapping') IS NOT NULL
BEGIN
UPDATE PortalDefaults_ClientFiles_MP
SET FolderId = Cim.New_ID
FROM PortalDefaults_ClientFiles_MP Pmp
JOIN PortalDefaults_ClientFolders_ID_Mapping Cim on Cim.Old_ID = Pmp.FolderId
END

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalDefaults_ClientFiles]
SELECT FolderId,
FileName,
FilePath,
ClientId,
FileSize,
UploadDate
FROM PortalDefaults_ClientFiles_MP

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