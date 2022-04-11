CREATE TABLE [dbo].[DimCustomerHistory] (
    [CustomerHistoryKey]              INT          IDENTITY (1, 1) NOT NULL,
    [CustomerID]                      CHAR (5)     NULL,
    [CustomerHistoricalCompanyName]   VARCHAR (40) NULL,
    [CustomerHistoricalPhoneNumber]   VARCHAR (24) NULL,
    [CustomerHistoricalFax]           VARCHAR (24) NULL,
    [CustomerHistoricalStreetAddress] VARCHAR (60) NULL,
    [CustomerHistoricalCity]          VARCHAR (15) NULL,
    [CustomerHistoricalStateOrRegion] VARCHAR (15) NULL,
    [CustomerHistoricalPostalCode]    VARCHAR (10) NULL,
    [CustomerHistoricalCountry]       VARCHAR (15) NULL,
    [StartDate]                       DATETIME     NOT NULL,
    [EndDate]                         DATETIME     NOT NULL,
    CONSTRAINT [pk_DimCustomerHistory] PRIMARY KEY CLUSTERED ([CustomerHistoryKey] ASC)
);

