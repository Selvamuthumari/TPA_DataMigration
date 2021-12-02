/*Portal_DocMaintainedBy Name Mapping*/

DECLARE @ListOfDocMaintainedBy TABLE(ID INT IDENTITY(1,1),MP_Name NVARCHAR(100) , PPC_Name NVARCHAR(100))
 
INSERT INTO @ListOfDocMaintainedBy
VALUES 
('Charles Schwab & Co. Inc.','Charles Schwab')

DECLARE @LoopCounter INT , @MaxId INT, @MP_Name NVARCHAR(100), @PPC_Name NVARCHAR(100), @MP_ID INT, @PPC_ID INT;
SELECT @LoopCounter = MIN(ID),
		@MaxId = MAX(ID) 
FROM @ListOfDocMaintainedBy
WHILE ( @LoopCounter IS NOT NULL
        AND  @LoopCounter <= @MaxId)
BEGIN
PRINT @LOOPCOUNTER

SET @MP_Name = (SELECT TOP 1 MP_Name FROM @ListOfDocMaintainedBy WHERE ID = @LoopCounter);
SET @PPC_Name = (SELECT TOP 1 PPC_Name FROM @ListOfDocMaintainedBy WHERE ID = @LoopCounter);
SET @MP_ID = (SELECT TOP 1 DocMaintainedById FROM [dbo].[Portal_DocMaintainedBy] WHERE TRIM(DocMaintainedByName) = TRIM(@MP_Name));
SET @PPC_ID = (SELECT TOP 1 DocMaintainedById FROM [dbo].[Portal_DocMaintainedBy] WHERE TRIM(DocMaintainedByName) =  TRIM(@PPC_Name));

IF(@MP_ID IS NOT NULL AND @PPC_ID IS NOT NULL)
BEGIN
UPDATE [dbo].[Portal_DocMaintainedBy_ID_Mapping]
SET New_ID = @PPC_ID
FROM [dbo].[Portal_DocMaintainedBy_ID_Mapping]
WHERE New_ID = @MP_ID

DELETE FROM [Portal_DocMaintainedBy]
WHERE DocMaintainedById=@MP_ID
END
ELSE
BEGIN
PRINT CONCAT('DATA NOT EXIST TO MAP: ', @MP_Name)
END
SELECT @LoopCounter  = MIN(ID) 
   FROM @ListOfDocMaintainedBy  WHERE ID > @LoopCounter
END


DELETE
FROM [Portal_DocMaintainedBy]
WHERE DocMaintainedByName IN ('CDNU - Client Does Not Use an Advisor','test', 'Test document value 23')
