-- Publishers table
INSERT INTO Publishers(publisher_id, name, zip_code_fk)
VALUES(1000, 'John', 43201);

DELETE FROM Publishers WHERE zip_code_fk = 43201;

-- Authors table
INSERT INTO Authors(author_id, name)
VALUES(10001, 'Author1');

DELETE FROM Authors WHERE author_id = 10001;

-- Books table
INSERT INTO Books(isbn, title, year, price, category, publisher, publisher_id)
VALUES('19999', 'Book1', 2023, 25.00, 'Fiction', 'John', 1000);

INSERT INTO BookAuthors(isbn, author_id)
VALUES('19999', 1);

DELETE FROM BookAuthors WHERE isbn = '19999' AND author_id = 1;

-- Customer table
INSERT INTO Customer(username, email, first_name, last_name, password)
VALUES('user1', 'user1@example.com', 'John', 'Doe', 'password1');

DELETE FROM Customer WHERE username = 'user1';
