CREATE PROCEDURE [CreateTransaction]
	@HouseholdId INT,
	@SourceAccount INT = NULL,
	@DestinationAccount INT = NULL,
	@Amount MONEY,
	@Date DATE,
	@Description NVARCHAR(MAX)

AS
	IF [dbo].[AccountHousehold](@SourceAccount) = @HouseholdId
	BEGIN
		INSERT INTO [Transaction]
			(SourceAccount, DestinationAccount, Amount, Date, Description)
		VALUES
			(@SourceAccount, @DestinationAccount, @Amount, @Date, @Description)
	END
RETURN 0
