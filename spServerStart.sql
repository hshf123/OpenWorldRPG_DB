USE [Game];
GO

CREATE PROCEDURE [dbo].[spServerStart]
	@ServerID	INT,
	@Tick		BIGINT OUTPUT
AS
    SET NOCOUNT, XACT_ABORT ON;
        
    BEGIN TRY    
		DECLARE @TimeStamp DATETIMEOFFSET;
		SET @TimeStamp = SYSDATETIMEOFFSET();
        IF EXISTS (SELECT 1 FROM [dbo].[ServerState] WHERE ServerID = @ServerID)
		BEGIN
			UPDATE [dbo].[ServerState] SET Time = @TimeStamp WHERE ServerID = @ServerID;
		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[ServerState] (ServerID, State, Time) VALUES (@ServerID, 1, @TimeStamp);
		END

        DECLARE @EpochTimeResult TABLE (EpochTime BIGINT);
        INSERT INTO @EpochTimeResult (EpochTime)
        EXEC [dbo].[fnDateTimeToEpochTime] @TimeStamp;
        
        SELECT @Tick = EpochTime FROM @EpochTimeResult;

        COMMIT;
        
    END TRY
    BEGIN CATCH
        
        IF @@TRANCOUNT > 0        
            ROLLBACK;        
        
        INSERT TProcedureError DEFAULT VALUES;    
    END CATCH 