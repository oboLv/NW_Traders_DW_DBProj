CREATE TABLE [dbo].[DimCustomer] (
    [CustomerKey]           INT          IDENTITY (1, 1) NOT NULL,
    [CustomerID]            CHAR (5)     NULL,
    [CustomerCompanyName]   VARCHAR (40) NULL,
    [CustomerPhoneNumber]   VARCHAR (24) NULL,
    [CustomerFax]           VARCHAR (24) NULL,
    [CustomerStreetAddress] VARCHAR (60) NULL,
    [CustomerCity]          VARCHAR (15) NULL,
    [CustomerStateOrRegion] VARCHAR (15) NULL,
    [CustomerPostalCode]    VARCHAR (10) NULL,
    [CustomerCountry]       VARCHAR (15) NULL,
    CONSTRAINT [pk_DimCustomer] PRIMARY KEY CLUSTERED ([CustomerKey] ASC)
);

