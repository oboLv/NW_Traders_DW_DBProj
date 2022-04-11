Create Procedure PopulateDimDate
(@StartDate date, @EndDate date)
As
Begin
Declare @dt date = @startDate
While (@dt <= @EndDate)
Begin
Insert into DimDate
Select Cast(Convert(varchar(8), @dt, 112) as int) as DateKey,
@dt as [Date],
DatePart(day, @dt) as DayOfMonth,
DatePart(Month, @dt) as MonthNumber,
DateName(Month, @dt) as MonthName,
Year(@dt) as [Year],
DateName(WEEKDAY, @dt) as DayOfWeek,
DatePart(WEEKDAY, @dt) as DayNumberOfWeek
Select @dt = dateAdd(day,1, @dt)
End
End
Exec PopulateDimDate '1/1/2018','12/31/2022'
Exec PopulateDimDate '1/1/1900','1/1/1900'
-- manually insert 12/31/1999 as it will throw an error trying to add a day to thisdate and keep looping
Declare @dtt date = '12/31/9999'
Insert into DimDate
Select Cast(Convert(varchar(8), @dt, 112) as int) as DateKey,
@dt as [Date],
DatePart(day, @dt) as DayOfMonth,
DatePart(Month, @dt) as MonthNumber,
DateName(Month, @dt) as MonthName,
Year(@dt) as [Year],
DateName(WEEKDAY, @dt) as DayOfWeek,
DatePart(WEEKDAY, @dt) as DayNumberOfWeek
