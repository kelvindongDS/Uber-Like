
DROP TABLE IF EXISTS Driver;

CREATE TABLE Driver
( 
 MemberID int Primary Key,
 CONSTRAINT FK_Driver FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID),
City varchar(20) NOT NULL,
InviteCode varchar(20) NOT NULL,
CarModel varchar(20) NOT NULL,
Type varchar(20)NOT NULL,
Licience varchar(20) NOT NULL,
Availability  varchar(5)NOT NULL,
Location varchar(20) NOT NULL
);
GO

DROP PROCEDURE IF EXISTS Drivercreation;
GO

CREATE PROCEDURE Drivercreation @total INT
AS
DECLARE @Counter INT=@total/2+1
DECLARE @Code1 INT
DECLARE @Code2 INT
DECLARE @Code3 INT
DECLARE @City varchar(20)
DECLARE @InviteCode VARCHAR(20)
DECLARE @Carmodel VARCHAR(20)
DECLARE @Type VARCHAR(20)
DECLARE @Licience VARCHAR(20)
DECLARE @Availability VARCHAR(20)
DECLARE @Location VARCHAR(20)
DECLARE @MemberID INT

WHILE @Counter< @total
BEGIN
SET @Code1 = (SELECT floor(RAND()*4 +1))
SET @Code2 = (SELECT floor(RAND()*11 +1))
SET @Code3 = (SELECT floor(RAND()*2 +1))
SET @Type=(SELECT CHOOSE(@Code1,'Economy','Premium','Accessibility','Carpool'))

SET @City=(SELECT CHOOSE(@Code2,'Auckland','Wellington','Nelson','Christchurch','Hamilton','Gisborne','Whanganui','New Plymouth','Rotorua','Palmerston North','Tauranga'))

SET @InviteCode=(SELECT CASE @Code1
WHEN 1 THEN 'None'
WHEN 2 THEN CONCAT('I',@Counter,'K',@Counter)
WHEN 3 THEN CONCAT('I',@Counter,'A',@Counter)
WHEN 4 THEN CONCAT('I',@Counter,'C',@Counter)
END)

SET @Carmodel=(SELECT CHOOSE(@Code2,'Mazda','Nissan','Misubishi','Toyota','BMW','Honda','Suzuki','Subaru','Lexus','Ford','Audi'))
SET @MemberID = @Counter

SET @Location=(SELECT CASE @City
WHEN 'Auckland' THEN CONCAT(@Counter/90,' Third Ave')
WHEN 'Wellington' THEN CONCAT(@Counter/110,' Colway')
WHEN 'Nelson' THEN CONCAT(@Counter/1230,' Bridge')
WHEN 'Christchurch' THEN CONCAT(@Counter/937,' Worthy')
WHEN 'Hamilton' THEN CONCAT(@Counter/170,' Vardon')
WHEN 'Gisborne' THEN CONCAT(@Counter/1300,' Kowhai')
WHEN 'Whanganui' THEN CONCAT(@Counter/240,' Keith')
WHEN 'New Plymouth' THEN CONCAT(@Counter/1500,' Lemon')
WHEN 'Rotorua' THEN CONCAT(@Counter/1100,' Hona')
WHEN 'Palmerston North' THEN CONCAT(@Counter/190,' Grey')
WHEN 'Tauranga' THEN CONCAT(@Counter/170,' Village Park')
END)

SET @Availability=(SELECT CHOOSE(@Code3,'Yes','No'))

SET @Licience=(SELECT CASE @Code1
WHEN 1 THEN CONCAT('I',@Counter,'K',@Counter,'Q',@Counter,'K',@Counter,'W',@Counter,'E',@Counter)
WHEN 2 THEN CONCAT('S',@Counter,'Q',@Counter,'D',@Counter,'G',@Counter,'Z',@Counter,'M',@Counter)
WHEN 3 THEN CONCAT('F',@Counter,'I',@Counter,'P',@Counter,'K',@Counter,'M',@Counter,'N',@Counter)
WHEN 4 THEN CONCAT('X',@Counter,'F',@Counter,'A',@Counter,'K',@Counter,'B',@Counter,'L',@Counter)
END)

INSERT INTO Driver
        ( MemberID,City,InviteCode,CarModel,Type,Licience,Availability,Location)
VALUES( @MemberID,@City,@InviteCode,@Carmodel,@Type,@Licience,@Availability,@Location)

SET @Counter+=1
END
GO

INSERT INTO Driver
        ( MemberID,City,InviteCode,CarModel,Type,Licience,Availability,Location)
Exec Drivercreation @total= 20001

select * from Driver