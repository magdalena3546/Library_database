-- tworzenie bazy danych
CREATE DATABASE Library;

USE Library;
-- tworzenie tabeli zawierającej czytelników
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
-- tworzenie tabeli zawierającej autorów
CREATE TABLE Authors (
	AuthorID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(250) NOT NULL,
    LastName VARCHAR(250) NOT NULL
);
-- tworzenie tabeli zawierającej gatunki literackie
CREATE TABLE Genres (
	GenreID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(250) NOT NULL
);
-- tworzenie tabeli zawierającej wydawnictwa
CREATE TABLE Publishers (
	PublisherID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    PublisherName VARCHAR(250) NOT NULL,
    City VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(250)
);
-- tworzenie tabeli zawierającej książki
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

CREATE TABLE Borrowings  (
    BorrowingID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    UserID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE DEFAULT NULL,
    ExpectedReturnDate DATE NOT NULL,
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

INSERT INTO Borrowings (BookID, UserID, BorrowDate)
VALUES (1, 1, '2024-04-15');
