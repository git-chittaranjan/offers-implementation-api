

CREATE OR ALTER PROCEDURE InsertBit
    @Fed_ID            VARCHAR(100) = NULL,
    @Offer_Guid        UNIQUEIDENTIFIER = NULL,
    @Offer_Name        VARCHAR(100) = NULL,
    @Bit_Type          VARCHAR(100),   -- mandatory
    @Channel_Name      VARCHAR(100) = NULL,
    @Placeholder_Guid  UNIQUEIDENTIFIER = NULL, -- fixed typo
    @Placeholder_Name  VARCHAR(100) = NULL,
    @InsertedBitGuid   UNIQUEIDENTIFIER OUTPUT, -- return newly inserted GUID
    @StatusCode        INT OUTPUT,              -- 0 = Success, -1 = Error
    @ErrorMessage      NVARCHAR(4000) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
    
    	DECLARE @NewGuid TABLE (Bit_Guid UNIQUEIDENTIFIER);
    
        -- Insert without specifying Bit_Guid (default NEWSEQUENTIALID() will generate it)
        INSERT INTO Bits
        (
            Fed_ID,
            Offer_Guid,
            Offer_Name,
            Bit_Type,
            Channel_Name,
            Placeholder_Guid,
            Placeholder_Name
        )
        OUTPUT INSERTED.Bit_Guid INTO @NewGuid  -- capture and insert auto-generated GUID into temp table
        VALUES
        (
            @Fed_ID,
            @Offer_Guid,
            @Offer_Name,
            @Bit_Type,
            @Channel_Name,
            @Placeholder_Guid,
            @Placeholder_Name
        );

        -- Success
        -- Set the output variable from the table variable
        SELECT TOP 1 @InsertedBitGuid = Bit_Guid FROM @NewGuid;
        SET @StatusCode = 0;
        SET @ErrorMessage = NULL;
    END TRY
    BEGIN CATCH
        SET @InsertedBitGuid = NULL;
        SET @StatusCode = -1;
        SET @ErrorMessage = ERROR_MESSAGE();
    END CATCH
END;



-- ============================================= SP Execution =============================================

DECLARE @InsertedBitGuid UNIQUEIDENTIFIER, 
        @StatusCode INT, 
        @ErrorMessage NVARCHAR(4000);

EXEC InsertBit
    @Fed_ID = '8391046275',
    @Offer_Guid = 'F8E26247-5587-F011-9F57-64D69AE7FAE4',
    @Offer_Name = 'Gold Loan Offer',
    @Bit_Type = 'VIEW',
    @Channel_Name = 'NLI',
    @Placeholder_Guid = '52C5AA3B-AB8B-F011-9F57-64D69AE7FAE4',
    @Placeholder_Name = 'Home Page Banner',
    @InsertedBitGuid = @InsertedBitGuid OUTPUT,
    @StatusCode = @StatusCode OUTPUT,
    @ErrorMessage = @ErrorMessage OUTPUT;

SELECT @InsertedBitGuid AS BitGuid, @StatusCode AS StatusCode, @ErrorMessage AS ErrorMessage;


