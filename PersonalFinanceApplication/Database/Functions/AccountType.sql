CREATE FUNCTION [dbo].[AccountType]
(
	@AccountId int,
	@Type1 CHAR(3),
	@Type2 CHAR(3) = NULL
)
RETURNS INT
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*)
	FROM [Account]
	WHERE Id = @AccountId
	AND (Catagory = @Type1 OR Catagory = @Type2)

	RETURN @count
END
