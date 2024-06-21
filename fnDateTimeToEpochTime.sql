USE [Game]
GO
/****** Object:  StoredProcedure [dbo].[fnDateTimeToEpochTime]    Script Date: 2024-06-21 오후 7:44:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[fnDateTimeToEpochTime]
	@DateTime	DATETIMEOFFSET,
	@ReturnTick BIGINT OUTPUT
AS
    SET NOCOUNT, XACT_ABORT ON;        
        
    BEGIN TRY    
    
        -- Unix Epoch Time 기준 날짜와 시간
		DECLARE @EpochDateTime DATETIME2 = '1970-01-01 00:00:00';

		-- 현재 날짜와 시간의 오프셋을 가져와서 초 단위로 변환
		SET @ReturnTick = DATEDIFF(SECOND, @EpochDateTime, @DateTime);
        COMMIT;        
    END TRY        
    BEGIN CATCH        
        
        IF @@TRANCOUNT > 0        
            ROLLBACK;        
        
        --INSERT TProcedureError DEFAULT VALUES;    
    END CATCH 