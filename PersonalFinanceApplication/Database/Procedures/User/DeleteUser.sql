CREATE PROCEDURE [DeleteUser]
	@Id int
AS
	DECLARE @HouseholdId INT
	DECLARE @HouseholdCount INT

	SELECT @HouseholdId = HouseholdId FROM [User] WHERE Id = @Id

	DELETE FROM [UserLogin] WHERE UserId = @Id
	DELETE FROM [User] WHERE Id = @Id
	DELETE FROM [Invite] WHERE SenderId = @Id

	SELECT @HouseholdCount = COUNT(*) FROM [User] WHERE HouseholdId = @HouseholdId

	IF @HouseholdCount = 0
		EXECUTE DeleteHousehold @HouseholdId
RETURN 0
