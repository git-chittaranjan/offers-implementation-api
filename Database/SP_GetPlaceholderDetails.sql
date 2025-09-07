

CREATE PROCEDURE GetPlaceholderDetails
    @Placeholder_Guid UNIQUEIDENTIFIER,
    @StatusCode INT OUTPUT   -- 0 = Success, 1 = Not Found, -1 = Error
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if placeholder exists
        IF EXISTS (
            SELECT 1 FROM Placeholders
            WHERE Placeholder_Guid = @Placeholder_Guid
        )
        BEGIN
            SET @StatusCode = 0; -- Success

            SELECT 
                Placeholder_Guid,
                Placeholder_Name,
                Channel_Name,
                Channel_Type,
                Placeholder_Offer_Limit,
                Placeholder_Creation_Date,
                Placeholder_Meta,
                Placeholder_Is_Active,
                'Success' AS Message
            FROM Placeholders
            WHERE Placeholder_Guid = @Placeholder_Guid;
        END
        ELSE
        BEGIN
            SET @StatusCode = 1; -- Not Found

            SELECT 
                @Placeholder_Guid AS Placeholder_Guid,
                CAST(NULL AS NVARCHAR(100)) AS Placeholder_Name,
                CAST(NULL AS NVARCHAR(100)) AS Channel_Name,
                CAST(NULL AS NVARCHAR(100)) AS Channel_Type,
                CAST(NULL AS INT) AS Placeholder_Offer_Limit,
                CAST(NULL AS DATETIME) AS Placeholder_Creation_Date,
                CAST(NULL AS NVARCHAR(MAX)) AS Placeholder_Meta,
                CAST(NULL AS BIT) AS Placeholder_Is_Active,
                'No Placeholder found with the given Placeholder ID.' AS Message;
        END
    END TRY

    BEGIN CATCH
        SET @StatusCode = -1; -- Error

        SELECT 
                @Placeholder_Guid AS Placeholder_Guid,
                CAST(NULL AS NVARCHAR(100)) AS Placeholder_Name,
                CAST(NULL AS NVARCHAR(100)) AS Channel_Name,
                CAST(NULL AS NVARCHAR(100)) AS Channel_Type,
                CAST(NULL AS INT) AS Placeholder_Offer_Limit,
                CAST(NULL AS DATETIME) AS Placeholder_Creation_Date,
                CAST(NULL AS NVARCHAR(MAX)) AS Placeholder_Meta,
                CAST(NULL AS BIT) AS Placeholder_Is_Active,
            	N'Error: ' + ERROR_MESSAGE() AS Message;
    END CATCH
END;



-- ============================================= SP Execution =============================================

DECLARE @Status INT;

EXEC GetPlaceholderDetails 
    @Placeholder_Guid = '54C5AA3B-AB8B-F011-9F57-64D69AE7FAE4',
    @StatusCode = @Status OUTPUT;

SELECT @Status AS StatusCode;













