CREATE PROCEDURE [UpdateAccount]
	@HouseholdId int,
	@AccountId int,
	@NewName nvarchar(50)
AS
	UPDATE Account
		SET Name = @NewName
		WHERE Id = @AccountId AND HouseholdId = @HouseholdId
RETURN 0
