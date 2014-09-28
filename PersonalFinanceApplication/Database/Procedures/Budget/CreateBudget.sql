CREATE PROCEDURE [dbo].[CreateBudget]
	@HouseholdId int,
	@AccountId int,
	@Limit money,
	@StartDate Date,
	@EndDate Date
AS
	INSERT INTO Budget
		(HouseholdId, AccountId, Limit, StartDate, EndDate)
	VALUES
		(@HouseholdId, @AccountId, @Limit, @StartDate, @EndDate)

RETURN 0
