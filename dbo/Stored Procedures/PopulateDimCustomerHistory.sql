-- now create the procedure
/***************************************
* PopulateDimCustomerHistory
* Author: NKowalchuk
* CreateDate: 3/7/2022
*
* This procedure populates DimCustomerHIstory. It handles the Type 2 SCD
*
* Change Log:
*
****************************************/
Create Procedure PopulateDimCustomerHistory
As
Begin
-- first see if the row even exists, only insert rows that don't match based on the customerIDs 
Insert into DimCustomerHistory
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
, Cast(GetDate() as Date) as StartDate -- it's a new row, so put the start date to the current date
, '12/31/9999' as EndDate
From NW_Traders_ODS.dbo.Customers as src
left join DimCustomerHistory as tgt
on src.CustomerID = tgt.CustomerID
where tgt.CustomerID is null
-- now the update to the existing row - just add an end date of the current date
Update DimCustomerHistory  
Set EndDate = Cast(getDate() as Date)
From NW_Traders_ODS.dbo.Customers as src
join DimCustomerHistory as tgt
on src.CustomerID = tgt.CustomerID
Where tgt.EndDate = '12/31/9999' 
and not (
src.CompanyName = tgt.CustomerHistoricalCompanyName
and src.Phone = tgt.CustomerHistoricalPhoneNumber
and isnull(src.Fax,'') = isnull(tgt.CustomerHistoricalFax, '')
and src.Address = 
tgt.CustomerHistoricalStreetAddress
and src.City = tgt.CustomerHistoricalCity
and isnull(src.Region,'') = 
isnull(tgt.CustomerHistoricalStateOrRegion ,'')
and src.PostalCode = tgt.CustomerHistoricalPostalCode
and src.Country = tgt.CustomerHistoricalCountry )
-- now insert a new row for the changed data
Insert into DimCustomerHistory
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
, Cast(GetDate() as Date) as StartDate -- it's a new row, so put the start date to the current date
, '12/31/9999' as EndDate
From NW_Traders_ODS.dbo.Customers as src
join DimCustomerHistory as tgt
on src.CustomerID = tgt.CustomerID
Where not (
src.CompanyName = tgt.CustomerHistoricalCompanyName
and src.Phone = tgt.CustomerHistoricalPhoneNumber
and isnull(src.Fax,'') = isnull(tgt.CustomerHistoricalFax, '')
and src.Address = 
tgt.CustomerHistoricalStreetAddress
and src.City = tgt.CustomerHistoricalCity
and isnull(src.Region,'') = 
isnull(tgt.CustomerHistoricalStateOrRegion ,'')
and src.PostalCode = tgt.CustomerHistoricalPostalCode
and src.Country = tgt.CustomerHistoricalCountry )
End