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