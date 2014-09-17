CREATE TABLE [User]
(
	Id int NOT NULL IDENTITY,
	Email nvarchar(50) NOT NULL,
	PasswordHash nvarchar(512) NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	HouseholdId int NULL,

	PRIMARY KEY (Id),
	CONSTRAINT FK_USER_HOUSEHOLD FOREIGN KEY (HouseholdId) REFERENCES [Household](Id)
)