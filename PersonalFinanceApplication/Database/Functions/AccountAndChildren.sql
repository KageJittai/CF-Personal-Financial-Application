CREATE FUNCTION [dbo].[AccountAndChildren]
(
	@HouseholdId int,
	@AccountId int
)
RETURNS @returntable TABLE ( Id int )
AS
BEGIN
	WITH SEARCH_CTE ( Id )
	AS
	(
		SELECT [Account].Id Id
		FROM [Account]
		WHERE HouseholdId = @HouseholdId AND Id = @AccountId

		UNION ALL

		SELECT [Account].Id Id
		FROM [Account]
		INNER JOIN SEARCH_CTE ON HouseholdId = @HouseholdId AND SEARCH_CTE.Id = [Account].ParentId
	)
	INSERT @returntable
	SELECT Id FROM SEARCH_CTE
	RETURN
END
