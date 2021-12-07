/* Update table query */
/*childtable ---- parenttable*/
/*PortalDefaults_MappingClientFoldersPlan ---- Plans*/
IF OBJECT_ID('dbo.Plans_ID_Mapping') IS NOT NULL
BEGIN
UPDATE PortalDefaults_MappingClientFoldersPlan_MP
SET Plans_Index_ID = Cim.New_ID
FROM PortalDefaults_MappingClientFoldersPlan_MP Pmp
JOIN Plans_ID_Mapping Cim on Cim.Old_ID = Pmp.Plans_Index_ID
END

/* Update table query */
IF OBJECT_ID('dbo.PortalDefaults_ClientFolders_ID_Mapping') IS NOT NULL
BEGIN
UPDATE PortalDefaults_MappingClientFoldersPlan_MP
SET FolderId = Cim.New_ID
FROM PortalDefaults_MappingClientFoldersPlan_MP Pmp
JOIN PortalDefaults_ClientFolders_ID_Mapping Cim on Cim.Old_ID = Pmp.FolderId
END

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[PortalDefaults_MappingClientFoldersPlan]
SELECT Plans_Index_ID,
FolderId
FROM PortalDefaults_MappingClientFoldersPlan_MP
