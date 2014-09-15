CREATE PROCEDURE [dbo].[CreateUserLogin]
	@UserId int,
	@Provider NVARCHAR(50),
	@UserKey NVARCHAR(512)
AS

	INSERT INTO [UserLogin]
		(UserId, Provider, UserKey)
	VALUES
		(@UserId, @Provider, @UserKey)

RETURN 0
