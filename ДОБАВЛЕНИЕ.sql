USE Ligue;
INSERT INTO Coaches VALUES(1,'����','�������','��������','')
INSERT INTO Coaches VALUES(2,'���������','������','����������','')
INSERT INTO Coaches VALUES(3,'���������','������','�����������','')
INSERT INTO Coaches VALUES(4,'����','�������','����������','')
INSERT INTO Coaches VALUES(5,'���������','�������','�������������','')
INSERT INTO Coaches VALUES(6,'�����','������','���������','')
INSERT INTO Coaches VALUES(7,'����','�������','����������','')
INSERT INTO Coaches VALUES(8,'���������','�����','������������','')
INSERT INTO Coaches VALUES(9,'��������','�����','���������','')
INSERT INTO Coaches VALUES(10,'������','���������','�������������','')

INSERT INTO Sponsors VALUES(1, 'MTS','������� ��������� ���������','79108299521')
INSERT INTO Sponsors VALUES(2, 'Sber','����������� ������ ���������','79107299521')
INSERT INTO Sponsors VALUES(3, 'BeeLine','��������� ���������','79108299999')
INSERT INTO Sponsors VALUES(4, 'Kaspersky','���������� �����������','73208299521')
INSERT INTO Sponsors VALUES(5, 'Amur','������� ������ ������������','79628299521')


INSERT INTO GROUPS VALUES(1,'�������� ������')
INSERT INTO GROUPS VALUES(2,'�������� �����')

INSERT INTO Qualification VALUES(5000,'����� ������ ���������')
INSERT INTO Qualification VALUES(3000,'����� ������� ������������')
INSERT INTO Qualification VALUES(1000,'�����-������')

INSERT INTO InjuriesType VALUES (234, '������ ����')

INSERT INTO InjuriesType VALUES (2543, '�������')

INSERT INTO InjuriesType VALUES (231, '��������')

INSERT INTO InjuriesType VALUES (57, '�������� ��������')

INSERT INTO InjuriesType VALUES (875, '�����')




INSERT INTO Teams VALUES(1,'�����',30,1,1,4,NULL)
INSERT INTO Teams VALUES(2,'����',29,1,10,2,NULL)
INSERT INTO Teams VALUES(10,'���',30,1,2,3,NULL)
INSERT INTO Teams VALUES(3,'�����',30,1,3,5,NULL)
INSERT INTO Teams VALUES(4,'�����',30,1,4,1,NULL)
INSERT INTO Teams VALUES(5,'����',30,2,5,4,NULL)
INSERT INTO Teams VALUES(6,'���',30,2,6,1,NULL)
INSERT INTO Teams VALUES(7,'���',30,2,7,3,NULL)
INSERT INTO Teams VALUES(8,'���',30,2,8,3,NULL)
INSERT INTO Teams VALUES(9,'���',30,2,9,4,NULL)









INSERT INTO Arena VALUES (3000, 'AkBArs','TOPOLEVO 54' , 160)
INSERT INTO Arena VALUES (4500, 'MISIS Stad','TROPAREVO 22' ,230)
INSERT INTO Arena VALUES (3400, 'MGIMO Stad','Prospekt Vernadskogo 84' ,555)
INSERT INTO Arena VALUES (1000, 'Reutov Stad','Reutovo 84' ,300)



INSERT INTO Judges VALUES(1,10,NULL, '������� ���� ����������')
INSERT INTO Judges VALUES(3,7,NULL, '������ ���� ��������')
INSERT INTO Judges VALUES(2,20,NULL, '�������� ������� ����������')



INSERT INTO Players VALUES(1,1,'������','������','��������',19,72,GETDATE(),21,NuLL)
INSERT INTO Players VALUES(2,1,'��������','����','���������',19,91,GETDATE(),2,NuLL)
INSERT INTO Players VALUES(3,2,'�����','������ ','���������',20,99,GETDATE(),45,NuLL)
INSERT INTO Players VALUES(4,2,'���������','�������','�������������',25,77,GETDATE(),67,NuLL)
INSERT INTO Players VALUES(5,3,'����','��������','����������',23,66,GETDATE(),78,NuLL)
INSERT INTO Players VALUES(6,3,'�����','�������','�������',21,76,GETDATE(),89,NuLL)
INSERT INTO Players VALUES(7,4,'�������� ','�������','��������',18,98,GETDATE(),88,NuLL)
INSERT INTO Players VALUES(8,5,'������','��������','������������',18,66,GETDATE(),99,NuLL)
INSERT INTO Players VALUES(9,5,'���� ','�������','�������������',22,65,GETDATE(),25,NuLL)
INSERT INTO Players VALUES(10,NULL,'��������','�����','�������',22,77,GETDATE(),36,NuLL)
INSERT INTO Players VALUES(11,NULL,'������ ','�������','���������',19,86,GETDATE(),22,NuLL)
INSERT INTO Players VALUES(12,NULL,'�������','�������','���������',23,78,GETDATE(),41,NuLL)



