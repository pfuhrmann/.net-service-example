
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/12/2015 02:19:10
-- Generated from EDMX file: D:\Google Drive\Visual Studio\comp1688\DataModel\DataModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [comp1688];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Sitters'
CREATE TABLE [dbo].[Sitters] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(max)  NOT NULL,
    [LastName] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Phone] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Services'
CREATE TABLE [dbo].[Services] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Postcode] nvarchar(max)  NOT NULL,
    [Type] nvarchar(max)  NOT NULL,
    [Location] nvarchar(max)  NOT NULL,
    [Availability] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Charges] nvarchar(max)  NOT NULL,
    [Sitter_Id] int  NOT NULL
);
GO

-- Creating table 'Images'
CREATE TABLE [dbo].[Images] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [code] nvarchar(max)  NOT NULL,
    [Service_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Sitters'
ALTER TABLE [dbo].[Sitters]
ADD CONSTRAINT [PK_Sitters]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Services'
ALTER TABLE [dbo].[Services]
ADD CONSTRAINT [PK_Services]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Images'
ALTER TABLE [dbo].[Images]
ADD CONSTRAINT [PK_Images]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Sitter_Id] in table 'Services'
ALTER TABLE [dbo].[Services]
ADD CONSTRAINT [FK_SitterService]
    FOREIGN KEY ([Sitter_Id])
    REFERENCES [dbo].[Sitters]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SitterService'
CREATE INDEX [IX_FK_SitterService]
ON [dbo].[Services]
    ([Sitter_Id]);
GO

-- Creating foreign key on [Service_Id] in table 'Images'
ALTER TABLE [dbo].[Images]
ADD CONSTRAINT [FK_ServiceImage]
    FOREIGN KEY ([Service_Id])
    REFERENCES [dbo].[Services]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ServiceImage'
CREATE INDEX [IX_FK_ServiceImage]
ON [dbo].[Images]
    ([Service_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------