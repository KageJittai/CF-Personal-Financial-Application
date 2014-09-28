CREATE PROCEDURE [dbo].[GetBudget]
	@HouseholdId int
AS
WITH CTE ( Id, SourceId, AccountId, Limit, StartDate, EndDate )
AS
(
	SELECT 
		b.Id Id,
		b.AccountId SourceId,
		b.AccountId AccountId,
		Limit,
		StartDate,
		EndDate
	FROM [Budget] b
	WHERE HouseholdId = @HouseholdId

	UNION ALL

	SELECT
		b.Id,
		b.SourceId SourceId,
		a.Id,
		b.Limit,
		b.StartDate,
		b.EndDate
	FROM [Account] a
	INNER JOIN CTE b ON HouseholdId = @HouseholdId AND b.AccountId = a.ParentId
)
SELECT
	c.Id Id,
	c.SourceId AccountId,
	c.Limit Limit,
	c.StartDate StartDate,
	c.EndDate EndDate,
	CAST(SUM(CASE 
		WHEN t.Amount IS NULL
			THEN 0 
			ELSE t.Amount
	END) AS MONEY) CurrentSum,
	(CASE 
		WHEN c.StartDate <= SYSDATETIME() AND
			 c.EndDate >= SYSDATETIME()
		THEN 1
		ELSE 0
	END) Active
FROM
	CTE c
	LEFT JOIN [Transaction] t
		ON	t.HouseholdId = @HouseholdId AND
			t.DestinationAccount = c.AccountId AND
			t.[Date] >= c.StartDate AND t.[Date] <= c.EndDate
GROUP BY
	c.Id, c.SourceId, c.Limit, c.StartDate, c.EndDate
RETURN 0