INSERT INTO Matches VALUES(5, 3400,10,2,3,'1:0',1,GETDATE())
INSERT INTO Matches VALUES(6, 1000,1,7,1,'3:0',1,GETDATE())





 INSERT INTO SponsoringInfo values(4,1,100000)
 INSERT INTO SponsoringInfo values(3,10,10000)
 INSERT INTO SponsoringInfo values(3,7,100000)










 
 -- ���������, ������������ ��������� ����� ��������� ������� ��� ������� ��������
GO
CREATE PROCEDURE TeamsPlayersStatus 

AS
BEGIN
DECLARE @CounterTeams int = 0
DECLARE @CounterPlayers int =0 
DECLARE @helper nvarchar(3000)
DECLARE c1 cursor LOCAL FAST_FORWARD
FOR 
SELECT TeamName
FROM Teams
WHERE NumberOfPlayers<30
OPEN c1
WHILE(1=1)
BEGIN 
if @@FETCH_STATUS<>0 break
fetch c1 into @helper
SET @CounterTeams = @CounterTeams + @@ROWCOUNT
end
CLOSE c1
DEALLOCATE c1
DECLARE c2 cursor LOCAL FAST_FORWARD
FOR 
SELECT LastName 
FROM Players
WHERE TeamID IS NULL
OPEN c2
WHILE(1=1)
BEGIN
if @@FETCH_STATUS<>0 BREAK 
fetch c1 into @helper
SET @CounterPlayers = @CounterPlayers + @@ROWCOUNT
END
CLOSE c2
DEALLOCATE c2
SELECT TeamName FROM Teams WHERE NumberOfPlayers <30
SELECT LastName + ' '+ Firstname + ' '+MiddleName AS Name, Age, Weight, License
FROM Players WHERE TeamID IS Null
PRINT '���������� ��������� ������� �� ����������� ����� - ' + CAST(@CounterPlayers AS nvarchar(3))
PRINT '���������� ������, ����������� � �������� - ' + CAST(@CounterTeams AS nvarchar(3))
IF(@CounterPlayers>=@CounterTeams)
PRINT '����� ���������� ���������� ��������'
ELSE 
PRINT'����� ���������� ���������� � ��������� �������'

END;
exec TeamsPlayersStatus



--���������, ������������ ��� ���������� ����� � ������
GO
CREATE PROCEDURE OSTMATCHES AS
BEGIN

--CREATE TABLE #table (
--MatchID int,ArenaID int, Team1 nvarchar(30),Team2 int, Judge nvarchar(120)
--)

SELECT M.MatchID, M.ArenaID, T.TeamName AS Team1 , M.Team2ID, J.FullName AS Judge
INTO #table
FROM Matches AS M
JOIN Teams AS T ON M.Team1ID = T.TeamID 
JOIN Judges AS J
ON M.JudgeID = J.JudgeID
WHERE M.Time IS NULL

--CREATE TABLE #TimeTable (
--Time_ nvarchar(40),ArenaName nvarchar(50), Team1 nvarchar(30),Team2 nvarchar(50), Judge nvarchar(120)
--)

SELECT Time_ = '�� ����������' , ArenaName, Team1, T.TeamName AS Team2, Judge
INTO #TimeTable
FROM #table as Ta
join Arena AS A
ON Ta.ArenaID =A.ArenaID
JOIN Matches AS M on Ta.MatchID = M.MatchID
JOIN Teams AS T 
on Ta.Team2ID = T.TeamID 

SELECT * FROM #TimeTable
END

EXEC OSTMATCHES 







--��� ����� �������
GO
CREATE PROCEDURE ExactMatches
@ID int
AS
BEGIN
SELECT M.Time AS Date, T.TeamName AS Opponent, M.Result AS SCORE, IIF(M.TeamWinner = 1, 'Win','Lose') AS Result
FROM Matches AS M
JOIN Teams AS T
ON M.Team2ID = T.TeamID
WHERE M.Team1ID = @ID

SELECT M.Time AS Date, T.TeamName AS Opponent, M.Result AS SCORE, IIF(M.TeamWinner = 1, 'Win','Lose') AS Result
FROM Matches AS M
JOIN Teams AS T
ON M.Team1ID = T.TeamID
WHERE M.Team2ID = @ID
END

EXEC ExactMatches 1

GO
--����������� ���� ��������� ������� �� �����

ALTER VIEW FreeAgents
AS
SELECT LastName +' ' + FirstName+' ' + MiddleName AS Name, Age, Weight, License
FROM Players
WHERE TeamID IS NULL
GO
SELECT * FROM FreeAgents





GO
CREATE FUNCTION DoRank(@ID int)
RETURNS int
BEGIN 
	DECLARE @points int = 0
	set @points = @points + (select Count(*) 
		from Matches
		where Team1ID = @ID
		and TeamWinner = 1) * 3
		+ (select Count(*) 
		from Matches
		where Team2ID = @ID
		and TeamWinner = 2) * 3;
