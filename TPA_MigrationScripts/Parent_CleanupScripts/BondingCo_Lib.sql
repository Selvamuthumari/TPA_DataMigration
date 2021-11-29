/*BondingCo_Lib Name Mapping*/

DECLARE @ListOfBondingCo TABLE(ID INT IDENTITY(1,1),MP_Name NVARCHAR(100) , PPC_Name NVARCHAR(100))
 
INSERT INTO @ListOfBondingCo
VALUES 
('Accord','Acord'),
('ACORD - Hub International','Acord'),
('ACORD - Stuckey Ins Assoc Agencies','Acord'),
('ACORD - The Mahoney Group','Acord'),
('CBIC Insuracne','CBIC'),
('CBIC Insurance','CBIC'),
('Chubb Group','Chubb'),
('Federal Ins Co (CHUBB)', 'Chubb'),
('Cincinatti Ins Co','Cincinnati Insurance'),
('Cincinnati Insurance Company','Cincinnati Insurance'),
('Cincinnatti Ins Co','Cincinnati Insurance'),
('CNA  Western Surety Company','CNA Surety'),
('CNA & Travelers','CNA Surety'),
('CNA Insurance Companies','CNA Surety'),
('Colonial Security','Colonial'),
('Colonial Surety','Colonial'),
('Colonial Surety Co.','Colonial'),
('Colonial Surety Company','Colonial'),
('Colonial Surety Compnay','Colonial'),
('Contractors Bond','Continental Casualty Company'),
('Contractors Bonding &amp; Insurance Company (CBIC)','Continental Casualty Company'),
('Contractors Bonding and Insurance Co.','Continental Casualty Company'),
('Fidelity','Fidelity Insurance Company'),
('Great American','Great American Insurance Group'),
('HARTFORD FIRE','Hartford Fire Insurance Company'),
('Hartford Fire Ins Co','Hartford Fire Insurance Company'),
('Hartford Fire Insurance','Hartford Fire Insurance Company'),
('Hartford Fire Insurance Co','Hartford Fire Insurance Company'),
('HUB Internaitonal Milne of AZ','HUB International'),
('Hub International of Arizona','HUB International'),
('Hub Intl Mountain States Ltd','HUB International'),
('Ohio Casualty','Ohio Casualty Insurance Company'),
('Old Republic','Old Republic Surety Company'),
('Old Republic Ins','Old Republic Surety Company'),
('Old Republic Insurance','Old Republic Surety Company'),
('Old Republic Insurance Company','Old Republic Surety Company'),
('Old Republic Surety Co','Old Republic Surety Company'),
('One Beacon','OneBeacon Insurance Group, LLC'),
('Philadelphia Ins. Co.','Philadelphia Indemnity Insurance Company'),
('Philadelphia Insurance','Philadelphia Indemnity Insurance Company'),
('Platt River Insurance Co','Platte River Insurance Company'),
('RLI Insurance','RLI'),
('RLI Insurance Co','RLI'),
('RLI Insurance Co.','RLI'),
('RLI Insurance Company','RLI'),
('RLI Insureance Company','RLI'),
('RLI Insurnace Company','RLI'),
('RLI Surety','RLI'),
('State Farm Ins','State Farm'),
('State Farm Fire and Casualty Company','State Farm'),
('State Farm Insuarance','State Farm'),
('State Farm Insurance','State Farm'),
('Statefarm','State Farm'),
('The Cincinnati Insurance Company','Cincinnati Insurance'),
('The Hanover','The Hanover Insurance Company'),
('The Hartford Co.','The Hartford'),
('Travelers Casualty','Travelers'),
('Travelers Casualty & Surety','Travelers'),
('Travelers Casualty & Surety Company of America','Travelers'),
('Travelers Casualty &amp; Surety of America','Travelers'),
('Travelers Casualty &amp;amp;amp;amp;amp; Surety of America', 'Travelers'),
('Travelers Casualty and Surety','Travelers'),
('Travelers Casualty and Surety Company of America','Travelers'),
('Travelers Casualty Surety Company of America','Travelers'),
('Travelers Casulty and Surety Company of America','Travelers'),
('Travelers Indemnity Company','Travelers'),
('Travelers Property &amp; Casualty Co','Travelers'),
('Travelers Property &amp;amp;amp; Casualty Co','Travelers'),
('Travelers Property &amp;amp;amp;amp;amp; Casualty Co','Travelers'),
('Western National','Western National Mutual Insurance Company'),
('Western Surety','Western Surety Company'),
('Western Surety Co','Western Surety Company'),
('Western Surety Co.','Western Surety Company'),
('Westfield Insurance Co.','Westfield Insurance')

DECLARE @LoopCounter INT , @MaxId INT, @MP_Name NVARCHAR(100), @PPC_Name NVARCHAR(100), @MP_ID INT, @PPC_ID INT;
SELECT @LoopCounter = MIN(ID),
		@MaxId = MAX(ID) 
FROM @ListOfBondingCo
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
PRINT @LOOPCOUNTER

SET @MP_Name = (SELECT TOP 1 MP_Name FROM @ListOfBondingCo WHERE ID = @LoopCounter);
SET @PPC_Name = (SELECT TOP 1 PPC_Name FROM @ListOfBondingCo WHERE ID = @LoopCounter);
SET @MP_ID = (SELECT TOP 1 BondingCo_ID FROM [dbo].[BondingCo_Lib] WHERE TRIM(BondingCo_Text) = TRIM(@MP_Name));
SET @PPC_ID = (SELECT TOP 1 BondingCo_ID FROM [dbo].[BondingCo_Lib] WHERE TRIM(BondingCo_Text) =  TRIM(@PPC_Name));

IF(@MP_ID IS NOT NULL AND @PPC_ID IS NOT NULL)
BEGIN
UPDATE [dbo].[BondingCo_Lib_ID_Mapping]
SET New_ID = @PPC_ID
FROM [dbo].[BondingCo_Lib_ID_Mapping]
WHERE New_ID = @MP_ID

DELETE FROM [BondingCo_Lib]
WHERE BondingCo_ID=@MP_ID
END
ELSE
BEGIN
PRINT CONCAT('DATA NOT EXIST TO MAP: ', @MP_Name)
END
SELECT @LoopCounter  = MIN(ID) 
   FROM @ListOfBondingCo  WHERE ID > @LoopCounter
END


DELETE
FROM [BondingCo_Lib]
WHERE BondingCo_Text IN ('64654')
