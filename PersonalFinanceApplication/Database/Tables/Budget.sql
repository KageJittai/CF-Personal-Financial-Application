CREATE TABLE [Budget]
(
	HouseholdId int NOT NULL,
	Id int NOT NULL IDENTITY,
	AccountId int NOT NULL,
	Limit money NOT NULL,
	StartDate Date NOT NULL,
	EndDate Date NOT NULL,

	CONSTRAINT Budget_Account_Exp CHECK ([dbo].[AccountType](HouseholdId, AccountId) = 'EXP'),

	PRIMARY KEY (HouseholdId, Id),
	CONSTRAINT FK_BUDGET_HOUSEHOLD FOREIGN KEY (HouseholdId) REFERENCES [Household](Id),
	CONSTRAINT FK_BUDGET_ACCOUNT FOREIGN KEY (HouseholdId, AccountId) REFERENCES [Account](HouseholdId, Id)
)
