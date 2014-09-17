CREATE PROCEDURE [UpdateAccount]
	@HouseholdId int,
	@AccountId int,
	@Name nvarchar(50),
	@ParentId int
AS
	UPDATE Account SET
		Name = @Name,
		ParentId = @ParentId
		WHERE HouseholdId = @HouseholdId AND Id = @AccountId
RETURN 0
