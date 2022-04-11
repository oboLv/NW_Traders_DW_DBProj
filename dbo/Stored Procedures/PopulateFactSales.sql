/***************************************
* PopulateFactSales
* Author: NKowalchuk
* CreateDate: 3/7/2022
*
* This procedure populates FactSales table. It handles the Type 2 SCD for the 
CustomerHistory dimension
*
* Change Log:
*
****************************************/
Create procedure PopulateFactSales
as
Begin
-- insert new rows
Insert into FactSales
Select Concat(o.OrderID,d.ProductID) as OrderID, -- concatenate these so thatwe have something unique to join on when searching for the row later
o.OrderDate,
o.RequiredDate,
o.ShippedDate,
DateDiff(Day, o.OrderDate, o.ShippedDate) as DaysToShip,
Iif(DateDiff(Day, o.RequiredDate, o.ShippedDate)> 0, DateDiff(Day, 
o.RequiredDate, o.ShippedDate), 0) as DaysOverdue,
d.UnitPrice,
d.Quantity,
d.UnitPrice * d.Quantity * (1 - d.discount) as LineTotal,
0 as Freight, -- TODO: Divide up the order's freight cost for each line of the order
isnull(dp.ProductKey, 0) as ProductKey,
isnull(dc.CustomerKey, 0) as CustomerKey,
isnull(dsp.SalesPersonKey, 0) as SalesPersonKey,
isnull(dcat.CategoryKey, 0) as CategoryKey,
isnull(ds.SupplierID, 0) as SupplierKey,
isnull(dship.ShipperKey, 0) as ShipperKey,
Cast(Convert(varchar(8), o.OrderDate, 112) as int) OrderDateKey,
Cast(Convert(varchar(8), o.RequiredDate, 112) as int) RequiredDateKey,
Isnull(Cast(Convert(varchar(8), o.ShippedDate, 112) as int), 99991231) 
ShippedDateKey, -- use the default end date for null ship dates
isnull(dch.CustomerHistoryKey, 0) as CustomerHistoryKey
From NW_Traders_ODS.dbo.Orders o
Join NW_Traders_ODS.dbo.OrderDetails d
on o.OrderID = d.OrderID
Join NW_Traders_ODS.dbo.Products p 
on d.productID = p.ProductID
--all dimension joins are left joins (except for dim date)
-- we will use the default SKs if we don't find the actual row
left Join DimProduct dp
on p.ProductID = dp.ProductID
left join DimCustomer dc 
on o.CustomerID = dc.CustomerID
left join DimSalesPerson dsp
on o.EmployeeID = dsp.EmployeeID
left join DimCategory dcat
on p.CategoryID = dcat.CategoryID
left join DimSupplier ds 
on p.SupplierID = ds.SupplierID
left join DimShipper dship 
on o.ShipVia = dship.ShipperID
left join DimCustomerHistory dch
on o.CustomerID = dch.CustomerID
and o.OrderDate between dch.StartDate and dch.EndDate 
Left Join FactSales fs -- see if the row exists already
on Concat(o.OrderID,d.ProductID) = fs.OrderID
where fs.SalesKey is null
-- update the existing changed rows
Update FactSales set
OrderID = Concat(o.OrderID,d.ProductID),
OrderDate = o.OrderDate,
RequiredDate = o.RequiredDate,
ShippedDate = o.ShippedDate,
DaysToShip = DateDiff(Day, o.OrderDate, o.ShippedDate),
DaysOverdue = Iif(DateDiff(Day, o.RequiredDate, o.ShippedDate)> 0, 
DateDiff(Day, o.RequiredDate, o.ShippedDate), 0),
UnitPrice = d.UnitPrice,
Quantity = d.Quantity,
LineTotal = d.UnitPrice * d.Quantity * (1 - d.discount),
Freight = 0, -- TODO: Divide up the order's freight cost for each line of theorder
ProductKey = isnull(dp.ProductKey, 0),
CustomerKey = isnull(dc.CustomerKey, 0),
SalesPersonKey = isnull(dsp.SalesPersonKey, 0),
CategoryKey = isnull(dcat.CategoryKey, 0),
SupplierKey = isnull(ds.SupplierID, 0),
ShipperKey = isnull(dship.ShipperKey, 0),
OrderDateKey = Cast(Convert(varchar(8), o.OrderDate, 112) as int),
RequiredDateKey = Cast(Convert(varchar(8), o.RequiredDate, 112) as int),
ShippedDateKey = Isnull(Cast(Convert(varchar(8), o.ShippedDate, 112) as int),
99991231) ,
CustomerHistoryKey = isnull(dch.CustomerHistoryKey, 0) 
From NW_Traders_ODS.dbo.Orders o
Join NW_Traders_ODS.dbo.OrderDetails d
on o.OrderID = d.OrderID
Join NW_Traders_ODS.dbo.Products p 
on d.productID = p.ProductID
--all dimension joins are left joins (except for dim date)
-- we will use the default SKs if we don't find the actual row
left Join DimProduct dp
on p.ProductID = dp.ProductID
left join DimCustomer dc 
on o.CustomerID = dc.CustomerID
left join DimSalesPerson dsp
on o.EmployeeID = dsp.EmployeeID
left join DimCategory dcat
on p.CategoryID = dcat.CategoryID
left join DimSupplier ds 
on p.SupplierID = ds.SupplierID
left join DimShipper dship 
on o.ShipVia = dship.ShipperID
left join DimCustomerHistory dch
on o.CustomerID = dch.CustomerID
and o.OrderDate between dch.StartDate and dch.EndDate 
Join FactSales fs 
on Concat(o.OrderID,d.ProductID) = fs.OrderID
where not (
Concat(o.OrderID,d.ProductID) = fs.OrderID
and o.OrderDate = fs.OrderDate
and o.RequiredDate = fs.RequiredDate
and isnull(o.ShippedDate, '12/31/9999') = isnull(fs.ShippedDate, 
'12/31/9999')
and DateDiff(Day, o.OrderDate, o.ShippedDate) =  fs.DaysToShip
and Iif(DateDiff(Day, o.RequiredDate, o.ShippedDate)> 0, DateDiff(Day, 
o.RequiredDate, o.ShippedDate), 0) = fs.DaysOverdue
and d.UnitPrice = fs.UnitPrice
and d.Quantity = fs.Quantity
and d.UnitPrice * d.Quantity * (1 - d.discount) =  fs.LineTotal
and 0 = fs.Freight
and isnull(dp.ProductKey, 0) = fs.ProductKey
and isnull(dc.CustomerKey, 0) = fs.CustomerKey
and isnull(dsp.SalesPersonKey, 0) = fs.SalesPersonKey
and isnull(dcat.CategoryKey, 0) = fs.CategoryKey
and isnull(ds.SupplierID, 0) = fs.SupplierKey
and isnull(dship.ShipperKey, 0) = fs.ShipperKey
and Cast(Convert(varchar(8), o.OrderDate, 112) as int) = 
fs.OrderDateKey
and Cast(Convert(varchar(8), o.RequiredDate, 112) as int) = 
fs.RequiredDateKey
and Isnull(Cast(Convert(varchar(8), o.ShippedDate, 112) as int), 
99991231) = fs.ShippedDateKey
and isnull(dch.CustomerHistoryKey, 0) =  fs.CustomerHistoryKey
)
End