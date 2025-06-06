CREATE DATABASE BusinessHost;
GO

USE BusinessHost;
GO

CREATE TABLE [dbo].[Academy] (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuthenticatorId] [varchar](256) NOT NULL,
	[ApplicationData] [nvarchar](max) NULL,
	[CreatedAt] [datetime2] NOT NULL,
	[LastModified] [datetime2] NOT NULL
);
GO 

INSERT INTO [dbo].[Academy] ([AuthenticatorId], [ApplicationData], [CreatedAt], [LastModified])
VALUES ('authenticator1', 'application data 1', GETDATE(), GETDATE());
GO
