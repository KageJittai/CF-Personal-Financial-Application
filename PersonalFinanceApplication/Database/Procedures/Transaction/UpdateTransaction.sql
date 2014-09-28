CREATE PROCEDURE [dbo].[UpdateTransaction]
	@HouseholdId INT,
	@Id INT,

	@SourceAccount INT = NULL,
	@DestinationAccount INT = NULL,
	@Amount MONEY,
	@Date DATE,
	@Description NVARCHAR(MAX),
	@Reconciled BIT
AS

UPDATE t SET
	SourceAccount = @SourceAccount,
	DestinationAccount = @DestinationAccount,
	Amount = @Amount,
	Date = @Date,
	Description = @Description,
	Reconciled = @Reconciled
FROM [Transaction] t
WHERE t.Id = @Id AND t.HouseholdId = @HouseholdId

RETURN 0
