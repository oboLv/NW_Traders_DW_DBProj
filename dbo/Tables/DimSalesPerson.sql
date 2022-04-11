CREATE TABLE [dbo].[DimSalesPerson] (
    [SalesPersonKey]    INT          IDENTITY (1, 1) NOT NULL,
    [EmployeeID]        INT          NULL,
    [EmployeeFirstName] VARCHAR (50) NULL,
    [EmployeeLastName]  VARCHAR (50) NULL,
    [JobTitle]          VARCHAR (50) NULL,
    CONSTRAINT [pk_DimSalesPerson] PRIMARY KEY CLUSTERED ([SalesPersonKey] ASC)
);

