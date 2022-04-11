CREATE TABLE [dbo].[DimProduct] (
    [ProductKey]            INT          IDENTITY (1, 1) NOT NULL,
    [ProductID]             INT          NULL,
    [ProductName]           VARCHAR (40) NULL,
    [CurrentUnitPrice]      MONEY        NULL,
    [CurrentWholesalePrice] MONEY        NULL,
    [ProductStatus]         VARCHAR (15) NULL,
    CONSTRAINT [pk_DimProduct] PRIMARY KEY CLUSTERED ([ProductKey] ASC)
);

