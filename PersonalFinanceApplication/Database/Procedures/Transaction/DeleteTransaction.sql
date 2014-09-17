CREATE PROCEDURE [DeleteTransaction]
	@HouseholdId int,
	@TransactionId int

AS

DELETE FROM [Transaction] WHERE HouseholdId = @HouseholdId AND Id = @TransactionId

RETURN 0
