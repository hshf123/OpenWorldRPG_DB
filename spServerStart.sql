USE [Game]
GO
/****** Object:  StoredProcedure [dbo].[spServerStart]    Script Date: 2024-07-09 오후 8:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spServerStart]
    @ServerID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @TimeStamp DATETIMEOFFSET = SYSDATETIMEOFFSET();
        
        DELETE FROM [dbo].[ServerState] WHERE [ServerID] = @ServerID;

        INSERT INTO [dbo].[ServerState] ([ServerID], [State], [Time])
        VALUES (@ServerID, 1, @TimeStamp);

		SELECT @TimeStamp;
    END TRY
    BEGIN CATCH
		ROLLBACK;
		INSERT [dbo].[TProcedureError] DEFAULT VALUES;
        THROW;
    END CATCH
END;
