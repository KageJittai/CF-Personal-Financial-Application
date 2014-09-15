CREATE PROCEDURE [FindUser]
	@Id int = NULL,
	@Email NVARCHAR(50) = NULL
AS
	SELECT 
		u.Id Id,
		u.Email UserName,
		u.PasswordHash PasswordHash,
		u.FirstName FirstName,
		u.LastName LastName,
		u.HouseholdId HouseholdId
		FROM [User] u
		WHERE u.Id = @Id OR u.Email = @Email
RETURN 0
