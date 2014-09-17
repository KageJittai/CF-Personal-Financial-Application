DECLARE @HouseholdId INT = 2

DECLARE @Income TABLE (Id INT)
DECLARE @Bank TABLE (Id INT)
DECLARE @Expenses TABLE (Id INT)

INSERT INTO @Income SELECT Id FROM [Account] WHERE ParentId IS NOT NULL AND HouseholdId = @HouseholdId AND Catagory = 'INC'
INSERT INTO @Bank SELECT Id FROM [Account] WHERE ParentId IS NOT NULL AND HouseholdId = @HouseholdId AND Catagory = 'AST'
INSERT INTO @Expenses SELECT Id FROM [Account] WHERE ParentId IS NOT NULL AND HouseholdId = @HouseholdId AND Catagory = 'EXP'

DECLARE @SrcTemp INT
DECLARE @DstTemp INT

SET NOCOUNT ON

DECLARE @c int = 0

WHILE @c < 1000
BEGIN

SELECT TOP 1 @SrcTemp = Id FROM @Income ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Bank ORDER BY NEWID()
INSERT INTO [Transaction] (HouseholdId, SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@HouseholdId, @SrcTemp, @DstTemp, [dbo].[RandomDate]('2010-01-01', CURRENT_TIMESTAMP, NEWID()), '', ROUND(RAND() * 500, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (HouseholdId, SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@HouseholdId, @SrcTemp, @DstTemp, [dbo].[RandomDate]('2010-01-01', CURRENT_TIMESTAMP, NEWID()), '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (HouseholdId, SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@HouseholdId, @SrcTemp, @DstTemp, [dbo].[RandomDate]('2010-01-01', CURRENT_TIMESTAMP, NEWID()), '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (HouseholdId, SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@HouseholdId, @SrcTemp, @DstTemp, [dbo].[RandomDate]('2010-01-01', CURRENT_TIMESTAMP, NEWID()), '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (HouseholdId, SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@HouseholdId, @SrcTemp, @DstTemp, [dbo].[RandomDate]('2010-01-01', CURRENT_TIMESTAMP, NEWID()), '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (HouseholdId, SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@HouseholdId, @SrcTemp, @DstTemp, [dbo].[RandomDate]('2010-01-01', CURRENT_TIMESTAMP, NEWID()), '', ROUND(RAND() * 100, 2))

set @c = @c + 1
END

PRINT N'Finished'