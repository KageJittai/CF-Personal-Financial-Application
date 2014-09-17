CREATE TABLE [dbo].[Transaction]
(
	Id INT NOT NULL IDENTITY,
	HouseholdId INT NOT NULL,
	SourceAccount INT NULL,
	DestinationAccount INT NULL,
	Date DATE NOT NULL,
	Description NVARCHAR(MAX) NOT NULL,
	Amount MONEY NOT NULL,
	Reconciled BIT NOT NULL DEFAULT(0),

	-- Must have a source or destination
	CONSTRAINT SRC_OR_DEST CHECK (SourceAccount IS NOT NULL OR DestinationAccount IS NOT NULL),

	-- Source and Destination can not be the same
	CONSTRAINT SRC_DEST_NOT_EQUAL CHECK (SourceAccount != DestinationAccount),

	-- Source can only come from INC or AST accounts
	CONSTRAINT Source_valid CHECK (SourceAccount IS NULL OR [dbo].[AccountType](HouseholdId, SourceAccount) IN('INC', 'AST')),

	-- Destination can only go to EXP or AST accounts
	CONSTRAINT Destination_valid CHECK (DestinationAccount IS NULL OR [dbo].[AccountType](HouseholdId, DestinationAccount) IN('EXP', 'AST')),

	PRIMARY KEY (Id),
	CONSTRAINT FK_SOURCE_ACCOUNT FOREIGN KEY (HouseholdId, SourceAccount) REFERENCES [Account](HouseholdId, Id),
	CONSTRAINT FK_DEST_ACCOUNT FOREIGN KEY (HouseholdId, DestinationAccount) REFERENCES [Account](HouseholdId, Id),
)
GO
CREATE INDEX IDX_Transaction_SourceAccount ON [Transaction](HouseholdId, SourceAccount)
GO
CREATE INDEX IDX_Transaction_DestinationAccount ON [Transaction](HouseholdId, DestinationAccount)
