

CREATE OR ALTER PROCEDURE GetBitDetails
    @Bit_Guid UNIQUEIDENTIFIER,
    @StatusCode INT OUTPUT   -- 0 = Success, 1 = Not Found, -1 = Error
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if Bit exists
        IF EXISTS (
        	SELECT 1 FROM Bits 
        	WHERE Bit_Guid = @Bit_Guid
        )
        BEGIN
            SET @StatusCode = 0; -- Success

            SELECT 
                Bit_Guid,
                Cust_Fed_ID,
                Offer_Guid,
                Offer_Name,
                Bit_Type,
                Channel_Name,
                Placeholder_Guid,
                Placeholder_Name,
                Action_Timestamp,
                'Success' AS Message
            FROM Bits
            WHERE Bit_Guid = @Bit_Guid;
        END
        ELSE
        BEGIN
            SET @StatusCode = 1; -- Not Found

            SELECT 
                @Bit_Guid AS Bit_Guid,
                CAST(NULL AS VARCHAR(100)) AS Cust_Fed_ID,
                CAST(NULL AS UNIQUEIDENTIFIER) AS Offer_Guid,
                CAST(NULL AS VARCHAR(100)) AS Offer_Name,
                CAST(NULL AS VARCHAR(100)) AS Bit_Type,
                CAST(NULL AS VARCHAR(100)) AS Channel_Name,
                CAST(NULL AS UNIQUEIDENTIFIER) AS Placeholder_Guid,
                CAST(NULL AS VARCHAR(100)) AS Placeholder_Name,
                CAST(NULL AS DATETIME) AS Action_Timestamp,
                'No Bit found with the given Bit ID' AS Message;
        END
    END TRY

    BEGIN CATCH
        SET @StatusCode = -1; -- Error

        SELECT 
            @Bit_Guid AS Bit_Guid,
            CAST(NULL AS VARCHAR(100)) AS Cust_Fed_ID,
            CAST(NULL AS UNIQUEIDENTIFIER) AS Offer_Guid,
            CAST(NULL AS VARCHAR(100)) AS Offer_Name,
            CAST(NULL AS VARCHAR(100)) AS Bit_Type,
            CAST(NULL AS VARCHAR(100)) AS Channel_Name,
            CAST(NULL AS UNIQUEIDENTIFIER) AS Placeholder_Guid,
            CAST(NULL AS VARCHAR(100)) AS Placeholder_Name,
            CAST(NULL AS DATETIME) AS Action_Timestamp,
            N'Error: ' + ERROR_MESSAGE() AS Message;
    END CATCH
END;



-- ============================================= SP Execution =============================================

DECLARE @Status INT;

EXEC GetBitDetails 
    @Bit_Guid = '33DCFBBB-19C5-F011-9F79-CD6F5F8138AD',
    @StatusCode = @Status OUTPUT;

SELECT @Status AS StatusCode;
