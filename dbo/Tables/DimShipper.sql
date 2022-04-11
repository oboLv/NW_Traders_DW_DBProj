CREATE TABLE [dbo].[DimShipper] (
    [ShipperKey]         INT          IDENTITY (1, 1) NOT NULL,
    [ShipperName]        VARCHAR (40) NULL,
    [ShipperPhoneNumber] VARCHAR (24) NULL,
    [ShipperID]          INT          NOT NULL,
    CONSTRAINT [pk_DimShipper] PRIMARY KEY CLUSTERED ([ShipperKey] ASC)
);

