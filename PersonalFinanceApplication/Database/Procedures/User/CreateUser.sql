CREATE PROCEDURE [CreateUser]
	@Id INT OUTPUT,
	@UserName NVARCHAR(50),
	@PasswordHash NVARCHAR(512),
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50)
AS
	INSERT INTO [User]
		(Email, PasswordHash, FirstName, LastName)
	VALUES
		(@UserName, @PasswordHash, @FirstName, @LastName)

	SET @Id = SCOPE_IDENTITY()

	EXECUTE CreateHousehold @Id, @LastName

RETURN 0
