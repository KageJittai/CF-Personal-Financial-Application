﻿CREATE PROCEDURE [GetHouseholdAccounts]
	@HouseholdId int
AS
	-- Super ugly, but works and is pretty fast
	
	SELECT
		a.Id Id,
		a.ParentId ParentId,
		a.Name Name,
		a.Catagory Catagory,

		SUM(CASE WHEN
			a.Id = t.SourceAccount OR
			a.Id = t.DestinationAccount THEN 1 ELSE 0 END) Transactions,

		SUM(CASE WHEN a.Id = t.SourceAccount THEN -t.Amount ELSE t.Amount END) Balance,

		SUM(CASE WHEN
			(a.Id = t.SourceAccount OR 
			 a.Id = t.DestinationAccount) AND 
			 t.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciled

		--SUM(CASE WHEN a.Id = t.DestinationAccount THEN 1 ELSE 0 END) NumberDestination,
		--SUM(CASE WHEN a.Id = t.DestinationAccount THEN t.Amount ELSE 0 END) DestinationSum,
		--SUM(CASE WHEN a.Id = t.DestinationAccount AND t.Reconciled = 0 THEN 1 ELSE 0 END) UnReconciledDestination

	FROM [Account] a
		LEFT JOIN [Transaction] t ON a.HouseholdId = t.HouseholdId AND
			(t.SourceAccount = a.Id OR t.DestinationAccount = a.Id)
		WHERE a.HouseholdId = @HouseholdId
		GROUP BY a.Id, a.ParentId, a.Name, a.Catagory
RETURN 0
