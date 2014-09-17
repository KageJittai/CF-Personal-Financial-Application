CREATE PROCEDURE [DeleteAccount]
	@HouseholdId int,
	@AccountId int
AS

DECLARE @tempAccountId int
DECLARE @accountList TABLE (Id int);

INSERT INTO @accountList (Id) (SELECT * FROM AccountAndChildren(@HouseholdId, @AccountId) tbl)

DECLARE accountCursor CURSOR FOR
	SELECT id FROM @accountList

OPEN accountCursor

FETCH NEXT FROM accountCursor
INTO @tempAccountId

WHILE @@FETCH_STATUS = 0
BEGIN
	-- DELETE Activities where this account is the only one involved
	DELETE FROM [Transaction]
	WHERE HouseholdId = @HouseholdId AND 
	(
		(SourceAccount = @tempAccountId AND DestinationAccount IS NULL)
		OR
		(DestinationAccount = @tempAccountId AND SourceAccount IS NULL)
	)

	-- Remove references to this account in all other activities
	UPDATE [Transaction]
		SET SourceAccount = NULL
		WHERE HouseholdId = @HouseholdId AND SourceAccount = @tempAccountId

	UPDATE [Transaction]
		SET DestinationAccount = NULL
		WHERE HouseholdId = @HouseholdId AND DestinationAccount = @tempAccountId

	FETCH NEXT FROM accountCursor
	INTO @tempAccountId
END

DELETE FROM [Account]
	FROM [Account] a
	INNER JOIN @accountList al ON a.HouseholdId = @HouseholdId AND a.Id = al.Id

RETURN 0
