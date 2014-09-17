CREATE PROCEDURE [GetAccountTransactions]
	@HouseholdId int,
	@AccountId int
AS
SELECT  t.Id, SourceAccount, DestinationAccount, Amount, Date, Description
FROM [Transaction] t
	INNER JOIN AccountAndChildren(@HouseholdId, @AccountId) ac ON 
		(DestinationAccount = ac.Id OR SourceAccount = ac.Id)
	WHERE t.HouseholdId = @HouseholdId

RETURN 0