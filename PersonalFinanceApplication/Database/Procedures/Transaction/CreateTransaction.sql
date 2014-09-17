CREATE PROCEDURE [CreateTransaction]
	@HouseholdId INT,
	@SourceAccount INT = NULL,
	@DestinationAccount INT = NULL,
	@Amount MONEY,
	@Date DATE,
	@Description NVARCHAR(MAX)

AS

INSERT INTO [Transaction]
	(HouseholdId, SourceAccount, DestinationAccount, Amount, Date, Description)
VALUES
	(@HouseholdId, @SourceAccount, @DestinationAccount, @Amount, @Date, @Description)

RETURN 0
