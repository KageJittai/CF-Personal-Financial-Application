SELECT * FROM [Household]
SELECT * FROM [Account]
SELECT * FROM [Transaction]

SELECT t.Date, t.Description, t.Amount, sa.Name as [From], sa.Description, da.Name as [To], da.Description
FROM [Transaction] t
LEFT JOIN [Account] sa ON sa.HouseholdId = t.HouseholdId and sa.Id = t.SourceAccount
LEFT JOIN [Account] da ON da.HouseholdId = t.HouseholdId and da.Id = t.DestinationAccount

SELECT * FROM [Account] a
INNER JOIN AccountAndChildren(2, 7) ac ON a.Id = ac.Id

EXECUTE GetHouseholodAccounts 1

EXECUTE GetAccountBalance 1, 2

SELECT * FROM AccountAndChildren(1, 3)

EXECUTE GetAccountActivity 1, 1

SELECT * FROM [Account] a
INNER JOIN AccountAndChildren(1, 16) t ON a.Id = t.Id

EXECUTE DeleteAccount 1, 2
EXECUTE DeleteHousehold 1

SELECT * FROM [Account]

DECLARE @Temp DATE = GETDATE()
EXECUTE CreateTransaction 1, 2, 3, 234.34, @Temp, 'Test';

		INSERT INTO [Transaction]
			(SourceAccount, DestinationAccount, Amount, Date, Description)
		VALUES
			(1, 2, 32.53, GETDATE(), 'Test')


EXECUTE DeleteTransaction 2, 12

