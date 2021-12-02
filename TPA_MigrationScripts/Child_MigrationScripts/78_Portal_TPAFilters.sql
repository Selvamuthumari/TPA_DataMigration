
/*Portal_TPAFilters Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--UPDATE UserId column
UPDATE [dbo].[Portal_TPAFilters_MP]
SET UserId = um.PPC_SysUserID
FROM [dbo].[Portal_TPAFilters_MP] bc
JOIN [dbo].[UserId_Mapping] um ON bc.UserId = um.MyPlans_SysUserID
WHERE bc.UserId != -1

--Insert prepared data from temp table to target table
INSERT INTO [dbo].[Portal_TPAFilters]
SELECT UserId,
PensionAssistantSelected,
ConsultantSelected,
FiveHundrdSelected,
PlanTypeSelected,
PlanStatusTypeSelected,
ClientStatusSelected,
ServiceScheduleSelected,
AssignedToSelected,
CreatedBySelected,
SubCategorySelected,
PlanYESelected,
IsActivePlanYear,
MainCategorySelected,
IsDashboardFilter,
IsCommLogFilter,
FlagSelected,
IsNotificationFilter,
IsDashboardStatusPlanReportFilter,
AdditionalServices
FROM [Portal_TPAFilters_MP]

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