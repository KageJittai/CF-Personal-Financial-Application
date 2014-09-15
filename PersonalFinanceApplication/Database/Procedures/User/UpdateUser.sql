CREATE PROCEDURE [UpdateUser]
	@Id int,
	@PasswordHash NVARCHAR(512),
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50)
AS
	UPDATE [User] SET
		PasswordHash = ISNULL(@PasswordHash, PasswordHash),
		FirstName    = ISNULL(@FirstName, FirstName),
		LastName     = ISNULL(@LastName, LastName)
	WHERE Id = @Id

RETURN 0
