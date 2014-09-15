CREATE PROCEDURE [dbo].[UpdateUserLogin]
	@UserId int,
	@Provider NVARCHAR(50),
	@UserKey NVARCHAR(512)
AS
	UPDATE [UserLogin]
		SET UserKey = @UserKey
		WHERE UserId = @UserId AND Provider = @Provider

RETURN 0
