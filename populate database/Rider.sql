DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS Rider;
CREATE TABLE Rider
( 
 MemberID int Primary Key,
 CONSTRAINT FK_Rider FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID),

);
GO

DROP PROCEDURE IF EXISTS ridercreation;
GO

CREATE PROCEDURE ridercreation @total INT
AS
DECLARE @Counter INT=1
DECLARE @Code INT
DECLARE @MemberID INT

WHILE @Counter< @total/2
BEGIN
SET @Code =(SELECT floor(RAND()*4 +1))
SET @MemberID = @Counter

INSERT INTO Rider
        ( MemberID)
VALUES( @MemberID)

SET @Counter+=1
END

GO

INSERT INTO Rider
        (MemberID)
Exec ridercreation @total= 20001

select * from Rider