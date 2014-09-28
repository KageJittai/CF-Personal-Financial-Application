CREATE PROCEDURE [DeleteHousehold]
	@HouseholdId int
AS
	DELETE FROM [Budget] WHERE HouseholdId = @HouseholdId
	DELETE FROM [Transaction] WHERE HouseholdId = @HouseholdId
	DELETE FROM [Account] WHERE HouseholdId = @HouseholdId
	DELETE FROM [Invite] WHERE HouseholdId = @HouseholdId

	UPDATE [User] SET HouseholdId = NULL WHERE HouseholdId = @HouseholdId

	DELETE FROM [Household] WHERE Id = @HouseholdId

RETURN 0
