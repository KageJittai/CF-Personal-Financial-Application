﻿DECLARE @HouseholdId INT = 5

DECLARE @Income TABLE (Id INT)
DECLARE @Bank TABLE (Id INT)
DECLARE @Expenses TABLE (Id INT)

INSERT INTO @Income SELECT Id FROM [Account] WHERE HouseholdId = @HouseholdId AND Catagory = 'INC'
INSERT INTO @Bank SELECT Id FROM [Account] WHERE HouseholdId = @HouseholdId AND Catagory = 'AST'
INSERT INTO @Expenses SELECT Id FROM [Account] WHERE HouseholdId = @HouseholdId AND Catagory = 'EXP'

DECLARE @SrcTemp INT
DECLARE @DstTemp INT

DECLARE @c int = 0

WHILE @c < 1000
BEGIN

SELECT TOP 1 @SrcTemp = Id FROM @Income ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Bank ORDER BY NEWID()
INSERT INTO [Transaction] (SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@SrcTemp, @DstTemp, CURRENT_TIMESTAMP, '', ROUND(RAND() * 550, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@SrcTemp, @DstTemp, CURRENT_TIMESTAMP, '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@SrcTemp, @DstTemp, CURRENT_TIMESTAMP, '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@SrcTemp, @DstTemp, CURRENT_TIMESTAMP, '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@SrcTemp, @DstTemp, CURRENT_TIMESTAMP, '', ROUND(RAND() * 100, 2))

SELECT TOP 1 @SrcTemp = Id FROM @Bank ORDER BY NEWID()
SELECT TOP 1 @DstTemp = Id FROM @Expenses ORDER BY NEWID()
INSERT INTO [Transaction] (SourceAccount, DestinationAccount, Date, Description, Amount)
              VALUES (@SrcTemp, @DstTemp, CURRENT_TIMESTAMP, '', ROUND(RAND() * 100, 2))

set @c = @c + 1
END
