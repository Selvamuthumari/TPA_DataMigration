/*Get ONLY active client's data from MyPlans*/

/*Client_Master*/
SELECT * FROM [dbo].[Client_Master]
EXCEPT(SELECT * FROM [dbo].[Client_Master]
WHERE IsDead=1 AND IsDeadDate<'2020-01-01 00:00:00.000')

/*Activities*/
select * from Activities
except (
select ac.* from Activities ac
JOIN Client_Master cm on cm.Client_ID= ac.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

/*AdHocTodo*/
SELECT [AdHocTodo_ID]
      ,[Subject]
      ,CAST([Description] AS nvarchar(max)) AS [Description]
      ,[Client_ID]
      ,[Advisor_ID]
      ,[Contact_ID]
      ,[Plan_Index_ID]
      ,[Comm_Log_ID]
      ,[MainCategory]
      ,[SubCategory]
      ,[Create_Date]
      ,[Budget_Time]
      ,[Actual_Time]
      ,[Promised_Date]
      ,[Deadline]
      ,[Assigned_To_ID]
      ,[Completed]
      ,[lastTouch]
      ,[byWho]
      ,[WhoComplete]
      ,[WhoCreated]
      ,[Attachment_ID]
      ,[Flag]
      ,[IsDeletedFromOutlook]
      ,[AssignedDate]
      ,[IsPortalDeleted]
      ,[IsCreatedByAdvisor]
      ,[IsReassigned]
      ,[InitiallyAassigned_To_ID]
      ,[InitialAssignedDate] 
FROM AdhocToDo
EXCEPT(
select [AdHocTodo_ID]
      ,[Subject]
      ,CAST([Description] AS nvarchar(max)) AS [Description]
      ,ad.[Client_ID]
      ,[Advisor_ID]
      ,[Contact_ID]
      ,[Plan_Index_ID]
      ,[Comm_Log_ID]
      ,[MainCategory]
      ,[SubCategory]
      ,[Create_Date]
      ,[Budget_Time]
      ,[Actual_Time]
      ,[Promised_Date]
      ,[Deadline]
      ,[Assigned_To_ID]
      ,[Completed]
      ,[lastTouch]
      ,ad.[byWho]
      ,[WhoComplete]
      ,[WhoCreated]
      ,[Attachment_ID]
      ,[Flag]
      ,[IsDeletedFromOutlook]
      ,[AssignedDate]
      ,[IsPortalDeleted]
      ,[IsCreatedByAdvisor]
      ,[IsReassigned]
      ,[InitiallyAassigned_To_ID]
      ,[InitialAssignedDate]
from AdhocToDo ad
JOIN client_master cm on cm.client_ID=ad.client_id
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'
)

/*[dbo].[Advisor_Client_Link] */
SELECT * FROM [dbo].[Advisor_Client_Link] 
EXCEPT (select ACL.* from [dbo].[Advisor_Client_Link] ACL
JOIN [dbo].[Client_Master] cm on cm.Client_ID = ACL.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[CnAPacketInfo]
SELECT * FROM [dbo].[CnAPacketInfo]
EXCEPT (select CNA.* from [dbo].[CnAPacketInfo] CNA
JOIN [dbo].[Client_Master] cm on cm.Client_ID = CNA.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Comm_Log]
SELECT [Comm_Log_ID]
      ,[Client_ID]
      ,[Comm_Log_Type]
      ,[Comm_Log_Origination]
      ,[Comm_Log_Category]
      ,[Sub_Category]
      ,[Comm_Log_Status]
      ,[Plan_ID]
      ,[Project_ID]
      ,[AdHocToDo]
      ,[Title]
      ,[CommContact1]
      ,[CommContact2]
      ,[CommContact3]
      ,[Attachment_ID]
      ,CAST([Comm_Log_Text] AS NVARCHAR(MAX)) AS Comm_Log_Text
      ,[Duplicate]
      ,[Internal_Use_Only]
      ,[OriginDate]
      ,[LastTouched]
      ,[ByWho]
      ,[Actual_Time]
      ,[CreatedByWho]
      ,[IsDeletedFromOutlook]
      ,[IsPortalDeleted]
      ,[ByWhoClient]
      ,[LastTouchedClient]
      ,[IsLastUpdatedByAdvisor] FROM [dbo].[Comm_Log]
EXCEPT (select [Comm_Log_ID]
      ,CL.[Client_ID]
      ,[Comm_Log_Type]
      ,[Comm_Log_Origination]
      ,[Comm_Log_Category]
      ,[Sub_Category]
      ,[Comm_Log_Status]
      ,[Plan_ID]
      ,[Project_ID]
      ,[AdHocToDo]
      ,[Title]
      ,[CommContact1]
      ,[CommContact2]
      ,[CommContact3]
      ,[Attachment_ID]
      ,CAST([Comm_Log_Text] AS NVARCHAR(MAX)) AS Comm_Log_Text
      ,[Duplicate]
      ,[Internal_Use_Only]
      ,[OriginDate]
      ,CL.[LastTouched]
      ,CL.[ByWho]
      ,[Actual_Time]
      ,[CreatedByWho]
      ,[IsDeletedFromOutlook]
      ,[IsPortalDeleted]
      ,[ByWhoClient]
      ,[LastTouchedClient]
      ,CL.[IsLastUpdatedByAdvisor] from [dbo].[Comm_Log] CL
JOIN [dbo].[Client_Master] cm on cm.Client_ID = CL.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Contacts]
SELECT * FROM [dbo].[Contacts]
EXCEPT (select CT.* from [dbo].[Contacts] CT
JOIN [dbo].[Client_Master] cm on cm.Client_ID = CT.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Documents]
SELECT * FROM [dbo].[Documents]
EXCEPT (select DC.* from [dbo].[Documents] DC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = DC.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[EmailPlanReview_Lib]
SELECT * FROM [dbo].[EmailPlanReview_Lib]
EXCEPT(SELECT EPRL.* FROM [dbo].[EmailPlanReview_Lib] EPRL
JOIN [dbo].[Client_Master] cm on cm.Client_ID = EPRL.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[EmailRecord]
SELECT [EmailRecord_ID]
      ,[Email_From]
      ,[Email_To]
      ,[Email_CC]
      ,[Email_Subject]
      ,CAST([Email_Text] AS nvarchar(MAX)) AS [Email_Text]
      ,[Client_ID]
      ,[Contact_ID]
      ,[Advisor_ID]
      ,[LastTouched]
      ,[ByWho]
      ,[Email_Attachment]
      ,[IsDeletedFromOutlook]
      ,[ByWhoClient]
      ,[LastTouchedClient]
      ,[IsLastUpdatedByAdvisor]
      ,[ScheduleId]
      ,[StatusId]
      ,[EmailTypeId]
      ,[ResponseCode]
      ,[CCStatus]
      ,[CCResponseCode] FROM [dbo].[EmailRecord]
EXCEPT (select [EmailRecord_ID]
      ,[Email_From]
      ,[Email_To]
      ,[Email_CC]
      ,[Email_Subject]
      ,CAST([Email_Text] AS nvarchar(MAX)) AS [Email_Text]
      ,ER.[Client_ID]
      ,[Contact_ID]
      ,[Advisor_ID]
      ,ER.[LastTouched]
      ,ER.[ByWho]
      ,[Email_Attachment]
      ,[IsDeletedFromOutlook]
      ,[ByWhoClient]
      ,[LastTouchedClient]
      ,ER.[IsLastUpdatedByAdvisor]
      ,[ScheduleId]
      ,[StatusId]
      ,[EmailTypeId]
      ,[ResponseCode]
      ,[CCStatus]
      ,[CCResponseCode] from [dbo].[EmailRecord] ER
JOIN [dbo].[Client_Master] cm on cm.Client_ID = ER.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

/*[dbo].[ParticipantFeeDisclosure]*/
SELECT * FROM [dbo].[ParticipantFeeDisclosure]
EXCEPT (select PFD.* from [dbo].[ParticipantFeeDisclosure] PFD
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PFD.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

/*[dbo].[Plans]*/
SELECT * FROM [dbo].[Plans]
EXCEPT (select P.* from [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm on cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

/*[Plans_YearToYear]*/
SELECT * FROM [dbo].[Plans_YearToYear]
WHERE [Plans_Index_ID] IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[PlanYearEnd]
SELECT * FROM [dbo].[PlanYearEnd]
WHERE [Plans_Index_ID] IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[PlanYearMilestone]
SELECT * FROM [dbo].[PlanYearMilestone]
WHERE [Plans_Index_ID] IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[Portal_AdditionalServicesHistory]
SELECT * FROM [dbo].[Portal_AdditionalServicesHistory]
EXCEPT (select P.* from [dbo].[Portal_AdditionalServicesHistory] P
JOIN [dbo].[Client_Master] cm on cm.Client_ID = P.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[Portal_AdvisorNotes]
SELECT NotesID,
CAST(NotesText AS NVARCHAR(MAX)) AS NotesText,
LastTouched,
AdvisorID,
ClientID,
PlanID FROM [dbo].[Portal_AdvisorNotes]
EXCEPT (select P.NotesID,
CAST(P.NotesText AS NVARCHAR(MAX)) AS NotesText,
P.LastTouched,
P.AdvisorID,
P.ClientID,
P.PlanID  from [dbo].[Portal_AdvisorNotes] P
JOIN [dbo].[Client_Master] cm on cm.Client_ID = P.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_ChangeRequest]
SELECT * FROM [dbo].[Portal_ChangeRequest]
EXCEPT (select PCR.* from [dbo].[Portal_ChangeRequest] PCR
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PCR.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_ClientContactType]
SELECT * FROM [dbo].[Portal_ClientContactType]
EXCEPT (select PCCT.* from [dbo].[Portal_ClientContactType] PCCT
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PCCT.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_ClientFilesActivity]
SELECT * FROM [dbo].[Portal_ClientFilesActivity]
EXCEPT (select PCCT.* from [dbo].[Portal_ClientFilesActivity] PCCT
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PCCT.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[Portal_CommLogContactAdvisor]
select * from [dbo].[Portal_CommLogContactAdvisor]
where CommLogId in (SELECT [Comm_Log_ID]
       FROM [dbo].[Comm_Log]
EXCEPT (select [Comm_Log_ID]
       from [dbo].[Comm_Log] CL
JOIN [dbo].[Client_Master] cm on cm.Client_ID = CL.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[Portal_DocumentDetails]
SELECT * FROM [dbo].[Portal_DocumentDetails]
WHERE [PlansIndexID] IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[Portal_DocumentTracking]
SELECT * FROM [dbo].[Portal_DocumentTracking]
WHERE [PlanID] IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[dbo].[Portal_ClientUpdateInfo]
SELECT * FROM [dbo].[Portal_ClientUpdateInfo]
EXCEPT (select PCUI.* from [dbo].[Portal_ClientUpdateInfo] PCUI
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PCUI.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_InfoGatheredTriggers]
SELECT * FROM [dbo].[Portal_InfoGatheredTriggers]
EXCEPT (select PIGT.* from [dbo].[Portal_InfoGatheredTriggers] PIGT
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PIGT.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[Portal_OptionalOwnership]
SELECT * FROM [dbo].[Portal_OptionalOwnership]
EXCEPT (select PCR.* from [dbo].[Portal_OptionalOwnership] PCR
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PCR.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_Permissions]
SELECT * FROM [dbo].[Portal_Permissions]
EXCEPT (select PP.* from [dbo].[Portal_Permissions] PP
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PP.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_PlanQuestionnarieAnswers]
SELECT * FROM [dbo].[Portal_PlanQuestionnarieAnswers]
EXCEPT (select PPQA.* from [dbo].[Portal_PlanQuestionnarieAnswers] PPQA
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PPQA.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_PlanSubQuestionnarieAnswers]
SELECT * FROM [dbo].[Portal_PlanSubQuestionnarieAnswers]
EXCEPT (select PSQA.* from [dbo].[Portal_PlanSubQuestionnarieAnswers] PSQA
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PSQA.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_ProgressBarStat]
SELECT * FROM [dbo].[Portal_ProgressBarStat]
EXCEPT (select PPBS.* from [dbo].[Portal_ProgressBarStat] PPBS
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PPBS.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Portal_UserClientContact]
SELECT * FROM [dbo].[Portal_UserClientContact]
EXCEPT (select PUCC.* from [dbo].[Portal_UserClientContact] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[ProspectPlan]
SELECT * FROM [dbo].[ProspectPlan]
EXCEPT (select PUCC.* from [dbo].[ProspectPlan] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Question]
SELECT [Question_ID]
      ,[Client_ID]
      ,[Plans_Index_ID]
      ,[Plan_Year]
      ,[Questionnaire_ID]
      ,[YN_Result]
      ,CAST([Other_Result] AS nvarchar(max)) AS [Other_Result]
      ,[LastTouched]
      ,[ByWho]
      ,[Questionnaire_Group_ID] FROM [dbo].[Question]
EXCEPT (select [Question_ID]
      ,PUCC.[Client_ID]
      ,[Plans_Index_ID]
      ,[Plan_Year]
      ,[Questionnaire_ID]
      ,[YN_Result]
      ,CAST([Other_Result] AS nvarchar(max)) AS [Other_Result]
      ,PUCC.[LastTouched]
      ,PUCC.[ByWho]
      ,[Questionnaire_Group_ID] from [dbo].[Question] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[special_instructions]
SELECT * FROM [dbo].[special_instructions]
EXCEPT (select PUCC.* from [dbo].[special_instructions] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.company_id
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[Testing_Tracking]
SELECT * FROM [dbo].[Testing_Tracking]
WHERE Plans_Index_ID IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[dbo].[WaitingItem]
SELECT WaitingItem_ID,
Client_ID,
Plans_Index_ID,
ContactAdvisor,
Subject_Line,
Response_Date,
Expiration_Date,
Completed,
CAST(Notes AS nvarchar(MAX)) AS Notes,
lastTouched,
ByWho FROM [dbo].[WaitingItem]
EXCEPT (select WaitingItem_ID,
PUCC.Client_ID,
Plans_Index_ID,
ContactAdvisor,
Subject_Line,
Response_Date,
Expiration_Date,
Completed,
CAST(Notes AS nvarchar(MAX)) AS Notes,
PUCC.lastTouched,
PUCC.ByWho from [dbo].[WaitingItem] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[YearEndNotes]
SELECT [YearEndNotes_ID]
      ,[Client_ID]
      ,[PYE_Year]
      ,[Plan_Number]
      ,[YEN_Category]
      ,[Reviewed_ByWho]
      ,[Reviewed_When]
      ,CAST([General_Notes] AS nvarchar(MAX)) AS [General_Notes]
      ,[Action_Required]
      ,CAST([Reviewer_Notes] AS nvarchar(MAX)) AS [Reviewer_Notes]
      ,[Resolved]
      ,[Carry_Over]
      ,[CreatedByWho]
      ,[CreatedWhen]
      ,[LastTouched]
      ,[ByWho] FROM [dbo].[YearEndNotes]
EXCEPT (select [YearEndNotes_ID]
      ,PUCC.[Client_ID]
      ,[PYE_Year]
      ,[Plan_Number]
      ,[YEN_Category]
      ,[Reviewed_ByWho]
      ,[Reviewed_When]
      ,CAST([General_Notes] AS nvarchar(MAX)) AS [General_Notes]
      ,[Action_Required]
      ,CAST([Reviewer_Notes] AS nvarchar(MAX)) AS [Reviewer_Notes]
      ,[Resolved]
      ,[Carry_Over]
      ,[CreatedByWho]
      ,[CreatedWhen]
      ,PUCC.[LastTouched]
      ,PUCC.[ByWho] from [dbo].[YearEndNotes] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[PortalWorkflow_Notes]
SELECT * FROM [dbo].[PortalWorkflow_Notes]
EXCEPT (select PUCC.* from [dbo].[PortalWorkflow_Notes] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[PortalWorkflow_WorkflowAppliedTo]
SELECT * FROM [dbo].[PortalWorkflow_WorkflowAppliedTo]
EXCEPT (select PUCC.* from [dbo].[PortalWorkflow_WorkflowAppliedTo] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[PortalWorkflow_YearEndTrackingPlanCompliance]
SELECT * FROM [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance]
EXCEPT (select PUCC.* from [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[PortalDefaults_ClientFiles]
SELECT * FROM [dbo].[PortalDefaults_ClientFiles]
EXCEPT (select PUCC.* from [dbo].[PortalDefaults_ClientFiles] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.ClientID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')

--[dbo].[PortalDefaults_MappingClientFoldersPlan]
SELECT * FROM [dbo].[PortalDefaults_MappingClientFoldersPlan]
WHERE Plans_Index_ID IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[ScheduleATracking]
SELECT * FROM [dbo].[ScheduleATracking]
WHERE Plans_Index_ID IN (
SELECT [Plans_Index_ID] FROM [dbo].[Plans]
EXCEPT (SELECT [Plans_Index_ID] FROM [dbo].[Plans] P
JOIN [dbo].[Client_Master] cm ON cm.Client_ID = P.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000'))

--[dbo].[Portal_Timeline]
SELECT * FROM [dbo].[Portal_Timeline]
EXCEPT (select PUCC.* from [dbo].[Portal_Timeline] PUCC
JOIN [dbo].[Client_Master] cm on cm.Client_ID = PUCC.Client_ID
where cm.IsDead=1 and cm.IsDeadDate<'2020-01-01 00:00:00.000')