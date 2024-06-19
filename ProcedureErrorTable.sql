USE [Game];
GO

CREATE TABLE [dbo].[TProcedureError]
(
    ErrorID INT IDENTITY(1,1) PRIMARY KEY,
    ErrorDateTime DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
    ErrorNumber INT,
    ErrorSeverity INT,
    ErrorState INT,
    ErrorProcedure NVARCHAR(128),
    ErrorLine INT,
    ErrorMessage NVARCHAR(MAX)
);
GO
