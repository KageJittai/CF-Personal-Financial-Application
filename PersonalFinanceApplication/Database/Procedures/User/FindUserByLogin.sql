CREATE PROCEDURE [dbo].[FindUserByLogin]
	@Provider NVARCHAR(50),
	@UserKey NVARCHAR(512)
AS
	SELECT
		u.Id Id,
		u.Email UserName,
		u.PasswordHash PasswordHash,
		u.FirstName FirstName,
		u.LastName LastName,
		u.HouseholdId HouseholdId

		FROM [UserLogin] ul
		INNER JOIN [User] u ON u.Id = ul.UserId
		WHERE ul.Provider = @Provider AND ul.UserKey = @UserKey

RETURN 0
