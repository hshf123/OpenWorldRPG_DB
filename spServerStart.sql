USE [Game]
GO
/****** Object:  StoredProcedure [dbo].[spServerStart]    Script Date: 2024-06-21 오후 7:44:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spServerStart]
    @ServerID INT,
    @Tick BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @TimeStamp DATETIMEOFFSET = SYSDATETIMEOFFSET();
        
		-- Epoch 시간 계산 및 할당
        DECLARE @EpochTimeResult BIGINT;
        EXEC [dbo].[fnDateTimeToEpochTime] @TimeStamp, @Tick OUTPUT;

        -- ServerID가 이미 있는 경우 삭제
        DELETE FROM [dbo].[ServerState] WHERE [ServerID] = @ServerID;

        -- ServerState 테이블에 새로운 행 삽입
        INSERT INTO [dbo].[ServerState] ([ServerID], [State], [Time])
        VALUES (@ServerID, 1, @TimeStamp);
    END TRY
    BEGIN CATCH
        -- 에러 정보를 저장하거나 로깅하는 코드
        -- INSERT INTO TProcedureError (ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine, ErrorState)
        -- VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_STATE());

        -- 에러를 다시 던져 호출자가 처리할 수 있도록 함
        THROW;
    END CATCH
END;
