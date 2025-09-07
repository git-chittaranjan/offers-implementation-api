

CREATE PROCEDURE GetCustomerOffers
    @Cust_Fed_ID VARCHAR(100),
    @Placeholder_Guid UNIQUEIDENTIFIER,
    @StatusCode INT OUTPUT  -- 0 = Success, 1 = No Offers, -1 = Error
AS
BEGIN
    SET NOCOUNT ON; --To suppress the “row(s) affected” messages after execution

    BEGIN TRY
        
        -- Main query with UNION
        WITH OffersResult AS
        (
            SELECT
                c.Cust_Fed_ID,
                o.Offer_Name,
                p.Placeholder_Name,
                p.Channel_Name
            FROM CustomerOffers co
            INNER JOIN PlaceholderOffers po ON co.Offer_ID = po.Offer_ID
            INNER JOIN Customers c ON c.Cust_Fed_ID = co.Cust_Fed_ID
            INNER JOIN Placeholders p ON po.Placeholder_ID = p.Placeholder_ID
            INNER JOIN Offers o ON co.Offer_ID = o.Offer_ID
            WHERE
                c.Cust_Fed_ID = @Cust_Fed_ID
                AND p.Placeholder_ID = @Placeholder_ID
                AND c.Cust_Is_Active = 1
                AND o.Offer_Visibility_Flag = 1
                AND p.Placeholder_Is_Active = 1

            UNION

            SELECT
                @Cust_Fed_ID,
                o.Offer_Name,
                p.Placeholder_Name,
                p.Channel_Name
            FROM PlaceholderOffers po
            INNER JOIN Placeholders p ON p.Placeholder_ID = po.Placeholder_ID
            INNER JOIN Offers o ON o.Offer_ID = po.Offer_ID
            WHERE
                p.Placeholder_ID = @Placeholder_ID
                AND o.Offer_Type = 'Default'
                AND o.Offer_Visibility_Flag = 1
                AND p.Placeholder_Is_Active = 1
        )
        SELECT 
            Cust_Fed_ID,
            Offer_Name,
            Placeholder_Name,
            Channel_Name,
            'Success' AS Message
        FROM OffersResult
        ORDER BY Offer_Name, Placeholder_Name;

        -- If no offers found
        IF @@ROWCOUNT = 0
        BEGIN
            SET @StatusCode = 1;
            SELECT 
                @Cust_Fed_ID AS Cust_Fed_ID,
                CAST(NULL AS NVARCHAR(200)) AS Offer_Name,
                CAST(NULL AS NVARCHAR(200)) AS Placeholder_Name,
                CAST(NULL AS NVARCHAR(100)) AS Channel_Name,
                'No offers found for this customer and placeholder.' AS Message;
        END
        ELSE
        BEGIN
            SET @StatusCode = 0; -- Success
        END
    END TRY

    BEGIN CATCH
        SET @StatusCode = -1;
        SELECT 
            @Cust_Fed_ID AS Cust_Fed_ID,
            CAST(NULL AS NVARCHAR(200)) AS Offer_Name,
            CAST(NULL AS NVARCHAR(200)) AS Placeholder_Name,
            CAST(NULL AS NVARCHAR(100)) AS Channel_Name,
            'Error: ' + ERROR_MESSAGE() AS Message;
    END CATCH
END;


	
	
	
	