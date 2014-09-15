CREATE PROCEDURE [GetAccountTransactions]
	@HouseholdId int,
	@AccountId int
AS
	IF [dbo].[AccountHousehold](@AccountId) = @HouseholdId
	BEGIN
		SELECT  t.Id, SourceAccount, DestinationAccount, Amount, Date, Description
		FROM [Transaction] t
		INNER JOIN AccountAndChildren(@AccountId) ac ON DestinationAccount = ac.Id OR SourceAccount = ac.Id
	END
RETURN 0