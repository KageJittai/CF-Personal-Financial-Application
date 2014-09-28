CREATE PROCEDURE [dbo].[UpdateBudget]
	@HouseholdId int,
	@Id int,
	@AccountId int,
	@Limit money,
	@StartDate date,
	@EndDate date
AS
	UPDATE Budget SET
		AccountId = @AccountId,
		Limit = @Limit,
		StartDate = @StartDate,
		EndDate = @EndDate
	WHERE
		HouseholdId = @HouseholdId AND
		Id = @Id

RETURN 0
