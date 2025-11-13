

CREATE OR ALTER FUNCTION fn_IsPlaceholderValid
(
    @Placeholder_Guid UNIQUEIDENTIFIER
)
RETURNS INT
AS
BEGIN
  DECLARE @Result INT = 0;

-- EXISTS: checks if subquery returns at least one row (TRUE if yes, FALSE if no)
-- IF EXISTS: run BEGIN...END only if matching rows exist, else go to ELSE
  IF EXISTS (SELECT 1 FROM Placeholders WHERE Placeholder_Guid = @Placeholder_Guid)
    BEGIN
        -- Placeholder exists
        IF EXISTS (
            SELECT 1
            FROM Placeholders
            WHERE Placeholder_Guid = @Placeholder_Guid
              AND Placeholder_Is_Active = 1
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
SET @Status = dbo.fn_IsPlaceholderValid('54C5AA3B-AB8B-F011-9F57-64D69AE7FAE4');
    
SELECT @Status AS PlaceholderStatus;

IF @Status = 1
    PRINT 'Placeholder exists and is active.';
ELSE IF @Status = 2
    PRINT 'Placeholder exists but is inactive.';
ELSE
    PRINT 'Placeholder does not exist.';



