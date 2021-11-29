/*Address --> ByWho_Client*/
UPDATE [dbo].[Address]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Address] AMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON AMP.ByWho_Client = UM.Old_ID
WHERE AMP.IsLastUpdatedByAdvisor = 1
AND AMP.Address_ID > (SELECT Old_ID FROM Address_ID_Mapping WHERE MapId=-1)


UPDATE [dbo].[Address]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Address] AMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON AMP.ByWho_Client = UM.Old_ID
WHERE AMP.IsLastUpdatedByAdvisor = 0 
AND AMP.Address_ID > (SELECT Old_ID FROM Address_ID_Mapping WHERE MapId=-1)

/*Client_Master --> ByWho_Client*/
UPDATE [dbo].[Client_Master]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Client_Master] CMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON CMP.ByWho_Client = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 1
AND CMP.Client_ID > (SELECT Old_ID FROM Client_Master_ID_Mapping WHERE MapId=-1)


UPDATE [dbo].[Client_Master]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Client_Master] CMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON CMP.ByWho_Client = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 0 
AND CMP.Client_ID > (SELECT Old_ID FROM Client_Master_ID_Mapping WHERE MapId=-1)

/*Contact_Method --> ByWho_Client*/
UPDATE [dbo].[Contact_Method]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Contact_Method] CMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON CMP.ByWho_Client = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 1
AND CMP.Contact_Method_ID > (SELECT Old_ID FROM Contact_Method_ID_Mapping WHERE MapId=-1)

UPDATE [dbo].[Contact_Method]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Contact_Method] CMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON CMP.ByWho_Client = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 0 
AND CMP.Contact_Method_ID > (SELECT Old_ID FROM Contact_Method_ID_Mapping WHERE MapId=-1)

/*Contacts --> ByWho_Client*/
UPDATE [dbo].[Contacts]
SET ByWho_Client=UM.New_ID --SELECT *
FROM [dbo].[Contacts] CMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON CMP.ByWho_Client = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 1
AND CMP.Contact_ID > (SELECT Old_ID FROM Contacts_ID_Mapping WHERE MapId=-1)


UPDATE [dbo].[Contacts]
SET ByWho_Client=UM.New_ID --SELECT *
FROM [dbo].[Contacts] CMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON CMP.ByWho_Client = UM.Old_ID
WHERE CMP.IsLastUpdatedByAdvisor = 0 
AND CMP.Contact_ID > (SELECT Old_ID FROM Contacts_ID_Mapping WHERE MapId=-1)


/*Advisor --> ByWho_Client*/
--UPDATE [dbo].[Advisor]
--SET ByWho_Client=UM.New_ID
SELECT *
FROM [dbo].[Advisor] AMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON AMP.ByWho_Client = UM.Old_ID
WHERE AMP.IsLastUpdatedByAdvisor = 1
AND AMP.Advisor_ID > (SELECT Old_ID FROM Advisor_ID_Mapping WHERE MapId=-1)


--UPDATE [dbo].[Advisor]
--SET ByWho_Client=UM.New_ID
SELECT *
FROM [dbo].[Advisor] AMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON AMP.ByWho_Client = UM.Old_ID
WHERE AMP.IsLastUpdatedByAdvisor = 0 
AND AMP.Advisor_ID > (SELECT Old_ID FROM Advisor_ID_Mapping WHERE MapId=-1)

/*Advisor_Client_Link --> ByWho_Client*/
UPDATE [dbo].[Advisor_Client_Link]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Advisor_Client_Link] AMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON AMP.ByWho_Client = UM.Old_ID
WHERE AMP.IsLastUpdatedByAdvisor = 1
AND AMP.Advisor_Client_Link_ID > (SELECT Old_ID FROM Advisor_Client_Link_ID_Mapping WHERE MapId=-1)

UPDATE [dbo].[Advisor_Client_Link]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Advisor_Client_Link] AMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON AMP.ByWho_Client = UM.Old_ID
WHERE AMP.IsLastUpdatedByAdvisor = 0 
AND AMP.Advisor_Client_Link_ID > (SELECT Old_ID FROM Advisor_Client_Link_ID_Mapping WHERE MapId=-1)

--TODO
/*EmailRecord --> ByWhoClient*/
UPDATE [dbo].[EmailRecord_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[EmailRecord_MP] EMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON EMP.ByWhoClient = UM.Old_ID
WHERE EMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[EmailRecord_MP]
SET ByWhoClient=UM.New_ID
FROM [dbo].[EmailRecord_MP] EMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON EMP.ByWhoClient = UM.Old_ID
WHERE EMP.IsLastUpdatedByAdvisor = 0 



/*Portal_ClientUpdateInfo --> ByWhoClient*/
UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[Portal_ClientUpdateInfo_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_ClientUpdateInfo_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 



/*Portal_OptionalOwnership --> ByWhoClient*/
UPDATE [dbo].[Portal_OptionalOwnership_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_OptionalOwnership_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[Portal_OptionalOwnership_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_OptionalOwnership_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 



/*Portal_PlanQuestionnarieAnswers --> ByWho_Client*/
UPDATE [dbo].[Portal_PlanQuestionnarieAnswers_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_PlanQuestionnarieAnswers_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[Portal_PlanQuestionnarieAnswers_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_PlanQuestionnarieAnswers_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 



/*Portal_PlanSubQuestionnarieAnswers --> ByWho_Client*/
UPDATE [dbo].[Portal_PlanSubQuestionnarieAnswers_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_PlanSubQuestionnarieAnswers_MP] PMP
JOIN [dbo].[Advisor_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 1


UPDATE [dbo].[Portal_PlanSubQuestionnarieAnswers_MP]
SET ByWho_Client=UM.New_ID
FROM [dbo].[Portal_PlanSubQuestionnarieAnswers_MP] PMP
JOIN [dbo].[Contacts_ID_Mapping] UM ON PMP.ByWho_Client = UM.Old_ID
WHERE PMP.IsLastUpdatedByAdvisor = 0 



