/*Update ByWho IDs in Parent tables*/
/*[dbo].[BondingCo_Lib]*/
--Before update
--SELECT bc.ByWho,  um.MyPlans_SysUserID, um.PPC_SysUserID 
--FROM [dbo].[BondingCo_Lib_MP] bc
--JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]

--UPDATE BYWHO
UPDATE [dbo].[BondingCo_Lib_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[BondingCo_Lib_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--After update
--SELECT bc.ByWho,  um.MyPlans_SysUserID, um.PPC_SysUserID FROM [dbo].[BondingCo_Lib_MP] bc
--JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[PPC_SysUserID]

/*[dbo].[Contact_Method]*/

--Before update
--SELECT CM.ByWho, UM.MyPlans_SysUserID, UM.PPC_SysUserID
--FROM [dbo].[Contact_Method_MP] CM
--JOIN [dbo].[UserID_Mapping] UM ON CM.BYWHO = UM.MyPlans_SysUserID

--UPDATE BYWHO
UPDATE [dbo].[Contact_Method_MP]
SET BYWHO=UM.PPC_SysUserID
FROM [dbo].[Contact_Method_MP] CM
JOIN [dbo].[UserID_Mapping] UM ON CM.BYWHO = UM.MyPlans_SysUserID
WHERE CM.ByWho != -1

--After update
--SELECT CM.ByWho,  um.MyPlans_SysUserID, um.PPC_SysUserID 
--FROM [dbo].[Contact_Method_MP] CM
--JOIN [dbo].[UserID_Mapping] um ON CM.ByWho=um.[PPC_SysUserID]

/*[dbo].[Questionnaire_Group]*/

--Before update
SELECT QG.ByWho, UM.MyPlans_SysUserID, UM.PPC_SysUserID
FROM [dbo].[Questionnaire_Group_MP] QG
JOIN [dbo].[UserID_Mapping] UM ON QG.BYWHO = UM.MyPlans_SysUserID

----UPDATE BYWHO
UPDATE [dbo].[Questionnaire_Group_MP]
SET BYWHO=UM.PPC_SysUserID
FROM [dbo].[Questionnaire_Group_MP] QG
JOIN [dbo].[UserID_Mapping] UM ON QG.BYWHO = UM.MyPlans_SysUserID
WHERE QG.ByWho != -1

--After update
SELECT CM.ByWho,  um.MyPlans_SysUserID, um.PPC_SysUserID 
FROM [dbo].[Contact_Method_MP] CM
JOIN [dbo].[UserID_Mapping] um ON CM.ByWho=um.[PPC_SysUserID]

/*[dbo].[TemplateDoc]*/

--Before update
--SELECT TD.ByWho, UM.MyPlans_SysUserID, UM.PPC_SysUserID
--FROM [dbo].[TemplateDoc_MP] TD
--JOIN [dbo].[UserID_Mapping] UM ON TD.BYWHO = UM.MyPlans_SysUserID

----UPDATE BYWHO
UPDATE [dbo].[TemplateDoc_MP]
SET BYWHO=UM.PPC_SysUserID
FROM [dbo].[TemplateDoc_MP] TD
JOIN [dbo].[UserID_Mapping] UM ON TD.BYWHO = UM.MyPlans_SysUserID
WHERE TD.ByWho != -1

--After update
--SELECT TD.ByWho,  um.MyPlans_SysUserID, um.PPC_SysUserID 
--FROM [dbo].[TemplateDoc_MP] TD
--JOIN [dbo].[UserID_Mapping] um ON TD.ByWho=um.[PPC_SysUserID]

/*[dbo].[TemplateEmail]*/

--Before update
--SELECT TE.ByWho, UM.MyPlans_SysUserID, UM.PPC_SysUserID
--FROM [dbo].[TemplateEmail_MP] TE
--JOIN [dbo].[UserID_Mapping] UM ON TE.BYWHO = UM.MyPlans_SysUserID

----UPDATE BYWHO
UPDATE [dbo].[TemplateEmail_MP]
SET BYWHO=UM.PPC_SysUserID
FROM [dbo].[TemplateEmail_MP] TE
JOIN [dbo].[UserID_Mapping] UM ON TE.BYWHO = UM.MyPlans_SysUserID
WHERE TE.ByWho != -1

--After update
--SELECT TE.ByWho,  um.MyPlans_SysUserID, um.PPC_SysUserID 
--FROM [dbo].[TemplateEmail_MP] TE
--JOIN [dbo].[UserID_Mapping] um ON TE.ByWho=um.[PPC_SysUserID]