CREATE PROCEDURE [DeleteAccount]
	@HouseholdId int,
	@AccountId int
AS
IF [dbo].[AccountHousehold](@AccountId) = @HouseholdId
BEGIN
	DECLARE @tempAccountId int
	DECLARE @accountList TABLE (id int);

	INSERT INTO @accountList (id) (SELECT * FROM AccountAndChildren(@AccountId) tbl)

	DECLARE accountCursor CURSOR FOR
		SELECT id FROM @accountList

	OPEN accountCursor

	FETCH NEXT FROM accountCursor
	INTO @tempAccountId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- DELETE Activities where this account is the only one involved
		DELETE FROM [Transaction]
		WHERE
		(SourceAccount = @tempAccountId AND DestinationAccount IS NULL)
		OR
		(DestinationAccount = @tempAccountId AND SourceAccount IS NULL)

		-- Remove references to this account in all other activities
		UPDATE [Transaction]
		SET SourceAccount = NULL
		WHERE SourceAccount = @tempAccountId

		UPDATE [Transaction]
		SET DestinationAccount = NULL
		WHERE DestinationAccount = @tempAccountId

		FETCH NEXT FROM accountCursor
		INTO @tempAccountId
	END

	DELETE FROM [Account]
	FROM [Account] a
	INNER JOIN @accountList al ON al.id = a.Id
END
RETURN 0
