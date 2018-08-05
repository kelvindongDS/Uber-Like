USE Uber
GO
DROP TABLE IF EXISTS Ride;
DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS Rider;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Member;
CREATE TABLE Member
(
MemberID INT IDENTITY(1,1) PRIMARY KEY,
FName VARCHAR(50) not null,
LName VARCHAR(50) not null,
Email VARCHAR(30) not null,
Gender VARCHAR(5),
Pass VARCHAR(50)not null,
Phone VARCHAR(20) not null
);


DROP PROCEDURE IF EXISTS membercreation;
GO

CREATE PROCEDURE membercreation @total INT
AS
DECLARE @Counter INT=1
DECLARE @Code INT
DECLARE @Code2 INT
DECLARE @FName varchar(50)

DECLARE @LName VARCHAR(50)
DECLARE @Gender VARCHAR(5)
DECLARE @Email VARCHAR(30)
DECLARE @Pass VARCHAR(50)
DECLARE @Phone VARCHAR(20)

WHILE @Counter< @total
BEGIN
SET @Code =(SELECT floor(RAND()*10 +1))
SET @Code2 =(SELECT floor(RAND()*2 +1))

SET @FName=(SELECT CASE @Code
WHEN 1 THEN CONCAT('John',@Counter)
WHEN 2 THEN CONCAT('Kelvin',@Counter)
WHEN 3 THEN CONCAT('Tom',@Counter)
WHEN 4 THEN CONCAT('Stephan',@Counter)
WHEN 5 THEN CONCAT('Steven',@Counter)
WHEN 6 THEN CONCAT('Bella',@Counter)
WHEN 7 THEN CONCAT('Jackie',@Counter)
WHEN 8 THEN CONCAT('Helen',@Counter)
WHEN 9 THEN CONCAT('Kai',@Counter)
WHEN 10 THEN CONCAT('Tracy',@Counter)
END)

SET @LName=(SELECT CASE @Code
WHEN 1 THEN CONCAT('Dong',@Counter)
WHEN 2 THEN CONCAT('Burn',@Counter)
WHEN 3 THEN CONCAT('Thomson',@Counter)
WHEN 4 THEN CONCAT('Walker',@Counter)
WHEN 5 THEN CONCAT('Williams',@Counter)
WHEN 6 THEN CONCAT('Smith',@Counter)
WHEN 7 THEN CONCAT('Taylor',@Counter)
WHEN 8 THEN CONCAT('Davis',@Counter)
WHEN 9 THEN CONCAT('Clark',@Counter)
WHEN 10 THEN CONCAT('Thomas',@Counter)
END)

SET @Email=(SELECT CASE @Code
WHEN 1 THEN CONCAT('John',@Counter,'@gmail.com')
WHEN 2 THEN CONCAT('Kelvin',@Counter,'@gmail.com')
WHEN 3 THEN CONCAT('Tom',@Counter,'@gmail.com')
WHEN 4 THEN CONCAT('Stephan',@Counter,'@gmail.com')
WHEN 5 THEN CONCAT('Steven',@Counter,'@yahoo.com')
WHEN 6 THEN CONCAT('Bella',@Counter,'@yahoo.com')
WHEN 7 THEN CONCAT('Jackie',@Counter,'@yahoo.com')
WHEN 8 THEN CONCAT('Helen',@Counter,'@nmit.com')
WHEN 9 THEN CONCAT('Kai',@Counter,'@nmit.com')
WHEN 10 THEN CONCAT('Tracy',@Counter,'@nmit.com')
END)

SET @Pass=(SELECT CASE @Code
WHEN 1 THEN CONCAT('123',@Counter)
WHEN 2 THEN CONCAT('abc',@Counter)
WHEN 3 THEN CONCAT('456',@Counter)
WHEN 4 THEN CONCAT('def',@Counter)
WHEN 5 THEN CONCAT('qwe',@Counter)
WHEN 6 THEN CONCAT('asd',@Counter)
WHEN 7 THEN CONCAT('zxc',@Counter)
WHEN 8 THEN CONCAT('qaz',@Counter)
WHEN 9 THEN CONCAT('zxc',@Counter)
WHEN 10 THEN CONCAT('zaq',@Counter)
END)

SET @Phone= convert(numeric(9,0),rand() * 899999999) + 100000000

SET @Gender= (SELECT CHOOSE(@Code2,'Males','Female'))

INSERT INTO Member
        ( FName,LName, Email, Pass,Phone,Gender )
VALUES( @FName,@LName,@Email,@Pass,@Phone,@Gender)

SET @Counter+=1
END
GO

INSERT INTO Member
        ( FName,LName, Email, Pass,Phone,Gender )
Exec membercreation @total= 20001

select * from Member;



