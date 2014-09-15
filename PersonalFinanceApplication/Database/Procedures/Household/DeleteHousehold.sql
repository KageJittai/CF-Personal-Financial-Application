CREATE PROCEDURE [DeleteHousehold]
	@HouseholdId int
AS
	DELETE t FROM [Transaction] t
		INNER JOIN Account a ON t.SourceAccount = a.Id OR t.DestinationAccount = a.Id
		WHERE a.HouseholdId = @HouseholdId

	DELETE FROM [Account] WHERE HouseholdId = @HouseholdId
	DELETE FROM [Invite] WHERE HouseholdId = @HouseholdId

	UPDATE [User] SET HouseholdId = NULL WHERE HouseholdId = @HouseholdId

	DELETE FROM [Household] WHERE Id = @HouseholdId

RETURN 0
