
/*STEP 5: Create Child temp tables*/
/*Activities*/
 IF OBJECT_ID('dbo.Activities_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Activities_MP] (LoopId INT IDENTITY(1,1), 
[Activity_ID] [int] NOT NULL,
	[Activity_Type] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[Duration] [decimal](15, 2) NOT NULL,
	[DurationUnits] [int] NOT NULL,
	[ScheduleWith] [int] NOT NULL,
	[ScheduleWithType] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Regarding] [nvarchar](255) NOT NULL,
	[LocationCode] [int] NOT NULL,
	[Location] [nvarchar](255) NOT NULL,
	[ScheduledBy] [int] NOT NULL,
	[ScheduledDate] [datetime] NOT NULL,
	[ScheduledForGroup] [int] NOT NULL,
	[ShowAlarm] [bit] NOT NULL,
	[AlarmDelay] [decimal](15, 2) NOT NULL,
	[AlarmDelayUnits] [int] NOT NULL,
	[Recurrence_ID] [int] NOT NULL,
	[Original_Activity_ID] [int] NOT NULL,
	[Result] [int] NOT NULL,
	[LinkedActivity] [int] NOT NULL,
	[Notes_ID] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[IsDeletedFromOutlook] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Activities_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Activities]) > 0
 BEGIN
CREATE TABLE [dbo].[Activities_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Address*/
 IF OBJECT_ID('dbo.Address_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Address_MP] (LoopId INT IDENTITY(1,1), 
	[Address_ID] [int] NOT NULL,
	[Address1] [varchar](200) NOT NULL,
	[Address2] [varchar](200) NULL,
	[City] [varchar](200) NOT NULL,
	[State] [int] NOT NULL,
	[Zip_Code] [varchar](10) NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastTouched_Client] [datetime] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Address_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Address]) > 0
 BEGIN
