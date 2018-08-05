
DROP TABLE IF EXISTS Ride;
CREATE TABLE Ride
(
RideID INT IDENTITY(1,1) PRIMARY KEY,
StartTime DATETIME NOT NULL,
Endtime DATETIME NOT NULL,
Actual DECIMAL NOT NULL,
Evaluation DECIMAL,
Payment VARCHAR(20) NOT NULL,

MemberDriverID INT,
 CONSTRAINT FK_fromDriver FOREIGN KEY (MemberDriverID)
    REFERENCES Driver(MemberID),

RouteID INT,
CONSTRAINT FK_Route FOREIGN KEY (RouteID)
    REFERENCES Route(RouteID)
);

DROP PROCEDURE IF EXISTS Ridecreation;
GO

CREATE PROCEDURE Ridecreation @total INT ,@Counter INT
AS

DECLARE @Code1 INT
DECLARE @Code2 INT
DECLARE @Code3 INT
DECLARE @n INT

DECLARE @StartTime DATETIME
DECLARE @EndTime DATETIME
DECLARE @Actual decimal
DECLARE @Distance INT
DECLARE @Payment VARCHAR(20)
DECLARE @Evaluation decimal
DECLARE @MemberDriverID INT
DECLARE @RouteID INT
DECLARE @ServiceRequest varchar(20)

DECLARE @start DATETIME = '2016-01-01 08:00:00'
DECLARE @end DATETIME = '2018-04-13 08:00:00'

SET @n= (SELECT COUNT(*) FROM Member)

WHILE @Counter< @total
BEGIN
SET @Code1 =(SELECT floor(RAND()*10 +1))
SET @Code2 =(SELECT floor(RAND()*5 +1))
SET @Code3 =(SELECT floor(RAND()*7 +1))

 
SET @StartTime = DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(SECOND, @start, @end)), @start)

SET @RouteID= @Counter
SET @Distance= (SELECT Distance FROM Route WHERE RouteID= @RouteID)
SET @ServiceRequest= (SELECT ServiceRequest FROM Route WHERE RouteID= @RouteID)

IF @Distance < 20 
		SET @Actual = @Code1 * 3
ELSE 
	BEGIN 
 IF @Distance< 40 
	SET @Actual = @Code1 * 6
 ELSE 
	SET @Actual = @Code1 * 9
	END

SET @EndTime = DATEADD(MINUTE, @Actual, @StartTime)

SET @Evaluation= @Code2

SET @Payment= (SELECT CHOOSE(@Code3,'Cash','ANZ','BNZ','ASB','City Bank','Kiwi Bank','Other'))


SET @MemberDriverID = (SELECT floor(RAND()*@n +1))
While @MemberDriverID not in (SELECT MemberID from Driver WHERE Type= @ServiceRequest)
BEGIN 
SET @MemberDriverID = (SELECT floor(RAND()*@n +1))
END

INSERT INTO Ride
        ( StartTime,Endtime,Actual,Evaluation,Payment,MemberDriverID,RouteID)
VALUES( @StartTime,@EndTime,@Actual,@Evaluation,@Payment,@MemberDriverID,@RouteID)

SET @Counter+=1
END
GO 

INSERT INTO Ride
        ( StartTime,Endtime,Actual,Evaluation,Payment,MemberDriverID,RouteID)
Exec Ridecreation @total= 9501, @Counter= 9001

select * from Ride ri


