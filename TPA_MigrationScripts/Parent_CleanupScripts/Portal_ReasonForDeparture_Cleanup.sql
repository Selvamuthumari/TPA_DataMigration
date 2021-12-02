/*Portal_ReasonForDeparture Name Mapping*/
DECLARE @ListOfROD TABLE(ID INT IDENTITY(1,1),MP_Name NVARCHAR(100) , PPC_Name NVARCHAR(100))
 
INSERT INTO @ListOfROD
VALUES 
('Fired by us','PPC Fired Client')  ,
('Left for new TPA','Moved to new TPA') ,
('Terminated Plan','Plan Termination')

DECLARE @LoopCounter INT , @MaxId INT, @MP_Name NVARCHAR(100), @PPC_Name NVARCHAR(100), @MP_ID INT, @PPC_ID INT;
SELECT @LoopCounter = MIN(ID),
		@MaxId = MAX(ID) 
FROM @ListOfROD
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
PRINT @LOOPCOUNTER

SET @MP_Name = (SELECT TOP 1 MP_Name FROM @ListOfROD WHERE ID = @LoopCounter);
SET @PPC_Name = (SELECT TOP 1 PPC_Name FROM @ListOfROD WHERE ID = @LoopCounter);
SET @MP_ID = (SELECT TOP 1 Id FROM [dbo].[Portal_ReasonForDeparture] WHERE TRIM(ReasonForDepartureText) = TRIM(@MP_Name));
SET @PPC_ID = (SELECT TOP 1 Id FROM [dbo].[Portal_ReasonForDeparture] WHERE TRIM(ReasonForDepartureText) =  TRIM(@PPC_Name));

IF(@MP_ID IS NOT NULL AND @PPC_ID IS NOT NULL)
BEGIN
UPDATE [dbo].[Portal_ReasonForDeparture_ID_Mapping]
SET New_ID = @PPC_ID
FROM [dbo].[Portal_ReasonForDeparture_ID_Mapping]
WHERE New_ID = @MP_ID

DELETE FROM [Portal_ReasonForDeparture]
WHERE Id=@MP_ID
END
ELSE
BEGIN
PRINT CONCAT('DATA NOT EXIST TO MAP: ', @MP_Name)
END
SELECT @LoopCounter  = MIN(ID) 
   FROM @ListOfROD  WHERE ID > @LoopCounter
END