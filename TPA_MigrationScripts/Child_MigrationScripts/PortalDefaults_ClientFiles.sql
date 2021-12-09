/* PortalDefaults_ClientFiles */
BEGIN TRANSACTION;  
  
BEGIN TRY  


--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(FileId) FROM [dbo].[PortalDefaults_ClientFiles]);

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[PortalDefaults_ClientFiles_ID_Mapping] ON; 
	INSERT INTO [dbo].[PortalDefaults_ClientFiles_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[PortalDefaults_ClientFiles_ID_Mapping] OFF; 
 
 UPDATE PortalDefaults_ClientFiles_MP
SET ClientID = Cim.New_ID, 
FilePath = REPLACE(FilePath, CAST(Cim.Old_ID as varchar(10))+'/', CAST(Cim.New_ID as varchar(10))+'/')
FROM PortalDefaults_ClientFiles_MP Pmp
JOIN Client_Master_ID_Mapping Cim on Cim.Old_ID = Pmp.ClientID

UPDATE PortalDefaults_ClientFiles_MP
SET FolderId = Cim.New_ID
FROM PortalDefaults_ClientFiles_MP Pmp
JOIN PortalDefaults_ClientFolders_ID_Mapping Cim on Cim.Old_ID = Pmp.FolderId

DECLARE @LoopCounter INT , @MaxId INT, @ClientID NVARCHAR(100), @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[PortalDefaults_ClientFiles_MP]

IF ((SELECT COUNT(*) FROM [dbo].[PortalDefaults_ClientFiles]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
   SELECT	@OldID = [FileId],
			@ClientID = [ClientId]
   FROM [dbo].[PortalDefaults_ClientFiles_MP]  WHERE LoopId = @LoopCounter
   --PRINT @ClientID 
	IF ((SELECT COUNT(*) FROM dbo.Client_Master_ID_Mapping WHERE New_ID = @ClientID) > 0 )
	BEGIN
	INSERT INTO [dbo].[PortalDefaults_ClientFiles] OUTPUT Inserted.FileId INTO @IdentityValue
	  SELECT FolderId,
			FileName,
			FilePath,
			ClientId,
			FileSize,
			UploadDate
   		FROM [dbo].[PortalDefaults_ClientFiles_MP]  WHERE LoopId = @LoopCounter
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	PRINT 'Data inserted' 
	DELETE FROM @IdentityValue;
	END

 IF OBJECT_ID('dbo.PortalDefaults_ClientFiles_ID_Mapping') IS NOT NULL
 BEGIN
	IF(@NewID IS NOT NULL)
	BEGIN
	INSERT INTO [dbo].[PortalDefaults_ClientFiles_ID_Mapping]
	VALUES(@OldID, @NewID)  
	END
END

SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[PortalDefaults_ClientFiles_MP]  WHERE LoopId > @LoopCounter

END
END


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