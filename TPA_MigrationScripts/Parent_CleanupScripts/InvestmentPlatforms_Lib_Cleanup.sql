/*InvestmentPlatforms_Lib Name Mapping*/
DECLARE @ListOfStatementFrom TABLE(ID INT IDENTITY(1,1),MP_Name NVARCHAR(100) , PPC_Name NVARCHAR(100))
 
INSERT INTO @ListOfStatementFrom
VALUES 
('Ameriprise Financial','Ameriprise'),
('AssetMark Trust Co','Assetmark'),
('BBVA Compass','BVVA'),
('E*Trade Financial','Etrade'),
('Fidelity Investments','Fidelity'),
('Jackson Nat''l Life Ins Co.', 'Jackson National Life Insurance'),
('RBC Wealth Management','RBC'),
('UBS Financial Services Inc.','UBS Financial'),
('T Rowe Price','T. Rowe Price'),
('USAA Investment Management Co.','USAA'),
('RK-American Funds','American Funds'),
('RK-American Funds Plan Premier','American Funds'),
('RK-Ameritas','Ameritas'),
('RK-Ascensus','Ascensus'),
('RK-ASPire (formerly 401kasp)','Aspire'),
('RK-Employee Fiduciary','Employee Fiduciary, LLC'),
('RK-First Mercantile','First Mercantile'),
('RK-John Hancock','John Hancock'),
('RK-Lincoln Financial','Lincoln Financial'),
('RK-Mass Mutual','Mass Mutual'),
('RK-Nationwide','Nationwide'),
('RK-Principal','Principal Financial'),
('RK-T. Rowe Price','T. Rowe Price'),
('RK-Transamerica','Transamerica'),
('RK-Voya','Voya')

DECLARE @LoopCounter INT , @MaxId INT, @MP_Name NVARCHAR(100), @PPC_Name NVARCHAR(100), @MP_ID INT, @PPC_ID INT;
SELECT @LoopCounter = MIN(ID),
		@MaxId = MAX(ID) 
FROM @ListOfStatementFrom
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
PRINT @LOOPCOUNTER

SET @MP_Name = (SELECT TOP 1 MP_Name FROM @ListOfStatementFrom WHERE ID = @LoopCounter);
SET @PPC_Name = (SELECT TOP 1 PPC_Name FROM @ListOfStatementFrom WHERE ID = @LoopCounter);
SET @MP_ID = (SELECT TOP 1 InvestmentPlatform_ID FROM [dbo].[InvestmentPlatforms_Lib] WHERE TRIM(InvestmentPlatform_Text) = TRIM(@MP_Name));
SET @PPC_ID = (SELECT TOP 1 InvestmentPlatform_ID FROM [dbo].[InvestmentPlatforms_Lib] WHERE TRIM(InvestmentPlatform_Text) =  TRIM(@PPC_Name));

IF(@MP_ID IS NOT NULL AND @PPC_ID IS NOT NULL)
BEGIN
UPDATE [dbo].[PayrollProvider_ID_Mapping]
SET New_ID = @PPC_ID
FROM [dbo].[PayrollProvider_ID_Mapping]
WHERE New_ID = @MP_ID

DELETE FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_ID=@MP_ID
END
ELSE
BEGIN
PRINT CONCAT('DATA NOT EXIST TO MAP: ', @MP_Name)
END
SELECT @LoopCounter  = MIN(ID) 
   FROM @ListOfStatementFrom  WHERE ID > @LoopCounter
END

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='ExpertPlan'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-ExpertPlan'

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='Great West'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-Great-West'

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='Guardian'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-Guardian'

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='July Services'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-July Services'

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='Paychex'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-Paychex'

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='T Bank'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-T Bank'

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='Ubiquity'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-Ubiquity'

UPDATE [InvestmentPlatforms_Lib]
SET InvestmentPlatform_Text='WESPAC'
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='RK-WESPAC'

DELETE
FROM [InvestmentPlatforms_Lib]
WHERE InvestmentPlatform_Text='Test'

