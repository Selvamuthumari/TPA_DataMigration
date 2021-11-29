
/*STEP 1: Create Parent temp tables*/
/*PayrollProvider*/
 IF OBJECT_ID('dbo.PayrollProvider_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PayrollProvider_MP] (LoopId INT IDENTITY(1,1), 
PayrollProvider_ID	int,
PayrollProvider_Text	nvarchar(100))
END
 IF OBJECT_ID('dbo.PayrollProvider_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PayrollProvider]) > 0
 BEGIN
CREATE TABLE [dbo].[PayrollProvider_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ACA_Type]*/
 IF OBJECT_ID('dbo.ACA_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ACA_Type_MP] (LoopId INT IDENTITY(1,1), 
ACA_Type_ID	int,
ACA_Type_Text	nvarchar(50))
END
 IF OBJECT_ID('dbo.ACA_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ACA_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[ACA_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AccruedBenefit_Type*/
 IF OBJECT_ID('dbo.AccruedBenefit_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AccruedBenefit_Type_MP] (LoopId INT IDENTITY(1,1), 
AccruedBenefit_Type_ID	int,
AccruedBenefit_Type_Text	nvarchar(50))
END
 IF OBJECT_ID('dbo.AccruedBenefit_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AccruedBenefit_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[AccruedBenefit_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ActivityType*/
 IF OBJECT_ID('dbo.ActivityType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ActivityType_MP] (LoopId INT IDENTITY(1,1), 
ActivityType_ID	int,
ActivityType_Text	nvarchar(50))
END
 IF OBJECT_ID('dbo.ActivityType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ActivityType]) > 0
 BEGIN
CREATE TABLE [dbo].[ActivityType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Advisor_Firm_Type*/
 IF OBJECT_ID('dbo.Advisor_Firm_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Advisor_Firm_Type_MP](LoopId INT IDENTITY(1,1),
	[Advisor_Firm_Type_ID] [int] NOT NULL,
	[Advisor_Firm_Type_Text] [nvarchar](50) NOT NULL)
END
 IF OBJECT_ID('dbo.Advisor_Firm_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Advisor_Firm_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[Advisor_Firm_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Advisor_Types*/
 IF OBJECT_ID('dbo.Advisor_Types_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Advisor_Types_MP](LoopId INT IDENTITY(1,1),
	[Advisor_Type_ID] [int] NOT NULL,
	[Advisor_Type_Text] [nvarchar](10) NOT NULL)
END
 IF OBJECT_ID('dbo.Advisor_Types_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Advisor_Types]) > 0
 BEGIN
CREATE TABLE [dbo].[Advisor_Types_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AgeRequirement_Lib*/
 IF OBJECT_ID('dbo.AgeRequirement_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AgeRequirement_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[AgeRequirement_Lib_ID] [int] NOT NULL,
	[AgeRequirement_Lib_Text] [varchar](100) NOT NULL)
END
 IF OBJECT_ID('dbo.AgeRequirement_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AgeRequirement_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[AgeRequirement_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AmendingTypeLib*/
 IF OBJECT_ID('dbo.AmendingTypeLib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AmendingTypeLib_MP] (LoopId INT IDENTITY(1,1), 
	[AmendingType_ID] [int] NOT NULL,
	[AmendingType_Text] [nvarchar](50) NOT NULL,
	[IsPortalDeleted] [bit] NULL)
END
 IF OBJECT_ID('dbo.AmendingTypeLib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AmendingTypeLib]) > 0
 BEGIN
CREATE TABLE [dbo].[AmendingTypeLib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AnnualLoanMaintFee_Lib*/
 IF OBJECT_ID('dbo.AnnualLoanMaintFee_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AnnualLoanMaintFee_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[AnnualLoanMaintFee_Lib_ID] [int] NOT NULL,
	[AnnualLoanMaintFee_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.AnnualLoanMaintFee_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AnnualLoanMaintFee_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[AnnualLoanMaintFee_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AutoRolloverProvider_Lib*/
 IF OBJECT_ID('dbo.AutoRolloverProvider_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AutoRolloverProvider_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[AutoRolloverProvider_Lib_ID] [int] NOT NULL,
	[AutoRolloverProvider_Lib_Text] [varchar](255) NOT NULL)
END
 IF OBJECT_ID('dbo.AutoRolloverProvider_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AutoRolloverProvider_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[AutoRolloverProvider_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*AvgMonthlyCompensationFrom_Type*/
 IF OBJECT_ID('dbo.AvgMonthlyCompensationFrom_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[AvgMonthlyCompensationFrom_Type_MP] (LoopId INT IDENTITY(1,1), 
	[AvgMonthlyCompensationFrom_Type_ID] [int] NOT NULL,
	[AvgMonthlyCompensationFrom_Type_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.AvgMonthlyCompensationFrom_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[AvgMonthlyCompensationFrom_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[AvgMonthlyCompensationFrom_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Billing_Type]*/
 IF OBJECT_ID('dbo.Billing_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Billing_Type_MP] (LoopId INT IDENTITY(1,1), 
	[Billing_Type_ID] [int] NOT NULL,
	[Billing_Type_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.Billing_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Billing_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[Billing_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*BondingCo_Lib*/
 IF OBJECT_ID('dbo.BondingCo_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[BondingCo_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[BondingCo_ID] [int] NOT NULL,
	[BondingCo_Text] [nvarchar](255) NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.BondingCo_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[BondingCo_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[BondingCo_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Builder_Group*/
 IF OBJECT_ID('dbo.Builder_Group_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Builder_Group_MP] (LoopId INT IDENTITY(1,1), 
	[Builder_Group_ID] [int] NOT NULL,
	[Builder_Group_Text] [nvarchar](255) NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Builder_Group_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Builder_Group]) > 0
 BEGIN
CREATE TABLE [dbo].[Builder_Group_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Business_Type*/
 IF OBJECT_ID('dbo.Business_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Business_Type_MP] (LoopId INT IDENTITY(1,1), 
	[Business_Type_ID] [int] NOT NULL,
	[Business_Type_Text] [nvarchar](50) NULL,
	[Business_Type_Form] [nvarchar](50) NULL)
END
 IF OBJECT_ID('dbo.Business_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Business_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[Business_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ClientStatusType*/
 IF OBJECT_ID('dbo.ClientStatusType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ClientStatusType_MP] (LoopId INT IDENTITY(1,1), 
	[ClientStatusType_ID] [int] NOT NULL,
	[ClientStatusType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.ClientStatusType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ClientStatusType]) > 0
 BEGIN
CREATE TABLE [dbo].[ClientStatusType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ClientToDoSectionLib*/
 IF OBJECT_ID('dbo.ClientToDoSectionLib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ClientToDoSectionLib_MP] (LoopId INT IDENTITY(1,1), 
	[ClientToDoSectionLib_ID] [int] NOT NULL,
	[ClientToDoSectionLib_Text] [nvarchar](255) NOT NULL,
	[ClientToDoSectionLib_TableName] [nvarchar](255) NOT NULL)
END
 IF OBJECT_ID('dbo.ClientToDoSectionLib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ClientToDoSectionLib]) > 0
 BEGIN
CREATE TABLE [dbo].[ClientToDoSectionLib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ComputationMethod_Lib*/
 IF OBJECT_ID('dbo.ComputationMethod_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ComputationMethod_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[ComputationMethod_Lib_ID] [int] NOT NULL,
	[ComputationMethod_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.ComputationMethod_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ComputationMethod_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[ComputationMethod_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ComputationPeriod_Lib*/
 IF OBJECT_ID('dbo.ComputationPeriod_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ComputationPeriod_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[ComputationPeriod_Lib_ID] [int] NOT NULL,
	[ComputationPeriod_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.ComputationPeriod_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ComputationPeriod_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[ComputationPeriod_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ConsideredCompensationType*/
 IF OBJECT_ID('dbo.ConsideredCompensationType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ConsideredCompensationType_MP] (LoopId INT IDENTITY(1,1), 
	[ConsideredCompensationType_ID] [int] NOT NULL,
	[ConsideredCompensationType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.ConsideredCompensationType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ConsideredCompensationType]) > 0
 BEGIN
CREATE TABLE [dbo].[ConsideredCompensationType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Contact_Method*/
 IF OBJECT_ID('dbo.Contact_Method_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Contact_Method_MP] (LoopId INT IDENTITY(1,1), 
	[Contact_Method_ID] [int] NOT NULL,
	[Phone] [varchar](20) NULL,
	[Phone_Ext] [varchar](5) NULL,
	[Business_Phone] [varchar](20) NULL,
	[Business_Phone_Ext] [varchar](10) NULL,
	[Mobile_Phone] [varchar](20) NULL,
	[Fax] [varchar](20) NULL,
	[Email] [varchar](200) NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL,
	[ByWho_Client] [int] NOT NULL,
	[LastTouched_Client] [datetime] NOT NULL,
	[IsLastUpdatedByAdvisor] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.Contact_Method_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Contact_Method]) > 0
 BEGIN
CREATE TABLE [dbo].[Contact_Method_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DefinedCompensationType*/
 IF OBJECT_ID('dbo.DefinedCompensationType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DefinedCompensationType_MP] (LoopId INT IDENTITY(1,1), 
	[DefinedCompensationType_ID] [int] NOT NULL,
	[DefinedCompensationType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.DefinedCompensationType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DefinedCompensationType]) > 0
 BEGIN
CREATE TABLE [dbo].[DefinedCompensationType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DeliverTo_Lib*/
 IF OBJECT_ID('dbo.DeliverTo_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DeliverTo_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DeliverTo_Lib_ID] [int] NOT NULL,
	[DeliverTo_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.DeliverTo_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DeliverTo_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DeliverTo_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DeliveryModeLib*/
 IF OBJECT_ID('dbo.DeliveryModeLib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DeliveryModeLib_MP] (LoopId INT IDENTITY(1,1), 
	[DeliveryMode_ID] [int] NOT NULL,
	[DeliveryMode_Text] [nvarchar](50) NOT NULL)
END
 IF OBJECT_ID('dbo.DeliveryModeLib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DeliveryModeLib]) > 0
 BEGIN
CREATE TABLE [dbo].[DeliveryModeLib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistDeliveryMethod_Lib*/
 IF OBJECT_ID('dbo.DistDeliveryMethod_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistDeliveryMethod_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DistDeliveryMethod_Lib_ID] [int] NOT NULL,
	[DistDeliveryMethod_Lib_Text] [varchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.DistDeliveryMethod_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistDeliveryMethod_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DistDeliveryMethod_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistFeeAmounts_Lib*/
 IF OBJECT_ID('dbo.DistFeeAmounts_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistFeeAmounts_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DistFeeAmounts_Lib_ID] [int] NOT NULL,
	[DistFeeAmounts_Lib_Text] [decimal](14, 2) NOT NULL)
END
 IF OBJECT_ID('dbo.DistFeeAmounts_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistFeeAmounts_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DistFeeAmounts_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistribServiceOptionsType*/
 IF OBJECT_ID('dbo.DistribServiceOptionsType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistribServiceOptionsType_MP] (LoopId INT IDENTITY(1,1), 
	[DistribServiceOptionsType_ID] [int] NOT NULL,
	[DistribServiceOptionsType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.DistribServiceOptionsType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistribServiceOptionsType]) > 0
 BEGIN
CREATE TABLE [dbo].[DistribServiceOptionsType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistributionCharge*/
 IF OBJECT_ID('dbo.DistributionCharge_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistributionCharge_MP] (LoopId INT IDENTITY(1,1), 
	[ID] [int] NOT NULL,
	[DistributionChargeAmount] [money] NOT NULL)
END
 IF OBJECT_ID('dbo.DistributionCharge_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistributionCharge]) > 0
 BEGIN
CREATE TABLE [dbo].[DistributionCharge_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistributionPayableToWhom_Lib*/
 IF OBJECT_ID('dbo.DistributionPayableToWhom_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistributionPayableToWhom_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DistributionPayableToWhom_Lib_ID] [int] NOT NULL,
	[DistributionPayableToWhom_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.DistributionPayableToWhom_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistributionPayableToWhom_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DistributionPayableToWhom_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistributionTiming_Lib*/
 IF OBJECT_ID('dbo.DistributionTiming_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistributionTiming_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DistributionTiming_Lib_ID] [int] NOT NULL,
	[DistributionTiming_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.DistributionTiming_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistributionTiming_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DistributionPayableToWhom_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistributionType_Lib*/
 IF OBJECT_ID('dbo.DistributionType_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistributionType_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DistributionType_Lib_ID] [int] NOT NULL,
	[DistributionType_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.DistributionType_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistributionType_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DistributionType_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistSourcesAllowed_Lib*/
 IF OBJECT_ID('dbo.DistSourcesAllowed_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistSourcesAllowed_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DistSourcesAllowed_Lib_ID] [int] NOT NULL,
	[DistSourcesAllowed_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.DistSourcesAllowed_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistSourcesAllowed_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DistSourcesAllowed_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DistTaxCode1099_Lib*/
 IF OBJECT_ID('dbo.DistTaxCode1099_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DistTaxCode1099_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[DistTaxCode1099_Lib_ID] [int] NOT NULL,
	[DistTaxCode1099_Lib_Text] [varchar](5) NOT NULL)
END
 IF OBJECT_ID('dbo.DistTaxCode1099_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DistTaxCode1099_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[DistTaxCode1099_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Doc_Types*/
 IF OBJECT_ID('dbo.Doc_Types_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Doc_Types_MP] (LoopId INT IDENTITY(1,1), 
	[DocType_ID] [int] NOT NULL,
	[DocType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.Doc_Types_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Doc_Types]) > 0
 BEGIN
CREATE TABLE [dbo].[Doc_Types_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*DocumentWorkLib*/
IF OBJECT_ID('dbo.DocumentWorkLib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[DocumentWorkLib_MP] (LoopId INT IDENTITY(1,1), 
	[DocumentWork_ID] [int] NOT NULL,
	[DocumentWork_Text] [nvarchar](100) NOT NULL,
	[IsPortalDeleted] [bit] NULL)
END
 IF OBJECT_ID('dbo.DocumentWorkLib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[DocumentWorkLib]) > 0
 BEGIN
CREATE TABLE [dbo].[DocumentWorkLib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*EarningsAllocationType*/
IF OBJECT_ID('dbo.EarningsAllocationType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[EarningsAllocationType_MP] (LoopId INT IDENTITY(1,1), 
	[EarningsAllocationType_ID] [int] NOT NULL,
	[EarningsAllocationType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.EarningsAllocationType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[EarningsAllocationType]) > 0
 BEGIN
CREATE TABLE [dbo].[EarningsAllocationType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Egtrra_Group*/
IF OBJECT_ID('dbo.Egtrra_Group_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Egtrra_Group_MP] (LoopId INT IDENTITY(1,1), 
	[Egtrra_Group_ID] [int] NOT NULL,
	[Egtrra_Text] [nvarchar](255) NOT NULL,
	[FlagRequired] [int] NOT NULL,
	[LastEdited] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Egtrra_Group_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Egtrra_Group]) > 0
 BEGIN
CREATE TABLE [dbo].[Egtrra_Group_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ElementDataTypes*/
IF OBJECT_ID('dbo.ElementDataTypes_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ElementDataTypes_MP] (LoopId INT IDENTITY(1,1), 
	[ElementDataTypes_ID] [int] NOT NULL,
	[ElementDataTypes_Text] [nvarchar](50) NULL)
END
 IF OBJECT_ID('dbo.ElementDataTypes_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ElementDataTypes]) > 0
 BEGIN
CREATE TABLE [dbo].[ElementDataTypes_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*EntryDate_Type*/
IF OBJECT_ID('dbo.EntryDate_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[EntryDate_Type_MP] (LoopId INT IDENTITY(1,1), 
	[EntryDate_Type_ID] [int] NOT NULL,
	[EntryDate_Type_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.EntryDate_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[EntryDate_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[EntryDate_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*EntryDateNear_Type*/
IF OBJECT_ID('dbo.EntryDateNear_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[EntryDateNear_Type_MP] (LoopId INT IDENTITY(1,1), 
	[EntryDateNear_Type_ID] [int] NOT NULL,
	[EntryDateNear_Type_Text] [nvarchar](30) NOT NULL)
END
 IF OBJECT_ID('dbo.EntryDateNear_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[EntryDateNear_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[EntryDateNear_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*EntryDateUM_Type*/
IF OBJECT_ID('dbo.EntryDateUM_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[EntryDateUM_Type_MP] (LoopId INT IDENTITY(1,1), 
	[EntryDateUM_Type_ID] [int] NOT NULL,
	[EntryDateUM_Type_Text] [nvarchar](15) NOT NULL)
END
 IF OBJECT_ID('dbo.EntryDateUM_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[EntryDateUM_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[EntryDateUM_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*FormsToBeUsed_Lib*/
IF OBJECT_ID('dbo.FormsToBeUsed_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[FormsToBeUsed_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[FormsToBeUsed_Lib_ID] [int] NOT NULL,
	[FormsToBeUsed_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.FormsToBeUsed_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[FormsToBeUsed_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[FormsToBeUsed_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*HarshipNotes_Lib*/
IF OBJECT_ID('dbo.HarshipNotes_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[HarshipNotes_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[HarshipNotes_Lib_ID] [int] NOT NULL,
	[HarshipNotes_Lib_Text] [varchar](255) NOT NULL)
END
 IF OBJECT_ID('dbo.HarshipNotes_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[HarshipNotes_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[HarshipNotes_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*InServiceNotes_Lib*/
IF OBJECT_ID('dbo.InServiceNotes_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[InServiceNotes_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[InServiceNotes_Lib_ID] [int] NOT NULL,
	[InServiceNotes_Lib_Text] [varchar](255) NOT NULL)
END
 IF OBJECT_ID('dbo.InServiceNotes_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[InServiceNotes_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[InServiceNotes_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*InterestRate_Lib*/
IF OBJECT_ID('dbo.InterestRate_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[InterestRate_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[InterestRate_Lib_ID] [int] NOT NULL,
	[InterestRate_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.InterestRate_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[InterestRate_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[InterestRate_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*InterestRateType*/
IF OBJECT_ID('dbo.InterestRateType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[InterestRateType_MP] (LoopId INT IDENTITY(1,1),
	[InterestRateType_ID] [int] NOT NULL,
	[InterestRateType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.InterestRateType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[InterestRateType]) > 0
 BEGIN
CREATE TABLE [dbo].[InterestRateType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*InterestRateType*/
IF OBJECT_ID('dbo.InterestRateType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[InterestRateType_MP] (LoopId INT IDENTITY(1,1),
	[InterestRateType_ID] [int] NOT NULL,
	[InterestRateType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.InterestRateType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[InterestRateType]) > 0
 BEGIN
CREATE TABLE [dbo].[InterestRateType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*InvestmentPlatforms_Lib*/
IF OBJECT_ID('dbo.InvestmentPlatforms_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[InvestmentPlatforms_Lib_MP] (LoopId INT IDENTITY(1,1),
	[InvestmentPlatform_ID] [int] NOT NULL,
	[InvestmentPlatform_Text] [nvarchar](255) NOT NULL,
	[InsurancePlatform] [bit] NULL,
	[WebLink] [nvarchar](500) NULL,
	[IsPortalDeleted] [bit] NOT NULL)
END
 IF OBJECT_ID('dbo.InvestmentPlatforms_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[InvestmentPlatforms_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[InvestmentPlatforms_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*InvoiceMethod_Lib*/
IF OBJECT_ID('dbo.InvoiceMethod_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[InvoiceMethod_Lib_MP] (LoopId INT IDENTITY(1,1),
	[InvoiceMethod_ID] [int] NOT NULL,
	[InvoiceMethod_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.InvoiceMethod_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[InvoiceMethod_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[InvoiceMethod_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PayrollFrequency_Lib*/
IF OBJECT_ID('dbo.PayrollFrequency_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PayrollFrequency_Lib_MP] (LoopId INT IDENTITY(1,1),
	[PayrollFrequency_Lib_ID] [int] NOT NULL,
	[PayrollFrequency_Lib_Text] [varchar](100) NOT NULL)
END
 IF OBJECT_ID('dbo.PayrollFrequency_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PayrollFrequency_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[PayrollFrequency_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PlanParticipantType_Lib*/
IF OBJECT_ID('dbo.PlanParticipantType_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PlanParticipantType_Lib_MP] (LoopId INT IDENTITY(1,1),
	[PlanParticipantType_Lib_ID] [int] NOT NULL,
	[PlanParticipantType_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.PlanParticipantType_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PlanParticipantType_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[PlanParticipantType_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PricingGroupsLib*/
IF OBJECT_ID('dbo.PricingGroupsLib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PricingGroupsLib_MP] (LoopId INT IDENTITY(1,1),
	[PricingGroupsLib_ID] [int] NOT NULL,
	[EffectiveYear] [int] NOT NULL,
	[PricingGroupsLib_Text] [nvarchar](150) NOT NULL)
END
 IF OBJECT_ID('dbo.PricingGroupsLib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PricingGroupsLib]) > 0
 BEGIN
CREATE TABLE [dbo].[PricingGroupsLib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PricingPlanRestrictions*/
IF OBJECT_ID('dbo.PricingPlanRestrictions_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PricingPlanRestrictions_MP] (LoopId INT IDENTITY(1,1),
	[PricingPlanRestrictions_ID] [int] NOT NULL,
	[PricingPlanName] [nvarchar](155) NOT NULL)
END
 IF OBJECT_ID('dbo.PricingPlanRestrictions_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PricingPlanRestrictions]) > 0
 BEGIN
CREATE TABLE [dbo].[PricingPlanRestrictions_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PricingScriptRestrictions*/
IF OBJECT_ID('dbo.PricingScriptRestrictions_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PricingScriptRestrictions_MP] (LoopId INT IDENTITY(1,1),
	[PricingScriptRestrictions_ID] [int] NOT NULL,
	[PricingScript] [nvarchar](255) NOT NULL,
	[ExclusionHash] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.PricingScriptRestrictions_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PricingScriptRestrictions]) > 0
 BEGIN
CREATE TABLE [dbo].[PricingScriptRestrictions_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PricingUnitOfMeasure*/
IF OBJECT_ID('dbo.PricingUnitOfMeasure_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PricingUnitOfMeasure_MP] (LoopId INT IDENTITY(1,1),
	[PricingUnitOfMeasure_ID] [int] NOT NULL,
	[PricingUnitOfMeasure_Text] [nvarchar](100) NOT NULL)
END
 IF OBJECT_ID('dbo.PricingUnitOfMeasure_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PricingUnitOfMeasure]) > 0
 BEGIN
CREATE TABLE [dbo].[PricingUnitOfMeasure_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ProfitSharingAllocationType*/
IF OBJECT_ID('dbo.ProfitSharingAllocationType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ProfitSharingAllocationType_MP] (LoopId INT IDENTITY(1,1),
	[ProfitSharingAllocationType_ID] [int] NOT NULL,
	[ProfitSharingAllocationType_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.ProfitSharingAllocationType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ProfitSharingAllocationType]) > 0
 BEGIN
CREATE TABLE [dbo].[ProfitSharingAllocationType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ProfitSharingClasses*/
IF OBJECT_ID('dbo.ProfitSharingClasses_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ProfitSharingClasses_MP] (LoopId INT IDENTITY(1,1),
	[ProfitSharingClasses_ID] [int] NOT NULL,
	[ProfitSharingClasses_Text] [nvarchar](25) NOT NULL)
END
 IF OBJECT_ID('dbo.ProfitSharingClasses_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ProfitSharingClasses]) > 0
 BEGIN
CREATE TABLE [dbo].[ProfitSharingClasses_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*PurposeOfLoan_Lib*/
IF OBJECT_ID('dbo.PurposeOfLoan_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[PurposeOfLoan_Lib_MP] (LoopId INT IDENTITY(1,1),
	[PurposeOfLoan_Lib_ID] [int] NOT NULL,
	[PurposeOfLoan_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.PurposeOfLoan_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[PurposeOfLoan_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[PurposeOfLoan_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Questionnaire_Group*/
IF OBJECT_ID('dbo.Questionnaire_Group_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Questionnaire_Group_MP] (LoopId INT IDENTITY(1,1),
	[Questionnaire_Group_ID] [int] NOT NULL,
	[Questionnaire_Group_Text] [nvarchar](50) NOT NULL,
	[Plan_Year] [int] NOT NULL,
	[LastTouched] [datetime] NOT NULL,
	[ByWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.Questionnaire_Group_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Questionnaire_Group]) > 0
 BEGIN
CREATE TABLE [dbo].[Questionnaire_Group_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*LoanCharge*/
 IF OBJECT_ID('dbo.LoanCharge_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[LoanCharge_MP] (LoopId INT IDENTITY(1,1), 
    [ID] [int]  NOT NULL,
	[LoanChargeAmount] [money] NOT NULL)
END
 IF OBJECT_ID('dbo.LoanCharge_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[LoanCharge]) > 0
 BEGIN
CREATE TABLE [dbo].[LoanCharge_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*LoanFee_Lib*/
 IF OBJECT_ID('dbo.LoanFee_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[LoanFee_Lib_MP] (LoopId INT IDENTITY(1,1), 
    [LoanFee_Lib_ID] [int] NOT NULL,
	[LoanFee_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.LoanFee_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[LoanFee_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[LoanFee_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*LoanPurpose_Lib*/
 IF OBJECT_ID('dbo.LoanPurpose_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[LoanPurpose_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[LoanPurpose_Lib_ID] [int] NOT NULL,
	[LoanPurpose_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.LoanPurpose_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[LoanPurpose_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[LoanPurpose_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*LoanPurposeType*/
 IF OBJECT_ID('dbo.LoanPurposeType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[LoanPurposeType_MP] (LoopId INT IDENTITY(1,1), 
	[LoanPurposeType_ID] [int] NOT NULL,
	[LoanPurposeType_Text] [nvarchar](25) NOT NULL
)
END
 IF OBJECT_ID('dbo.LoanPurposeType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[LoanPurposeType]) > 0
 BEGIN
CREATE TABLE [dbo].[LoanPurposeType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*LoanRefinanceCharge*/
 IF OBJECT_ID('dbo.LoanRefinanceCharge_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[LoanRefinanceCharge_MP] (LoopId INT IDENTITY(1,1), 
	[ID] [int] NOT NULL,
	[LoanRefinanceChargeAmount] [money] NOT NULL
)
END
 IF OBJECT_ID('dbo.LoanRefinanceCharge_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[LoanRefinanceCharge]) > 0
 BEGIN
CREATE TABLE [dbo].[LoanRefinanceCharge_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*LoanTaxCode1099_Lib*/
 IF OBJECT_ID('dbo.LoanTaxCode1099_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[LoanTaxCode1099_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[LoanTaxCode1099_Lib_ID] [int] NOT NULL,
	[LoanTaxCode1099_Lib_Text] [varchar](5) NOT NULL
)
END
 IF OBJECT_ID('dbo.LoanTaxCode1099_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[LoanTaxCode1099_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[LoanTaxCode1099_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ReasonForDistribution_Lib*/
 IF OBJECT_ID('dbo.ReasonForDistribution_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ReasonForDistribution_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[ReasonForDistribution_Lib_ID] [int] NOT NULL,
	[ReasonForDistribution_Lib_Text] [varchar](100) NOT NULL
)
END
 IF OBJECT_ID('dbo.ReasonForDistribution_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ReasonForDistribution_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[ReasonForDistribution_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*RecordKeeper_Type*/
 IF OBJECT_ID('dbo.RecordKeeper_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[RecordKeeper_Type_MP] (LoopId INT IDENTITY(1,1), 
	[RecordKeeper_Type_ID] [int] NOT NULL,
	[RecordKeeper_Type_Text] [nvarchar](30) NOT NULL
)
END
 IF OBJECT_ID('dbo.RecordKeeper_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[RecordKeeper_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[RecordKeeper_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*RefinanceFee_Lib*/
 IF OBJECT_ID('dbo.RefinanceFee_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[RefinanceFee_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[RefinanceFee_Lib_ID] [int] NOT NULL,
	[RefinanceFee_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.RefinanceFee_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[RefinanceFee_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[RefinanceFee_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Refund_Type_Lib*/
 IF OBJECT_ID('dbo.Refund_Type_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Refund_Type_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[Refund_Type_Lib_ID] [int] NOT NULL,
	[Refund_Type_Lib_Text] [varchar](25) NOT NULL
)
END
 IF OBJECT_ID('dbo.Refund_Type_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Refund_Type_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[Refund_Type_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*TaxIDToUse_Lib*/
IF OBJECT_ID('dbo.TaxIDToUse_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[TaxIDToUse_Lib_MP] (LoopId INT IDENTITY(1,1),
	[TaxIDToUse_Lib_ID] [int] NOT NULL,
	[TaxIDToUse_Lib_Text] [varchar](60) NOT NULL)
END
 IF OBJECT_ID('dbo.TaxIDToUse_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[TaxIDToUse_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[TaxIDToUse_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*TemplateDoc*/
IF OBJECT_ID('dbo.TemplateDoc_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[TemplateDoc_MP] (LoopId INT IDENTITY(1,1),
	[Template_ID] [int] NOT NULL,
	[Document_Type] [nvarchar](max) NOT NULL,
	[Document_Text] [nvarchar](max) NOT NULL,
	[lastTouched] [datetime] NOT NULL,
	[byWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.TemplateDoc_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[TemplateDoc]) > 0
 BEGIN
CREATE TABLE [dbo].[TemplateDoc_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*TemplateEmail*/
IF OBJECT_ID('dbo.TemplateEmail_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[TemplateEmail_MP] (LoopId INT IDENTITY(1,1),
	[Template_ID] [int] NOT NULL,
	[Template_Type] [nvarchar](max) NOT NULL,
	[Template_Text] [nvarchar](max) NOT NULL,
	[Email_Sub] [nvarchar](max) NOT NULL,
	[lastTouched] [datetime] NOT NULL,
	[byWho] [int] NOT NULL)
END
 IF OBJECT_ID('dbo.TemplateEmail_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[TemplateEmail]) > 0
 BEGIN
CREATE TABLE [dbo].[TemplateEmail_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NoQBSReason_Lib*/
 IF OBJECT_ID('dbo.NoQBSReason_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NoQBSReason_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[NoQBSReason_Lib_ID] [int] NOT NULL,
	[NoQBSReason_Lib_Text] [nvarchar](255) NOT NULL
)
END
 IF OBJECT_ID('dbo.NoQBSReason_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NoQBSReason_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[NoQBSReason_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NormalFormOfBenefit_Lib*/
 IF OBJECT_ID('dbo.NormalFormOfBenefit_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NormalFormOfBenefit_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[NormalFormOfBenefit_Lib_ID] [int] NOT NULL,
	[NormalFormOfBenefit_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.NormalFormOfBenefit_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NormalFormOfBenefit_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[NormalFormOfBenefit_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NormalRetirementAge_Lib*/
 IF OBJECT_ID('dbo.NormalRetirementAge_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NormalRetirementAge_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[NormalRetirementAge_Lib_ID] [int] NOT NULL,
	[NormalRetirementAge_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.NormalRetirementAge_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NormalRetirementAge_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[NormalRetirementAge_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NormalRetirementDate_Lib*/
 IF OBJECT_ID('dbo.NormalRetirementDate_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NormalRetirementDate_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[NormalRetirementDate_Lib_ID] [int] NOT NULL,
	[NormalRetirementDate_Lib_Text] [varchar](100) NOT NULL
)
END
 IF OBJECT_ID('dbo.NormalRetirementDate_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NormalRetirementDate_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[NormalRetirementDate_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NormRetireDate_Type*/
 IF OBJECT_ID('dbo.NormRetireDate_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NormRetireDate_Type_MP] (LoopId INT IDENTITY(1,1), 
	[NormRetireDate_Type_ID] [int] NOT NULL,
	[NormRetireDate_Type_Text] [nvarchar](25) NOT NULL
)
END
 IF OBJECT_ID('dbo.NormRetireDate_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NormRetireDate_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[NormRetireDate_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NormRetireDateNear_Type*/
 IF OBJECT_ID('dbo.NormRetireDateNear_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NormRetireDateNear_Type_MP] (LoopId INT IDENTITY(1,1), 
	[NormRetireDateNear_Type_ID] [int] NOT NULL,
	[NormRetireDateNear_Type_Text] [nvarchar](50) NOT NULL
)
END
 IF OBJECT_ID('dbo.NormRetireDateNear_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NormRetireDateNear_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[NormRetireDateNear_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NormRetireDateUM_Type*/
 IF OBJECT_ID('dbo.NormRetireDateUM_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NormRetireDateUM_Type_MP] (LoopId INT IDENTITY(1,1), 
	[NormRetireDateUM_Type_ID] [int] NOT NULL,
	[NormRetireDateUM_Type_Text] [nvarchar](50) NOT NULL
)
END
 IF OBJECT_ID('dbo.NormRetireDateUM_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NormRetireDateUM_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[NormRetireDateUM_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NormRetireForm_Type*/
 IF OBJECT_ID('dbo.NormRetireForm_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NormRetireForm_Type_MP] (LoopId INT IDENTITY(1,1), 
	[NormRetireForm_Type_ID] [int] NOT NULL,
	[NormRetireForm_Type_Text] [nvarchar](30) NOT NULL
)
END
 IF OBJECT_ID('dbo.NormRetireForm_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NormRetireForm_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[NormRetireForm_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*NumberAllowed_Lib*/
 IF OBJECT_ID('dbo.NumberAllowed_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[NumberAllowed_Lib_MP] (LoopId INT IDENTITY(1,1), 
    [NumberAllowed_Lib_ID] [int] NOT NULL,
	[NumberAllowed_Lib_Text] [varchar](20) NOT NULL
)
END
 IF OBJECT_ID('dbo.NumberAllowed_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[NumberAllowed_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[NumberAllowed_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ManditoryAutoRolloverProvisions_Lib*/
 IF OBJECT_ID('dbo.ManditoryAutoRolloverProvisions_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ManditoryAutoRolloverProvisions_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[ManditoryAutoRolloverProvisions_Lib_ID] [int] NOT NULL,
	[ManditoryAutoRolloverProvisions_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.ManditoryAutoRolloverProvisions_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ManditoryAutoRolloverProvisions_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[ManditoryAutoRolloverProvisions_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ManditoryCashOutProvisions_Lib*/
 IF OBJECT_ID('dbo.ManditoryCashOutProvisions_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ManditoryCashOutProvisions_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[ManditoryCashOutProvisions_Lib_ID] [int] NOT NULL,
	[ManditoryCashOutProvisions_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.ManditoryCashOutProvisions_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ManditoryCashOutProvisions_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[ManditoryCashOutProvisions_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*MatchPeriodType*/
 IF OBJECT_ID('dbo.MatchPeriodType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[MatchPeriodType_MP] (LoopId INT IDENTITY(1,1), 
	[MatchPeriodType_ID] [int] NOT NULL,
	[MatchPeriodType_Text] [nvarchar](25) NOT NULL
)
END
 IF OBJECT_ID('dbo.MatchPeriodType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[MatchPeriodType]) > 0
 BEGIN
CREATE TABLE [dbo].[MatchPeriodType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*MatchType*/
 IF OBJECT_ID('dbo.MatchType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[MatchType_MP] (LoopId INT IDENTITY(1,1), 
	[MatchType_ID] [int] NOT NULL,
	[MatchType_Text] [nvarchar](25) NOT NULL
)
END
 IF OBJECT_ID('dbo.MatchType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[MatchType]) > 0
 BEGIN
CREATE TABLE [dbo].[MatchType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*MortalityType*/
 IF OBJECT_ID('dbo.MortalityType_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[MortalityType_MP] (LoopId INT IDENTITY(1,1), 
	[MortalityType_ID] [int] NOT NULL,
	[MortalityType_Text] [nvarchar](10) NOT NULL
)
END
 IF OBJECT_ID('dbo.MortalityType_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[MortalityType]) > 0
 BEGIN
CREATE TABLE [dbo].[MortalityType_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ServiceSchedule_Lib*/
 IF OBJECT_ID('dbo.ServiceSchedule_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ServiceSchedule_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[ServiceSchedule_Lib_ID] [int] NOT NULL,
	[ServiceSchedule_Lib_Text] [varchar](50) NOT NULL
)
END
 IF OBJECT_ID('dbo.ServiceSchedule_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ServiceSchedule_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[ServiceSchedule_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*ServiceUM_Type*/
 IF OBJECT_ID('dbo.ServiceUM_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[ServiceUM_Type_MP] (LoopId INT IDENTITY(1,1), 
	[ServiceUm_Type] [int] NOT NULL,
	[ServiceUm_Text] [nvarchar](15) NOT NULL
)
END
 IF OBJECT_ID('dbo.ServiceUM_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[ServiceUM_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[ServiceUM_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*SourceHierarchy_Lib*/
 IF OBJECT_ID('dbo.SourceHierarchy_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[SourceHierarchy_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[SourceHierarchy_Lib_ID] [int] NOT NULL,
	[SourceHierarchy_Lib_Text] [varchar](255) NOT NULL
)
END
 IF OBJECT_ID('dbo.SourceHierarchy_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[SourceHierarchy_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[SourceHierarchy_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*SourcesAvailable_Lib*/
 IF OBJECT_ID('dbo.SourcesAvailable_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[SourcesAvailable_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[SourcesAvailable_Lib_ID] [int] NOT NULL,
	[SourcesAvailable_Lib_Text] [varchar](255) NOT NULL
)
END
 IF OBJECT_ID('dbo.SourcesAvailable_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[SourcesAvailable_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[SourcesAvailable_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*TaskList_Categories*/
 IF OBJECT_ID('dbo.TaskList_Categories_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[TaskList_Categories_MP] (LoopId INT IDENTITY(1,1), 
	[TaskCategory_ID] [int] NOT NULL,
	[TaskCategory_Text] [nvarchar](75) NULL
)
END
 IF OBJECT_ID('dbo.TaskList_Categories_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[TaskList_Categories]) > 0
 BEGIN
CREATE TABLE [dbo].[TaskList_Categories_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*TermsOfTermination_Lib*/
 IF OBJECT_ID('dbo.TermsOfTermination_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[TermsOfTermination_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[TermsOfTermination_Lib_ID] [int] NOT NULL,
	[TermsOfTermination_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.TermsOfTermination_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[TermsOfTermination_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[TermsOfTermination_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Testing_Status_Type*/
 IF OBJECT_ID('dbo.Testing_Status_Type_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Testing_Status_Type_MP] (LoopId INT IDENTITY(1,1), 
	[Testing_Status_Type_ID] [int] NOT NULL,
	[Testing_Status_Type_Text] [nvarchar](30) NOT NULL,
	[Testing_Color] [nvarchar](7) NOT NULL
)
END
 IF OBJECT_ID('dbo.Testing_Status_Type_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Testing_Status_Type]) > 0
 BEGIN
CREATE TABLE [dbo].[Testing_Status_Type_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*VestingAcceleration_Lib*/
 IF OBJECT_ID('dbo.VestingAcceleration_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[VestingAcceleration_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[VestingAcceleration_Lib_ID] [int] NOT NULL,
	[VestingAcceleration_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.VestingAcceleration_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[VestingAcceleration_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[VestingAcceleration_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*VestingExclusions_Lib*/
 IF OBJECT_ID('dbo.VestingExclusions_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[VestingExclusions_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[VestingExclusions_Lib_ID] [int] NOT NULL,
	[VestingExclusions_Lib_Text] [varchar](100) NOT NULL
)
END
 IF OBJECT_ID('dbo.VestingExclusions_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[VestingExclusions_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[VestingExclusions_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*VestingSource_Lib*/
 IF OBJECT_ID('dbo.VestingSource_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[VestingSource_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[VestingSource_Lib_ID] [int] NOT NULL,
	[VestingSource_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.VestingSource_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[VestingSource_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[VestingSource_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*WhoPaysFee_Lib*/
 IF OBJECT_ID('dbo.WhoPaysFee_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[WhoPaysFee_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[WhoPaysFee_Lib_ID] [int] NOT NULL,
	[WhoPaysFee_Lib_Text] [varchar](60) NOT NULL,
	[PlanRestriction] [int] NOT NULL
)
END
 IF OBJECT_ID('dbo.WhoPaysFee_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[WhoPaysFee_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[WhoPaysFee_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*WhoRemitsWithholding_Lib*/
 IF OBJECT_ID('dbo.WhoRemitsWithholding_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[WhoRemitsWithholding_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[WhoRemitsWithholding_Lib_ID] [int] NOT NULL,
	[WhoRemitsWithholding_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.WhoRemitsWithholding_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[WhoRemitsWithholding_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[WhoRemitsWithholding_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*YearEndNoteCategory*/
 IF OBJECT_ID('dbo.YearEndNoteCategory_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[YearEndNoteCategory_MP] (LoopId INT IDENTITY(1,1), 
	[YearEndNoteCategory_ID] [int] NOT NULL,
	[YearEndNoteCategory_Text] [nvarchar](255) NOT NULL
)
END
 IF OBJECT_ID('dbo.YearEndNoteCategory_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[YearEndNoteCategory]) > 0
 BEGIN
CREATE TABLE [dbo].[YearEndNoteCategory_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*YearsRequirement_Lib*/
 IF OBJECT_ID('dbo.YearsRequirement_Lib_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[YearsRequirement_Lib_MP] (LoopId INT IDENTITY(1,1), 
	[YearsRequirement_Lib_ID] [int] NOT NULL,
	[YearsRequirement_Lib_Text] [varchar](60) NOT NULL
)
END
 IF OBJECT_ID('dbo.YearsRequirement_Lib_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[YearsRequirement_Lib]) > 0
 BEGIN
CREATE TABLE [dbo].[YearsRequirement_Lib_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*Portal_NewTPAFirm*/
 IF OBJECT_ID('dbo.Portal_NewTPAFirm_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_NewTPAFirm_MP] (LoopId INT IDENTITY(1,1), 
	[Id] [int] NOT NULL,
	[TPAFirmText] [nvarchar](255) NOT NULL
)
END
 IF OBJECT_ID('dbo.Portal_NewTPAFirm_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_NewTPAFirm]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_NewTPAFirm_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_ReasonForDeparture]*/
 IF OBJECT_ID('dbo.Portal_ReasonForDeparture_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_ReasonForDeparture_MP] (LoopId INT IDENTITY(1,1), 
	[Id] [int] NOT NULL,
	[ReasonForDepartureText] [nvarchar](255) NOT NULL
)
END
 IF OBJECT_ID('dbo.Portal_ReasonForDeparture_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_ReasonForDeparture]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_ReasonForDeparture_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END

/*[dbo].[Portal_TakeOverFrom]*/
 IF OBJECT_ID('dbo.Portal_TakeOverFrom_MP') IS NULL
 BEGIN
CREATE TABLE [dbo].[Portal_TakeOverFrom_MP] (LoopId INT IDENTITY(1,1), 
	[Id] [int] NOT NULL,
	[TakeOverFromText] [nvarchar](255) NOT NULL
)
END
 IF OBJECT_ID('dbo.Portal_TakeOverFrom_ID_Mapping') IS NULL AND (SELECT COUNT(*) FROM [dbo].[Portal_TakeOverFrom]) > 0
 BEGIN
CREATE TABLE [dbo].[Portal_TakeOverFrom_ID_Mapping] (MapId INT IDENTITY(1,1),
Old_ID int,
New_ID int)
END
