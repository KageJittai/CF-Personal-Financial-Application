CREATE FUNCTION [dbo].[RandomDate]
(
	@date_from DATETIME, 
	@date_to DATETIME,
	@seed uniqueidentifier
)
RETURNS DATETIME
AS
BEGIN
DECLARE @ReturnValue DATETIME

-- Select random dates.
SELECT
    @ReturnValue = (
        -- Remember, we want to add a random number to the
        -- start date. In SQL we can add days (as integers)
        -- to a date to increase the actually date/time
        -- object value.
        @date_from +
        (
            -- This will force our random number to be GTE 0.
            ABS(
 
                -- This will give us a HUGE random number that
                -- might be negative or positive.
                CAST(
                    CAST( @seed AS BINARY(8) )
                    AS INT
                )
            )
 
            -- Our random number might be HUGE. We can't have
            -- exceed the date range that we are given.
            -- Therefore, we have to take the modulus of the
            -- date range difference. This will give us between
            -- zero and one less than the date range.
            %
 
            -- To get the number of days in the date range, we
            -- can simply substrate the start date from the
            -- end date. At this point though, we have to cast
            -- to INT as SQL will not make any automatic
            -- conversions for us.
            CAST(
                (@date_to - @date_from)
                AS INT
            )
        )
    )

	RETURN @ReturnValue
END
