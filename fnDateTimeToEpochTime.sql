USE [Game];
GO

CREATE PROCEDURE [dbo].[fnDateTimeToEpochTime]
	@DateTime	DATETIMEOFFSET
AS
    SET NOCOUNT, XACT_ABORT ON;        
        
    BEGIN TRY    
    
        -- Unix Epoch Time ���� ��¥�� �ð�
		DECLARE @EpochDateTime DATETIME2 = '1970-01-01 00:00:00';

		-- ���� ��¥�� �ð��� �������� �����ͼ� �� ������ ��ȯ
		SELECT DATEDIFF(SECOND, @EpochDateTime, SYSDATETIMEOFFSET()) AS EpochTime;
        COMMIT;        
    END TRY        
    BEGIN CATCH        
        
        IF @@TRANCOUNT > 0        
            ROLLBACK;        
        
        --INSERT TProcedureError DEFAULT VALUES;    
    END CATCH 