CREATE FUNCTION [dbo].[AccountHousehold]
(
	@AccountId int
)
RETURNS INT
AS
BEGIN
	DECLARE @householdId int

	SELECT @householdId = HouseholdId
	FROM Account
	WHERE Id = @AccountId

	RETURN @householdId
END
