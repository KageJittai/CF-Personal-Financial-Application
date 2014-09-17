CREATE PROCEDURE [GetTransactions]
	@HouseholdId int,
	@AccountId int
AS

SELECT  t.Id, SourceAccount, DestinationAccount, Amount, Date, Description
	FROM [Transaction] t
	WHERE HouseholdId = @HouseholdId AND
		(DestinationAccount = @AccountId OR SourceAccount = @AccountId)

RETURN 0