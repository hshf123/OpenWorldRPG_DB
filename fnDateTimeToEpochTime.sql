USE [Game];
GO

CREATE PROCEDURE [dbo].[fnDateTimeToEpochTime]
	@DateTime	DATETIMEOFFSET
AS
    SET NOCOUNT, XACT_ABORT ON;        
        
    BEGIN TRY    
    
        -- Unix Epoch Time 기준 날짜와 시간
		DECLARE @EpochDateTime DATETIME2 = '1970-01-01 00:00:00';

		-- 현재 날짜와 시간의 오프셋을 가져와서 초 단위로 변환
		SELECT DATEDIFF(SECOND, @EpochDateTime, SYSDATETIMEOFFSET()) AS EpochTime;
        COMMIT;        
    END TRY        
    BEGIN CATCH        
        
        IF @@TRANCOUNT > 0        
            ROLLBACK;        
        
        --INSERT TProcedureError DEFAULT VALUES;    
    END CATCH 