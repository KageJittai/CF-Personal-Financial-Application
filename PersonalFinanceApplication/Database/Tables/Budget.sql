CREATE TABLE [Budget]
(
	Id int NOT NULL IDENTITY,
	HouseholdId int NOT NULL,
	AccountId int NOT NULL,
	Limit money NOT NULL,
	StartDate Date NOT NULL,
	EndDate Date NOT NULL,

	PRIMARY KEY (Id),
	CONSTRAINT FK_BUDGET_HOUSEHOLD FOREIGN KEY (HouseholdId) REFERENCES [Household](Id),
	CONSTRAINT FK_BUDGET_ACCOUNT FOREIGN KEY (AccountId) REFERENCES [Account](Id)
)
