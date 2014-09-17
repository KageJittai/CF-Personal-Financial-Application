CREATE FUNCTION [dbo].[AccountType]
(
	@HouseholdId int,
	@AccountId int
)
RETURNS CHAR(3)
AS
BEGIN
	DECLARE @type CHAR(3)

	SELECT @type = Catagory
		FROM [Account]
		WHERE HouseholdId = @HouseholdId AND Id = @AccountId

	RETURN @type
END
