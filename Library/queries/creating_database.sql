-- create database library
CREATE DATABASE Library;

USE Library;
-- create table readers
CREATE TABLE Readers (
	ReaderID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(250) NOT NULL,
    LastName VARCHAR(250) NOT NULL,
    Age INT NOT NULL,
    StreetName VARCHAR(250) NOT NULL,
    BuildingNumber VARCHAR(20) NOT NULL,
    ApartmentNumber VARCHAR(20) DEFAULT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    City VARCHAR(250) NOT NULL,
    PhoneNumber VARCHAR(50) NOT NULL,
    Email VARCHAR(250) NOT NULL,
    DateAdded TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- create table authors
CREATE TABLE Authors (
	AuthorID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(250) NOT NULL,
    LastName VARCHAR(250) NOT NULL
);
-- -- create table genres
CREATE TABLE Genres (
	GenreID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(250) NOT NULL
);
-- create table publishers
CREATE TABLE Publishers (
	PublisherID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    PublisherName VARCHAR(250) NOT NULL,
    City VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(250)
);
-- create table books
CREATE TABLE Books (
	BookID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(250) NOT NULL,
    ReleaseDate DATE NOT NULL,
    AuthorID INT NOT NULL,
    GenreID INT NOT NULL,
    PublisherID INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES genres(GenreID),
    FOREIGN KEY (PublisherID) REFERENCES publishers(PublisherID)
);
-- create table borrowings
CREATE TABLE Borrowings  (
    BorrowingID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    UserID INT NOT NULL,
	BorrowDate DATE NOT NULL,
    ReturnDate DATE DEFAULT NULL,
    ExpectedReturnDate DATE NOT NULL,
    Delay INT DEFAULT 0,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (UserID) REFERENCES Readers(ReaderID)
);

-- create trigger for set return date;
DELIMITER //
CREATE TRIGGER set_expected_return_date
BEFORE INSERT ON Borrowings
FOR EACH ROW
	BEGIN 
		SET NEW.ExpectedReturnDate = DATE_ADD(NEW.BorrowDate, INTERVAL 28 DAY);
	END
//
DELIMITER ;

-- create penalties table
CREATE TABLE Penalties (
	PenaltyID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    BorrowingID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Settled BOOLEAN DEFAULT FALSE,
    FOREIGN KEY(BorrowingID) REFERENCES Borrowings(BorrowingID)
);