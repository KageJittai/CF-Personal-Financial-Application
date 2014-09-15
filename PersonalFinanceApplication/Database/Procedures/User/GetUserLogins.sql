CREATE PROCEDURE [dbo].[GetUserLogins]
	@UserId INT
AS
	SELECT UserId, Provider, UserKey
		FROM [UserLogin]
		WHERE UserId = @UserId

RETURN 0