CREATE TABLE [dbo].[Address_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AdHocToDo*/
IF OBJECT_ID('dbo.AdHocToDo_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AdHocToDo_MP] (LoopId INT IDENTITY(1,1), 
	[AdHocTodo_ID] [int] NOT NULL,
	[Subject] [nvarchar](max) NULL,
	[Description] [ntext] NULL,
	[Client_ID] [int] NULL,
	[Advisor_ID] [int] NULL,
	[Contact_ID] [int] NULL,
	[Plan_Index_ID] [int] NULL,
	[Comm_Log_ID] [int] NULL,
	[MainCategory] [int] NULL,
	[SubCategory] [nvarchar](25) NULL,
	[Create_Date] [datetime] NOT NULL,
	[Budget_Time] [decimal](9, 3) NULL,
	[Actual_Time] [decimal](8, 3) NULL,
	[Promised_Date] [datetime] NULL,
	[Deadline] [datetime] NOT NULL,
	[Assigned_To_ID] [int] NULL,
	[Completed] [datetime] NULL,
	[lastTouch] [datetime] NULL,
	[byWho] [int] NULL,
	[WhoComplete] [int] NULL,
	[WhoCreated] [int] NULL,
	[Attachment_ID] [int] NULL,
	[Flag] [int] NULL,
	[IsDeletedFromOutlook] [bit] NOT NULL,
	[AssignedDate] [varchar](50) NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[IsCreatedByAdvisor] [bit] NOT NULL,
	[IsReassigned] [bit] NOT NULL,
	[InitiallyAassigned_To_ID] [int] NULL,
	[InitialAssignedDate] [datetime] NOT NULL)
END
 IF OBJECT_ID('dbo.AdHocToDo_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AdHocToDo]) > 0
 BEGIN
CREATE TABLE [dbo].[AdHocToDo_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*EmailRecord*/
IF OBJECT_ID('dbo.EmailRecord_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[EmailRecord_MP] (LoopId INT IDENTITY(1,1), 
    [EmailRecord_ID] [int]  NOT NULL,
[Email_From] [nvarchar] (100) NOT NULL,
[Email_To] [nvarchar] (500) NOT NULL,
[Email_CC] [nvarchar] (max) NULL,
[Email_Subject] [nvarchar] (500) NOT NULL,
[Email_Text] [ntext]  NOT NULL,
[Client_ID] [int]  NULL,
[Contact_ID] [int]  NULL,
[Advisor_ID] [int]  NULL,
[LastTouched] [datetime]  NOT NULL,
[ByWho] [int]  NOT NULL,
[Email_Attachment] [int]  NULL,
[IsDeletedFromOutlook] [bit]  NOT NULL,
[ByWhoClient] [int]  NOT NULL,
[LastTouchedClient] [datetime]  NOT NULL,
[IsLastUpdatedByAdvisor] [bit]  NOT NULL,
[ScheduleId] [int]  NULL,
[StatusId] [int]  NULL,
[EmailTypeId] [int]  NULL,
[ResponseCode] [nvarchar] (max) NULL,
[CCStatus] [nvarchar] (max) NULL,
[CCResponseCode] [nvarchar] (max) NULL
)
END
IF OBJECT_ID('dbo.EmailRecord_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[EmailRecord]) > 0
BEGIN
CREATE TABLE [dbo].[EmailRecord_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Advisor*/
IF OBJECT_ID('dbo.Advisor_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[Advisor_MP] (LoopId INT IDENTITY(1,1), 
    [Advisor_ID] [int] NOT NULL,
	[Advisor_Firm_ID] [int] NOT NULL,
	[Last_Name] [nvarchar](100) NOT NULL,
	[MI] [nvarchar](2) NULL,
	[First_Name] [nvarchar](100) NOT NULL,
	[Credentials] [nvarchar](25) NULL,
	[Contact_Method] [int] NULL,
	[Address] [int] NULL,
	[MailAddress] [int] NULL,
	[Advisor_Notes] [int] NULL,
	[CC] [int] NULL,
	[CommunicationPreference] [int] NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[IsComplete] [bit] NOT NULL,
	[IsDeletedFromOutlook] [bit] NOT NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastTouched_Client] [datetime] NOT NULL,
	[prefix] [int] NOT NULL,
	[suffix] [int] NOT NULL,
	[IsEnableByBoyce] [bit] NOT NULL,
	[IsSameFirmMainAddress] [bit] NOT NULL,
	[IsSameFirmMailAddress] [bit] NOT NULL,
	[IsSameAsAboveAddress] [bit] NOT NULL,
	[orignal_ID] AS [Advisor_ID],
	[UDF1] [nvarchar](max) NULL,
	[UDF2] [nvarchar](max) NULL,
	[UDF3] [nvarchar](max) NULL,
	[UDF4] [nvarchar](max) NULL,
	[UDF5] [nvarchar](max) NULL
)
END
IF OBJECT_ID('dbo.Advisor_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Advisor]) > 0
BEGIN
CREATE TABLE [dbo].[Advisor_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Advisor_Client_Link*/
 IF OBJECT_ID('dbo.Advisor_Client_Link_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Advisor_Client_Link_MP] (LoopId INT IDENTITY(1,1), 
	[Advisor_Client_Link_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Plan_Number] [int] NOT NULL,
	[Advisor_Type_ID] [int] NOT NULL,
	[Advisor_ID] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[CC] [int] NULL,
	[Plans_Index_ID] [int] NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastTouched_Client] [datetime] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[IsEnableByBoyce] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Advisor_Client_Link_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Advisor_Client_Link]) > 0
 BEGIN
CREATE TABLE [dbo].[Advisor_Client_Link_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AdvisorFirms*/
 IF OBJECT_ID('dbo.AdvisorFirms_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AdvisorFirms_MP] (LoopId INT IDENTITY(1,1), 
	[Advisor_Firm_ID] [int] NOT NULL,
	[Advisor_Firm_Type] [int] NOT NULL,
	[Firm_Name] [nvarchar](200) NOT NULL,
	[Attention] [nvarchar](100) NULL,
	[Address] [int] NULL,
	[MailAddress] [int] NULL,
	[Contact_Method] [int] NULL,
	[IsClient] [bit] NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[UDF1] [nvarchar](max) NULL,
	[UDF2] [nvarchar](max) NULL,
	[UDF3] [nvarchar](max) NULL,
	[UDF4] [nvarchar](max) NULL,
	[UDF5] [nvarchar](max) NULL,
	[IsSameAsAbove] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.AdvisorFirms_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AdvisorFirms]) > 0
 BEGIN
CREATE TABLE [dbo].[AdvisorFirms_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AssetTracking*/
 IF OBJECT_ID('dbo.AssetTracking_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AssetTracking_MP] (LoopId INT IDENTITY(1,1), 
	[AssetTracking_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[PYE_Month] [nvarchar](5) NOT NULL,
	[Asset_Index] [int] NOT NULL,
	[Money_Type] [int] NOT NULL,
	[Account_Type] [int] NOT NULL,
	[Record_Keeper] [nvarchar](100) NULL,
	[RK_Account_No] [nvarchar](50) NULL,
	[Custodian] [nvarchar](100) NULL,
	[C_Account_No] [nvarchar](50) NULL,
	[Statement_Delivery] [int] NOT NULL,
	[Advisor] [int] NOT NULL,
	[Notes] [bit] NULL,
	[More] [bit] NULL,
	[Same_As] [int] NULL,
	[Sch_A_Required] [bit] NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Notes_ID] [int] NULL,
	[QBSAction] [int] NULL,
	[InvestmentPlatform] [int] NULL,
	[AssetConfirmed] [bit] NULL,
	[AssetConfirmedByWho] [int] NULL,
	[AssetConfirmedByType] [int] NULL,
	[AssetConfirmedWhen] [datetime] NULL,
	[Kind] [nvarchar](10) NULL,
	[AccountClosed] [bit] NOT NULL,
	[LastStatementDate] [datetime] NULL,
	[FirstStatementDate] [datetime] NULL,
	[NonQualifiedAsset] [bit] NULL,
	[Download] [bit] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[UDF1] [nvarchar](max) NULL,
	[UDF2] [nvarchar](max) NULL,
	[UDF3] [nvarchar](max) NULL,
	[UDF4] [nvarchar](max) NULL,
	[UDF5] [nvarchar](max) NULL)
END
 IF OBJECT_ID('dbo.AssetTracking_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AssetTracking]) > 0
 BEGIN
CREATE TABLE [dbo].[AssetTracking_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Client_Master*/
 IF OBJECT_ID('dbo.Client_Master_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Client_Master_MP] (LoopId INT IDENTITY(1,1), 
	[Client_ID] [int] NOT NULL,
	[Client_Name] [nvarchar](200) NOT NULL,
	[Alpha_Sort] [nvarchar](100) NULL,
	[Main_Address] [int] NULL,
	[Mail_Address] [int] NULL,
	[Contact_Method] [int] NULL,
	[Client_Notes] [int] NULL,
	[ReferedBy] [int] NULL,
	[ReferedByOther] [nvarchar](50) NULL,
	[EIN] [nvarchar](200) NULL,
	[PrimaryContact] [nvarchar](100) NULL,
	[Business_Type] [int] NULL,
	[Tax_YE] [nvarchar](6) NOT NULL,
	[IncorpDate] [datetime] NULL,
	[GroupType] [nvarchar](25) NULL,
	[TaxedAs] [int] NULL,
	[PayrollProvider] [int] NULL,
	[Alias] [nvarchar](200) NULL,
	[Classification] [nvarchar](50) NULL,
	[Client_Hold] [bit] NULL,
	[Client_Hold_Date] [datetime] NULL,
	[Segmentation] [int] NULL,
	[NatureOfBusiness] [nvarchar](200) NULL,
	[EmployeeCount] [int] NULL,
	[SIC_Code] [int] NULL,
	[IsActive] [int] NOT NULL,
	[FilePath] [nvarchar](255) NULL,
	[AltIDNum1] [nvarchar](max) NULL,
	[AltIDNum2] [nvarchar](10) NULL,
	[IsDeadDate] [datetime] NULL,
	[IsDead] [bit] NULL,
	[WebPage] [nvarchar](255) NULL,
	[Client_Link_ID] [int] NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[NoPartnershipIncome] [bit] NULL,
	[PreferredInvoiceMethod] [int] NULL,
	[PayrollFrequency] [int] NULL,
	[IsInfoGatheringRequired] [bit] NULL,
	[IsSeparateBilling] [bit] NULL,
	[FirstPlanYear] [nvarchar](25) NULL,
	[LastPlanYear] [nvarchar](25) NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastTouched_Client] [datetime] NOT NULL,
	[IsTestClient] [bit] NOT NULL,
	[CurrCombinedValue] [decimal](18, 2) NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL,
	[OverAllConfirm] [datetime] NOT NULL,
	[UDF1] [nvarchar](max) NULL,
	[UDF2] [nvarchar](max) NULL,
	[UDF3] [nvarchar](max) NULL,
	[UDF4] [nvarchar](max) NULL,
	[UDF5] [nvarchar](max) NULL,
	[IsOverried] [bit] NOT NULL,
	[IsNewClientDate] [bit] NOT NULL,
	[NewClientDate] [datetime] NULL,
	[IsEngagementLetter] [bit] NOT NULL,
	[EngagementLetter] [datetime] NULL,
	[IsCongratulationDone] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Client_Master_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Client_Master]) > 0
 BEGIN
CREATE TABLE [dbo].[Client_Master_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*CnAPacketInfo*/
 IF OBJECT_ID('dbo.CnAPacketInfo_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[CnAPacketInfo_MP] (LoopId INT IDENTITY(1,1), 
	[CnAPacketInfo_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[CnAPacketSentDate] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.CnAPacketInfo_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[CnAPacketInfo]) > 0
 BEGIN
CREATE TABLE [dbo].[CnAPacketInfo_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Comm_Log*/
 IF OBJECT_ID('dbo.Comm_Log_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Comm_Log_MP] (LoopId INT IDENTITY(1,1), 
	[Comm_Log_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Comm_Log_Type] [int] NOT NULL,
	[Comm_Log_Origination] [int] NOT NULL,
	[Comm_Log_Category] [int] NOT NULL,
	[Sub_Category] [nvarchar](25) NULL,
	[Comm_Log_Status] [int] NOT NULL,
	[Plan_ID] [int] NULL,
	[Project_ID] [int] NULL,
	[AdHocToDo] [int] NULL,
	[Title] [nvarchar](200) NOT NULL,
	[CommContact1] [nvarchar](100) NULL,
	[CommContact2] [nvarchar](100) NULL,
	[CommContact3] [nvarchar](100) NULL,
	[Attachment_ID] [int] NULL,
	[Comm_Log_Text] [ntext] NULL,
	[Duplicate] [bit] NOT NULL,
	[Internal_Use_Only] [bit] NOT NULL,
	[OriginDate] [datetime] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Actual_Time] [decimal](10, 5) NULL,
	[CreatedByWho] [int] NULL,
	[IsDeletedFromOutlook] [bit] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[ByWhoClient] [int] NOT NULL,
	[LastTouchedClient] [datetime] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Comm_Log_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Comm_Log]) > 0
 BEGIN
CREATE TABLE [dbo].[Comm_Log_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ComplianceQuestionGroup*/
 IF OBJECT_ID('dbo.ComplianceQuestionGroup_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ComplianceQuestionGroup_MP] (LoopId INT IDENTITY(1,1), 
	[ComplianceQuestionGroup_ID] [int] NOT NULL,
	[ComplianceQuestionGroup_Text] [nvarchar](255) NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.ComplianceQuestionGroup_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ComplianceQuestionGroup]) > 0
 BEGIN
CREATE TABLE [dbo].[ComplianceQuestionGroup_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ComplianceQuestions*/
 IF OBJECT_ID('dbo.ComplianceQuestions_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ComplianceQuestions_MP] (LoopId INT IDENTITY(1,1), 
	[Questionnaire_ID] [int] NOT NULL,
	[Questionnaire_Group] [int] NOT NULL,
	[Questionnaire_Type] [int] NOT NULL,
	[Plan_Restrictions] [int] NOT NULL,
	[BusinessType_Restrictions] [int] NOT NULL,
	[Effective_Year] [int] NOT NULL,
	[Last_Effective_Year] [int] NOT NULL,
	[Question_Text] [text] NOT NULL,
	[Question_Hint] [text] NOT NULL,
	[AskYN] [bit] NOT NULL,
	[AskAmount] [bit] NOT NULL,
	[AskText] [bit] NOT NULL,
	[AskDate] [bit] NOT NULL,
	[SectionLabel] [nvarchar](5) NOT NULL,
	[Position] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.ComplianceQuestions_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ComplianceQuestions]) > 0
 BEGIN
CREATE TABLE [dbo].[ComplianceQuestions_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Contacts*/
 IF OBJECT_ID('dbo.Contacts_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Contacts_MP] (LoopId INT IDENTITY(1,1), 
	[Contact_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Contact_No] [int] NOT NULL,
	[Contact_Type] [int] NOT NULL,
	[Last_Name] [nvarchar](100) NOT NULL,
	[MI] [nvarchar](2) NULL,
	[First_Name] [nvarchar](100) NOT NULL,
	[Greeting] [nvarchar](100) NULL,
	[Credentials] [nvarchar](50) NULL,
	[Contact_Method] [int] NULL,
	[CommunicationPreference] [int] NULL,
	[Address] [int] NULL,
	[MailAddress] [int] NULL,
	[Advisor_Notes] [int] NULL,
	[CC] [int] NULL,
	[BoardMember] [bit] NULL,
	[Trustee] [bit] NULL,
	[StockHolder] [bit] NULL,
	[StockPercent] [decimal](18, 5) NULL,
	[PrimaryContact] [bit] NULL,
	[CorporateOfficer] [bit] NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[InvoiceContact] [bit] NULL,
	[Sinor] [bit] NULL,
	[PINConfirmed] [bit] NULL,
	[RegistrationEmail] [varchar](200) NULL,
	[Date5500Signer] [datetime] NULL,
	[ASCSignerUpdated] [bit] NULL,
	[DateASCSignerUpdate] [datetime] NULL,
	[BoardMemberSinceWhen] [datetime] NULL,
	[IsComplete] [bit] NOT NULL,
	[IsDeletedFromOutlook] [bit] NOT NULL,
	[AdministrativeContact] [bit] NOT NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastTouched_Client] [datetime] NOT NULL,
	[prefix] [int] NOT NULL,
	[suffix] [int] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[PriorOwnerPercent] [decimal](18, 0) NOT NULL,
	[PriorOwnerYear] [int] NOT NULL,
	[IsSameClientMainAddress] [bit] NOT NULL,
	[IsSameClientMailAddress] [bit] NOT NULL,
	[IsSameAsAboveAddress] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL,
	[OrignalPpcClientId] AS [Client_ID],
	[EffectiveDtCO] [nvarchar](50) NULL,
	[EffectiveDtBM] [nvarchar](50) NULL,
	[EffectiveDtTrustee] [nvarchar](50) NULL,
	[EffectiveDtSH] [nvarchar](50) NULL,
	[UDF1] [nvarchar](max) NULL,
	[UDF2] [nvarchar](max) NULL,
	[UDF3] [nvarchar](max) NULL,
	[UDF4] [nvarchar](max) NULL,
	[UDF5] [nvarchar](max) NULL)
END
 IF OBJECT_ID('dbo.Contacts_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Contacts]) > 0
 BEGIN
CREATE TABLE [dbo].[Contacts_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DocTrackTicket*/
 IF OBJECT_ID('dbo.DocTrackTicket_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DocTrackTicket_MP] (LoopId INT IDENTITY(1,1), 
	[DocTrackTicket_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[Document_Name] [nvarchar](150) NOT NULL,
	[Document_Purpose] [nvarchar](100) NOT NULL,
	[AmendingWhat] [int] NOT NULL,
	[Document_Work] [nvarchar](255) NOT NULL,
	[AmendmentNumber] [int] NOT NULL,
	[Effective_Date] [datetime] NOT NULL,
	[Deadline] [datetime] NOT NULL,
	[Consultant] [int] NOT NULL,
	[RequestInitiatedPriorToTracking] [bit] NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[RequestDateByWho] [int] NOT NULL,
	[RequestCanceled] [datetime] NOT NULL,
	[RequestCanceledByWho] [int] NOT NULL,
	[ManagementApprovalRequired] [bit] NOT NULL,
	[ManagementApprovalGiven] [bit] NOT NULL,
	[ManagementApprovalGivenWhen] [datetime] NOT NULL,
	[ManagementApprovalGivenByWho] [int] NOT NULL,
	[WriteUpDraftAssignedTo] [int] NOT NULL,
	[WriteUpDraftWhen] [datetime] NOT NULL,
	[WriteUpDraftDone] [bit] NOT NULL,
	[ReviewAssignedTo] [int] NOT NULL,
	[ReviewWhen] [datetime] NOT NULL,
	[ReviewDone] [bit] NOT NULL,
	[ReturnFromReviewAssignedTo] [int] NOT NULL,
	[ReturnFromReviewDone] [bit] NOT NULL,
	[ReturnFromReviewWhen] [datetime] NOT NULL,
	[FinalSignOffAssignedTo] [int] NOT NULL,
	[FinalSignOffWhen] [datetime] NOT NULL,
	[FinalSignOffDone] [bit] NOT NULL,
	[InvoiceAssignedTo] [int] NOT NULL,
	[InvoiceWhen] [datetime] NOT NULL,
	[InvoiceDone] [bit] NOT NULL,
	[FinalForMailAssignedTo] [int] NOT NULL,
	[FinalForMailWhen] [datetime] NOT NULL,
	[FinalForMailDone] [bit] NOT NULL,
	[PagesMarkedSignedByWho] [int] NOT NULL,
	[PagesMarkedSignedWhen] [datetime] NOT NULL,
	[PagesReceivedByWho] [int] NOT NULL,
	[PagesReceivedWhen] [datetime] NOT NULL,
	[DateClientNotifiedOfFee] [datetime] NOT NULL,
	[DateClientApprovedFee] [datetime] NOT NULL,
	[FeeEstimate] [decimal](14, 2) NOT NULL,
	[InvoiceNumber] [int] NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[InvoiceAmount] [decimal](14, 2) NOT NULL,
	[DeliveryMode] [int] NOT NULL,
	[MeetingDate] [datetime] NOT NULL,
	[DateSent] [datetime] NOT NULL,
	[DateSentByWho] [int] NOT NULL,
	[NotesSummary] [int] NOT NULL,
	[Locked] [bit] NOT NULL,
	[LockedByWho] [int] NOT NULL,
	[LockedStamp] [datetime] NOT NULL,
	[LockLevel] [int] NOT NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[BookmarkAnnotateWhen] [datetime] NULL,
	[BookmarkAnnotateAssignedTo] [int] NULL,
	[BookmarkAnnotateDone] [bit] NULL,
	[AttachmentId] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.DocTrackTicket_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DocTrackTicket]) > 0
 BEGIN
CREATE TABLE [dbo].[DocTrackTicket_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Documents*/
 IF OBJECT_ID('dbo.Documents_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Documents_MP] (LoopId INT IDENTITY(1,1), 
	[Document_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Document_Name] [nvarchar](256) NOT NULL,
	[Local_Name] [nvarchar](256) NOT NULL,
	[Mime_Type] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](200) NULL,
	[SubCategory] [nvarchar](25) NULL,
	[Permission_Level] [int] NOT NULL,
	[lastTouched] [datetime] NOT NULL,
	[byWho] [int] NOT NULL,
	[Plan_Stamp] [nvarchar](10) NULL,
	[Cluster_ID] [int] NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Documents_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Documents]) > 0
 BEGIN
CREATE TABLE [dbo].[Documents_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Documents_Cluster*/
IF OBJECT_ID('dbo.Documents_Cluster_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Documents_Cluster_MP] (LoopId INT IDENTITY(1,1), 
	[DocumentClusterUnique_ID] [int] NOT NULL,
	[DocumentCluster_ID] [int] NOT NULL,
	[Document_ID] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Documents_Cluster_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Documents_Cluster]) > 0
 BEGIN
CREATE TABLE [dbo].[Documents_Cluster_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*EmailPlanReview_Lib*/
IF OBJECT_ID('dbo.EmailPlanReview_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[EmailPlanReview_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Plan_Index_ID] [int] NOT NULL,
	[PlanYear] [int] NOT NULL,
	[TotalPlanCount] [int] NOT NULL,
	[CheckedPlanCount] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.EmailPlanReview_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[EmailPlanReview_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[EmailPlanReview_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*EmailRecord*/
IF OBJECT_ID('dbo.EmailRecord_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[EmailRecord_MP] (LoopId INT IDENTITY(1,1), 
	[EmailRecord_ID] [int] NOT NULL,
	[Email_From] [nvarchar](100) NOT NULL,
	[Email_To] [nvarchar](500) NOT NULL,
	[Email_CC] [nvarchar](max) NULL,
	[Email_Subject] [nvarchar](500) NOT NULL,
	[Email_Text] [ntext] NOT NULL,
	[Client_ID] [int] NULL,
	[Contact_ID] [int] NULL,
	[Advisor_ID] [int] NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Email_Attachment] [int] NULL,
	[IsDeletedFromOutlook] [bit] NOT NULL,
	[ByWhoClient] [int] NOT NULL,
	[LastTouchedClient] [datetime] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL,
	[ScheduleId] [int] NULL,
	[StatusId] [int] NULL,
	[EmailTypeId] [int] NULL,
	[ResponseCode] [nvarchar](max) NULL,
	[CCStatus] [nvarchar](max) NULL,
	[CCResponseCode] [nvarchar](max) NULL)
END
 IF OBJECT_ID('dbo.EmailRecord_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[EmailRecord]) > 0
 BEGIN
CREATE TABLE [dbo].[EmailRecord_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*MarketValuationTracking*/
IF OBJECT_ID('dbo.MarketValuationTracking_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[MarketValuationTracking_MP] (LoopId INT IDENTITY(1,1), 
	[MarketValuation_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[PYE_Month] [nvarchar](5) NOT NULL,
	[Asset_Index] [int] NOT NULL,
	[Money_Type] [int] NOT NULL,
	[Account_Type] [int] NOT NULL,
	[Record_Keeper] [nvarchar](100) NULL,
	[RK_Account_No] [nvarchar](50) NULL,
	[Custodian] [nvarchar](100) NULL,
	[C_Account_No] [nvarchar](50) NULL,
	[Statement_Delivery] [int] NOT NULL,
	[Advisor] [int] NOT NULL,
	[Notes] [bit] NULL,
	[More] [bit] NULL,
	[Same_As] [int] NULL,
	[Sch_A_Required] [bit] NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Notes_ID] [int] NULL,
	[QBSAction] [int] NULL,
	[InvestmentPlatform] [int] NULL,
	[AssetConfirmed] [bit] NULL,
	[AssetConfirmedByWho] [int] NULL,
	[AssetConfirmedByType] [int] NULL,
	[AssetConfirmedWhen] [datetime] NULL,
	[Kind] [nvarchar](10) NULL,
	[AccountClosed] [bit] NOT NULL,
	[LastStatementDate] [datetime] NULL,
	[FirstStatementDate] [datetime] NULL,
	[NonQualifiedAsset] [bit] NULL,
	[Download] [bit] NOT NULL,
	[AssetTracking_ID] [int] NULL,
	[IsPortalDeleted] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.MarketValuationTracking_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[MarketValuationTracking]) > 0
 BEGIN
CREATE TABLE [dbo].[MarketValuationTracking_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*MonthlyStatement*/
IF OBJECT_ID('dbo.MonthlyStatement_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[MonthlyStatement_MP] (LoopId INT IDENTITY(1,1), 
	[MonthlyStatement_ID] [int] NOT NULL,
	[PYE_ID] [int] NOT NULL,
	[PYE_Day] [int] NOT NULL,
	[Month01] [int] NOT NULL,
	[Received01] [bit] NOT NULL,
	[Month02] [int] NOT NULL,
	[Received02] [bit] NOT NULL,
	[Month03] [int] NOT NULL,
	[Received03] [bit] NOT NULL,
	[Month04] [int] NOT NULL,
	[Received04] [bit] NOT NULL,
	[Month05] [int] NOT NULL,
	[Received05] [bit] NOT NULL,
	[Month06] [int] NOT NULL,
	[Received06] [bit] NOT NULL,
	[Month07] [int] NOT NULL,
	[Received07] [bit] NOT NULL,
	[Month08] [int] NOT NULL,
	[Received08] [bit] NOT NULL,
	[Month09] [int] NOT NULL,
	[Received09] [bit] NOT NULL,
	[Month10] [int] NOT NULL,
	[Received10] [bit] NOT NULL,
	[Month11] [int] NOT NULL,
	[Received11] [bit] NOT NULL,
	[Month12] [int] NOT NULL,
	[Received12] [bit] NOT NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Month01Doc] [int] NULL,
	[Month02Doc] [int] NULL,
	[Month03Doc] [int] NULL,
	[Month04Doc] [int] NULL,
	[Month05Doc] [int] NULL,
	[Month06Doc] [int] NULL,
	[Month07Doc] [int] NULL,
	[Month08Doc] [int] NULL,
	[Month09Doc] [int] NULL,
	[Month10Doc] [int] NULL,
	[Month11Doc] [int] NULL,
	[Month12Doc] [int] NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.MonthlyStatement_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[MonthlyStatement]) > 0
 BEGIN
CREATE TABLE [dbo].[MonthlyStatement_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Notes]*/
IF OBJECT_ID('dbo.Notes_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Notes_MP] (LoopId INT IDENTITY(1,1), 
	[Notes_ID] [int] NOT NULL,
	[Notes_Text] [ntext] NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Notes_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Notes]) > 0
 BEGIN
CREATE TABLE [dbo].[Notes_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ParticipantFeeDisclosure*/
IF OBJECT_ID('dbo.ParticipantFeeDisclosure_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ParticipantFeeDisclosure_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[loan_org_change] [float] NOT NULL,
	[loan_on_sdbac] [float] NOT NULL,
	[refinanced_loan_org] [float] NOT NULL,
	[distribution] [float] NOT NULL,
	[distribution_on_sdbac] [float] NOT NULL,
	[1099R_preparation] [float] NOT NULL,
	[qdro_consulting] [nvarchar](50) NULL,
	[client_id] [int] NOT NULL,
	[is_dc_plan] [bit] NULL,
	[is_db_plan] [bit] NULL,
	[created_date] [datetime] NULL,
	[NoticeDueDate] [datetime] NOT NULL)
END
 IF OBJECT_ID('dbo.ParticipantFeeDisclosure_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ParticipantFeeDisclosure]) > 0
 BEGIN
CREATE TABLE [dbo].[ParticipantFeeDisclosure_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PlanExpiringFormulaDocuments*/
IF OBJECT_ID('dbo.PlanExpiringFormulaDocuments_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PlanExpiringFormulaDocuments_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[PlanIndexId] [int] NOT NULL,
	[PlanYear] [int] NOT NULL,
	[documentId] [int] NOT NULL,
	[documentTypeId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL)
END
 IF OBJECT_ID('dbo.PlanExpiringFormulaDocuments_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PlanExpiringFormulaDocuments]) > 0
 BEGIN
CREATE TABLE [dbo].[PlanExpiringFormulaDocuments_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Plans*/
IF OBJECT_ID('dbo.Plans_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Plans_MP] (LoopId INT IDENTITY(1,1),
	[Plans_Index_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Plan_Number] [int] NOT NULL,
	[Plan_Name] [nvarchar](255) NOT NULL,
	[PlanYE] [nvarchar](5) NOT NULL,
	[Plan_Type_Code] [int] NOT NULL,
	[ServiceType] [int] NOT NULL,
	[BillingType] [int] NOT NULL,
	[DocType] [int] NOT NULL,
	[TrustId] [nvarchar](12) NOT NULL,
	[InvestmentPlatform] [int] NOT NULL,
	[DocResponsible] [int] NOT NULL,
	[AssetType] [int] NOT NULL,
	[PlanStatus] [int] NOT NULL,
	[Consultant] [int] NOT NULL,
	[CSR] [int] NOT NULL,
	[Acquired_Date] [datetime] NOT NULL,
	[FirstYrRespon] [int] NOT NULL,
	[PlanOrigin] [int] NOT NULL,
	[TakeOverFrom] [nvarchar](255) NOT NULL,
	[DocCreatedBy] [nvarchar](255) NOT NULL,
	[SvcAgreementDate] [datetime] NOT NULL,
	[LastAmendmentDate] [datetime] NOT NULL,
	[PlanEffectiveDate] [datetime] NOT NULL,
	[PlanRestatementDate] [datetime] NOT NULL,
	[DateNotifiedOfDeparture] [datetime] NOT NULL,
	[NotifiedOfDepartureToWho] [int] NOT NULL,
	[PlanTerminationDate] [datetime] NOT NULL,
	[DepartureTPAFirm] [nvarchar](255) NOT NULL,
	[LastYearResponsible] [int] NOT NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[SafeHarborProvision] [bit] NULL,
	[LinkedPlan_ID] [int] NULL,
	[ServiceSchedule_Lib_ID] [int] NULL,
	[LinkedPlanIndexID] [int] NULL,
	[PlanYB] [nvarchar](5) NULL,
	[ShortPlanYear] [bit] NULL,
	[ShortPlanYearEndDate] [nvarchar](5) NULL,
	[DateOfLastWork] [datetime] NULL,
	[prev_plan_status] [int] NULL,
	[ReasonForDeparture] [nvarchar](250) NULL,
	[LastDepartureUpdated] [varchar](100) NOT NULL,
	[LastDepartureUpdatedByWho] [int] NOT NULL,
	[TakeOverFromId] [int] NULL,
	[ReasonForDepartureId] [int] NULL,
	[NewTpaFirmId] [int] NULL,
	[OrignalPpcClientId] AS [Client_ID],
	[ReportingCycle] [int] NOT NULL,
	[Client_Name] [varchar](500) NULL,
	[UDF1] [nvarchar](max) NULL,
	[UDF2] [nvarchar](max) NULL,
	[UDF3] [nvarchar](max) NULL,
	[UDF4] [nvarchar](max) NULL,
	[UDF5] [nvarchar](max) NULL,
	[ClientPlanId] [nvarchar](50) NULL)
END
 IF OBJECT_ID('dbo.Plans_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Plans]) > 0
 BEGIN
CREATE TABLE [dbo].[Plans_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


/*[dbo].[Plans_YearToYear]*/
IF OBJECT_ID('dbo.Plans_YearToYear_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Plans_YearToYear_MP] (LoopId INT IDENTITY(1,1),
	[Plans_YearToYear_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[Type5500] [int] NOT NULL,
	[Analyst] [int] NOT NULL,
	[Reviewer] [int] NOT NULL,
	[SafeHarbor] [bit] NOT NULL,
	[SafeHarbor_Type] [int] NOT NULL,
	[ACA] [bit] NOT NULL,
	[ACA_Type] [int] NOT NULL,
	[ACA_MIN_PERC] [decimal](5, 2) NOT NULL,
	[ACA_MAX_PERC] [decimal](5, 2) NOT NULL,
	[PBGC_Covered] [bit] NOT NULL,
	[Formulae] [nvarchar](150) NOT NULL,
	[NoAdpTesting_Required] [bit] NOT NULL,
	[NoAcpTesting_Required] [bit] NOT NULL,
	[BondCompany] [nvarchar](255) NOT NULL,
	[FidBondAmt] [money] NOT NULL,
	[BondDate] [datetime] NOT NULL,
	[FeeOverride] [bit] NOT NULL,
	[BaseFee] [money] NOT NULL,
	[PerParticipantFee] [money] NOT NULL,
	[NonParticipantFee] [money] NOT NULL,
	[LoanFee] [money] NOT NULL,
	[Plan_Termed] [bit] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[BondRequired] [bit] NULL,
	[DateAssignedForWork] [datetime] NULL,
	[AssetAnalyst] [int] NULL,
	[AssetReviewer] [int] NULL,
	[AssetDateAssignedForWork] [datetime] NULL,
	[ProfitSharing] [bit] NULL,
	[CrossTesting] [bit] NULL,
	[Aggregate] [bit] NULL,
	[TopHeavy] [bit] NULL,
	[ParticipantCount] [decimal](30, 0) NULL,
	[JobTitleAddenReq] [bit] NULL,
	[ActivePlanYear] [bit] NULL,
	[SHConfirmed] [bit] NULL,
	[SHConfirmedBy] [int] NULL,
	[SHConfirmedWhen] [datetime] NULL,
	[AcaConfirmed] [bit] NULL,
	[AcaConfirmedBy] [int] NULL,
	[AcaConfirmedWhen] [datetime] NULL,
	[QBSRequirement] [int] NULL,
	[InvestmentPlatform_ID] [int] NULL,
	[ER_Match_VS] [int] NULL,
	[ER_Profit_Sharing_VS] [int] NULL,
	[PlanQuarter1] [datetime] NULL,
	[PlanQuarter2] [datetime] NULL,
	[PlanQuarter3] [datetime] NULL,
	[PlanQuarter4] [datetime] NULL,
	[YearsOfService] [int] NULL,
	[ClientRefusesToGetFidelityBond] [bit] NULL,
	[ClientRefusesToGetFidelityBondWhen] [datetime] NULL,
	[ClientRefusesToGetFidelityBondByWho] [int] NULL,
	[ValuationDates] [int] NULL,
	[DistFeePaidByWho] [int] NULL,
	[DistLoansAllowed] [int] NULL,
	[DistInService] [int] NULL,
	[DistHardShips] [int] NULL,
	[AscNumber] [nvarchar](20) NULL,
	[ArcAscNumber] [nvarchar](20) NULL,
	[Form5500Filed] [bit] NULL,
	[FormulaeExpires] [bit] NULL,
	[FormulaeExpiresOn] [datetime] NULL,
	[YEAssetTotal] [decimal](30, 2) NULL,
	[AssetsAsOf] [datetime] NULL,
	[ActiveParticipants] [decimal](30, 2) NULL,
	[TermVestedParticipants] [decimal](30, 2) NULL,
	[FundingStatus] [nvarchar](10) NULL,
	[YEPVAB] [decimal](30, 2) NULL,
	[YEAFTAP] [decimal](30, 2) NULL,
	[CurrentContribution] [decimal](30, 2) NULL,
	[AVA] [decimal](30, 2) NULL,
	[AnnualPremium] [decimal](30, 2) NULL,
	[DownloadFromWeb] [bit] NOT NULL,
	[EffectiveUntilCancelled] [bit] NOT NULL,
	[TaxFilerStatus] [bit] NOT NULL,
	[EarlyDate] [datetime] NULL,
	[From5558FiledDate] [datetime] NULL,
	[IsPooled] [bit] NOT NULL,
	[IsSelfdirected] [bit] NOT NULL,
	[IsAutoIncrease] [bit] NOT NULL,
	[PriorTopHeavy] [decimal](30, 2) NOT NULL,
	[CurrentTopHeavy] [decimal](30, 2) NOT NULL,
	[DistributionFee] [money] NOT NULL,
	[DistFee] [decimal](12, 2) NULL,
	[IsBalanceForward] [bit] NOT NULL,
	[IsClientPrepElecFrm] [bit] NOT NULL,
	[IsBoycePrep1099R] [bit] NOT NULL,
	[DistInstruction] [int] NOT NULL,
	[DistDeliveryPref] [int] NOT NULL,
	[OtherDistDeliveryPref] [nvarchar](50) NULL,
	[UseInvestCoForm] [int] NOT NULL,
	[DistributionCharge] [int] NOT NULL,
	[SDBACharge] [money] NOT NULL,
	[LoanCharge] [int] NOT NULL,
	[SDBALoanCharge] [money] NOT NULL,
	[LoanRefinanceCharge] [int] NOT NULL,
	[Notes_ID] [int] NOT NULL,
	[IsQACA] [bit] NOT NULL,
	[IsQBSRequired] [bit] NOT NULL,
	[IsProvidedByPlatform] [bit] NOT NULL,
	[IsQDIARequired] [bit] NOT NULL,
	[IsTestedPlan] [bit] NOT NULL,
	[IsQDIAInvestment] [bit] NOT NULL,
	[Qdia_Investment] [nvarchar](max) NULL,
	[CurrentYear] [decimal](18, 2) NOT NULL,
	[PriorYear] [decimal](18, 2) NOT NULL,
	[IsBoyceProcessLoan] [bit] NOT NULL,
	[IsEFAST] [bit] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[Actuary] [int] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[UDF1] [nvarchar](max) NULL,
	[UDF2] [nvarchar](max) NULL,
	[UDF3] [nvarchar](max) NULL,
	[UDF4] [nvarchar](max) NULL,
	[UDF5] [nvarchar](max) NULL,
	[IsHoldFollowUp] [bit] NOT NULL,
	[IsParticipantDisclosureNoticeRequired] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Plans_YearToYear_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Plans_YearToYear]) > 0
 BEGIN
CREATE TABLE [dbo].[Plans_YearToYear_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[PlanYearEnd]*/
IF OBJECT_ID('dbo.PlanYearEnd_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PlanYearEnd_MP] (LoopId INT IDENTITY(1,1),
	[PYE_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[PYE_Month] [nvarchar](5) NOT NULL,
	[PYE_Cycle] [int] NOT NULL,
	[PYE_Period] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[TrackingDoc_Type_ID] [int] NOT NULL,
	[TrackingDoc_Type_Add] [int] NOT NULL,
	[Request_From] [int] NOT NULL,
	[Request_Delivery_Type] [int] NOT NULL,
	[Request_Init] [datetime] NULL,
	[Request_Init_Type] [int] NULL,
	[Request_Init_Doc] [int] NULL,
	[Request_Follow_1] [datetime] NULL,
	[Request_Follow_1_Type] [int] NULL,
	[Request_Follow_1_Doc] [int] NULL,
	[Request_Follow_2] [datetime] NULL,
	[Request_Follow_2_Type] [int] NULL,
	[Request_Follow_2_Doc] [int] NULL,
	[Request_Follow_3] [datetime] NULL,
	[Request_Follow_3_Type] [int] NULL,
	[Request_Follow_3_Doc] [int] NULL,
	[Request_Follow_4] [datetime] NULL,
	[Request_Follow_4_Type] [int] NULL,
	[Request_Follow_4_Doc] [int] NULL,
	[Initially_Received] [datetime] NULL,
	[Checked] [datetime] NULL,
	[More_Requested] [datetime] NULL,
	[More_Received] [datetime] NULL,
	[Reviewed] [datetime] NULL,
	[Actual_Document] [int] NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Notes_ID] [int] NULL,
	[Initially_Received_ByWho] [int] NULL,
	[More_Requested_ByWho] [int] NULL,
	[More_Received_ByWho] [int] NULL,
	[Reviewed_ByWho] [int] NULL,
	[Request_Init_ByWho] [int] NULL,
	[Request_Follow_1_ByWho] [int] NULL,
	[Request_Follow_2_ByWho] [int] NULL,
	[Request_Follow_3_ByWho] [int] NULL,
	[Request_Follow_4_ByWho] [int] NULL,
	[NotRequired] [bit] NULL,
	[NotRequiredByWho] [int] NULL,
	[NotRequiredDate] [datetime] NULL,
	[Verified] [bit] NULL,
	[VerifiedByWho] [int] NULL,
	[VerifiedWhen] [datetime] NULL,
	[Date_Invoice_Mailed] [datetime] NULL,
	[Date_Invoice_Mailed_ByWho] [int] NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[DownloadFrom] [int] NOT NULL,
	[Download] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL,
	[IsCompletedByTPA] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.PlanYearEnd_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PlanYearEnd]) > 0
 BEGIN
CREATE TABLE [dbo].[PlanYearEnd_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[PlanYearMilestone]*/
IF OBJECT_ID('dbo.PlanYearMilestone_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PlanYearMilestone_MP] (LoopId INT IDENTITY(1,1),
	[PlanYearMilestone_Id] [int] NOT NULL,
	[TrackingMilestone_Type_Id] [int] NULL,
	[PYE_Year] [int] NULL,
	[PYE_Month] [nvarchar](25) NULL,
	[Note_Id] [int] NULL,
	[DueDate] [datetime] NULL,
	[Completed] [bit] NULL,
	[CompletedBy] [int] NULL,
	[CompletedDate] [datetime] NULL,
	[WaitingOnClient] [bit] NULL,
	[WaitingOnClientDatetime] [datetime] NULL,
	[ReceivedFromclient] [bit] NULL,
	[ReceivedFromClientDatetime] [datetime] NULL,
	[LastEdited] [datetime] NULL,
	[Plans_Index_ID] [int] NULL,
	[ByWho] [int] NULL
	)
END
 IF OBJECT_ID('dbo.PlanYearMilestone_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PlanYearMilestone]) > 0
 BEGIN
CREATE TABLE [dbo].[PlanYearMilestone_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_AdditionalServicesHistory]*/
IF OBJECT_ID('dbo.Portal_AdditionalServicesHistory_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_AdditionalServicesHistory_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[PlanId] [int] NOT NULL,
	[AdditionalServiceId] [int] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_AdditionalServicesHistory_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_AdditionalServicesHistory]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_AdditionalServicesHistory_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_AdvisorNotes]*/
IF OBJECT_ID('dbo.Portal_AdvisorNotes_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_AdvisorNotes_MP] (LoopId INT IDENTITY(1,1),
	[NotesID] [int] NOT NULL,
	[NotesText] [ntext] NULL,
	[LastTouched] [datetime] NOT NULL,
	[AdvisorID] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
	[PlanID] [int] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_AdvisorNotes_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_AdvisorNotes]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_AdvisorNotes_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ChangeRequest]*/
IF OBJECT_ID('dbo.Portal_ChangeRequest_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ChangeRequest_MP] (LoopId INT IDENTITY(1,1),
	[ID] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[ContactId] [int] NOT NULL,
	[ChangeType] [varchar](50) NOT NULL,
	[ColumnName] [varchar](50) NOT NULL,
	[RequestValue] [varchar](max) NOT NULL,
	[IsNew] [bit] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[IsPoratlDeleted] [bit] NOT NULL,
	[IsRejected] [bit] NOT NULL,
	[IsAcepted] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ChangeRequest_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ChangeRequest]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ChangeRequest_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ClientContactType]*/
IF OBJECT_ID('dbo.Portal_ClientContactType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ClientContactType_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[ContactId] [int] NOT NULL,
	[ContactType] [int] NOT NULL,
	[ContactTypeText] [nvarchar](100) NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ClientContactType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ClientContactType]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ClientContactType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ClientFilesActivity]*/
IF OBJECT_ID('dbo.Portal_ClientFilesActivity_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ClientFilesActivity_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[FileId] [int] NOT NULL,
	[FileName] [varchar](150) NOT NULL,
	[FilePath] [varchar](300) NOT NULL,
	[Activity] [varchar](20) NOT NULL,
	[ActivityDate] [datetime] NOT NULL,
	[UserType] [varchar](20) NOT NULL,
	[UserEmail] [varchar](50) NOT NULL,
	[CompanyName] [varchar](50) NULL,
	[IpAddress] [varchar](30) NULL,
	[Location] [varchar](100) NULL,
	[ClientId] [int] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ClientFilesActivity_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ClientFilesActivity]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ClientFilesActivity_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ClientUpdateInfo]*/
IF OBJECT_ID('dbo.Portal_ClientUpdateInfo_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ClientUpdateInfo_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[AdvisorId] [int] NOT NULL,
	[ContactId] [int] NOT NULL,
	[OwnerId] [int] NOT NULL,
	[PlanId] [int] NOT NULL,
	[ColumnName] [varchar](50) NULL,
	[ColumnValue] [varchar](150) NULL,
	[IsClient] [bit] NOT NULL,
	[IsAdvisor] [bit] NOT NULL,
	[IsContact] [bit] NOT NULL,
	[IsOwner] [bit] NOT NULL,
	[ByWhoClient] [int] NOT NULL,
	[LastUpdatedClient] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[IsChange] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ClientUpdateInfo_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ClientUpdateInfo]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ClientUpdateInfo_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Portal_CommLogContactAdvisor*/
IF OBJECT_ID('dbo.Portal_CommLogContactAdvisor_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_CommLogContactAdvisor_MP] (LoopId INT IDENTITY(1,1),
	[CommLogContactAdvisorId] [int] NOT NULL,
	[CommLogId] [int] NOT NULL,
	[ContactAdvisorId] [int] NOT NULL,
	[IsContactAdvisor] [nvarchar](50) NOT NULL,
	[IsSelected] [bit] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_CommLogContactAdvisor_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_CommLogContactAdvisor]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_CommLogContactAdvisor_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ComplianceCalender_Master]*/
IF OBJECT_ID('dbo.Portal_ComplianceCalender_Master_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ComplianceCalender_Master_MP] (LoopId INT IDENTITY(1,1),
	[ID] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[IsDB] [bit] NOT NULL,
	[IsDC] [bit] NOT NULL,
	[Task] [nvarchar](max) NOT NULL,
	[Requirement] [nvarchar](max) NOT NULL,
	[DueDates] [int] NOT NULL,
	[IsCYE] [bit] NOT NULL,
	[IsPYE] [bit] NOT NULL,
	[PYEAddMonth] [int] NOT NULL,
	[PYEAddDays] [int] NOT NULL,
	[NoticeTrigger] [nvarchar](100) NULL,
	[YearCurrentPast] [nvarchar](50) NOT NULL,
	[IsSharefile] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ComplianceCalender_Master_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ComplianceCalender_Master]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ComplianceCalender_Master_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


/*[dbo].[Portal_ConfirmationOfContribution]*/
IF OBJECT_ID('dbo.Portal_ConfirmationOfContribution_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ConfirmationOfContribution_MP] (LoopId INT IDENTITY(1,1),
	[ConfirmationOfContributionId] [int] NOT NULL,
	[PlanIndexId] [int] NOT NULL,
	[PlanYear] [int] NOT NULL,
	[ContributionNotes] [nvarchar](max) NULL,
	[ByWho] [int] NOT NULL,
	[LastUpdated] [nvarchar](max) NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ConfirmationOfContribution_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ConfirmationOfContribution]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ConfirmationOfContribution_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ContributionDepositDetails]*/
IF OBJECT_ID('dbo.Portal_ContributionDepositDetails_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ContributionDepositDetails_MP] (LoopId INT IDENTITY(1,1),
	[ContributionDepositDetailsId] [int] NOT NULL,
	[ConfirmationOfContributionId] [int] NOT NULL,
	[DepositDate] [date] NOT NULL,
	[Investment] [float] NOT NULL,
	[AssetName] [nvarchar](250) NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ContributionDepositDetails_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ContributionDepositDetails]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ContributionDepositDetails_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_DocMaintainedBy]*/
IF OBJECT_ID('dbo.Portal_DocMaintainedBy_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_DocMaintainedBy_MP] (LoopId INT IDENTITY(1,1),
	[DocMaintainedById] [int] NOT NULL,
	[DocMaintainedByName] [nvarchar](250) NULL
	)
END
 IF OBJECT_ID('dbo.Portal_DocMaintainedBy_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_DocMaintainedBy]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_DocMaintainedBy_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_DocumentDetails]*/
IF OBJECT_ID('dbo.Portal_DocumentDetails_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentDetails_MP] (LoopId INT IDENTITY(1,1),
	[DocTrackTicketId] [int]  NOT NULL,
	[PlansIndexId] [int] NOT NULL,
	[DocumentName] [nvarchar](max) NOT NULL,
	[DocumentPurpose] [nvarchar](max) NOT NULL,
	[DocumentWorkId] [int] NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[Consultant] [int] NOT NULL,
	[RequestCanceled] [bit] NOT NULL,
	[RequestCanceledDate] [datetime] NOT NULL,
	[RequestCanceledByWho] [int] NOT NULL,
	[AmendingWhatId] [int] NOT NULL,
	[AmendmentNumber] [int] NOT NULL,
	[Deadline] [datetime] NOT NULL,
	[DateClientNotifiedOfFee] [datetime] NOT NULL,
	[DateClientApprovedOfFee] [datetime] NOT NULL,
	[FeeEstimateCharges] [decimal](18, 2) NOT NULL,
	[InvoiceCharges] [decimal](18, 2) NOT NULL,
	[InvoiceNumber] [int] NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[ManagementApprovalRequired] [bit] NOT NULL,
	[ManagementApprovalGivenWhen] [datetime] NOT NULL,
	[ManagementApprovalGivenByWho] [int] NOT NULL,
	[NoteId] [int] NOT NULL,
	[ByWho] [int] NOT NULL,
	[LastEdited] [datetime] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[AttachmentId] [int] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_DocumentDetails_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_DocumentDetails]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentDetails_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


/*[dbo].[Portal_DocumentTaskEvents]*/
IF OBJECT_ID('dbo.Portal_DocumentTaskEvents_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTaskEvents_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
	[EventType] [int] NOT NULL,
	[Action] [int] NOT NULL,
	[ExecuteTasks] [nvarchar](max) NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_DocumentTaskEvents_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_DocumentTaskEvents]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTaskEvents_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_DocumentTemplateMapping]*/
IF OBJECT_ID('dbo.Portal_DocumentTemplateMapping_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTemplateMapping_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[PlanTypeId] [int] NOT NULL,
	[DocumentTypeId] [varchar](max) NOT NULL,
	[TemplateTypeId] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[UpdatedByWho] [int] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_DocumentTemplateMapping_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_DocumentTemplateMapping]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTemplateMapping_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_DocumentTemplates]*/
IF OBJECT_ID('dbo.Portal_DocumentTemplates_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTemplates_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[TemplateType] [int] NOT NULL,
	[DocumentType] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
	[Assignee] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[Deadline] [decimal](18, 2) NOT NULL,
	[Percentage] [decimal](18, 2) NOT NULL,
	[TaskType] [int] NOT NULL,
	[BudgetedTime] [decimal](18, 2) NOT NULL,
	[IsCreateToDo] [bit] NOT NULL,
	[IsSendEmail] [bit] NOT NULL,
	[TemplateCompletionStatus] [bit] NOT NULL,
	[IsDeliveryAdd] [bit] NOT NULL,
	[Ordering] [int] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_DocumentTemplates_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_DocumentTemplates]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTemplates_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_DocumentTracking]*/
IF OBJECT_ID('dbo.Portal_DocumentTracking_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTracking_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[DocumentTrackId] [int] NOT NULL,
	[PlanId] [int] NOT NULL,
	[DocumentType] [int] NOT NULL,
	[Assignee] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[TaskStatus] [int] NOT NULL,
	[Start] [datetime] NOT NULL,
	[Pause] [datetime] NOT NULL,
	[ContinueOn] [datetime] NOT NULL,
	[Delay] [datetime] NOT NULL,
	[Finished] [datetime] NOT NULL,
	[TaskName] [nvarchar](max) NOT NULL,
	[TaskType] [int] NOT NULL,
	[IsTaskEnable] [bit] NOT NULL,
	[TaskCategory] [int] NOT NULL,
	[Deadline] [decimal](18, 0) NOT NULL,
	[Percentage] [numeric](18, 0) NOT NULL,
	[IsDeliveredByAdd] [bit] NOT NULL,
	[DeliveredBy] [int] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL,
	[Ordering] [int] NOT NULL,
	[AssigneeUserId] [int] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_DocumentTracking_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_DocumentTracking]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_DocumentTracking_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_InfoGatheredTriggers]*/
IF OBJECT_ID('dbo.Portal_InfoGatheredTriggers_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_InfoGatheredTriggers_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Plan_Id] [int] NOT NULL,
	[Plan_Year] [int] NOT NULL,
	[Task] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[SubType] [nvarchar](50) NOT NULL,
	[TriggerFor] [nvarchar](50) NULL,
	[IsDone] [bit] NOT NULL,
	[DoneByWho] [int] NOT NULL,
	[DoneLastUpdated] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DoneByWho_Client] [int] NOT NULL,
	[DoneLastUpdated_Client] [datetime] NOT NULL,
	[CreatedByWho] [int] NOT NULL,
	[LastCreateddate] [datetime] NOT NULL,
	[TrackingDocTypeID] [int] NOT NULL,
	[TrackingDocTypeAdd] [int] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_InfoGatheredTriggers_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_InfoGatheredTriggers]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_InfoGatheredTriggers_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


/*[dbo].[Portal_OptionalOwnership]*/
IF OBJECT_ID('dbo.Portal_OptionalOwnership_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_OptionalOwnership_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[PlanYear] [int] NOT NULL,
	[OwnerName] [nvarchar](100) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[PriorOwnerPercent] [decimal](18, 2) NOT NULL,
	[CurrentOwnerPercent] [decimal](18, 2) NOT NULL,
	[EffectiveDate] [nvarchar](100) NOT NULL,
	[ByWhoClient] [int] NOT NULL,
	[LastUpdatedClient] [datetime] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_OptionalOwnership_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_OptionalOwnership]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_OptionalOwnership_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


/*[dbo].[Portal_OwnershipConfirmationTimestamp]*/
IF OBJECT_ID('dbo.Portal_OwnershipConfirmationTimestamp_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_OwnershipConfirmationTimestamp_MP] (LoopId INT IDENTITY(1,1),
	[ConfirmationId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[OwnershipLastUpdatedBy] [int] NOT NULL,
	[OwnershipLastUpdatedDate] [datetime] NOT NULL,
	[IsLastUpdateByAdvisor] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_OwnershipConfirmationTimestamp_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_OwnershipConfirmationTimestamp]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_OwnershipConfirmationTimestamp_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_Permissions]*/
IF OBJECT_ID('dbo.Portal_Permissions_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_Permissions_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[SectionId] [int] NOT NULL,
	[IsReadOnly] [bit] NOT NULL,
	[IsWrite] [bit] NOT NULL,
	[TurnOff] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_Permissions_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_Permissions]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_Permissions_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


/*[dbo].[Portal_Permissions]*/
IF OBJECT_ID('dbo.Portal_Permissions_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_Permissions_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[SectionId] [int] NOT NULL,
	[IsReadOnly] [bit] NOT NULL,
	[IsWrite] [bit] NOT NULL,
	[TurnOff] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_Permissions_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_Permissions]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_Permissions_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


/*[dbo].[Portal_ProgressBarStat]*/
IF OBJECT_ID('dbo.Portal_ProgressBarStat_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ProgressBarStat_MP] (LoopId INT IDENTITY(1,1),
	[ProgressId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[IsConfirmBusinessInfoDone] [bit] NOT NULL,
	[IsConfirmOwnershipDone] [bit] NOT NULL,
	[IsAnnualComQuesDone] [bit] NOT NULL,
	[IsAnnualPlanQuesDone] [bit] NOT NULL,
	[IsAnnualFormQuesDone] [bit] NOT NULL,
	[IsFidelityBondDone] [bit] NOT NULL,
	[IsCODDone] [bit] NOT NULL,
	[IsCensusDone] [bit] NOT NULL,
	[PYE_Year] [int] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ProgressBarStat_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ProgressBarStat]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ProgressBarStat_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ReopenDocumentTask]*/
IF OBJECT_ID('dbo.Portal_ReopenDocumentTask_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ReopenDocumentTask_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[DocumentTrackingId] [int] NOT NULL,
	[FinishedDate1] [datetime] NOT NULL,
	[FinishedAssignee1] [int] NOT NULL,
	[FinishedByWho1] [int] NOT NULL,
	[FinishedDate2] [datetime] NOT NULL,
	[FinishedAssignee2] [int] NOT NULL,
	[FinishedByWho2] [int] NOT NULL,
	[ReopenDate1] [datetime] NOT NULL,
	[ReopenByWho1] [int] NOT NULL,
	[ReopenDate2] [datetime] NOT NULL,
	[ReopenByWho2] [int] NOT NULL,
	[IsPortalDeleted] [bit] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_ReopenDocumentTask_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ReopenDocumentTask]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ReopenDocumentTask_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_Roles]*/
IF OBJECT_ID('dbo.Portal_Roles_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_Roles_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_Roles_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_Roles]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_Roles_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_TimeZone]*/
IF OBJECT_ID('dbo.Portal_TimeZone_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_TimeZone_MP] (LoopId INT IDENTITY(1,1),
	[AttendanceId] [int] NOT NULL,
	[UserId] [int] NULL,
	[SundayIsAvailble] [bit] NULL,
	[SundayInTime] [varchar](50) NULL,
	[SundayOutTime] [varchar](50) NULL,
	[MondayIsAvailble] [bit] NULL,
	[MondayInTime] [varchar](50) NULL,
	[MondayOutTime] [varchar](50) NULL,
	[TuesdayIsAvailble] [bit] NULL,
	[TuesdayInTime] [varchar](50) NULL,
	[TuesdayOutTime] [varchar](50) NULL,
	[WedIsAvailble] [bit] NULL,
	[WedInTime] [varchar](50) NULL,
	[WedOutTime] [varchar](50) NULL,
	[ThurIsAvailble] [bit] NULL,
	[ThurInTime] [varchar](50) NULL,
	[ThurOutTime] [varchar](50) NULL,
	[FriIsAvailble] [bit] NULL,
	[FriInTime] [varchar](50) NULL,
	[FriOutTime] [varchar](50) NULL,
	[SatAvailble] [bit] NULL,
	[SatInTime] [varchar](50) NULL,
	[SatOutTime] [varchar](50) NULL,
	[TimeZoneId] [varchar](50) NULL,
	[TimeZoneText] [varchar](50) NULL,
	[UpdatedBy] [datetime] NOT NULL
	)
END
 IF OBJECT_ID('dbo.Portal_TimeZone_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_TimeZone]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_TimeZone_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ToDoAssigneeHistory]*/
IF OBJECT_ID('dbo.Portal_ToDoAssigneeHistory_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ToDoAssigneeHistory_MP] (LoopId INT IDENTITY(1,1),
	[Id] [int] NOT NULL,
	[TicketId] [int] NOT NULL,
	[PreviousAssignedId] [int] NOT NULL,
	[CurrentAssignedId] [int] NOT NULL,
	[AssignedDate] [datetime] NOT NULL,
	[AssignedBy] [int] NOT NULL,
	[PreparedBy] [int] NULL,
	[PreparedDate] [datetime] NULL)
END
 IF OBJECT_ID('dbo.Portal_ToDoAssigneeHistory_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ToDoAssigneeHistory]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ToDoAssigneeHistory_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_UserClientContact]*/
IF OBJECT_ID('dbo.Portal_UserClientContact_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_UserClientContact_MP] (LoopId INT IDENTITY(1,1),
	[ID] [int] NOT NULL,
	[PortalUser_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Contact_ID] [int] NOT NULL,
	[AdvisorID] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Portal_UserClientContact_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_UserClientContact]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_UserClientContact_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_UserSignatures]*/
IF OBJECT_ID('dbo.Portal_UserSignatures_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_UserSignatures_MP] (LoopId INT IDENTITY(1,1),
	[SignatureId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[SignatureName] [nvarchar](150) NOT NULL,
	[Local_Name] [nvarchar](250) NOT NULL,
	[MimeType] [nvarchar](100) NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Portal_UserSignatures_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_UserSignatures]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_UserSignatures_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Pricing_Answers]*/
IF OBJECT_ID('dbo.Pricing_Answers_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Pricing_Answers_MP](LoopId INT IDENTITY(1,1),
	[Pricing_Answers_ID] [int] NOT NULL,
	[Pricing_Schedule_ID] [int] NOT NULL,
	[PricingDetails_ID] [int] NOT NULL,
	[Actual_Year] [int] NOT NULL,
	[Actual_Partial] [int] NOT NULL,
	[Base_Fee] [decimal](14, 2) NOT NULL,
	[PerPart_Fee] [decimal](14, 2) NOT NULL,
	[FeeEst] [decimal](14, 2) NOT NULL)
END
 IF OBJECT_ID('dbo.Pricing_Answers_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Pricing_Answers]) > 0
 BEGIN
CREATE TABLE [dbo].[Pricing_Answers_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Pricing_Schedule]*/
IF OBJECT_ID('dbo.Pricing_Schedule_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Pricing_Schedule_MP](LoopId INT IDENTITY(1,1),
	[Pricing_Schedule_ID] [int] NOT NULL,
	[ServiceSchedule_Lib_ID] [int] NOT NULL,
	[First_Active_Year] [int] NOT NULL,
	[Last_Active_Year] [int] NOT NULL,
	[AdditionalService_Description] [varchar](255) NOT NULL,
	[Min_Participants] [int] NOT NULL,
	[Max_Participants] [int] NOT NULL,
	[Base_Fee] [decimal](14, 2) NOT NULL,
	[Per_Participant_Fee] [decimal](14, 2) NOT NULL,
	[Per_Key_Employee] [smallint] NOT NULL,
	[Per_Partner_Spouse] [smallint] NOT NULL,
	[Individual_Quote] [smallint] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Locked] [bit] NOT NULL,
	[LockedByWho] [int] NOT NULL,
	[LockedWhen] [datetime] NOT NULL)
END
 IF OBJECT_ID('dbo.Pricing_Schedule_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Pricing_Schedule]) > 0
 BEGIN
CREATE TABLE [dbo].[Pricing_Schedule_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[PricingDetails]*/
IF OBJECT_ID('dbo.PricingDetails_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PricingDetails_MP](LoopId INT IDENTITY(1,1),
	[PricingDetails_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[PYE_Partial] [int] NOT NULL,
	[Participant_Count] [int] NOT NULL,
	[Pricing_Schedule_ID] [int] NOT NULL,
	[Balance_Forward] [smallint] NOT NULL,
	[General_Testing] [smallint] NOT NULL,
	[Plan_Audit_Fee] [smallint] NOT NULL,
	[Multiple_Employer_CO] [smallint] NOT NULL,
	[Number_Employer_CO] [int] NOT NULL,
	[Benefit_Formula_Redesign] [smallint] NOT NULL,
	[Num_KeysForBenFormRedesign] [smallint] NOT NULL,
	[Multiple_Owner_Funding_Analysis] [smallint] NOT NULL,
	[AnnualAdministration] [decimal](14, 2) NOT NULL,
	[LoansDistributions] [decimal](14, 2) NOT NULL,
	[AssetReconciliation] [decimal](14, 2) NOT NULL,
	[RushCharges] [decimal](14, 2) NOT NULL,
	[DocumentWork] [decimal](14, 2) NOT NULL,
	[OtherCharges] [decimal](14, 2) NOT NULL,
	[CreditDiscountRevShare] [decimal](14, 2) NOT NULL,
	[TotalFeesBilled] [decimal](14, 2) NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Locked] [bit] NOT NULL,
	[LockedByWho] [int] NOT NULL,
	[LockedWhen] [datetime] NOT NULL)
END
 IF OBJECT_ID('dbo.PricingDetails_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PricingDetails]) > 0
 BEGIN
CREATE TABLE [dbo].[PricingDetails_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[PricingElements]*/
IF OBJECT_ID('dbo.PricingElements_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PricingElements_MP](LoopId INT IDENTITY(1,1),
	[PricingElements_ID] [int] NOT NULL,
	[ParentElement_ID] [int] NOT NULL,
	[PricingElements_Label] [nvarchar](255) NOT NULL,
	[PricingElements_Hint] [nvarchar](255) NOT NULL,
	[PricingHeader_ID] [int] NOT NULL,
	[Fee] [decimal](14, 2) NOT NULL,
	[MinPart] [int] NOT NULL,
	[MaxPart] [int] NOT NULL,
	[PricingScriptRestrictionsList] [nvarchar](50) NOT NULL,
	[PricingPlanRestrictionsList] [nvarchar](50) NOT NULL,
	[UnitOfMeasure] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.PricingElements_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PricingElements]) > 0
 BEGIN
CREATE TABLE [dbo].[PricingElements_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[PricingHeader]
IF OBJECT_ID('dbo.PricingHeader_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PricingHeader_MP](LoopId INT IDENTITY(1,1),
	[PricingHeader_ID] [int] NOT NULL,
	[PricingHeader_Label] [nvarchar](150) NOT NULL,
	[PricingGroup_ID] [int] NOT NULL,
	[EffectiveYear] [int] NOT NULL,
	[PlanTypeRestriction] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.PricingHeader_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PricingHeader]) > 0
 BEGIN
CREATE TABLE [dbo].[PricingHeader_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[ProspectPlan]
IF OBJECT_ID('dbo.ProspectPlan_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ProspectPlan_MP](LoopId INT IDENTITY(1,1),
	[ProspectPlan_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[PlanIndex] [int] NOT NULL,
	[Plan_Name] [nvarchar](255) NOT NULL,
	[PlanOrigin] [int] NOT NULL,
	[PlanType] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[NumParticipants] [int] NOT NULL,
	[PlanYE] [nvarchar](5) NOT NULL,
	[Type5500] [int] NOT NULL,
	[Analyst] [int] NOT NULL,
	[Reviewer] [int] NOT NULL,
	[SafeHarbor] [bit] NOT NULL,
	[SafeHarbor_Type] [int] NOT NULL,
	[ACA] [bit] NOT NULL,
	[ACA_Type] [int] NOT NULL,
	[ACA_MIN_PERC] [decimal](5, 2) NOT NULL,
	[ACA_MAX_PERC] [decimal](5, 2) NOT NULL,
	[PBGC_Covered] [bit] NOT NULL,
	[NoAdpTesting_Required] [bit] NOT NULL,
	[NoAcpTesting_Required] [bit] NOT NULL,
	[BaseFee] [money] NOT NULL,
	[PerParticipantFee] [money] NOT NULL,
	[NonParticipantFee] [money] NOT NULL,
	[LoanFee] [money] NOT NULL,
	[DistributionFee] [money] NOT NULL,
	[BondRequired] [bit] NULL,
	[NewComparability] [bit] NOT NULL,
	[ProfitSharing] [bit] NOT NULL,
	[GeneralTested] [bit] NOT NULL,
	[Pooled] [bit] NOT NULL,
	[FBOAccounts] [bit] NOT NULL,
	[Rollover] [bit] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Plan_Name_2] [nvarchar](255) NULL,
	[PlanOrigin_2] [int] NULL,
	[PlanType_2] [int] NULL,
	[NextProspectPlan] [int] NULL,
	[FeeOverride] [bit] NULL)
END
 IF OBJECT_ID('dbo.ProspectPlan_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ProspectPlan]) > 0
 BEGIN
CREATE TABLE [dbo].[ProspectPlan_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[Question]
IF OBJECT_ID('dbo.Question_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Question_MP](LoopId INT IDENTITY(1,1),
	[Question_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[Plan_Year] [int] NOT NULL,
	[Questionnaire_ID] [int] NOT NULL,
	[YN_Result] [bit] NOT NULL,
	[Other_Result] [ntext] NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Questionnaire_Group_ID] [int] NULL)
END
 IF OBJECT_ID('dbo.Question_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Question]) > 0
 BEGIN
CREATE TABLE [dbo].[Question_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[Questionnaire]
IF OBJECT_ID('dbo.Questionnaire_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Questionnaire_MP](LoopId INT IDENTITY(1,1),
	[Questionnaire_ID] [int] NOT NULL,
	[Questionnaire_Group] [int] NOT NULL,
	[Questionnaire_Index] [int] NOT NULL,
	[Questionnaire_Label] [nvarchar](20) NOT NULL,
	[Questionnaire_Text] [ntext] NULL,
	[AskYN] [bit] NOT NULL,
	[AskOther] [bit] NOT NULL,
	[PlanType_Qualifier] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Questionnaire_Hint] [ntext] NULL)
END
 IF OBJECT_ID('dbo.Questionnaire_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Questionnaire]) > 0
 BEGIN
CREATE TABLE [dbo].[Questionnaire_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[Recurrence]
IF OBJECT_ID('dbo.Recurrence_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Recurrence_MP](LoopId INT IDENTITY(1,1),
	[Recurrence_ID] [int] NOT NULL,
	[Pattern] [int] NOT NULL,
	[Recur_Every] [int] NOT NULL,
	[Recur_On] [int] NOT NULL,
	[Recur_Day] [int] NOT NULL,
	[Recur_Month] [int] NOT NULL,
	[Recur_Start] [datetime] NOT NULL,
	[EndAfter] [int] NOT NULL,
	[EndCount] [int] NOT NULL,
	[EndByDate] [datetime] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Recurrence_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Recurrence]) > 0
 BEGIN
CREATE TABLE [dbo].[Recurrence_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[Relationships]
IF OBJECT_ID('dbo.Relationships_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Relationships_MP](LoopId INT IDENTITY(1,1),
	[Relationship_ID] [int] NOT NULL,
	[Contact_ID] [int] NOT NULL,
	[Relative] [nvarchar](255) NULL,
	[RelRelationship] [nvarchar](255) NULL,
	[RelTermDate] [datetime] NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Relationships_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Relationships]) > 0
 BEGIN
CREATE TABLE [dbo].[Relationships_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[special_instructions]
IF OBJECT_ID('dbo.special_instructions_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[special_instructions_MP](LoopId INT IDENTITY(1,1),
	[special_instruction_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[initiated] [datetime] NOT NULL,
	[expires] [datetime] NOT NULL,
	[user_id] [int] NOT NULL,
	[importance] [int] NULL,
	[IsWarning] [bit] NULL)
END
 IF OBJECT_ID('dbo.special_instructions_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[special_instructions]) > 0
 BEGIN
CREATE TABLE [dbo].[special_instructions_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[TaskList]
IF OBJECT_ID('dbo.TaskList_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[TaskList_MP](LoopId INT IDENTITY(1,1),
	[TaskList_ID] [int] NOT NULL,
	[Category] [int] NOT NULL,
	[FirstPostedStamp] [datetime] NOT NULL,
	[RequestedByWho] [int] NOT NULL,
	[RequiredByStamp] [datetime] NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[DateReopenedStamp] [datetime] NOT NULL,
	[DateCompletedStamp] [datetime] NOT NULL,
	[TaskPriority] [int] NOT NULL,
	[TaskSubject] [nvarchar](255) NOT NULL,
	[TaskDescription] [ntext] NOT NULL,
	[AssignedToWho] [int] NOT NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.TaskList_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[TaskList]) > 0
 BEGIN
CREATE TABLE [dbo].[TaskList_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

-- [dbo].[Testing_Tracking]
IF OBJECT_ID('dbo.Testing_Tracking_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Testing_Tracking_MP](LoopId INT IDENTITY(1,1),
	[Testing_Tracking_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[Plan_Year] [int] NOT NULL,
	[Testing_Index] [int] NOT NULL,
	[Testing_Type] [int] NOT NULL,
	[Testing_Status] [int] NOT NULL,
	[Preparer_By] [int] NOT NULL,
	[PreparerAssign] [datetime] NOT NULL,
	[PreparerDone] [datetime] NOT NULL,
	[Reviewed_By] [int] NOT NULL,
	[ReviewedAssign] [datetime] NOT NULL,
	[ReviewedDone] [datetime] NOT NULL,
	[Results] [int] NOT NULL,
	[Communicated_By] [int] NOT NULL,
	[CommunicatedAssign] [datetime] NOT NULL,
	[CommunicatedDone] [datetime] NOT NULL,
	[Waiting] [int] NOT NULL,
	[Decision] [int] NOT NULL,
	[Attachment_ID] [int] NOT NULL,
	[Notes_ID] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Testing_Tracking_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Testing_Tracking]) > 0
 BEGIN
CREATE TABLE [dbo].[Testing_Tracking_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

-- [dbo].[Testing_Type]
IF OBJECT_ID('dbo.Testing_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Testing_Type_MP](LoopId INT IDENTITY(1,1),
	[Testing_Type_ID] [int] NOT NULL,
	[Testing_Type_Text] [nvarchar](50) NOT NULL,
	[Testing_Group] [int] NOT NULL,
	[Testing_Plan] [int] NOT NULL,
	[Testing_Communicate] [bit] NOT NULL,
	[Testing_Decision] [bit] NOT NULL,
	[Testing_Results] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Testing_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Testing_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[Testing_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

-- [dbo].[UserGroup]
IF OBJECT_ID('dbo.UserGroup_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[UserGroup_MP](LoopId INT IDENTITY(1,1),
	[UserGroup_ID] [int] NOT NULL,
	[UserGroupCollection_ID] [int] NOT NULL,
	[SysUserID] [int] NOT NULL,
	[SysUserIDType] [int] NULL)
END
 IF OBJECT_ID('dbo.UserGroup_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[UserGroup]) > 0
 BEGIN
CREATE TABLE [dbo].[UserGroup_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

-- [dbo].[VestingSchedule]
IF OBJECT_ID('dbo.VestingSchedule_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[VestingSchedule_MP](LoopId INT IDENTITY(1,1),
	[VestingSchedule_ID] [int] NOT NULL,
	[VestingSchedule_Name] [nvarchar](255) NOT NULL,
	[Vesting_Set_1] [int] NOT NULL,
	[Vesting_Percent_1] [int] NOT NULL,
	[Vesting_Set_2] [int] NOT NULL,
	[Vesting_Percent_2] [int] NOT NULL,
	[Vesting_Set_3] [int] NOT NULL,
	[Vesting_Percent_3] [int] NOT NULL,
	[Vesting_Set_4] [int] NOT NULL,
	[Vesting_Percent_4] [int] NOT NULL,
	[Vesting_Set_5] [int] NOT NULL,
	[Vesting_Percent_5] [int] NOT NULL,
	[Vesting_Set_6] [int] NOT NULL,
	[Vesting_Percent_6] [int] NOT NULL,
	[Vesting_Set_7] [int] NOT NULL,
	[Vesting_Percent_7] [int] NOT NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.VestingSchedule_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[VestingSchedule]) > 0
 BEGIN
CREATE TABLE [dbo].[VestingSchedule_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

-- [dbo].[WaitingItem]
IF OBJECT_ID('dbo.WaitingItem_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[WaitingItem_MP](LoopId INT IDENTITY(1,1),
	[WaitingItem_ID] [int] NOT NULL,
	[Client_ID] [int] NULL,
	[Plans_Index_ID] [int] NULL,
	[ContactAdvisor] [nvarchar](100) NULL,
	[Subject_Line] [nvarchar](255) NULL,
	[Response_Date] [datetime] NULL,
	[Expiration_Date] [datetime] NULL,
	[Completed] [bit] NULL,
	[Notes] [ntext] NULL,
	[lastTouched] [datetime] NULL,
	[ByWho] [int] NULL)
END
 IF OBJECT_ID('dbo.WaitingItem_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[WaitingItem]) > 0
 BEGIN
CREATE TABLE [dbo].[WaitingItem_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

-- [dbo].[XChangeContact]
IF OBJECT_ID('dbo.XChangeContact_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[XChangeContact_MP](LoopId INT IDENTITY(1,1),
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](40) NULL,
	[ClassType] [varchar](2) NULL,
	[Tel] [varchar](20) NULL,
	[ForeignId] [varchar](132) NULL,
	[DirectoryId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NULL)
END
 IF OBJECT_ID('dbo.XChangeContact_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[XChangeContact]) > 0
 BEGIN
CREATE TABLE [dbo].[XChangeContact_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[YearEndNotes]
IF OBJECT_ID('dbo.YearEndNotes_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[YearEndNotes_MP](LoopId INT IDENTITY(1,1),
	[YearEndNotes_ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[Plan_Number] [int] NOT NULL,
	[YEN_Category] [int] NOT NULL,
	[Reviewed_ByWho] [int] NOT NULL,
	[Reviewed_When] [datetime] NOT NULL,
	[General_Notes] [ntext] NULL,
	[Action_Required] [bit] NOT NULL,
	[Reviewer_Notes] [ntext] NULL,
	[Resolved] [bit] NOT NULL,
	[Carry_Over] [bit] NOT NULL,
	[CreatedByWho] [int] NOT NULL,
	[CreatedWhen] [datetime] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.YearEndNotes_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[YearEndNotes]) > 0
 BEGIN
CREATE TABLE [dbo].[YearEndNotes_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[YearToYear_Answers]
IF OBJECT_ID('dbo.YearToYear_Answers_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[YearToYear_Answers_MP](LoopId INT IDENTITY(1,1),
	[YearToYear_Answers_ID] [int] NOT NULL,
	[YearToYear_Header_ID] [int] NOT NULL,
	[YearToYear_Questions_ID] [int] NOT NULL,
	[Text_Res] [nvarchar](max) NOT NULL,
	[YN_Res] [bit] NOT NULL,
	[Int_Res] [int] NOT NULL,
	[Float_Res] [decimal](14, 2) NOT NULL,
	[DateTime_Res] [datetime] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.YearToYear_Answers_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[YearToYear_Answers]) > 0
 BEGIN
CREATE TABLE [dbo].[YearToYear_Answers_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[YearToYear_Group]
IF OBJECT_ID('dbo.YearToYear_Group_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[YearToYear_Group_MP](LoopId INT IDENTITY(1,1),
	[YearToYear_Group_ID] [int] NOT NULL,
	[YearToYear_Group_Label] [nvarchar](150) NOT NULL,
	[PlanRestriction] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.YearToYear_Group_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[YearToYear_Group]) > 0
 BEGIN
CREATE TABLE [dbo].[YearToYear_Group_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[YearToYear_Header]
IF OBJECT_ID('dbo.YearToYear_Header_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[YearToYear_Header_MP](LoopId INT IDENTITY(1,1),
	[YearToYear_Header_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[ActivePlanYear] [bit] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.YearToYear_Header_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[YearToYear_Header]) > 0
 BEGIN
CREATE TABLE [dbo].[YearToYear_Header_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[YearToYear_Questions]
IF OBJECT_ID('dbo.YearToYear_Questions_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[YearToYear_Questions_MP](LoopId INT IDENTITY(1,1),
	[YearToYear_Questions_ID] [int] NOT NULL,
	[YearToYear_Group_ID] [int] NOT NULL,
	[YearToYear_Questions_Label] [nvarchar](150) NOT NULL,
	[YearToYear_Questions_Hint] [nvarchar](150) NOT NULL,
	[YearToYear_Questions_Type] [int] NOT NULL,
	[YearToYear_Questions_Ref] [int] NOT NULL,
	[YearToYear_Questions_Param] [nvarchar](max) NOT NULL,
	[EffectiveYear] [int] NOT NULL,
	[FinalYear] [int] NOT NULL,
	[Position] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.YearToYear_Questions_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[YearToYear_Questions]) > 0
 BEGIN
CREATE TABLE [dbo].[YearToYear_Questions_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_EmailNotice*/
IF OBJECT_ID('dbo.PortalWorkflow_EmailNotice_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_EmailNotice_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[ElementId] [int]  NOT NULL,
[StateId] [int]  NOT NULL,
[WorkflowId] [int]  NOT NULL,
[MilestoneId] [int]  NOT NULL,
[ProcessId] [int]  NOT NULL,
[TaskId] [int]  NOT NULL,
[IsDefault] [bit]  NOT NULL,
[EmailSubject] [nvarchar] (250) NULL,
[EmailBody] [ntext]  NULL,
[EmailCc] [nvarchar] (max) NULL,
[EmailBodyContents] [nvarchar] (500) NULL,
[IsCompanyLogo] [bit]  NOT NULL,
[DynamicFields] [nvarchar] (100) NULL,
[IsPortalDeleted] [bit]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_EmailNotice_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_EmailNotice]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_EmailNotice_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_MilestoneProcessLink*/
IF OBJECT_ID('dbo.PortalWorkflow_MilestoneProcessLink_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_MilestoneProcessLink_MP] (LoopId INT IDENTITY(1,1), 
    [MilestoneProcessLinkId] [int]  NOT NULL,
[MilestoneId] [int]  NOT NULL,
[ProcessId] [int]  NOT NULL,
[ProcessSequenceId] [int]  NOT NULL,
[IsPortalDeleted] [bit]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_MilestoneProcessLink_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_MilestoneProcessLink]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_MilestoneProcessLink_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_MilestonesLibrary*/
IF OBJECT_ID('dbo.PortalWorkflow_MilestonesLibrary_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_MilestonesLibrary_MP] (LoopId INT IDENTITY(1,1), 
    [MilestoneId] [int]  NOT NULL,
[MilestoneName] [nvarchar] (max) NOT NULL,
[Description] [nvarchar] (max) NOT NULL,
[Category] [int]  NOT NULL,
[Role] [int]  NOT NULL,
[Assignee] [int]  NOT NULL,
[TriggerId] [int]  NOT NULL,
[CreatedBy] [int]  NOT NULL,
[CreatedDate] [datetime]  NOT NULL,
[UpdatedBy] [int]  NOT NULL,
[UpdatedDate] [datetime]  NOT NULL,
[IsPortalDeleted] [bit]  NOT NULL,
[IsIndependent] [bit]  NOT NULL,
[IsHiddenFromLibrary] [bit]  NOT NULL,
[IsAddedToLibrary] [bit]  NOT NULL,
[IsAssignee] [bit]  NOT NULL,
[IsDefault] [bit]  NOT NULL,
[IsOrignal] [bit]  NOT NULL,
[ReportingElement] [int]  NOT NULL,
[ChildReportingElement] [int]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_MilestonesLibrary_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_MilestonesLibrary]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_MilestonesLibrary_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_Notes*/
IF OBJECT_ID('dbo.PortalWorkflow_Notes_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_Notes_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[TpaUserId] [int]  NOT NULL,
[ClientId] [int]  NOT NULL,
[PlanId] [int]  NOT NULL,
[PlanYear] [int]  NOT NULL,
[WorkflowId] [int]  NOT NULL,
[MilestoneId] [int]  NOT NULL,
[SectionName] [nvarchar] (max) NOT NULL,
[PriorRolloverYear] [int]  NOT NULL,
[CurrentYearNotes] [nvarchar] (max) NULL,
[CreatedBy] [int]  NOT NULL,
[CreatedDate] [datetime]  NOT NULL,
[UpdatedBy] [int]  NOT NULL,
[UpdatedDate] [datetime]  NOT NULL,
[IsPortalDeleted] [bit]  NOT NULL,
[IsRollOverYear] [bit]  NOT NULL,
[DocumentId] [int]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_Notes_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_Notes]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_Notes_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_ProcessLibrary*/
IF OBJECT_ID('dbo.PortalWorkflow_ProcessLibrary_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_ProcessLibrary_MP] (LoopId INT IDENTITY(1,1), 
    [ProcessId] [int]  NOT NULL,
[ProcessName] [nvarchar] (max) NOT NULL,
[Description] [nvarchar] (max) NOT NULL,
[CategoryId] [int]  NOT NULL,
[RoleId] [int]  NOT NULL,
[AssigneeId] [int]  NOT NULL,
[TriggerId] [int]  NOT NULL,
[CreatedBy] [int]  NOT NULL,
[CreatedDate] [datetime]  NOT NULL,
[UpdatedBy] [int]  NOT NULL,
[UpdatedDate] [datetime]  NOT NULL,
[IsPortalDeleted] [bit]  NOT NULL,
[IsIndependent] [bit]  NOT NULL,
[IsHiddenFromLibrary] [bit]  NOT NULL,
[IsAddedToLibrary] [bit]  NOT NULL,
[IsAssignee] [bit]  NOT NULL,
[IsDefault] [bit]  NOT NULL,
[IsOrignal] [bit]  NOT NULL,
[ReportingElement] [int]  NOT NULL,
[ChildReportingElement] [int]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_ProcessLibrary_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_ProcessLibrary]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_ProcessLibrary_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_ReasonForDelay*/
IF OBJECT_ID('dbo.PortalWorkflow_ReasonForDelay_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_ReasonForDelay_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[Reason] [nvarchar] (50) NOT NULL,
[IsDeleted] [bit]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_ReasonForDelay_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_ReasonForDelay]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_ReasonForDelay_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_StatusBoardHistory*/
IF OBJECT_ID('dbo.PortalWorkflow_StatusBoardHistory_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_StatusBoardHistory_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[ApplyWorkflowId] [int]  NOT NULL,
[ElementState] [int]  NOT NULL,
[ActionDate] [datetime]  NOT NULL,
[ByWho] [int]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_StatusBoardHistory_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_StatusBoardHistory]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_StatusBoardHistory_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_TasksLibrary*/
IF OBJECT_ID('dbo.PortalWorkflow_TasksLibrary_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_TasksLibrary_MP] (LoopId INT IDENTITY(1,1), 
    [TaskId] [int]  NOT NULL,
[TaskName] [nvarchar] (max) NOT NULL,
[Description] [nvarchar] (max) NOT NULL,
[ProcessId] [int]  NOT NULL,
[SequenceId] [int]  NOT NULL,
[CategoryId] [int]  NOT NULL,
[RoleId] [int]  NOT NULL,
[AssigneeId] [int]  NOT NULL,
[TriggerId] [int]  NOT NULL,
[CreatedBy] [int]  NOT NULL,
[CreatedDate] [datetime]  NOT NULL,
[UpdatedBy] [int]  NOT NULL,
[UpdatedDate] [datetime]  NOT NULL,
[IsPortalDeleted] [bit]  NOT NULL,
[IsIndependent] [bit]  NOT NULL,
[IsAssignee] [bit]  NOT NULL,
[IsDefault] [bit]  NOT NULL,
[ReportingElement] [int]  NOT NULL,
[ChildReportingElement] [int]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_TasksLibrary_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_TasksLibrary]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_TasksLibrary_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_ToDo*/
IF OBJECT_ID('dbo.PortalWorkflow_ToDo_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_ToDo_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[ElementId] [int]  NOT NULL,
[StateId] [int]  NOT NULL,
[WorkflowId] [int]  NOT NULL,
[MilestoneId] [int]  NOT NULL,
[ProcessId] [int]  NOT NULL,
[TaskId] [int]  NOT NULL,
[IsDefault] [bit]  NOT NULL,
[ToDoSubject] [nvarchar] (250) NULL,
[ToDoDescription] [ntext]  NOT NULL,
[Category] [int]  NOT NULL,
[BudgetedTime] [decimal] (8, 2) NOT NULL,
[Deadline] [int]  NOT NULL,
[EmailBodyContents] [nvarchar] (500) NULL,
[DynamicFields] [nvarchar] (100) NULL,
[IsPortalDeleted] [bit]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_ToDo_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_ToDo]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_ToDo_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_Triggers*/
IF OBJECT_ID('dbo.PortalWorkflow_Triggers_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_Triggers_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[TriggerId] [int]  NOT NULL,
[StateId] [int]  NOT NULL,
[IsTodo] [bit]  NOT NULL,
[IsEmail] [bit]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_Triggers_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_Triggers]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_Triggers_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_Workflow*/
IF OBJECT_ID('dbo.PortalWorkflow_Workflow_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_Workflow_MP] (LoopId INT IDENTITY(1,1), 
    [WorkflowId] [int]  NOT NULL,
[WorkflowName] [nvarchar] (max) NOT NULL,
[Description] [nvarchar] (max) NOT NULL,
[Category] [int]  NOT NULL,
[Role] [int]  NOT NULL,
[Assignee] [int]  NOT NULL,
[TriggerId] [int]  NOT NULL,
[CreatedBy] [int]  NOT NULL,
[CreatedDate] [datetime]  NULL,
[UpdatedBy] [int]  NOT NULL,
[UpdatedDate] [datetime]  NOT NULL,
[IsPortalDeleted] [bit]  NOT NULL,
[IsHiddenFromLibrary] [bit]  NOT NULL,
[IsAssignee] [bit]  NOT NULL,
[TicketTypeId] [int]  NOT NULL,
[IsDefault] [bit]  NOT NULL,
[IsPlanAmmendment] [bit]  NOT NULL,
[ReportingElement] [int]  NOT NULL,
[ChildReportingElement] [int]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_Workflow_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_Workflow]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_Workflow_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_WorkflowAppliedTo*/
IF OBJECT_ID('dbo.PortalWorkflow_WorkflowAppliedTo_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_WorkflowAppliedTo_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[TpaUserId] [int]  NOT NULL,
[ClientId] [int]  NOT NULL,
[PlanId] [int]  NOT NULL,
[PlanYear] [int]  NOT NULL,
[ElementId] [int]  NOT NULL,
[WorkflowId] [int]  NOT NULL,
[MilestoneId] [int]  NOT NULL,
[ProcessId] [int]  NOT NULL,
[TaskId] [int]  NOT NULL,
[RoleId] [int]  NOT NULL,
[AssigneeId] [int]  NOT NULL,
[TriggerId] [int]  NOT NULL,
[State] [int]  NOT NULL,
[StartDate] [datetime]  NOT NULL,
[ClientWaitDate] [datetime]  NOT NULL,
[CompletedDate] [datetime]  NOT NULL,
[ReopenDate] [datetime]  NOT NULL,
[CreatedBy] [int]  NOT NULL,
[CreatedDate] [datetime]  NOT NULL,
[UpdatedBy] [int]  NOT NULL,
[UpdatedDate] [datetime]  NOT NULL,
[IsIndependent] [bit]  NOT NULL,
[SequenceId] [int]  NOT NULL,
[IsAssignee] [bit]  NOT NULL,
[IsDocumentTicket] [bit]  NOT NULL,
[DocumentId] [int]  NOT NULL,
[IsClosed] [bit]  NOT NULL,
[IsComplete] [bit]  NOT NULL,
[IsNotApplicable] [bit]  NOT NULL,
[NotApplicableNotes] [nvarchar] (max) NULL,
[IsAssigneeApplicableForTask] [bit]  NOT NULL,
[UniqueDescription] [nvarchar] (max) NULL,
[ParentReportingElementId] [int]  NOT NULL,
[ChildReportingElementId] [int]  NOT NULL,
[IsReportingElementComplete] [bit]  NOT NULL,
[ReportingElementCompletedDate] [datetime]  NOT NULL,
[ReportingElementCompletedBy] [int]  NOT NULL,
[IsQAConfirmed] [bit]  NULL,
[QAUpdatedDate] [datetime]  NULL,
[QAUpdatedBy] [int]  NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_WorkflowAppliedTo_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_WorkflowAppliedTo]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_WorkflowAppliedTo_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_WorkflowMilestoneLink*/
IF OBJECT_ID('dbo.PortalWorkflow_WorkflowMilestoneLink_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_WorkflowMilestoneLink_MP] (LoopId INT IDENTITY(1,1), 
    [WorkflowMilestoneLinkId] [int]  NOT NULL,
[WorkflowId] [int]  NOT NULL,
[MilestoneId] [int]  NOT NULL,
[MilestoneSequenceId] [int]  NOT NULL,
[IsPortalDeleted] [bit]  NOT NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_WorkflowMilestoneLink_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_WorkflowMilestoneLink]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_WorkflowMilestoneLink_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PortalWorkflow_YearEndTrackingPlanCompliance*/
IF OBJECT_ID('dbo.PortalWorkflow_YearEndTrackingPlanCompliance_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [int]  NOT NULL,
[ClientId] [int]  NOT NULL,
[PlanId] [int]  NOT NULL,
[PlanYear] [int]  NOT NULL,
[ReasonForDelay] [int]  NOT NULL,
[WorkflowId] [int]  NOT NULL,
[UniqueDiscription] [varchar] (50) NULL,
[LastUpdatedDate] [datetime]  NOT NULL,
[LastUpdatedByWho] [int]  NOT NULL,
[IsSelected] [bit]  NULL,

)
END
IF OBJECT_ID('dbo.PortalWorkflow_YearEndTrackingPlanCompliance_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance]) > 0
BEGIN
CREATE TABLE [dbo].[PortalWorkflow_YearEndTrackingPlanCompliance_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[PortalDefaults_ClientFiles]
IF OBJECT_ID('dbo.PortalDefaults_ClientFiles_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalDefaults_ClientFiles_MP] (LoopId INT IDENTITY(1,1), 
    [FileId] [int]  NOT NULL,
[FolderId] [int]  NOT NULL,
[FileName] [nvarchar] (250) NULL,
[FilePath] [nvarchar] (500) NULL,
[ClientId] [int]  NULL,
[FileSize] [nvarchar] (50) NULL,
[UploadDate] [datetime]  NULL
)
END
IF OBJECT_ID('dbo.PortalDefaults_ClientFiles_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalDefaults_ClientFiles]) > 0
BEGIN
CREATE TABLE [dbo].[PortalDefaults_ClientFiles_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[PortalDefaults_ClientFolders]
IF OBJECT_ID('dbo.PortalDefaults_ClientFolders_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalDefaults_ClientFolders_MP] (LoopId INT IDENTITY(1,1), 
   [FolderId] [int]  NOT NULL,
[FolderName] [nvarchar] (50) NOT NULL,
[ParentFolderId] [int]  NOT NULL,
[DisplayName] [nvarchar] (50) NULL,
[IsDefault] [bit]  NULL,
[LastUpdatedDate] [nvarchar] (50) NULL,
[LastUpdatedBy] [int]  NULL,
[IsFile] [bit]  NOT NULL,
[FileNamingConvention] [nvarchar] (max) NULL,
[FileFriendlyName] [nvarchar] (50) NULL,
[FileNamingParameters] [nvarchar] (max) NULL
)
END
IF OBJECT_ID('dbo.PortalDefaults_ClientFolders_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalDefaults_ClientFolders]) > 0
BEGIN
CREATE TABLE [dbo].[PortalDefaults_ClientFolders_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[PortalDefaults_GridState]
IF OBJECT_ID('dbo.PortalDefaults_GridState_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalDefaults_GridState_MP] (LoopId INT IDENTITY(1,1), 
   [Id] [int]  NOT NULL,
[GridName] [nvarchar] (100) NOT NULL,
[GridState] [nvarchar] (max) NOT NULL,
[UserId] [int]  NOT NULL
)
END
IF OBJECT_ID('dbo.PortalDefaults_GridState_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalDefaults_GridState]) > 0
BEGIN
CREATE TABLE [dbo].[PortalDefaults_GridState_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[PortalDefaults_MappingClientFoldersPlan]
IF OBJECT_ID('dbo.PortalDefaults_MappingClientFoldersPlan_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[PortalDefaults_MappingClientFoldersPlan_MP] (LoopId INT IDENTITY(1,1), 
   [Id] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[FolderId] [int] NOT NULL
)
END
IF OBJECT_ID('dbo.PortalDefaults_MappingClientFoldersPlan_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PortalDefaults_MappingClientFoldersPlan]) > 0
BEGIN
CREATE TABLE [dbo].[PortalDefaults_MappingClientFoldersPlan_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


--[dbo].[Portal_Users]
IF OBJECT_ID('dbo.Portal_Users_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[Portal_Users_MP] (LoopId INT IDENTITY(1,1), 
    [UserId] [int] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[IsNew] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[IsBlocked] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[InvalidEntryCount] [int] NOT NULL
)
END
IF OBJECT_ID('dbo.Portal_Users_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_Users]) > 0
BEGIN
CREATE TABLE [dbo].[Portal_Users_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[Portal_PlanSubQuestionnarieAnswers]
IF OBJECT_ID('dbo.Portal_PlanSubQuestionnarieAnswers_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[Portal_PlanSubQuestionnarieAnswers_MP] (LoopId INT IDENTITY(1,1), 
    [SubPlanAnswerId] [int] NOT NULL,
	[MainQuestionId] [int] NOT NULL,
	[SubQuestionId] [int] NOT NULL,
	[SubQuestionType] [nvarchar](50) NOT NULL,
	[ClientId] [int] NOT NULL,
	[PlanId] [int] NOT NULL,
	[PlanYear] [int] NOT NULL,
	[Answer] [nvarchar](max) NOT NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastedUpdated_Client] [datetime] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL
)
END
IF OBJECT_ID('dbo.Portal_PlanSubQuestionnarieAnswers_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_PlanSubQuestionnarieAnswers]) > 0
BEGIN
CREATE TABLE [dbo].[Portal_PlanSubQuestionnarieAnswers_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

--[dbo].[Portal_PlanQuestionnarieAnswers]
IF OBJECT_ID('dbo.Portal_PlanQuestionnarieAnswers_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[Portal_PlanQuestionnarieAnswers_MP] (LoopId INT IDENTITY(1,1), 
    [AnswerId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[PlanYear] [int] NOT NULL,
	[QuqetionId] [int] NOT NULL,
	[QuestionGroup] [int] NOT NULL,
	[PlanId] [int] NOT NULL,
	[Answer] [int] NOT NULL,
	[SubAnswerId] [int] NOT NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastedUpdated_Client] [datetime] NOT NULL,
	[isFiedilityBond] [bit] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL
)
END
IF OBJECT_ID('dbo.Portal_PlanQuestionnarieAnswers_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_PlanQuestionnarieAnswers]) > 0
BEGIN
CREATE TABLE [dbo].[Portal_PlanQuestionnarieAnswers_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END


--[dbo].[XChangeContact]
IF OBJECT_ID('dbo.XChangeContact_MP') IS NULL
BEGIN
CREATE TABLE [dbo].[XChangeContact_MP] (LoopId INT IDENTITY(1,1), 
    [Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](40) NULL,
	[ClassType] [varchar](2) NULL,
	[Tel] [varchar](20) NULL,
	[ForeignId] [varchar](132) NULL,
	[DirectoryId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NULL
)
END
IF OBJECT_ID('dbo.XChangeContact_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[XChangeContact]) > 0
BEGIN
CREATE TABLE [dbo].[XChangeContact_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_Timeline]*/
 IF OBJECT_ID('dbo.Portal_Timeline_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_Timeline_MP] (LoopId INT IDENTITY(1,1), 
	[ID] [int] NOT NULL,
	[Client_ID] [int] NOT NULL,
	[Plan_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[Task] [nvarchar](max) NOT NULL,
	[Requirement] [nvarchar](max) NOT NULL,
	[DueDate] [date] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[IsDone] [bit] NOT NULL,
	[Task_Id] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[DoneByWho] [int] NOT NULL,
	[IsSharefile] [bit] NOT NULL,
	[DoneDateClient] [datetime] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL
)
END
 IF OBJECT_ID('dbo.Portal_Timeline_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_Timeline]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_Timeline_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_TPAFilters]*/
 IF OBJECT_ID('dbo.Portal_TPAFilters_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_TPAFilters_MP] (LoopId INT IDENTITY(1,1), 
	[Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[PensionAssistantSelected] [nvarchar](max) NULL,
	[ConsultantSelected] [nvarchar](max) NULL,
	[FiveHundrdSelected] [nvarchar](max) NULL,
	[PlanTypeSelected] [nvarchar](max) NULL,
	[PlanStatusTypeSelected] [nvarchar](max) NULL,
	[ClientStatusSelected] [nvarchar](max) NULL,
	[ServiceScheduleSelected] [nvarchar](max) NULL,
	[AssignedToSelected] [nvarchar](max) NULL,
	[CreatedBySelected] [nvarchar](max) NULL,
	[SubCategorySelected] [nvarchar](max) NULL,
	[PlanYESelected] [nvarchar](max) NULL,
	[IsActivePlanYear] [bit] NULL,
	[MainCategorySelected] [nvarchar](max) NULL,
	[IsDashboardFilter] [bit] NOT NULL,
	[IsCommLogFilter] [bit] NOT NULL,
	[FlagSelected] [nvarchar](max) NULL,
	[IsNotificationFilter] [bit] NOT NULL,
	[IsDashboardStatusPlanReportFilter] [bit] NOT NULL,
	[AdditionalServices] [nvarchar](max) NULL
)
END
 IF OBJECT_ID('dbo.Portal_TPAFilters_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_TPAFilters]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_TPAFilters_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ScheduleATracking*/
IF OBJECT_ID('dbo.ScheduleATracking_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ScheduleATracking_MP] (LoopId INT IDENTITY(1,1), 
	[ScheduleATracking_ID] [int] NOT NULL,
	[Plans_Index_ID] [int] NOT NULL,
	[PYE_Year] [int] NOT NULL,
	[PYE_Month] [nvarchar](5) NOT NULL,
	[Asset_Index] [int] NOT NULL,
	[Money_Type] [int] NOT NULL,
	[Account_Type] [int] NOT NULL,
	[Record_Keeper] [nvarchar](100) NULL,
	[RK_Account_No] [nvarchar](50) NULL,
	[Custodian] [nvarchar](100) NULL,
	[C_Account_No] [nvarchar](50) NULL,
	[Statement_Delivery] [int] NOT NULL,
	[Advisor] [int] NOT NULL,
	[Notes] [bit] NULL,
	[More] [bit] NULL,
	[Same_As] [int] NULL,
	[Sch_A_Required] [bit] NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[Notes_ID] [int] NULL,
	[QBSAction] [int] NULL,
	[InvestmentPlatform] [int] NULL,
	[AssetConfirmed] [bit] NULL,
	[AssetConfirmedByWho] [int] NULL,
	[AssetConfirmedByType] [int] NULL,
	[AssetConfirmedWhen] [datetime] NULL,
	[Kind] [nvarchar](10) NULL,
	[AccountClosed] [bit] NOT NULL,
	[LastStatementDate] [datetime] NULL,
	[FirstStatementDate] [datetime] NULL,
	[NonQualifiedAsset] [bit] NULL,
	[Download] [bit] NOT NULL,
	[AssetTracking_ID] [int] NULL,
	[IsPortalDeleted] [bit] NOT NULL
)
END
 IF OBJECT_ID('dbo.ScheduleATracking_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ScheduleATracking]) > 0
 BEGIN
CREATE TABLE [dbo].[ScheduleATracking_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ReportingElement]*/
 IF OBJECT_ID('dbo.Portal_ReportingElement_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ReportingElement_MP] (LoopId INT IDENTITY(1,1), 
	[ID] [int] NOT NULL,
	[ReportingElement] [nvarchar](500) NOT NULL,
	[ShortText] [nvarchar](500) NULL,
	[ShowToClient] [bit] NOT NULL,
	[AllowManualUpdate] [bit] NOT NULL,
	[Weight] [int] NOT NULL,
	[SequenceReportingElement] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[Version] [int] NOT NULL,
	[ParentId] [int] NOT NULL,
	[RequiredForDBPlans] [bit] NOT NULL,
	[RequiredForDCPlans] [bit] NOT NULL
)
END
 IF OBJECT_ID('dbo.Portal_ReportingElement_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ReportingElement]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ReportingElement_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ReportingElementList]*/
 IF OBJECT_ID('dbo.Portal_ReportingElementList_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ReportingElementList_MP] (LoopId INT IDENTITY(1,1), 
	[Id] [int] NOT NULL,
	[ElementId] [int] NOT NULL,
	[ElementActualId] [int] NOT NULL,
	[ElementName] [nvarchar](250) NULL,
	[ParentRepotingElementId] [int] NOT NULL,
	[ParentRepotingElementName] [nvarchar](250) NULL,
	[ChildRepotingElementId] [int] NOT NULL,
	[ChildRepotingElementName] [nvarchar](250) NULL
)
END
 IF OBJECT_ID('dbo.Portal_ReportingElementList_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ReportingElementList]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ReportingElementList_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END