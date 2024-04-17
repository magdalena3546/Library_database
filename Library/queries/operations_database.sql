USE Library;
-- select title from books and full name from authors
SELECT 
	Title, 
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Books b 
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID;

-- select authors and title and group by author's full name
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Title
FROM Authors a 
LEFT JOIN Books b ON a.AuthorID = b.AuthorID
ORDER BY FullName;

-- select books (title and full name of authors) by specific genre (Fantastyka)
SELECT 
	title,
    CONCAT(a.firstName, ' ', a.lastName) AS fullName,
    g.genreName
FROM Books b
INNER JOIN Genres g ON g.GenreID = b.GenreID
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID
WHERE g.genreName LIKE 'Fantastyka%';

-- select book by Author's full name
SELECT 
	CONCAT(FirstName, ' ', LastName) AS FullName,
	title
FROM Authors a
INNER JOIN Books b ON a.AuthorID = b.AuthorID
WHERE CONCAT(FirstName, ' ', LastName) LIKE 'Bolesław Prus%';

-- check if book is borrowed by title ('Wiedźmin')
SELECT 
	title 
FROM Books b
INNER JOIN Borrowings o ON b.BookID = o.BookID
WHERE b.title LIKE 'Wiedźmin%' AND o.returnDate IS NULL;
    