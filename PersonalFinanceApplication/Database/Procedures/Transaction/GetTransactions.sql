﻿CREATE PROCEDURE [GetTransactions]
	@HouseholdId int,
	@AccountId int,

	@Skip int = NULL,
	@Top int = NULL,

	@StartDate date = NULL,
	@EndDate date = NULL,

	@LowerAmount money = NULL,
	@UpperAmount money = NULL,

	@ReconciledStatus bit = NULL,

	@Description nvarchar(max) = NULL,

	@OrderBy nvarchar(20) = NULL
AS

SET @Skip = ISNULL(@Skip, 0)
SET @Top = ISNULL(@Top, 10)

SELECT
	Id, SourceAccount, DestinationAccount, Amount, Date, Description, Reconciled
	FROM [Transaction]

	-- Account Search
	WHERE HouseholdId = @HouseholdId AND
		(DestinationAccount = @AccountId OR SourceAccount = @AccountId) AND

	-- Date
		(@StartDate IS NULL OR [Date] >= @StartDate) AND
		(@EndDate IS NULL OR [Date] <= @EndDate) AND

	-- Amount
		(@LowerAmount IS NULL OR Amount >= @LowerAmount) AND
		(@UpperAmount IS NULL OR Amount <= @UpperAmount) AND

	-- Description
		(@Description IS NULL OR [Description] LIKE '%' + @Description + '%') AND

	-- Reconciled
		(@ReconciledStatus IS NULL OR Reconciled = @ReconciledStatus)

	ORDER BY
		CASE WHEN @OrderBy = 'DateA' THEN [Date] END ASC,
		CASE WHEN @OrderBy = 'DateD' THEN [Date] END DESC,

		CASE WHEN @OrderBy = 'AmountA' THEN Amount END ASC,
		CASE WHEN @OrderBy = 'AmountD' THEN Amount END DESC,

		-- Default sorting
		[Date] DESC

	OFFSET @Skip ROWS FETCH NEXT @Top ROWS ONLY

RETURN 0