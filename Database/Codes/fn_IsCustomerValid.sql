

CREATE OR ALTER FUNCTION fn_IsCustomerValid
(
    @Cust_Fed_ID VARCHAR(100)
)
RETURNS INT
AS
BEGIN
  DECLARE @Result INT = 0;

-- EXISTS: checks if subquery returns at least one row (TRUE if yes, FALSE if no)
-- IF EXISTS: run BEGIN...END only if matching rows exist, else go to ELSE
  IF EXISTS (SELECT 1 FROM Customers WHERE Cust_Fed_ID = @Cust_Fed_ID)
    BEGIN
        -- Customer exists
        IF EXISTS (
            SELECT 1
            FROM Customers
            WHERE Cust_Fed_ID = @Cust_Fed_ID
              AND Cust_Is_Active = 1
        )
        BEGIN
            SET @Result = 1; -- Exists & Active
        END
        ELSE
        BEGIN
            SET @Result = 0; -- Exists but Inactive
        END
    END
    ELSE
    BEGIN
        SET @Result = -1; -- Not Found
    END

    RETURN @Result;
END;


-- ============================================= Function Execution =============================================

DECLARE @Status INT;
SET @Status = dbo.fn_IsCustomerValid('715290384');
    
SELECT @Status AS CustomerStatus;

IF @Status = 1
    PRINT 'Customer exists and is active.';
ELSE IF @Status = 0
    PRINT 'Customer exists but is inactive.';
ELSE
    PRINT 'Customer does not exist.';




