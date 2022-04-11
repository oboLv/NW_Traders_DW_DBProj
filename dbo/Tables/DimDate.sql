CREATE TABLE [dbo].[DimDate] (
    [DateKey]         INT          NOT NULL,
    [Date]            DATE         NULL,
    [DayOfMonth]      TINYINT      NULL,
    [MonthNumber]     TINYINT      NULL,
    [MonthName]       VARCHAR (20) NULL,
    [Year]            SMALLINT     NULL,
    [DayOfWeek]       VARCHAR (15) NULL,
    [DayNumberOfWeek] TINYINT      NULL,
    PRIMARY KEY CLUSTERED ([DateKey] ASC)
);

