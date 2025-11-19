

CREATE OR ALTER PROCEDURE GetCustomerOffers
    @Cust_Fed_ID VARCHAR(100),
    @Placeholder_Guid UNIQUEIDENTIFIER,
    @StatusCode INT OUTPUT,
    @Message NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -----------------------------------------------------------
        -- CUSTOMER VALIDATION
        -----------------------------------------------------------
        IF dbo.fn_IsCustomerValid(@Cust_Fed_ID) = 0
        BEGIN
            SET @StatusCode = 0;
            SET @Message = 'Customer is inactive';
            RETURN;
        END

        IF dbo.fn_IsCustomerValid(@Cust_Fed_ID) = -1
        BEGIN
            SET @StatusCode = 0;
            SET @Message = 'Customer not found';
            RETURN;
        END

        -----------------------------------------------------------
        -- PLACEHOLDER VALIDATION
        -----------------------------------------------------------
        IF dbo.fn_IsPlaceholderValid(@Placeholder_Guid) = 0
        BEGIN
            SET @StatusCode = 0;
            SET @Message = 'Placeholder is inactive';
            RETURN;
        END

        IF dbo.fn_IsPlaceholderValid(@Placeholder_Guid) = -1
        BEGIN
            SET @StatusCode = 0;
            SET @Message = 'Placeholder not found';
            RETURN;
        END

        -----------------------------------------------------------
        -- TABLE 1: CUSTOMER + PLACEHOLDER DETAILS
        -----------------------------------------------------------
        SELECT 
            c.Cust_Fed_ID AS cust_fed_id,
            p.Placeholder_Guid AS placeholder_guid,
            p.Placeholder_Name AS placeholder_name,
            p.Channel_Name AS channel_name,
            p.Channel_Type AS channel_type,
            p.Placeholder_Offer_Limit AS placeholder_offer_limit,
            p.Placeholder_Meta AS placeholder_meta
        FROM Customers c
        INNER JOIN Placeholders p ON p.Placeholder_Guid = @Placeholder_Guid
        WHERE c.Cust_Fed_ID = @Cust_Fed_ID;

        -----------------------------------------------------------
        -- TABLE 2: OFFER LIST
        -----------------------------------------------------------
        ;WITH Stats3Days AS (
            SELECT 
                Cust_Fed_ID, 
                Offer_Guid,
                SUM(View_Count) AS Views3Days,
                SUM(Click_Count) AS Clicks3Days
            FROM CustomerOfferStatsDaily
            WHERE Stat_Date >= CAST(DATEADD(DAY, -2, CAST(GETDATE() AS DATE)) AS DATE)
            GROUP BY Cust_Fed_ID, Offer_Guid
        )

        SELECT DISTINCT
            o.Offer_Guid AS offer_guid,
            o.Offer_Name AS offer_name,
            o.Offer_Description AS offer_description,
            o.Offer_Type AS offer_type,
            o.Offer_Priority AS offer_priority,
            o.Offer_View_Threshold AS offer_view_threshold,
            o.Offer_Click_Threshold AS offer_click_threshold,
            o.Offer_Banner_Type AS offer_banner_type,
            o.Offer_Content AS offer_content,
            o.Offer_Extra_Content AS offer_extra_content,
            o.Offer_Meta AS offer_meta
        FROM CustomerOffers co
            INNER JOIN Offers o ON co.Offer_ID = o.Offer_ID
            INNER JOIN PlaceholderOffers po ON o.Offer_ID = po.Offer_ID
            INNER JOIN Placeholders p2 ON po.Placeholder_ID = p2.Placeholder_ID
            LEFT JOIN Stats3Days s ON co.Cust_Fed_ID = s.Cust_Fed_ID 
                                   AND o.Offer_Guid = s.Offer_Guid
        WHERE co.Cust_Fed_ID = @Cust_Fed_ID
          AND p2.Placeholder_Guid = @Placeholder_Guid
          AND o.Offer_Visibility_Flag = 1
          AND ISNULL(s.Views3Days,0) < o.Offer_View_Threshold
          AND ISNULL(s.Clicks3Days,0) < o.Offer_Click_Threshold

        UNION

        -----------------------------------------------------------
        -- TABLE 2: OFFER LIST (Default Offers)
        -----------------------------------------------------------
        
        SELECT
            o.Offer_Guid,
            o.Offer_Name,
            o.Offer_Description,
            o.Offer_Type,
            o.Offer_Priority,
            o.Offer_View_Threshold,
            o.Offer_Click_Threshold,
            o.Offer_Banner_Type,
            o.Offer_Content,
            o.Offer_Extra_Content,
            o.Offer_Meta
        FROM PlaceholderOffers po
        INNER JOIN Placeholders p2 ON p2.Placeholder_ID = po.Placeholder_ID
        INNER JOIN Offers o ON o.Offer_ID = po.Offer_ID
        WHERE p2.Placeholder_Guid = @Placeholder_Guid
          AND o.Offer_Type = 'Default'
          AND o.Offer_Visibility_Flag = 1;

        -----------------------------------------------------------
        -- SUCCESS STATUS
        -----------------------------------------------------------
        SET @StatusCode = 1;
        SET @Message = 'Success';

    END TRY
    BEGIN CATCH
        SET @StatusCode = 0;
        SET @Message = 'Error: ' + ERROR_MESSAGE();
    END CATCH
