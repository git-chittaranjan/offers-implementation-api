

CREATE OR ALTER PROCEDURE GetOfferDetails
    @Offer_Guid UNIQUEIDENTIFIER,
    @StatusCode INT OUTPUT   -- 0 = Success, 1 = Offer Not Found, -1 = Error
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if offer exists
        IF EXISTS (
            SELECT 1 FROM Offers
            WHERE Offer_Guid = @Offer_Guid
        )
        BEGIN
            SET @StatusCode = 0; -- Success

            SELECT 
                Offer_GUID,
                Offer_Name,
                Offer_Description,
                Offer_Type,
                Offer_Start_Date,
                Offer_End_Date,
                Offer_Priority,
                Offer_View_Threshold,
                Offer_Click_Threshold,
                Offer_Banner_Type,
                Offer_Content,
                Offer_Extra_Content,
                Offer_Meta,
                Last_Modification_Date,
                Offer_Visibility_Flag,
                'Success' AS Message
            FROM Offers
            WHERE Offer_Guid = @Offer_Guid;
        END
        ELSE
        BEGIN
            SET @StatusCode = 1; -- Not Found

            SELECT 
                @Offer_Guid AS Offer_GUID,
                CAST(NULL AS VARCHAR(100)) AS Offer_Name,
                CAST(NULL AS VARCHAR(500)) AS Offer_Description,
                CAST(NULL AS VARCHAR(100)) AS Offer_Type,
                CAST(NULL AS DATETIME) AS Offer_Start_Date,
                CAST(NULL AS DATETIME) AS Offer_End_Date,
                CAST(NULL AS INT) AS Offer_Priority,
                CAST(NULL AS INT) AS Offer_View_Threshold,
                CAST(NULL AS INT) AS Offer_Click_Threshold,
                CAST(NULL AS VARCHAR(100)) AS Offer_Banner_Type,
                CAST(NULL AS NVARCHAR(MAX)) AS Offer_Content,
                CAST(NULL AS NVARCHAR(MAX)) AS Offer_Extra_Content,
                CAST(NULL AS NVARCHAR(MAX)) AS Offer_Meta,
                CAST(NULL AS DATETIME) AS Last_Modification_Date,
                CAST(NULL AS BIT) AS Offer_Visibility_Flag,
                'No offer found with the given Offer ID.' AS Message;
        END
    END TRY

    BEGIN CATCH
        SET @StatusCode = -1; -- Error

        SELECT 
            @Offer_Guid AS Offer_GUID,
            CAST(NULL AS VARCHAR(100)) AS Offer_Name,
            CAST(NULL AS VARCHAR(500)) AS Offer_Description,
            CAST(NULL AS VARCHAR(100)) AS Offer_Type,
            CAST(NULL AS DATETIME) AS Offer_Start_Date,
            CAST(NULL AS DATETIME) AS Offer_End_Date,
            CAST(NULL AS INT) AS Offer_Priority,
            CAST(NULL AS INT) AS Offer_View_Threshold,
            CAST(NULL AS INT) AS Offer_Click_Threshold,
            CAST(NULL AS VARCHAR(100)) AS Offer_Banner_Type,
            CAST(NULL AS NVARCHAR(MAX)) AS Offer_Content,
            CAST(NULL AS NVARCHAR(MAX)) AS Offer_Extra_Content,
            CAST(NULL AS NVARCHAR(MAX)) AS Offer_Meta,
            CAST(NULL AS DATETIME) AS Last_Modification_Date,
            CAST(NULL AS BIT) AS Offer_Visibility_Flag,
            N'Error: ' + ERROR_MESSAGE() AS Message;
    END CATCH
END;



-- ============================================= SP Execution =============================================

DECLARE @Status INT;

EXEC GetOfferDetails 
    @Offer_Guid = 'CBDA7CC0-5387-F011-9F57-64D69AE7FAE4',
    @StatusCode = @Status OUTPUT;

SELECT @Status AS StatusCode;
