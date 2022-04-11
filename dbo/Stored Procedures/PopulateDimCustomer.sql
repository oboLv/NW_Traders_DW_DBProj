/***************************************
* PopulateDimCustomer
* Author: NKowalchuk
* CreateDate: 3/7/2022
*
* This procedure populates DimCustomer. It will insert new row
* as well as update existing rows IF they are changed
*
* Change Log:
*
****************************************/
Create Procedure PopulateDimCustomer
As
Begin
-- first see if the row even exists, only insert rows that don't match based on the customerIDs 
Insert into DimCustomer
Select 
src.CustomerID
,src.CompanyName
,src.Phone
,src.Fax
,src.Address
,src.City
,src.Region
,src.PostalCode
,src.Country
From NW_Traders_ODS.dbo.Customers as src
left join DimCustomer as tgt
on src.CustomerID = tgt.CustomerID
where tgt.CustomerID is null
-- now the update where there is a match and there were changes
Update DimCustomer 
Set CustomerCompanyName = src.CompanyName,
CustomerPhoneNumber = src.Phone,
CustomerFax = src.Fax,
CustomerStreetAddress = src.Address,
CustomerCity = src.City,
CustomerStateOrRegion = src.Region,
CustomerPostalCode = src.PostalCode,
CustomerCountry = src.Country
From NW_Traders_ODS.dbo.Customers as src
join DimCustomer as tgt
on src.CustomerID = tgt.CustomerID
Where not (
src.CompanyName = tgt.CustomerCompanyName 
and src.Phone = tgt.CustomerPhoneNumber
and isnull(src.Fax,'') = isnull(tgt.CustomerFax, '')
and src.Address = tgt.CustomerStreetAddress
and src.City = tgt.CustomerCity
and isnull(src.Region,'') = isnull(tgt.CustomerStateOrRegion ,'')
and src.PostalCode = tgt.CustomerPostalCode
and src.Country = tgt.CustomerCountry )
End