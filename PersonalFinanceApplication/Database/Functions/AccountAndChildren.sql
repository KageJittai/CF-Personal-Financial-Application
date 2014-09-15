CREATE FUNCTION [dbo].[AccountAndChildren]
(
	@AccountId int
)
RETURNS @returntable TABLE
(
	Id int
)
AS
BEGIN
	WITH SEARCH_CTE ( Id )
	AS
	(
		SELECT [Account].Id
		FROM [Account]
		WHERE Id = @AccountId

		UNION ALL

		SELECT [Account].Id
		FROM [Account]
		INNER JOIN SEARCH_CTE ON SEARCH_CTE.Id = [Account].ParentId
	)
	INSERT @returntable
	SELECT Id FROM SEARCH_CTE
	RETURN
END
