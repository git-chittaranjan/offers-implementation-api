
CREATE TRIGGER trg_UpdateClickViewStatusDaily
ON Bits
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    MERGE CustomerOfferStatsDaily AS target
    USING (
        SELECT 
            CAST(Action_Timestamp AS DATE) AS Stat_Date,
            Cust_Fed_ID,
            Offer_Guid,
            SUM(CASE WHEN Bit_Type='VIEW' THEN 1 ELSE 0 END) AS ViewCnt,
            SUM(CASE WHEN Bit_Type='CLICK' THEN 1 ELSE 0 END) AS ClickCnt
        FROM inserted
        GROUP BY CAST(Action_Timestamp AS DATE), Cust_Fed_ID, Offer_Guid
    ) AS src
    ON (target.Stat_Date = src.Stat_Date 
        AND target.Cust_Fed_ID = src.Cust_Fed_ID 
        AND target.Offer_Guid = src.Offer_Guid)
    WHEN MATCHED THEN
        UPDATE SET 
            View_Count  = target.View_Count  + src.ViewCnt,
            Click_Count = target.Click_Count + src.ClickCnt
    WHEN NOT MATCHED THEN
        INSERT (Stat_Date, Cust_Fed_ID, Offer_Guid, View_Count, Click_Count)
        VALUES (src.Stat_Date, src.Cust_Fed_ID, src.Offer_Guid, src.ViewCnt, src.ClickCnt);
END;










