CREATE TABLE [Account]
(
	HouseholdId INT NOT NULL,
	Id INT NOT NULL IDENTITY,
	ParentId INT NULL,
	Name NVARCHAR(50) NOT NULL,
	Catagory CHAR(3) NOT NULL,
	
	CONSTRAINT Parent_Same_Catagory CHECK (ParentId IS NULL OR ([dbo].[AccountType](HouseholdId, ParentId) = Catagory)),
	CONSTRAINT Parent_Not_Account CHECK (ParentId != Id),
	CONSTRAINT Catagory_Enum CHECK (Catagory IN ('AST', 'INC', 'EXP')),

	PRIMARY KEY (HouseholdId, Id),
	CONSTRAINT FK_RECUSIVE_TABLE FOREIGN KEY (HouseholdId, ParentId) REFERENCES [Account](HouseholdId, Id),
	CONSTRAINT FK_ACCOUNT_HOUSEHOLD FOREIGN KEY (HouseholdId) REFERENCES [Household](Id)
)
GO
CREATE INDEX IXD_Account_HouseholdId ON [Account](HouseholdId)
GO