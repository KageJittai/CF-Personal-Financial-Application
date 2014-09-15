CREATE PROCEDURE [CreateHousehold]
	@UserId INT,
	@Name NVARCHAR(50)
AS
DECLARE @HouseholdId int

DECLARE @IncomeId int
DECLARE @BankId int
DECLARE @ExpensesId int
DECLARE @TaxId int

DECLARE @Subtemp int

INSERT INTO [Household] (Name) VALUES (@Name)

set @HouseholdId = SCOPE_IDENTITY()

-- Core
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, NULL, 'Income', 'INC')
set @IncomeId = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, NULL, 'Banks', 'AST')
set @BankId = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, NULL, 'Expenses', 'EXP')
set @ExpensesId = SCOPE_IDENTITY()

-- Income
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @IncomeId, 'Job #1', 'INC')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @IncomeId, 'Job #2', 'INC')

-- Bank
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @BankId, 'Checking', 'AST')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @BankId, 'Savings', 'AST')

-- Expenses

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Utilities', 'EXP')
set @Subtemp = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Electricity', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Water and sewer', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Gas/Oil', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Telephone', 'EXP')
-- SUB ---------------------------------------------------------------------------------------------------------------------------

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Food', 'EXP')
set @Subtemp = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Groceries', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Eating Out', 'EXP')
-- SUB ---------------------------------------------------------------------------------------------------------------------------

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Health + Medical', 'EXP')
set @Subtemp = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Insurance', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Doctor', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Gym Membership', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Medication', 'EXP')
-- SUB ---------------------------------------------------------------------------------------------------------------------------

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Transportation', 'EXP')
set @Subtemp = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Car Payment', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Gasoline', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Auto Repairs', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Insurance', 'EXP')
-- SUB ---------------------------------------------------------------------------------------------------------------------------

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Entertainment', 'EXP')
set @Subtemp = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Cable', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Computer Expenses', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Hobbies', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Vacations', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Subscriptions', 'EXP')
-- SUB ---------------------------------------------------------------------------------------------------------------------------

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Pets', 'EXP')
set @Subtemp = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Food', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Vet', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Grooming', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Boarding', 'EXP')
-- SUB ---------------------------------------------------------------------------------------------------------------------------

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Clothing', 'EXP')
set @Subtemp = SCOPE_IDENTITY()
-- SUB ---------------------------------------------------------------------------------------------------------------------------

-- SUB ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @ExpensesId, 'Miscellaneous', 'EXP')
set @Subtemp = SCOPE_IDENTITY()

INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Household Products', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Gifts', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Grooming', 'EXP')
INSERT INTO [Account] (HouseholdId, ParentId, Name, Catagory) VALUES (@HouseholdId, @Subtemp, 'Other', 'EXP')
-- SUB ---------------------------------------------------------------------------------------------------------------------------

UPDATE [User] SET HouseholdId = @HouseholdId WHERE Id = @UserId

RETURN 0