RETURN @points
END
select * from Matches
declare @id int = 1
print dbo.DoRank(@id)




GO

CREATE FUNCTION JudSum(@JID int)
RETURNS int
BEGIN
DECLARE @Summ int = 0
	set @Summ = (select j.NumberOfMatches * q.Salary 
	from Judges as j
	Join Qualification as q
	ON q.QualificationID = j.QualificationID
	where JudgeID = @JID)
RETURN @Summ
END

declare @id int = 1
print dbo.JudSum(@id)



GO
CREATE FUNCTION CountOFPlayers(@TeamID int)
RETURNS int
begin
	declare @count int = 0
	set @count = (select count(*) 
	from Players
	where TeamID = @TeamID
	and InjuryID is null AND License IS NOT NULL)
return @count
end
declare @id int = 1
print dbo.CountOFPlayers(@id)



SELECT * FROM Teams

GO
ALTER VIEW TOPTeams
AS 
SELECT TOP 10 TeamName FROM 
Teams
ORDER BY TeamRank DESC
--GO
--CREATE TRIGGER SafetyDB
--ON DATABASE
--FOR DROP_TABLE, ALTER_TABLE
--AS 
--BEGIN
--PRINT '� ��� ��� ���������� ��������, ������� �������!'
--ROLLBACK;
--END;
--GO

SELECT * FROM TOPTeams


GO
CREATE TRIGGER PlayerDeleter
ON Players 
INSTEAD OF DELETE
AS 
UPDATE Players 
SET License = NUll
WHERE PlayerID = (SELECT PlayerID from deleted)





GO
CREATE TRIGGER AddMatch
ON Matches 
FOR INSERT
AS 
begin
DECLARE @MATCHID INT
DECLARE @ARENAID INT
DECLARE @TEAM1ID INT
DECLARE @TEAM2ID INT
DECLARE @JUDGEID INT
DECLARE @RESULT NVARCHAR(10)
DECLARE @TEAMWINNER INT
DECLARE @TIME DATETIME
IF(@TEAM1ID = @TEAM2ID)  OR EXists(SELECT * FROM Matches where Team1ID = @TEAM1ID aNd Team2ID = @TEAM2ID )
PRINT '�� ����� ������ ���������� �������/����� ���� ��� ����'
rollback
END

INSERT INTO Matches VALUES(9,3000,1,1,2,NULL,NULL,NULL)


GO
CREATE TRIGGER PlayerADD
on Players
FOR INSERT
AS
BEGIN
DECLARE @PlayerID int
DECLARE @TEAMID INT
DECLARE @FIRSTNAME NVARCHAR(30)
DECLARE @LASTNAME NVARCHAR(30)
DECLARE @mIDDLENAME NVARCHAR(30)
DECLARE @AGE INT
DECLARE @WEIGHT INT
DECLARE @LICENSE DATETIME
DECLARE @NUMBER INT
DECLARE @INJURYID INT
BEGIN
IF(dbo.CountOFPlayers(@TEAMID)>=30)
print '������� ��������������'
ROLlBACK
end
END 




GO
CREATE PROCEDURE InJud

@Qualific int,
@Number int,
@FullName nvarchar(120)
AS 
BEGIN 
Insert INTO Judges
VALUES (@Qualific,@Number,NULL,@FullName)
UPDATE Judges
SET Summ = dbo.JudSum(SCOPE_IDENTITY())
WHERE JudgeID = SCOPE_IDENTITY()
END



EXEC InJud 2, 1, '��������� �������� ����������'
SELECT QualificationID, NumberOfMatches, Summ, FullName FROM Judges

GO
CREATE PROCEDURE InTeam

@TeamID int,
@TeamName nvarchar(30),
@Group int,
@Coach int,
@Sponsor int

AS 
BEGIN 
Insert INTO Teams
VALUES (@TeamID,@TeamName,NULL,@Group,@Coach,@Sponsor,Null)
UPDATE Teams
SET NumberOfPlayers = dbo.CountOFPlayers(SCOPE_IDENTITY())
WHERE TeamID = SCOPE_IDENTITY()
UPDATE Teams
SET TeamRank = dbo.DoRank(SCOPE_IDENTITY())
WHERE TeamID = SCOPE_IDENTITY()
END




Go
CREATE TRIGGER Inserterteam
ON Teams

AFTER INSERT
AS
UPDATE Teams
SET NumberOfPlayers = dbo.CountOFPlayers(SCOPE_IDENTITY())
WHERE TeamID = SCOPE_IDENTITY()
UPDATE Teams
SET TeamRank = dbo.DoRank(SCOPE_IDENTITY())
WHERE TeamID = SCOPE_IDENTITY()


SELECT * FROM FreeAgents



SELECT * FROM TOPTeams
INSERT INTO Players VALUES(14,2,'f','a','ty',22,67,GETDATE(),33,NULL)