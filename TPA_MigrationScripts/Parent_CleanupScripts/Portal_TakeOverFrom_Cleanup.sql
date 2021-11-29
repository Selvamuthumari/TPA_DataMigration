/*Portal_TakeOverFrom Name Mapping*/

DECLARE @ListOfTakeOverFrom TABLE(ID INT IDENTITY(1,1),MP_Name NVARCHAR(100) , PPC_Name NVARCHAR(100))
 
INSERT INTO @ListOfTakeOverFrom
VALUES 
('Mattews Gold & Kennnedy','MGKS')  ,
('Matthews Gold Kennedy & Snow','MGKS') ,
('MKGS','MGKS'),
('Paycheck','Paychex')

DECLARE @LoopCounter INT , @MaxId INT, @MP_Name NVARCHAR(100), @PPC_Name NVARCHAR(100), @MP_ID INT, @PPC_ID INT;
SELECT @LoopCounter = MIN(ID),
		@MaxId = MAX(ID) 
FROM @ListOfTakeOverFrom
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
PRINT @LOOPCOUNTER

SET @MP_Name = (SELECT TOP 1 MP_Name FROM @ListOfTakeOverFrom WHERE ID = @LoopCounter);
SET @PPC_Name = (SELECT TOP 1 PPC_Name FROM @ListOfTakeOverFrom WHERE ID = @LoopCounter);
SET @MP_ID = (SELECT TOP 1 Id FROM [dbo].[Portal_TakeOverFrom] WHERE TRIM(TakeOverFromText) = TRIM(@MP_Name));
SET @PPC_ID = (SELECT TOP 1 Id FROM [dbo].[Portal_TakeOverFrom] WHERE TRIM(TakeOverFromText) =  TRIM(@PPC_Name));

IF(@MP_ID IS NOT NULL AND @PPC_ID IS NOT NULL)
BEGIN
UPDATE [dbo].[Portal_TakeOverFrom_ID_Mapping]
SET New_ID = @PPC_ID
FROM [dbo].[Portal_TakeOverFrom_ID_Mapping]
WHERE New_ID = @MP_ID

DELETE FROM [Portal_TakeOverFrom]
WHERE Id=@MP_ID
END
ELSE
BEGIN
PRINT CONCAT('DATA NOT EXIST TO MAP: ', @MP_Name)
END
SELECT @LoopCounter  = MIN(ID) 
   FROM @ListOfTakeOverFrom  WHERE ID > @LoopCounter
END


DELETE
FROM [Portal_TakeOverFrom]
WHERE TakeOverFromText IN ('32432','5555')
