DROP TABLE IF EXISTS Ride;
DROP TABLE IF EXISTS Route;
CREATE TABLE Route
(
RouteID INT IDENTITY(1,1) PRIMARY KEY,
PickupLocation VARCHAR(50) NOT NULL,
Destination VARCHAR(50) NOT NULL,
Distance INT NOT NULL,
Cost DECIMAL NOT NULL,
Discount DECIMAL NOT NULL,
FinalCost DECIMAL NOT NULL,
ServiceRequest VARCHAR(20) NOT NULL,
Coupon VARCHAR(20) NOT NULL,

MemberRiderID INT,
CONSTRAINT FK_fromRider FOREIGN KEY (MemberRiderID)
    REFERENCES Rider(MemberID)
);

DROP PROCEDURE IF EXISTS routecreation;
GO

CREATE PROCEDURE routecreation @total INT
AS
DECLARE @Counter INT=1
DECLARE @Code INT
DECLARE @n INT
DECLARE @PickupLocation varchar(50)
DECLARE @Destination VARCHAR(50)
DECLARE @Distance int
DECLARE @Cost decimal
DECLARE @Discount decimal
DECLARE @FinalCost decimal
DECLARE @MemberRiderID int
DECLARE @ServiceRequest varchar(20)
DECLARE @Coupon VARCHAR(20)

WHILE @Counter< @total
BEGIN
SET @Code =(SELECT floor(RAND()*4 +1))

SET @ServiceRequest = (SELECT CHOOSE(@Code,'Economy','Premium','Accessibility','Carpool'))

SET @Coupon=(SELECT CASE @Code
WHEN 1 THEN 'None'
WHEN 2 THEN CONCAT('A',@Counter,'K',@Counter)
WHEN 3 THEN CONCAT('B',@Counter,'K',@Counter)
WHEN 4 THEN CONCAT('C',@Counter,'K',@Counter)
END)

SET @PickupLocation=(SELECT CASE @Code
WHEN 1 THEN CONCAT(6*@Counter,' Third Ave ','Auckland')
WHEN 2 THEN CONCAT(3*@Counter,' Colway ','Wellington')
WHEN 3 THEN CONCAT(2*@Counter,' Bridge ','Nelson')
WHEN 4 THEN CONCAT(5*@Counter,' Worthy ','Christchurch')
WHEN 5 THEN CONCAT(7*@Counter,' Vardon ','Hamilton')
WHEN 6 THEN CONCAT(9*@Counter,' Kowhai ','Gisborne')
WHEN 7 THEN CONCAT(2*@Counter,' Keith ','Whanganui')
WHEN 8 THEN CONCAT(3*@Counter,' Lemon ','New Plymouth')
WHEN 9 THEN CONCAT(4*@Counter,' Hona ','Rotorua')
WHEN 10 THEN CONCAT(2*@Counter,' Grey ','Palmerston North')
WHEN 11 THEN CONCAT(3*@Counter,' Village Park ','Tauranga')
END)

SET @Destination=(SELECT CASE 
WHEN @PickupLocation like '%Auckland' THEN CONCAT(21*@Counter,' Valley','Auckland')
WHEN @PickupLocation like '%Wellington'  THEN CONCAT(20*@Counter,' Standen ','Wellington')
WHEN @PickupLocation like '%Nelson'  THEN CONCAT(21*@Counter,' Tahunanui ','Nelson')
WHEN @PickupLocation like '%Christchurch' THEN CONCAT(20*@Counter,' Kotare ','Christchurch')
WHEN @PickupLocation like '%Hamilton' THEN CONCAT(23*@Counter,' Richmond ','Hamilton')
WHEN @PickupLocation like '%Gisborne' THEN CONCAT(19*@Counter,' Bell ','Gisborne')
WHEN @PickupLocation like '%Whanganui' THEN CONCAT(25*@Counter,' Harrion ','Whanganui')
WHEN @PickupLocation like '%New Plymouth'  THEN CONCAT(16*@Counter,' Clemow ','New Plymouth')
WHEN @PickupLocation like '%Rotorua'  THEN CONCAT(13*@Counter,' State hwy ','Rotorua')
WHEN @PickupLocation like '%Palmerston North' THEN CONCAT(18*@Counter,' Railway ','Palmerston North')
WHEN @PickupLocation like '%Tauranga' THEN CONCAT(29*@Counter,' Grange ','Tauranga')
END)

SET @Distance=(SELECT CASE 
WHEN @PickupLocation like '%Auckland' THEN @Code* 17
WHEN @PickupLocation like '%Wellington'  THEN @Code* 16
WHEN @PickupLocation like '%Nelson'  THEN @Code* 12
WHEN @PickupLocation like '%Christchurch' THEN @Code* 15
WHEN @PickupLocation like '%Hamilton' THEN @Code* 15
WHEN @PickupLocation like '%Gisborne' THEN @Code* 14
WHEN @PickupLocation like '%Whanganui' THEN @Code* 13
WHEN @PickupLocation like '%New Plymouth'  THEN @Code* 16
WHEN @PickupLocation like '%Rotorua'  THEN @Code* 11
WHEN @PickupLocation like '%Palmerston North' THEN @Code* 17
WHEN @PickupLocation like '%Tauranga' THEN @Code* 12
END)

SET @Cost= @Distance*22

SET @Discount = (SELECT CHOOSE(@Code,0.05* @Cost,0.1* @Cost,0.12* @Cost,0.15* @Cost))

SET @FinalCost= @Cost- @Discount

SET @n= (SELECT COUNT(*) FROM Member)
SET @MemberRiderID = (SELECT floor(RAND()*@n/2 +1))

INSERT INTO Route
        ( PickupLocation,Destination, Distance, Cost,MemberRiderID,ServiceRequest,Coupon,Discount,FinalCost )
VALUES( @PickupLocation,@Destination,@Distance,@Cost,@MemberRiderID,@ServiceRequest,@Coupon,@Discount,@FinalCost)

SET @Counter+=1
END
GO

INSERT INTO Route
        ( PickupLocation,Destination, Distance, Cost,MemberRiderID,ServiceRequest,Coupon,Discount,FinalCost )
Exec routecreation @total= 10001

select * from Route