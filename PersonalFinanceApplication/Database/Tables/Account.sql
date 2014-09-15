CREATE TABLE [Account]
(
	Id int NOT NULL IDENTITY,
	ParentId int NULL,
	HouseholdId int NOT NULL,
	Name nvarchar(50) NOT NULL,
	Catagory char(3) NOT NULL,
	
	CONSTRAINT Parent_Same_Catagory CHECK (ParentId IS NULL OR ([dbo].[AccountType](ParentId, Catagory, DEFAULT) > 0)),
	CONSTRAINT Parent_Same_Household CHECK (ParentId IS NULL OR ([dbo].[AccountHousehold](ParentId) = HouseholdId)),
	CONSTRAINT Catagory_Enum CHECK (Catagory IN ('AST', 'INC', 'EXP')),

	PRIMARY KEY (Id),
	CONSTRAINT FK_RECUSIVE_TABLE FOREIGN KEY (ParentId) REFERENCES [Account](Id),
	CONSTRAINT FK_ACCOUNT_HOUSEHOLD FOREIGN KEY (HouseholdId) REFERENCES [Household](Id)
)
GO
CREATE INDEX IXD_Account_HouseholdId ON [Account](HouseholdId)
GO