/*Pricing_Answers Migration*/
BEGIN TRANSACTION;  
  
BEGIN TRY  

--Insert prepared data from temp table to target table
SET IDENTITY_INSERT [dbo].[Pricing_Answers] ON;
INSERT INTO [dbo].[Pricing_Answers]
(Pricing_Answers_ID,
Pricing_Schedule_ID,
PricingDetails_ID,
Actual_Year,
Actual_Partial,
Base_Fee,
PerPart_Fee,
FeeEst)
SELECT Pricing_Answers_ID,
Pricing_Schedule_ID,
PricingDetails_ID,
Actual_Year,
Actual_Partial,
Base_Fee,
PerPart_Fee,
FeeEst
FROM [Pricing_Answers_MP]
SET IDENTITY_INSERT [dbo].[Pricing_Answers] OFF;

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