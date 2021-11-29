/*Payroll Name Mapping*/
DECLARE @ListOfPayroll TABLE(ID INT IDENTITY(1,1),MP_Name NVARCHAR(100) , PPC_Name NVARCHAR(100))
 
INSERT INTO @ListOfPayroll
VALUES 
('ADP','ADP, LLC')  ,
('Advantage Payroll','Advantage Payroll Services - PAYCHEX') ,
('CBR- Creative Business Resources','CBR - Creative Business Resources'),
('Inhouse','In House'),
('In-House','In House'),
('Heartland', 'Heartland Payroll'),
('Intuit/Quickbooks','Intuit Payroll'),
('Ledgers Etc','Ledgers Etc.'),
('Magellan HCM','Magellan')

DECLARE @LoopCounter INT , @MaxId INT, @MP_Name NVARCHAR(100), @PPC_Name NVARCHAR(100), @MP_ID INT, @PPC_ID INT;
SELECT @LoopCounter = MIN(ID),
		@MaxId = MAX(ID) 
FROM @ListOfPayroll
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
PRINT @LOOPCOUNTER

SET @MP_Name = (SELECT TOP 1 MP_Name FROM @ListOfPayroll WHERE ID = @LoopCounter);
SET @PPC_Name = (SELECT TOP 1 PPC_Name FROM @ListOfPayroll WHERE ID = @LoopCounter);
SET @MP_ID = (SELECT TOP 1 PayrollProvider_ID FROM [dbo].[PayrollProvider] WHERE TRIM(PayrollProvider_Text) = TRIM(@MP_Name));
SET @PPC_ID = (SELECT TOP 1 PayrollProvider_ID FROM [dbo].[PayrollProvider] WHERE TRIM(PayrollProvider_Text) =  TRIM(@PPC_Name));

IF(@MP_ID IS NOT NULL AND @PPC_ID IS NOT NULL)
BEGIN
UPDATE [dbo].[PayrollProvider_ID_Mapping]
SET New_ID = @PPC_ID
FROM [dbo].[PayrollProvider_ID_Mapping]
WHERE New_ID = @MP_ID

DELETE FROM [PayrollProvider]
WHERE PayrollProvider_ID=@MP_ID
END
ELSE
BEGIN
PRINT CONCAT('DATA NOT EXIST TO MAP: ', @MP_Name)
END
SELECT @LoopCounter  = MIN(ID) 
   FROM @ListOfPayroll  WHERE ID > @LoopCounter
END