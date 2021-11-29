
/*Plans_YearToYear Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  
--Get max ID value in table
DECLARE @MaxIDExist INT = (SELECT MAX(Plans_YearToYear_ID) FROM [dbo].[Plans_YearToYear]);--353

--Insert @MaxIDExist into respective mapping table
	SET IDENTITY_INSERT dbo.[Plans_YearToYear_ID_Mapping] ON; 
	INSERT INTO [dbo].[Plans_YearToYear_ID_Mapping] (MapId, Old_ID, New_ID)
	VALUES(-1, @MaxIDExist, -1)
	SET IDENTITY_INSERT dbo.[Plans_YearToYear_ID_Mapping] OFF; 

--UPDATE Plans_Index_ID column
UPDATE [dbo].[Plans_YearToYear_MP]
SET Plans_Index_ID = um.New_ID
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_ID = um.Old_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE ByWho column
UPDATE [dbo].[Plans_YearToYear_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE Analyst
UPDATE [dbo].[Plans_YearToYear_MP]
SET Analyst = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Analyst=um.[MyPlans_SysUserID]
WHERE bc.Analyst != -1

--UPDATE Reviewer
UPDATE [dbo].[Plans_YearToYear_MP]
SET Reviewer = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.Reviewer=um.[MyPlans_SysUserID]
WHERE bc.Reviewer != -1

--UPDATE AssetAnalyst
UPDATE [dbo].[Plans_YearToYear_MP]
SET AssetAnalyst = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssetAnalyst=um.[MyPlans_SysUserID]
WHERE bc.AssetAnalyst != -1

--UPDATE AssetReviewer
UPDATE [dbo].[Plans_YearToYear_MP]
SET AssetReviewer = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AssetReviewer=um.[MyPlans_SysUserID]
WHERE bc.AssetReviewer != -1

--UPDATE SHConfirmedBy
UPDATE [dbo].[Plans_YearToYear_MP]
SET SHConfirmedBy = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.SHConfirmedBy=um.[MyPlans_SysUserID]
WHERE bc.SHConfirmedBy != -1

--UPDATE AcaConfirmedBy
UPDATE [dbo].[Plans_YearToYear_MP]
SET AcaConfirmedBy = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.AcaConfirmedBy=um.[MyPlans_SysUserID]
WHERE bc.AcaConfirmedBy != -1

--UPDATE InvestmentPlatform_ID
UPDATE [dbo].[Plans_YearToYear_MP]
SET InvestmentPlatform_ID = um.New_ID
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[InvestmentPlatforms_Lib_ID_Mapping] um ON bc.InvestmentPlatform_ID=um.Old_ID
WHERE bc.InvestmentPlatform_ID != -1

--UPDATE ClientRefusesToGetFidelityBondByWho
UPDATE [dbo].[Plans_YearToYear_MP]
SET ClientRefusesToGetFidelityBondByWho = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ClientRefusesToGetFidelityBondByWho=um.[MyPlans_SysUserID]
WHERE bc.ClientRefusesToGetFidelityBondByWho != -1

--UPDATE ClientRefusesToGetFidelityBondByWho
UPDATE [dbo].[Plans_YearToYear_MP]
SET DistFeePaidByWho = um.[PPC_SysUserID]
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.DistFeePaidByWho=um.[MyPlans_SysUserID]
WHERE bc.DistFeePaidByWho != -1

--UPDATE DistributionCharge
UPDATE [dbo].[Plans_YearToYear_MP]
SET DistributionCharge = um.New_ID
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[DistributionCharge_ID_Mapping] um ON bc.DistributionCharge=um.Old_ID
WHERE bc.DistributionCharge != -1

--UPDATE LoanCharge
UPDATE [dbo].[Plans_YearToYear_MP]
SET LoanCharge = um.New_ID
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[LoanCharge_ID_Mapping] um ON bc.LoanCharge=um.Old_ID
WHERE bc.LoanCharge != -1

--UPDATE LoanRefinanceCharge
UPDATE [dbo].[Plans_YearToYear_MP]
SET LoanRefinanceCharge = um.New_ID
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[LoanRefinanceCharge_ID_Mapping] um ON bc.LoanRefinanceCharge=um.Old_ID
WHERE bc.LoanRefinanceCharge != -1

--UPDATE Notes_ID
UPDATE [dbo].[Plans_YearToYear_MP]
SET Notes_ID = um.New_ID
FROM [dbo].[Plans_YearToYear_MP] bc
JOIN [dbo].[Notes_ID_Mapping] um ON bc.Notes_ID=um.Old_ID
WHERE bc.Notes_ID != -1

--Insert records to target table and grab new IDs 
DECLARE @LoopCounter INT , @MaxId INT, @OldID INT, @NewID INT;
DECLARE @IdentityValue AS TABLE(ID INT); 
SELECT @LoopCounter = MIN(LoopId),
		@MaxId = MAX(LoopId) 
FROM [dbo].[Plans_YearToYear_MP]

IF ((SELECT COUNT(*) FROM [dbo].[Plans_YearToYear_MP]) > 0)
BEGIN
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
	PRINT CONCAT('Processing row: ', @LoopCounter)
	SELECT @OldId = Plans_Index_ID FROM [dbo].[Plans_YearToYear_MP]  WHERE LoopId = @LoopCounter
	IF(@OldID != -1
	AND (SELECT COUNT(*) FROM Plans WHERE Plans_Index_ID = @OldId) > 0)	
	BEGIN
	INSERT INTO [dbo].[Plans_YearToYear] OUTPUT Inserted.Plans_YearToYear_ID INTO @IdentityValue
		SELECT 	Plans_Index_ID,
				PYE_Year,
				Type5500,
				Analyst,
				Reviewer,
				SafeHarbor,
				SafeHarbor_Type,
				ACA,
				ACA_Type,
				ACA_MIN_PERC,
				ACA_MAX_PERC,
				PBGC_Covered,
				Formulae,
				NoAdpTesting_Required,
				NoAcpTesting_Required,
				BondCompany,
				FidBondAmt,
				BondDate,
				FeeOverride,
				BaseFee,
				PerParticipantFee,
				NonParticipantFee,
				LoanFee,
				Plan_Termed,
				LastUpdated,
				ByWho,
				BondRequired,
				DateAssignedForWork,
				AssetAnalyst,
				AssetReviewer,
				AssetDateAssignedForWork,
				ProfitSharing,
				CrossTesting,
				Aggregate,
				TopHeavy,
				ParticipantCount,
				JobTitleAddenReq,
				ActivePlanYear,
				SHConfirmed,
				SHConfirmedBy,
				SHConfirmedWhen,
				AcaConfirmed,
				AcaConfirmedBy,
				AcaConfirmedWhen,
				QBSRequirement,
				InvestmentPlatform_ID,
				ER_Match_VS,
				ER_Profit_Sharing_VS,
				PlanQuarter1,
				PlanQuarter2,
				PlanQuarter3,
				PlanQuarter4,
				YearsOfService,
				ClientRefusesToGetFidelityBond,
				ClientRefusesToGetFidelityBondWhen,
				ClientRefusesToGetFidelityBondByWho,
				ValuationDates,
				DistFeePaidByWho,
				DistLoansAllowed,
				DistInService,
				DistHardShips,
				AscNumber,
				ArcAscNumber,
				Form5500Filed,
				FormulaeExpires,
				FormulaeExpiresOn,
				YEAssetTotal,
				AssetsAsOf,
				ActiveParticipants,
				TermVestedParticipants,
				FundingStatus,
				YEPVAB,
				YEAFTAP,
				CurrentContribution,
				AVA,
				AnnualPremium,
				DownloadFromWeb,
				EffectiveUntilCancelled,
				TaxFilerStatus,
				EarlyDate,
				From5558FiledDate,
				IsPooled,
				IsSelfdirected,
				IsAutoIncrease,
				PriorTopHeavy,
				CurrentTopHeavy,
				DistributionFee,
				DistFee,
				IsBalanceForward,
				IsClientPrepElecFrm,
				IsBoycePrep1099R,
				DistInstruction,
				DistDeliveryPref,
				OtherDistDeliveryPref,
				UseInvestCoForm,
				DistributionCharge,
				SDBACharge,
				LoanCharge,
				SDBALoanCharge,
				LoanRefinanceCharge,
				Notes_ID,
				IsQACA,
				IsQBSRequired,
				IsProvidedByPlatform,
				IsQDIARequired,
				IsTestedPlan,
				IsQDIAInvestment,
				Qdia_Investment,
				CurrentYear,
				PriorYear,
				IsBoyceProcessLoan,
				IsEFAST,
				ExpirationDate,
				Actuary,
				IsPortalDeleted,
				UDF1,
				UDF2,
				UDF3,
				UDF4,
				UDF5,
				IsHoldFollowUp,
				IsParticipantDisclosureNoticeRequired
   		FROM [dbo].[Plans_YearToYear_MP]  WHERE LoopId = @LoopCounter
	
	SET @NewID = (SELECT TOP 1 ID FROM @IdentityValue); 
	DELETE FROM @IdentityValue;

	--Insert oldId, newId into respective mapping table
	INSERT INTO [dbo].[Plans_YearToYear_ID_Mapping]
	VALUES(@OldID, @NewID)
	
 END
   SELECT @LoopCounter  = MIN(LoopId) 
   FROM [dbo].[Plans_YearToYear_MP]  WHERE LoopId > @LoopCounter

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