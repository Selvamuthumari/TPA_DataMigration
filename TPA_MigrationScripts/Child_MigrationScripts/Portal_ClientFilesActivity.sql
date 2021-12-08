/*Portal_ClientFilesActivity */

--UPDATE FileID
UPDATE Portal_ClientFilesActivity_MP
SET FileId = Cim.New_ID
FROM Portal_ClientFilesActivity_MP Pmp
JOIN PortalDefaults_ClientFiles_ID_Mapping Cim on Cim.Old_ID = Pmp.FileId

--UPDATE ClientId & FilePath
 UPDATE Portal_ClientFilesActivity_MP
SET ClientID = Cim.New_ID, 
FilePath = REPLACE(FilePath, CAST(Cim.Old_ID as varchar(10))+'/', CAST(Cim.New_ID as varchar(10))+'/')
FROM Portal_ClientFilesActivity_MP Pmp
JOIN Client_Master_ID_Mapping Cim on Cim.Old_ID = Pmp.ClientID

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_ClientFilesActivity]
SELECT FileId,
FileName,
FilePath,
Activity,
ActivityDate,
UserType,
UserEmail,
CompanyName,
IpAddress,
Location,
ClientId
FROM Portal_ClientFilesActivity_MP
