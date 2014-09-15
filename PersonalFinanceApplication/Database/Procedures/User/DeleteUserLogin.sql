CREATE PROCEDURE [dbo].[DeleteUserLogin]
	@UserId int,
	@Provider NVARCHAR(50)
AS
	DELETE FROM [UserLogin]
		WHERE UserId = @UserId AND Provider = @Provider
RETURN 0
