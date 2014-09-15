CREATE PROCEDURE [DeleteTransaction]
	@HouseholdId int,
	@TransactionId int

AS

DELETE t FROM [Transaction] t
	INNER JOIN [Account] a ON a.Id = t.SourceAccount OR a.Id = t.DestinationAccount
	WHERE a.HouseholdId = @HouseholdId AND t.Id = @TransactionId

RETURN 0
