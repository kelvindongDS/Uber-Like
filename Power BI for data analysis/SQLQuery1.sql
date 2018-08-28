drop table Jointable;
Select m.MemberID,
	   m.Gender,
	   ro.ServiceRequest,
	   ro.FinalCost,
	   rid.StartTime,
	   rid.Payment,
	   rid.Actual,
	   d.City into Jointable from
	Member m 
	INNER JOIN Rider ri on ri.MemberID= m.MemberID
	INNER JOIN Route ro on ro.MemberRiderID= ri.MemberID
	INNER JOIN Ride rid on rid.RouteID= ro.RouteID
	INNER JOIN Driver d on d.MemberID= rid.MemberDriverID
	

	select * from Jointable