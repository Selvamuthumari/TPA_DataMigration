-- Table to record errors
-- Check to see whether log table exists.  
IF OBJECT_ID (N'dbo.DataMigration_Errors') IS NULL  
BEGIN
CREATE TABLE [dbo].[DataMigration_Errors]
         (ErrorID        INT IDENTITY(1, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME)
END

---- Stored procedure to log error information. 
---- Check to see whether this stored procedure exists.  
--IF OBJECT_ID (N'dbo.usp_LogErrorInfo', N'P') IS NOT NULL  
--    DROP PROCEDURE [dbo].[usp_LogErrorInfo];  
--GO  
  
---- Create procedure to retrieve error information.  
--CREATE PROCEDURE [dbo].[usp_LogErrorInfo]  
--AS  
--    INSERT INTO dbo.DataMigration_Errors
--    VALUES
--  (SUSER_SNAME(),
--   ERROR_NUMBER(),
--   ERROR_STATE(),
--   ERROR_SEVERITY(),
--   ERROR_LINE(),
--   ERROR_PROCEDURE(),
--   ERROR_MESSAGE(),
--   GETDATE()); 
--GO  