CREATE PROCEDURE GetCustomerDetails
    @Cust_Fed_ID VARCHAR(100),
    @StatusCode INT OUTPUT   -- 0 = Success, 1 = Customer Not Found, -1 = Error
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if customer exists
        IF EXISTS (
            SELECT 1 FROM Customers
            WHERE Cust_Fed_ID = @Cust_Fed_ID
        )
        BEGIN
            SET @StatusCode = 0; -- Success

            SELECT 
                Cust_Fed_ID,
                Cust_Name,
                Cust_Data,
                Cust_Entry_Date,
                Cust_Is_Active,
                'Success' AS Message
            FROM Customers
            WHERE Cust_Fed_ID = @Cust_Fed_ID;
        END
        ELSE
        BEGIN
            SET @StatusCode = 1; -- Not Found

            SELECT 
                @Cust_Fed_ID AS Cust_Fed_ID,
                CAST(NULL AS NVARCHAR(100)) AS Cust_Name,
                CAST(NULL AS NVARCHAR(MAX)) AS Cust_Data,
                CAST(NULL AS DATETIME) AS Cust_Entry_Date,
                CAST(NULL AS BIT) AS Cust_Is_Active,
                'No customer found with the given Customer Fed ID' AS Message;
        END
    END TRY

    BEGIN CATCH
        SET @StatusCode = -1; -- Error

        SELECT
            @Cust_Fed_ID AS Cust_Fed_ID,
            CAST(NULL AS NVARCHAR(100)) AS Cust_Name,
            CAST(NULL AS NVARCHAR(MAX)) AS Cust_Data,
            CAST(NULL AS DATETIME) AS Cust_Entry_Date,
            CAST(NULL AS BIT) AS Cust_Is_Active,
            N'Error: ' + ERROR_MESSAGE() AS Message; -- fixed
    END CATCH

    RETURN @StatusCode; -- optional but cleaner
END;



-- ============================================= SP Execution =============================================

DECLARE @Status INT;

EXEC GetCustomerDetails 
    @Cust_Fed_ID = '4839201745',
    @StatusCode = @Status OUTPUT;

SELECT @Status AS StatusCode;













