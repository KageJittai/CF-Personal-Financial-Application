CREATE PROCEDURE [CreateAccount]
	@HouseholdId int,
	@ParentId int = NULL,
	@Name nvarchar(50),
	@Catagory CHAR(3)
AS
	INSERT INTO Account
		(HouseholdId,  ParentId,  Name,  Catagory)
	VALUES
		(@HouseholdId, @ParentId, @Name, @Catagory)

RETURN 0
