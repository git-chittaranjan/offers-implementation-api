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



-- Active customer offers + default offers
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



