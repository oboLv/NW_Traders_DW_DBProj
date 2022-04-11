CREATE TABLE [dbo].[DimCategory] (
    [CategoryKey]         INT           IDENTITY (1, 1) NOT NULL,
    [CategoryID]          INT           NULL,
    [CategoryName]        VARCHAR (15)  NULL,
    [CategoryDescription] VARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([CategoryKey] ASC)
);