DECLARE @HouseholdId INT = 1;

	SELECT
		a.Id Id,
		a.ParentId ParentId,
		a.Name Name,
		a.Catagory Catagory,

		SUM(CASE WHEN a.Id = t.SourceAccount THEN 1 ELSE 0 END) NumberSource,
		SUM(CASE WHEN a.Id = t.SourceAccount THEN t.Amount ELSE 0 END) SourceSum,
		SUM(CASE WHEN a.Id = t.SourceAccount AND t.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciledSource,

		SUM(CASE WHEN a.Id = t.DestinationAccount THEN 1 ELSE 0 END) NumberDestination,
		SUM(CASE WHEN a.Id = t.DestinationAccount THEN t.Amount ELSE 0 END) DestinationSum,
		SUM(CASE WHEN a.Id = t.DestinationAccount AND t.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciledDestination

	FROM [Account] a
	LEFT JOIN [Transaction] t ON t.SourceAccount = a.Id OR t.DestinationAccount = a.Id
	WHERE a.HouseholdId = @HouseholdId
	GROUP BY a.Id, a.ParentId, a.Name, a.Catagory

	SELECT
		Id Id,
		ParentId ParentId,
		Name Name,
		Catagory Catagory,

		COUNT(SId) NumberSource,
		SUM(SAmount) SourceSum,
		SUM(CASE WHEN SReconciled = 0 THEN 1 ELSE 0 END) UnReconciledSource,

		COUNT(DId) NumberDestination,
		SUM(DAmount) DestinationSum,
		SUM(CASE WHEN DReconciled = 0 THEN 1 ELSE 0 END) UnReconciledDestination
	FROM
	(
	SELECT
		a.Id Id,
		a.ParentId,
		a.Name Name,
		a.Catagory Catagory,
		a.HouseholdId,

		sa.Id SId,
		sa.Amount SAmount,
		sa.Reconciled SReconciled,

		NULL AS DId,
		NULL AS DAmount ,
		NULL AS DReconciled

		FROM [Account] a LEFT JOIN [Transaction] sa ON sa.SourceAccount = a.Id
		WHERE a.HouseholdId = @HouseholdId

	UNION ALL

	SELECT
		a.Id Id,
		a.ParentId,
		a.Name Name,
		a.Catagory Catagory,
		a.HouseholdId,

		NULL AS SId,
		NULL AS SAmount,
		NULL AS SReconciled,

		da.Id DId,
		da.Amount DAmount,
		da.Reconciled DReconciled

		FROM [Account] a LEFT JOIN [Transaction] da ON da.DestinationAccount = a.Id
		WHERE a.HouseholdId = @HouseholdId
	) tbl
	WHERE HouseholdId = @HouseholdId
	GROUP BY Id, ParentId, Name, Catagory

	SELECT
        a.Id Id,
        a.ParentId ParentId,
        a.Name Name,
        a.Catagory Catagory,

		sa.Id,
		da.Id

 
        --COUNT(sa.SourceAccount) NumberSource,
        --SUM(sa.Amount) SourceSum,
        --SUM(CASE WHEN sa.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciledSource,
 
        --COUNT(da.SourceAccount) NumberDestination,
        --SUM(da.Amount) DestinationSum,
        --SUM(CASE WHEN da.Reconciled IS NOT NULL AND da.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciledDestination
 
FROM [Account] a
LEFT JOIN [Transaction] sa ON sa.SourceAccount = a.Id
LEFT JOIN [Transaction] da ON da.DestinationAccount = a.Id
WHERE HouseholdId = 1 AND a.Id = 2
GROUP BY a.Id, a.ParentId, a.Name, a.Catagory


                SELECT
                a.Id Id,
                a.ParentId ParentId,
                a.Name Name,
                a.Catagory Catagory,
 
                SUM(CASE WHEN sa.SourceAccount IS NOT NULL THEN 1 ELSE 0 END)  NumberSource,
                SUM(sa.Amount) SourceSum,
                SUM(CASE WHEN sa.SourceAccount IS NOT NULL AND sa.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciledSource,
 
                SUM(CASE WHEN da.DestinationAccount IS NOT NULL THEN 1 ELSE 0 END) NumberDestination,
                SUM(da.Amount) DestinationSum,
                SUM(CASE WHEN da.DestinationAccount IS NOT NULL AND da.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciledDestination
 
        FROM [Account] a
        LEFT JOIN [Transaction] sa ON sa.SourceAccount = a.Id
        LEFT JOIN [Transaction] da ON da.DestinationAccount = a.Id
        WHERE HouseholdId = 1
        GROUP BY a.Id, a.ParentId, a.Name, a.Catagory

DECLARE @startDate DATE
DECLARE @endDate DATE
DECLARE @AccountId INT = 2
SET @startDate = ISNULL(@startDate, '1600-01-01')
SET @endDate = ISNULL(@endDate, GETDATE())


SELECT SUM(Amount) Balance, COUNT(*) NumberOfTransactions
FROM
(
	SELECT Amount Amount
	FROM [Transaction]
	INNER JOIN AccountAndChildren(@AccountId) ac ON DestinationAccount = ac.Id
	AND [Transaction].[Date] >= @startDate AND [Transaction].[Date] <= @endDate

	UNION ALL
	
	SELECT -Amount Amount
	FROM [Transaction]
	INNER JOIN AccountAndChildren(@AccountId) ac ON SourceAccount = ac.Id
	AND [Transaction].[Date] >= @startDate AND [Transaction].[Date] <= @endDate
) tbl


DECLARE @Table TABLE (amount int NULL)

INSERT INTO @Table (amount) VALUES (10)
INSERT INTO @Table (amount) VALUES (NULL)

SELECT ISNULL(SUM(amount), 0) FROM @Table


DECLARE @endtime date = SYSDATETIME()
DECLARE @starttime date = DATEADD(month, -1, @endtime)
--EXECUTE CreateBudget 3, 1055, 150.00, @starttime, @endtime
--EXECUTE DeleteBudget 3, 4

EXECUTE GetBudgets 3
EXECUTE GetTransactions 3, NULL, 1055, 0, 100, @starttime, @endtime, NULL, NULL, NULL, NULL, '-Date'

DECLARE @HouseholdId int = 3
DECLARE @Id int = 3
DECLARE @AccountId int

SELECT @AccountId = b.AccountId
	FROM Budget b
	WHERE b.HouseholdId = @HouseholdId AND b.Id = @Id

SELECT b.Id Id, Limit, StartDate, EndDate, SUM(t.Amount) CurrentSum
	FROM Budget b
		LEFT JOIN [Transaction] t
			ON t.HouseholdId = @HouseholdId
		RIGHT JOIN AccountAndChildren(@HouseholdId, @AccountId) tt
			ON tt.Id = t.DestinationAccount
	WHERE b.HouseholdId = @HouseholdId AND b.Id = @Id AND
		  (t.[Date] >= b.StartDate AND t.[Date] <= b.EndDate)
	GROUP BY b.Id, Limit, StartDate, EndDate


SELECT * FROM
	Budget b,
	(SELECT SUM(Amount) Balance, COUNT(*) NumberOfTransactions
		FROM
		(
			SELECT Amount Amount
			FROM [Transaction]
			INNER JOIN @TempTable ac ON HouseholdId = @HouseholdId AND DestinationAccount = ac.Id
			AND [Transaction].[Date] >= @StartDate AND [Transaction].[Date] <= @EndDate

			UNION ALL
	
			SELECT -Amount Amount
			FROM [Transaction]
			INNER JOIN @TempTable ac ON HouseholdId = @HouseholdId AND SourceAccount = ac.Id
			AND [Transaction].[Date] >= @StartDate AND [Transaction].[Date] <= @EndDate
		)
	) t

EXECUTE GetBudgetDetails 3, 3
EXECUTE CreateBudget 3, 10604, 599, '2013-6-1', '2013-6-30'
EXECUTE GetBudgets 3

DECLARE @HouseholdId INT = 3

--SELECT
--	b.Id Id,
--	b.AccountId AccountId,
--	Limit,
--	StartDate,
--	EndDate,
--	SUM(t.Amount) CurrentSum
--FROM Budget b
--	INNER JOIN AccountAndChildren(@HouseholdId, b.AccountId) tt ON 1 = 1
--	LEFT JOIN [Transaction] t
--		ON t.HouseholdId = @HouseholdId AND tt.Id = t.DestinationAccount
--WHERE
--	b.HouseholdId = @HouseholdId AND
--	(t.[Date] >= b.StartDate AND t.[Date] <= b.EndDate)
--GROUP BY
--	b.Id,
--	b.AccountId,
--	Limit,
--	StartDate,
--	EndDate

DECLARE @HouseholdId INT = 3;

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
	c.SourceId AccoundId,
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

