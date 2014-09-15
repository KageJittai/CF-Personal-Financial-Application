CREATE PROCEDURE [GetAccountBalance]
	@HouseholdId int,
	@AccountId int,
	@StartDate date = NULL,
	@EndDate date = NULL
AS

IF [dbo].[AccountHousehold](@AccountId) = @HouseholdId
BEGIN
	SET @StartDate = ISNULL(@StartDate, '1600-01-01')
	SET @EndDate = ISNULL(@EndDate, GETDATE())

	DECLARE @TempTable TABLE (Id int)

	INSERT INTO @TempTable SELECT Id FROM AccountAndChildren(@AccountId)

	SELECT SUM(Amount) Balance, COUNT(*) NumberOfTransactions
	FROM
	(
		SELECT Amount Amount
		FROM [Transaction]
		INNER JOIN @TempTable ac ON DestinationAccount = ac.Id
		AND [Transaction].[Date] >= @StartDate AND [Transaction].[Date] <= @EndDate

		UNION ALL
	
		SELECT -Amount Amount
		FROM [Transaction]
		INNER JOIN @TempTable ac ON SourceAccount = ac.Id
		AND [Transaction].[Date] >= @StartDate AND [Transaction].[Date] <= @EndDate
	) tbl
END

RETURN 0
