
SELECT * FROM [Portal_TpaRoleSubsectionItems]
WHERE ITEMNAME IN ('Generate CnA Packet', 'Email CnA Packet')

--Generate CnA Packet

UPDATE [Portal_TpaRoleSubsectionItems]
SET ITEMNAME='Generate Info Gathering Packet'
FROM [Portal_TpaRoleSubsectionItems]
WHERE ITEMNAME='Generate CnA Packet'

--Email CnA Packet

UPDATE [Portal_TpaRoleSubsectionItems]
SET ITEMNAME='Email Info Gathering Packet'
FROM [Portal_TpaRoleSubsectionItems]
WHERE ITEMNAME='Email CnA Packet'

SELECT * FROM [Portal_TpaRoleSubsectionItems]
WHERE ITEMNAME IN ('Generate Info Gathering Packet', 'Email Info Gathering Packet')