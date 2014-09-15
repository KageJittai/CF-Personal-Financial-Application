CREATE TABLE [dbo].[Transaction]
(
	Id int NOT NULL IDENTITY,
	SourceAccount int NULL,
	DestinationAccount int NULL,
	Date Date NOT NULL,
	Description nvarchar(MAX) NOT NULL,
	Amount money NOT NULL,
	Reconciled bit NOT NULL DEFAULT(0),

	-- Must have a source or destination
	CONSTRAINT SRC_OR_DEST CHECK (SourceAccount IS NOT NULL OR DestinationAccount IS NOT NULL),

	-- Source and Destination can not be the same
	CONSTRAINT SRC_DEST_NOT_EQUAL CHECK (SourceAccount != DestinationAccount),

	-- Source and Destination must belong to the same household
	CONSTRAINT Source_Destination_Same_Household CHECK ([dbo].[AccountHousehold](SourceAccount) = [dbo].[AccountHousehold](DestinationAccount)),

	-- Source can only come from INC or AST accounts
	CONSTRAINT Source_valid CHECK (SourceAccount IS NULL OR [dbo].[AccountType](SourceAccount, 'INC', 'AST') > 0),

	-- Destination can only go to EXP or AST accounts
	CONSTRAINT Destination_valid CHECK (DestinationAccount IS NULL OR [dbo].[AccountType](DestinationAccount, 'EXP', 'AST') > 0),

	PRIMARY KEY (Id),
	CONSTRAINT FK_SOURCE_ACCOUNT FOREIGN KEY (SourceAccount) REFERENCES [Account](Id),
	CONSTRAINT FK_DEST_ACCOUNT FOREIGN KEY (DestinationAccount) REFERENCES [Account](Id),
)
GO
CREATE INDEX IDX_Transaction_SourceAccount ON [Transaction](SourceAccount)
GO
CREATE INDEX IDX_Transaction_DestinationAccount ON [Transaction](DestinationAccount)
