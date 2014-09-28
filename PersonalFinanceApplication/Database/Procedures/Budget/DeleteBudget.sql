CREATE PROCEDURE [dbo].[DeleteBudget]
	@HouseholdId int,
	@Id int
AS
	DELETE FROM
		Budget
	WHERE
		HouseholdId = @HouseholdId AND
		Id = @Id

RETURN 0
