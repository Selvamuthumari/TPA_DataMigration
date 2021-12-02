/*Update ACTIVE Client's # to resolve conflicts between MyPlans and PPC*/

BEGIN TRANSACTION;  
  
BEGIN TRY 
IF((select COUNT(*) from Client_Master_MP mp
join Client_Master pp on pp.altIdNum1 = mp.altIdNum1
where mp.isdead=0) >0 )
BEGIN

DECLARE @ActiveClientList TABLE(ID INT IDENTITY(1,1),AltIDNum1 NVARCHAR(MAX) , UpdatedAltIDNum1 NVARCHAR(MAX))
 
INSERT INTO @ActiveClientList
VALUES 
('1234','555122-001'),
('1900','Delete Client'),
('2433','Delete Client'),
('2496','5043-001'),
('2545','Delete Client'),
('2718','Delete Client'),
('2757','5183'),
('2771','Delete Client'),
('2776','5443'),
('3256','Delete Client')

--SELECT * FROM Client_Master_MP MP JOIN @ActiveClientList AC ON MP.AltIDNum1=AC.AltIDNum1

UPDATE Client_Master_MP
SET [AltIDNum1]= AC.UpdatedAltIDNum1
FROM Client_Master_MP MP
JOIN @ActiveClientList AC ON MP.AltIDNum1=AC.AltIDNum1
WHERE AC.UpdatedAltIDNum1 != 'Delete Client'

SELECT MP.* INTO Client_Master_MP_Deleted
FROM Client_Master_MP MP
JOIN @ActiveClientList AC ON MP.AltIDNum1=AC.AltIDNum1
WHERE AC.UpdatedAltIDNum1 = 'Delete Client'

DELETE MP
FROM Client_Master_MP MP
JOIN @ActiveClientList AC ON MP.AltIDNum1=AC.AltIDNum1
WHERE AC.UpdatedAltIDNum1 = 'Delete Client'

END
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
  
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO  