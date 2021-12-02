/*DocTrackTicket Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE Plan_ID column
UPDATE [dbo].[DocTrackTicket_MP]
SET Plans_Index_ID = um.New_ID
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[Plans_ID_Mapping] um ON bc.Plans_Index_ID = um.Old_ID
WHERE bc.Plans_Index_ID != -1

--UPDATE AmendingWhat column
UPDATE [dbo].[DocTrackTicket_MP]
SET AmendingWhat = um.New_ID
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[AmendingTypeLib_ID_Mapping] um ON bc.AmendingWhat = um.Old_ID
WHERE bc.AmendingWhat != -1

--UPDATE ByWho column
UPDATE [dbo].[DocTrackTicket_MP]
SET [ByWho] = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ByWho=um.[MyPlans_SysUserID]
WHERE bc.ByWho != -1

--UPDATE RequestDateByWho
UPDATE [dbo].[DocTrackTicket_MP]
SET RequestDateByWho = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.RequestDateByWho=um.[MyPlans_SysUserID]
WHERE bc.RequestDateByWho != -1

--UPDATE RequestCanceledByWho
UPDATE [dbo].[DocTrackTicket_MP]
SET RequestCanceledByWho = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.RequestCanceledByWho=um.[MyPlans_SysUserID]
WHERE bc.RequestCanceledByWho != -1

--UPDATE ManagementApprovalGivenByWho
UPDATE [dbo].[DocTrackTicket_MP]
SET ManagementApprovalGivenByWho = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ManagementApprovalGivenByWho=um.[MyPlans_SysUserID]
WHERE bc.ManagementApprovalGivenByWho != -1

--UPDATE WriteUpDraftAssignedTo
UPDATE [dbo].[DocTrackTicket_MP]
SET WriteUpDraftAssignedTo = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.WriteUpDraftAssignedTo=um.[MyPlans_SysUserID]
WHERE bc.WriteUpDraftAssignedTo != -1

--UPDATE ReviewAssignedTo
UPDATE [dbo].[DocTrackTicket_MP]
SET ReviewAssignedTo = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ReviewAssignedTo=um.[MyPlans_SysUserID]
WHERE bc.ReviewAssignedTo != -1

--UPDATE ReturnFromReviewAssignedTo
UPDATE [dbo].[DocTrackTicket_MP]
SET ReturnFromReviewAssignedTo = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.ReturnFromReviewAssignedTo=um.[MyPlans_SysUserID]
WHERE bc.ReturnFromReviewAssignedTo != -1

--UPDATE FinalSignOffAssignedTo
UPDATE [dbo].[DocTrackTicket_MP]
SET FinalSignOffAssignedTo = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.FinalSignOffAssignedTo=um.[MyPlans_SysUserID]
WHERE bc.FinalSignOffAssignedTo != -1

--UPDATE InvoiceAssignedTo
UPDATE [dbo].[DocTrackTicket_MP]
SET InvoiceAssignedTo = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.InvoiceAssignedTo=um.[MyPlans_SysUserID]
WHERE bc.InvoiceAssignedTo != -1

--UPDATE FinalForMailAssignedTo
UPDATE [dbo].[DocTrackTicket_MP]
SET FinalForMailAssignedTo = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.FinalForMailAssignedTo=um.[MyPlans_SysUserID]
WHERE bc.FinalForMailAssignedTo != -1

--UPDATE PagesMarkedSignedByWho
UPDATE [dbo].[DocTrackTicket_MP]
SET PagesMarkedSignedByWho = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.PagesMarkedSignedByWho=um.[MyPlans_SysUserID]
WHERE bc.PagesMarkedSignedByWho != -1

--UPDATE PagesReceivedByWho
UPDATE [dbo].[DocTrackTicket_MP]
SET PagesReceivedByWho = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.PagesReceivedByWho=um.[MyPlans_SysUserID]
WHERE bc.PagesReceivedByWho != -1

--UPDATE DateSentByWho
UPDATE [dbo].[DocTrackTicket_MP]
SET DateSentByWho = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.DateSentByWho=um.[MyPlans_SysUserID]
WHERE bc.DateSentByWho != -1

--UPDATE LockedByWho
UPDATE [dbo].[DocTrackTicket_MP]
SET LockedByWho = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.LockedByWho=um.[MyPlans_SysUserID]
WHERE bc.LockedByWho != -1

--UPDATE BookmarkAnnotateAssignedTo
UPDATE [dbo].[DocTrackTicket_MP]
SET BookmarkAnnotateAssignedTo = um.[PPC_SysUserID]
FROM [dbo].[DocTrackTicket_MP] bc
JOIN [dbo].[UserID_Mapping] um ON bc.BookmarkAnnotateAssignedTo=um.[MyPlans_SysUserID]
WHERE bc.BookmarkAnnotateAssignedTo != -1


--Insert prepared data from temp table to target table
INSERT INTO [dbo].[DocTrackTicket]
SELECT Plans_Index_ID,
Document_Name,
Document_Purpose,
AmendingWhat,
Document_Work,
AmendmentNumber,
Effective_Date,
Deadline,
Consultant,
RequestInitiatedPriorToTracking,
RequestDate,
RequestDateByWho,
RequestCanceled,
RequestCanceledByWho,
ManagementApprovalRequired,
ManagementApprovalGiven,
ManagementApprovalGivenWhen,
ManagementApprovalGivenByWho,
WriteUpDraftAssignedTo,
WriteUpDraftWhen,
WriteUpDraftDone,
ReviewAssignedTo,
ReviewWhen,
ReviewDone,
ReturnFromReviewAssignedTo,
ReturnFromReviewDone,
ReturnFromReviewWhen,
FinalSignOffAssignedTo,
FinalSignOffWhen,
FinalSignOffDone,
InvoiceAssignedTo,
InvoiceWhen,
InvoiceDone,
FinalForMailAssignedTo,
FinalForMailWhen,
FinalForMailDone,
PagesMarkedSignedByWho,
PagesMarkedSignedWhen,
PagesReceivedByWho,
PagesReceivedWhen,
DateClientNotifiedOfFee,
DateClientApprovedFee,
FeeEstimate,
InvoiceNumber,
InvoiceDate,
InvoiceAmount,
DeliveryMode,
MeetingDate,
DateSent,
DateSentByWho,
NotesSummary,
Locked,
LockedByWho,
LockedStamp,
LockLevel,
LastEdited,
ByWho,
BookmarkAnnotateWhen,
BookmarkAnnotateAssignedTo,
BookmarkAnnotateDone,
AttachmentId
FROM DocTrackTicket_MP

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