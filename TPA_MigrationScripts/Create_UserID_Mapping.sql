IF OBJECT_ID('dbo.UserID_Mapping') IS NULL
 BEGIN
CREATE TABLE [dbo].[UserID_Mapping] (ID INT IDENTITY(1,1), 
	[PPC_SysUserID] [int] NOT NULL,
	[MyPlans_SysUserID] [int] NOT NULL,
	[Value] [int] NOT NULL,
	[Action] [nvarchar](100) NOT NULL
)
END


SET IDENTITY_INSERT dbo.[UserID_Mapping] ON; 
INSERT INTO dbo.UserID_Mapping (ID, PPC_SysUserID, MyPlans_SysUserID, Value, Action) VALUES 
(1, -1, -1, -1, 'Map to PPC'), 
(2, 156, 5,1, 'Map to PPC'), 
(3, 153, 19, 1,'Map to PPC'), 
(4, 141, 28,1, 'Map to PPC'), 
(5, 154, 33,1, 'Map to PPC'),  
(6, 158, 35,1,'Map to PPC'),  
(7, 155, 45, 1, 'Map to PPC'), 
(8, 157, 48, 1, 'Map to PPC'), 
(9, 149, 52,1, 'Map to PPC'), 
(10, 0, 54,3, 'No Mapping to PPC'), 
(11, 143, 56,1, 'Map to PPC'),  
(12, 142, 57,1, 'Map to PPC'),
(13, 0, 60,3, 'No Mapping to PPC'), 
(14, 145, 61,1, 'Map to PPC'), 
(15, 148, 66,3, 'Map to PPC'), 
(16, 0, 68,2, 'Need to decide how to map to PPC Distribution Lists'), 
(17, 0, 69,2,'Need to decide how to map to PPC Distribution Lists'), 
(18, 0, 70,2,'Need to decide how to map to PPC Distribution Lists'),
(19, 0, 71,2,'Need to decide how to map to PPC Distribution Lists'), 
(20, 0, 73,2,'Need to decide how to map to PPC Distribution Lists'), 
(21, 0, 79,2,'Need to decide how to map to PPC Distribution Lists'),
(22, 144,80,1, 'Map to PPC'), 
(23, 150, 88,1, 'Map to PPC'),  
(24, 147, 105,1, 'Map to PPC'),
(25, 146,106,1, 'Map to PPC'), 
(26, 152, 108,1, 'Map to PPC'),  
(27, 6, 110,1, 'Map to PPC'),
(28, 91,111,1, 'Map to PPC'), 
(29, 37, 112,1, 'Map to PPC'),  
(30, 51, 113,1, 'Map to PPC'),
(31, 28,114,1, 'Map to PPC'), 
(32, 30, 115,1, 'Map to PPC'),  
(33, 36, 116,1, 'Map to PPC'),
(34, 35,117,1, 'Map to PPC'), 
(35, 46, 118,1, 'Map to PPC'),  
(36, 53, 119,1, 'Map to PPC'),
(37, 64,120,1, 'Mapto PPC'), 
(38, 95, 121,1, 'Map to PPC'),  
(39, 94, 122,1, 'Map to PPC'),
(40, 8,123,1, 'Map to PPC'), 
(41, 122,125,1, 'Map to PPC'), 
(42,95,126,1, 'Map to PPC'), 
(43, 160, 127,1, 'Map to PPC')
SET IDENTITY_INSERT dbo.[UserID_Mapping] OFF; 



--select * from UserID_Mapping