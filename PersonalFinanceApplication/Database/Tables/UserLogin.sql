CREATE TABLE [UserLogin]
(
	UserId int NOT NULL,
	Provider nvarchar(50) NOT NULL,
	UserKey nvarchar(512) NOT NULL,
	
	PRIMARY KEY (UserId, Provider),
	CONSTRAINT FK_MEMBERLOGIN_MEMBER FOREIGN KEY (UserId) REFERENCES [User](Id)
)
