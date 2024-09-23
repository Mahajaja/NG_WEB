--USE db_aad2f8_neogenesis
USE NEO_GENESIS
GO

-- Crear tabla AspNetRoles
CREATE TABLE AspNetRoles (
    Id NVARCHAR(128) NOT NULL PRIMARY KEY,
    Name NVARCHAR(256) NOT NULL
);

-- Crear índice único en el campo Name de AspNetRoles
CREATE UNIQUE INDEX RoleNameIndex ON AspNetRoles(Name);

-- Crear tabla AspNetUsers
CREATE TABLE AspNetUsers (
    Id NVARCHAR(128) NOT NULL PRIMARY KEY,
	id_usuario INT IDENTITY(1,1) NOT NULL,
    Email NVARCHAR(256),
    EmailConfirmed BIT NOT NULL,
    PasswordHash NVARCHAR(MAX),
    SecurityStamp NVARCHAR(MAX),
    PhoneNumber NVARCHAR(MAX),
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEndDateUtc DATETIME,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    UserName NVARCHAR(256) NOT NULL
);

-- Crear índice único en el campo UserName de AspNetUsers
CREATE UNIQUE INDEX UserNameIndex ON AspNetUsers(UserName);

-- Crear tabla AspNetUserRoles (relación entre usuarios y roles)
CREATE TABLE AspNetUserRoles (
    UserId NVARCHAR(128) NOT NULL,
    RoleId NVARCHAR(128) NOT NULL,
    PRIMARY KEY (UserId, RoleId),
    CONSTRAINT FK_AspNetUserRoles_AspNetUsers FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE,
    CONSTRAINT FK_AspNetUserRoles_AspNetRoles FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
);

-- Crear tabla AspNetUserClaims (reclamaciones de usuarios)
CREATE TABLE AspNetUserClaims (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(128) NOT NULL,
    ClaimType NVARCHAR(MAX),
    ClaimValue NVARCHAR(MAX),
    CONSTRAINT FK_AspNetUserClaims_AspNetUsers FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- Crear tabla AspNetUserLogins (logins externos de usuarios)
CREATE TABLE AspNetUserLogins (
    LoginProvider NVARCHAR(128) NOT NULL,
    ProviderKey NVARCHAR(128) NOT NULL,
    UserId NVARCHAR(128) NOT NULL,
    PRIMARY KEY (LoginProvider, ProviderKey, UserId),
    CONSTRAINT FK_AspNetUserLogins_AspNetUsers FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- Crear índices
CREATE INDEX IX_AspNetUserRoles_UserId ON AspNetUserRoles(UserId);
CREATE INDEX IX_AspNetUserRoles_RoleId ON AspNetUserRoles(RoleId);
CREATE INDEX IX_AspNetUserClaims_UserId ON AspNetUserClaims(UserId);
CREATE INDEX IX_AspNetUserLogins_UserId ON AspNetUserLogins(UserId);

SELECT * FROM AspNetUsers
SELECT * FROM USUARIO
--UPDATE AspNetUsers
--SET UserName = 'spadmin'
--WHERE Id = 'd36b7f68-6eff-412e-a52c-593ed30c6d44'