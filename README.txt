

GetOfferResponse
===================================================
cust_fed_id,
placeholder_guid,
placeholder_name,
channel_name,
channel_type,
placeholder_offer_limit,
placeholder_meta{},
offers
[
{
	offer_guid
	offer_name
	offer_description
	offer_type
	offer_priority
	offer_view_threshold
	offer_click_threshold
	offer_banner_type
	offer_content{}
	offer_extra_content{}
	offer_meta{}
},
{
	offer_guid
	offer_name
	offer_description
	offer_type
	offer_priority
	offer_view_threshold
	offer_click_threshold
	offer_banner_type
	offer_content{}
	offer_extra_content{}
	offer_meta{}
},
{
	offer_guid
	offer_name
	offer_description
	offer_type
	offer_priority
	offer_view_threshold
	offer_click_threshold
	offer_banner_type
	offer_content{}
	offer_extra_content{}
	offer_meta{}
}
]




Test cases -
1. Check if customer exists/valid
2. Check if placeholder exists/valid
3. Check for empty offer
4. Apply placeholder offer limit
5. Check for active flag for customer, offer placeholder table
6. Offer Viewed and Offer clicked are less than the threshold
7. Placeholder default offer handling
8. Counter will count for last three days



















