/*Portal_NewTPAFirm Name Mapping*/

DECLARE @ListOfNewTPAFirm TABLE(ID INT IDENTITY(1,1),MP_Name NVARCHAR(100) , PPC_Name NVARCHAR(100))
 
INSERT INTO @ListOfNewTPAFirm
VALUES 
('ADP Retirement Services','ADP'),
('Mercer Advisros','Mercer'),
('Sunwest Actuarial Services','Sunwest Pensions'),
('Sunwest Actuarial Systems','Sunwest Pensions'),
('unknown','Not Specified'),
('unknown - not disclosed','Not Specified')

DECLARE @LoopCounter INT , @MaxId INT, @MP_Name NVARCHAR(100), @PPC_Name NVARCHAR(100), @MP_ID INT, @PPC_ID INT;
SELECT @LoopCounter = MIN(ID),
		@MaxId = MAX(ID) 
FROM @ListOfNewTPAFirm
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
PRINT @LOOPCOUNTER

SET @MP_Name = (SELECT TOP 1 MP_Name FROM @ListOfNewTPAFirm WHERE ID = @LoopCounter);
SET @PPC_Name = (SELECT TOP 1 PPC_Name FROM @ListOfNewTPAFirm WHERE ID = @LoopCounter);
SET @MP_ID = (SELECT TOP 1 Id FROM [dbo].[Portal_NewTPAFirm] WHERE TRIM(TPAFirmText) = TRIM(@MP_Name));
SET @PPC_ID = (SELECT TOP 1 Id FROM [dbo].[Portal_NewTPAFirm] WHERE TRIM(TPAFirmText) =  TRIM(@PPC_Name));

IF(@MP_ID IS NOT NULL AND @PPC_ID IS NOT NULL)
BEGIN
UPDATE [dbo].[Portal_NewTPAFirm_ID_Mapping]
SET New_ID = @PPC_ID
FROM [dbo].[Portal_NewTPAFirm_ID_Mapping]
WHERE New_ID = @MP_ID

DELETE FROM [Portal_NewTPAFirm]
WHERE Id=@MP_ID
END
ELSE
BEGIN
PRINT CONCAT('DATA NOT EXIST TO MAP: ', @MP_Name)
END
SELECT @LoopCounter  = MIN(ID) 
   FROM @ListOfNewTPAFirm  WHERE ID > @LoopCounter
END


DELETE
FROM [Portal_NewTPAFirm]
WHERE TPAFirmText IN ('2012','2121','dfdsf', 'n/a', 'N/A - Plan Term', 'Plan Term','Plan termination', 'sdfsd', 'Test Already','werwer','ytt')
