CREATE PROCEDURE [dbo].[UpdateTransaction]
	@HouseholdId INT,
	@TransactionId INT,

	@NewSourceAccount INT = NULL,
	@NewDestinationAccount INT = NULL,
	@NewAmount MONEY,
	@NewDate DATE,
	@NewDescription NVARCHAR(MAX)
AS

UPDATE t SET
	SourceAccount = @NewSourceAccount,
	DestinationAccount = @NewDestinationAccount,
	Amount = @NewAmount,
	Date = @NewDate,
	Description = @NewDescription
FROM [Transaction] t
INNER JOIN [Account] a ON a.HouseholdId = t.HouseholdId AND
	(a.Id = t.SourceAccount OR a.Id = t.DestinationAccount)
WHERE t.Id = @TransactionId AND a.HouseholdId = @HouseholdId

RETURN 0
