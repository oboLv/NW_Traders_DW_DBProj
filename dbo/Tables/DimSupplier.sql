CREATE TABLE [dbo].[DimSupplier] (
    [SupplierKey]           INT          IDENTITY (1, 1) NOT NULL,
    [SupplierID]            INT          NULL,
    [SupplierName]          VARCHAR (40) NULL,
    [SupplierPhoneNumber]   VARCHAR (24) NULL,
    [SupplierFax]           VARCHAR (24) NULL,
    [SupplierStreetAddress] VARCHAR (60) NULL,
    [SupplierCity]          VARCHAR (15) NULL,
    [SupplierStateOrRegion] VARCHAR (15) NULL,
    [SupplierPostalCode]    VARCHAR (10) NULL,
    [SupplierCountry]       VARCHAR (15) NULL,
    CONSTRAINT [pk_DimSupplier] PRIMARY KEY CLUSTERED ([SupplierKey] ASC)
);