END



-- ============================================= SP Execution =============================================

DECLARE @Status INT;
DECLARE @Msg NVARCHAR(500);

EXEC GetCustomerOffers 
    @Cust_Fed_ID = '6049382751',
    @Placeholder_Guid = '56C5AA3B-AB8B-F011-9F57-64D69AE7FAE4',
    @StatusCode = @Status OUTPUT,
    @Message = @Msg OUTPUT;

SELECT @Status AS StatusCode,@Msg AS Message;











-- ============================================= Return JSON Data =============================================


--CREATE OR ALTER PROCEDURE GetCustomerOffers
--    @Cust_Fed_ID VARCHAR(100),
--    @Placeholder_Guid UNIQUEIDENTIFIER,
--    @StatusCode INT OUTPUT,
--    @Message NVARCHAR(500) OUTPUT
--AS
--BEGIN
--    SET NOCOUNT ON;
--
--    BEGIN TRY
--        -- Validate customer
--        IF dbo.fn_IsCustomerValid(@Cust_Fed_ID) = 0
--        BEGIN
--            SET @StatusCode = 0;
--            SET @Message = 'Customer is inactive';
--            RETURN;
--        END
--        
--        IF dbo.fn_IsCustomerValid(@Cust_Fed_ID) = -1
--        BEGIN
--            SET @StatusCode = 0;
--            SET @Message = 'Customer not found';
--            RETURN;
--        END
--
--        -- Validate placeholder
--        IF dbo.fn_IsPlaceholderValid(@Placeholder_Guid) = 0
--        BEGIN
--            SET @StatusCode = 0;
--            SET @Message = 'Placeholder is inactive';
--            RETURN;
--        END
--        
--        IF dbo.fn_IsPlaceholderValid(@Placeholder_Guid) = -1
--        BEGIN
--            SET @StatusCode = 0;
--            SET @Message = 'Placeholder not found';
--            RETURN;
--        END
--
--        
--        DECLARE @OfferData NVARCHAR(MAX);
--
--        SELECT @OfferData = (
--            SELECT * FROM (
--                SELECT
--                    o.Offer_Guid AS offer_guid,
--                    o.Offer_Name AS offer_name,
--                    o.Offer_Description AS offer_description,
--                    o.Offer_Type AS offer_type,
--                    o.Offer_Priority AS offer_priority,
--                    o.Offer_View_Threshold AS offer_view_threshold,
--                    o.Offer_Click_Threshold AS offer_click_threshold,
--                    o.Offer_Banner_Type AS offer_banner_type,
--                    o.Offer_Content AS offer_content,
--                    o.Offer_Extra_Content AS offer_extra_content,
--                    o.Offer_Meta AS offer_meta
--                FROM CustomerOffers co
--                INNER JOIN Offers o ON co.Offer_ID = o.Offer_ID                
--                INNER JOIN PlaceholderOffers po ON o.Offer_ID  = po.Offer_ID
--                INNER JOIN Placeholders p2 ON po.Placeholder_ID = p2.Placeholder_ID
--                LEFT JOIN (
--    				SELECT 
--    					Cust_Fed_ID, 
--    					Offer_Guid,
--           				SUM(View_Count) AS Views3Days,
--           				SUM(Click_Count) AS Clicks3Days
--    				FROM CustomerOfferStatsDaily
--    				WHERE Stat_Date >= CAST(DATEADD(DAY, -2, CAST(GETDATE() AS DATE)) AS DATE) -- If today is 2025-09-22, we check 2025-09-22, 2025-09-21, 2025-09-20. Which is today + last 2 days.
--   					GROUP BY Cust_Fed_ID, Offer_Guid
--				) stats ON co.Cust_Fed_ID = stats.Cust_Fed_ID AND o.Offer_Guid = stats.Offer_Guid
--                WHERE co.Cust_Fed_ID = @Cust_Fed_ID
--                  AND p2.Placeholder_Guid = @Placeholder_Guid
--                  AND o.Offer_Visibility_Flag = 1
--                  AND ISNULL(stats.Views3Days,0) < o.Offer_View_Threshold -- To be suppressed on n views
--  				  AND ISNULL(stats.Clicks3Days,0) < o.Offer_Click_Threshold -- To be suppressed on m clicks
--
--                UNION
--
--                SELECT
--                    o.Offer_Guid AS offer_guid,
--                    o.Offer_Name AS offer_name,
--                    o.Offer_Description AS offer_description,
--                    o.Offer_Type AS offer_type,
--                    o.Offer_Priority AS offer_priority,
--                    o.Offer_View_Threshold AS offer_view_threshold,
--                    o.Offer_Click_Threshold AS offer_click_threshold,
--                    o.Offer_Banner_Type AS offer_banner_type,
--                    o.Offer_Content AS offer_content,
--                    o.Offer_Extra_Content AS offer_extra_content,
--                    o.Offer_Meta AS offer_meta
--                FROM PlaceholderOffers po
--                INNER JOIN Placeholders p2 ON p2.Placeholder_ID = po.Placeholder_ID
--                INNER JOIN Offers o ON o.Offer_ID = po.Offer_ID
--                WHERE p2.Placeholder_Guid = @Placeholder_Guid
--                  AND o.Offer_Type = 'Default'
--                  AND o.Offer_Visibility_Flag = 1
--            ) AS DerivedOffers
--            FOR JSON PATH
--        );
--                
--
--		IF @OfferData IS NULL OR LEN(@OfferData) = 0
--		BEGIN
--    		SET @StatusCode = 1;
--    		SET @Message = 'No offers available for this customer for the given placeholder';
--
--    		-- Return a select statement with status and message
--    		SELECT
--            	@Cust_Fed_ID AS cust_fed_id,
--            	p.Placeholder_Guid AS placeholder_guid,
--            	p.Placeholder_Name AS placeholder_name,
--            	p.Channel_Name AS channel_name,
--            	p.Channel_Type AS channel_type,
--            	p.Placeholder_Offer_Limit AS placeholder_offer_limit,
--            	p.Placeholder_Meta AS placeholder_meta,
--            	JSON_QUERY('[]') AS offer_data 
--            FROM Placeholders p 
--            WHERE p.Placeholder_Guid = @Placeholder_Guid
--    		FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
--
--    		RETURN;
--		END
--
--
--        -- Success
--        SET @StatusCode = 1;
--        SET @Message = 'Success';
--        
--        -- Return customer + placeholder + offer data
--        SELECT
--            c.Cust_Fed_ID AS cust_fed_id,
--            p.Placeholder_Guid AS placeholder_guid,
--            p.Placeholder_Name AS placeholder_name,
--            p.Channel_Name AS channel_name,
--            p.Channel_Type AS channel_type,
--            p.Placeholder_Offer_Limit AS placeholder_offer_limit,
--            p.Placeholder_Meta AS placeholder_meta,
--            @OfferData AS offer_data
--        FROM Customers c
--        INNER JOIN Placeholders p ON p.Placeholder_Guid = @Placeholder_Guid
--        WHERE c.Cust_Fed_ID = @Cust_Fed_ID
--        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
--
--    END TRY
--    BEGIN CATCH
--        SET @StatusCode = 0;
--	SET @Message = N'Cust_Fed_ID: ' + CAST(@Cust_Fed_ID AS NVARCHAR(MAX))
--             + N', placeholder_guid: ' + CAST(@Placeholder_Guid AS NVARCHAR(MAX))
--             + N', Message: ' + CAST(ERROR_MESSAGE() AS NVARCHAR(MAX));
--    END CATCH
--END









