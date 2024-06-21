USE [Game];
GO

ALTER PROCEDURE [dbo].[spServerStart]
    @ServerID INT,
    @Tick BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @TimeStamp DATETIMEOFFSET = SYSDATETIMEOFFSET();
        
        -- ServerID�� �̹� �ִ� ��� ����
        DELETE FROM [dbo].[ServerState] WHERE [ServerID] = @ServerID;

        -- ServerState ���̺� ���ο� �� ����
        INSERT INTO [dbo].[ServerState] ([ServerID], [State], [Time])
        VALUES (@ServerID, 1, @TimeStamp);

        -- Epoch �ð� ��� �� �Ҵ�
        DECLARE @EpochTimeResult BIGINT;
        EXEC @Tick = [dbo].[fnDateTimeToEpochTime] @TimeStamp;
    END TRY
    BEGIN CATCH
        -- ���� ������ �����ϰų� �α��ϴ� �ڵ�
        -- INSERT INTO TProcedureError (ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine, ErrorState)
        -- VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_STATE());

        -- ������ �ٽ� ���� ȣ���ڰ� ó���� �� �ֵ��� ��
        THROW;
    END CATCH
END;
GO
