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



-- Active customer offers + default offers with UNION 
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
WHERE c.Cust_Fed_ID = '4839201746'
  AND p.Placeholder_ID = 1
  AND c.Cust_Is_Active = 1
  AND o.Offer_Visibility_Flag = 1
  AND p.Placeholder_Is_Active = 1

UNION

SELECT
    '4839201746' AS Cust_Fed_ID,
    o.Offer_Name,
    p.Placeholder_Name,
    p.Channel_Name
FROM PlaceholderOffers po
INNER JOIN Placeholders p ON p.Placeholder_ID = po.Placeholder_ID
INNER JOIN Offers o ON o.Offer_ID = po.Offer_ID
WHERE p.Placeholder_ID = 1
  AND o.Offer_Type = 'Default'
  AND o.Offer_Visibility_Flag = 1
  AND p.Placeholder_Is_Active = 1;



            
                
            SELECT
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
                INNER JOIN Customers c ON co.Cust_Fed_ID = c.Cust_Fed_ID
                INNER JOIN PlaceholderOffers po ON o.Offer_ID  = po.Offer_ID
                INNER JOIN Placeholders p ON po.Placeholder_ID = p.Placeholder_ID
            WHERE co.Cust_Fed_ID = '9283746150'
                AND p.Placeholder_Guid = '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4'
            FOR JSON PATH      
                
                
                
        
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
    
    
                
SELECT
    c.Cust_Fed_ID AS cust_fed_id,
    p.Placeholder_Guid AS placeholder_guid,
    p.Placeholder_Name AS placeholder_name,
    p.Channel_Name AS channel_name,
    p.Channel_Type  AS channel_type,
    p.Placeholder_Offer_Limit AS placeholder_offer_limit,
    p.Placeholder_Meta AS placeholder_meta
FROM Customers c
INNER JOIN Placeholders p 
    ON p.Placeholder_Guid = '55C5AA3B-AB8B-F011-9F57-64D69AE7FAE4'
WHERE c.cust_fed_id = '9283746150'
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER               
                
                
               
         
