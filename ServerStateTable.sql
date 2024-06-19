



CREATE TABLE dbo.ServerState
(
	ServerID INT NOT NULL PRIMARY KEY,
	State	INT NOT NULL,
	Time DateTimeOffset NOT NULL
);