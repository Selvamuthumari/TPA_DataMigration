/* PortalDefaults_ClientFolders */
BEGIN TRANSACTION;  
  
BEGIN TRY  

 
DECLARE @LoopCounter INT , @MaxId INT, @LibName NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PortalDefaults_ClientFolders_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PortalDefaults_ClientFolders]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [FolderId],
			@LibName = [FolderName]
   FROM [dbo].[PortalDefaults_ClientFolders_MP]  WHERE LoopId = @LoopCounter
   PRINT @LibName 

IF EXISTS(SELECT 1 FROM [dbo].[PortalDefaults_ClientFolders] T 
              WHERE T.FolderName NOT LIKE '%{dynamicPlanFolder~%' AND T.FolderName = @LibName) 
BEGIN
    SET @NewID = (SELECT FolderId FROM [dbo].[PortalDefaults_ClientFolders] T 
              WHERE T.FolderName NOT LIKE '%{dynamicPlanFolder~%' AND T.FolderName = @LibName)
END
ELSE
BEGIN
	INSERT INTO [dbo].[PortalDefaults_ClientFolders] OUTPUT Inserted.FolderId INTO @IdentityValue
	  SELECT FolderName
   		FROM [dbo].[PortalDefaults_ClientFolders_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
END

 IF OBJECT_ID('dbo.PortalDefaults_ClientFolders_ID_Mapping') IS NOT NULL
 BEGIN
	INSERT INTO [dbo].[PortalDefaults_ClientFolders_ID_Mapping]
	VALUES(@OldID, @NewID)   
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PortalDefaults_ClientFolders_MP]  WHERE LoopId > @LoopCounter

END
END


IF OBJECT_ID('dbo.PortalDefaults_ClientFolders_ID_Mapping') IS NOT NULL
BEGIN
UPDATE PortalDefaults_ClientFolders_MP
SET ParentFolderId = Cim.New_ID
FROM PortalDefaults_ClientFolders_MP Pmp
JOIN PortalDefaults_ClientFolders_ID_Mapping Cim on Cim.Old_ID = Pmp.ParentFolderId
END

IF OBJECT_ID('dbo.Plans_ID_Mapping') IS NOT NULL
BEGIN
UPDATE PortalDefaults_ClientFolders_MP
SET FolderName = '{dynamicPlanFolder~'+CAST(Cim.New_ID as varchar(10))+'}'
FROM PortalDefaults_ClientFolders_MP Pmp
JOIN Plans_ID_Mapping Cim on Cim.Old_ID = SUBSTRING(FolderName, PATINDEX('%[0-9]%', FolderName), PATINDEX('%[0-9][^0-9]%', FolderName + 't') - PATINDEX('%[0-9]%',  FolderName) + 1)
WHERE FolderName LIKE '%{dynamicPlanFolder~%'
END

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalDefaults_ClientFolders]
SELECT FolderName,
ParentFolderId,
DisplayName,
IsDefault,
LastUpdatedDate,
LastUpdatedBy,
IsFile,
FileNamingConvention,
FileFriendlyName,
FileNamingParameters
FROM PortalDefaults_ClientFolders_MP

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