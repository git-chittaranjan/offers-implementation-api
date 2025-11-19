-- ============================================= General Queries =============================================

-- Get all offers for a given customer
SELECT
    c.Cust_ID,
    c.Cust_Fed_ID,
    c.Cust_Name,
    o.Offer_ID,
    o.Offer_Name
FROM CustomerOffers co
INNER JOIN Offers o ON co.Offer_ID = o.Offer_ID
INNER JOIN Customers c ON co.Cust_Fed_ID = c.Cust_Fed_ID
WHERE c.Cust_Fed_ID = '6049382751';





-- Get customer and placeholder details
SELECT 
   c.Cust_Fed_ID AS cust_fed_id,
   p.Placeholder_Guid AS placeholder_guid,
   p.Placeholder_Name AS placeholder_name,
   p.Channel_Name AS channel_name,
   p.Channel_Type AS channel_type,
   p.Placeholder_Offer_Limit AS placeholder_offer_limit,
   p.Placeholder_Meta AS placeholder_meta
FROM Customers c
INNER JOIN Placeholders p ON p.Placeholder_Guid = '55C5AA3B-AB8B-F011-9F57-64D69AE7FAE4'
WHERE c.Cust_Fed_ID = '6049382751';





-- Get default offers for a placeholder
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
FROM 	PlaceholderOffers po
INNER JOIN Placeholders p2 ON p2.Placeholder_ID = po.Placeholder_ID
INNER JOIN Offers o ON o.Offer_ID = po.Offer_ID
WHERE p2.Placeholder_Guid = '55C5AA3B-AB8B-F011-9F57-64D69AE7FAE4'
	AND o.Offer_Type = 'Default'
	AND o.Offer_Visibility_Flag = 1;





-- Get sum of views and click counts for last three days
SELECT
	Cust_Fed_ID,
	Offer_Guid,
	SUM(View_Count) AS Views3Days,
	SUM(Click_Count) AS Clicks3Days
FROM CustomerOfferStatsDaily
WHERE Stat_Date >= CAST(DATEADD(DAY, -2, CAST(GETDATE() AS DATE)) AS DATE)
GROUP BY Cust_Fed_ID, Offer_Guid





-- Get sum of views and click counts for last three days
WITH Stats3Days AS (
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
LEFT JOIN Stats3Days s ON co.Cust_Fed_ID = s.Cust_Fed_ID AND o.Offer_Guid = s.Offer_Guid
WHERE
	co.Cust_Fed_ID = '6049382751'
	AND p2.Placeholder_Guid = '55C5AA3B-AB8B-F011-9F57-64D69AE7FAE4'
	AND o.Offer_Visibility_Flag = 1
	AND ISNULL(s.Views3Days, 0) < o.Offer_View_Threshold
	AND ISNULL(s.Clicks3Days, 0) < o.Offer_Click_Threshold


	
	

--Outputs is a single JSON object containing alll the offers for that placeholder
   SELECT
        c.Cust_Fed_ID AS cust_fed_id,
        p.Placeholder_Guid AS placeholder_guid,
        p.Placeholder_Name AS placeholder_name,
        p.Channel_Name AS channel_name,
        p.Channel_Type  AS channel_type,
        p.Placeholder_Offer_Limit AS placeholder_offer_limit,
        p.Placeholder_Meta AS placeholder_meta
    FROM Customers c
        INNER JOIN CustomerOffers co ON c.cust_fed_id = co.cust_fed_id
        INNER JOIN Placeholders p ON p.Placeholder_Guid = '55C5AA3B-AB8B-F011-9F57-64D69AE7FAE4'
    WHERE c.cust_fed_id = '9283746150'
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    
--JSON Output of above quary after beautifying
{
    "cust_fed_id": "9283746150",
    "placeholder_guid": "55C5AA3B-AB8B-F011-9F57-64D69AE7FAE4",
    "placeholder_name": "Offer For You",
    "channel_name": "NLI",
    "channel_type": "Web",
    "placeholder_offer_limit": 2,
    "placeholder_meta": "{\"service_type\":\"Retail\",\"placeholder_description\":\"\"}"
}
                
                
               
         
