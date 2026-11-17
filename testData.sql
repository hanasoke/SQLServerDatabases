--CREATE DATABASE testData;
--GO

--USE testData;
--GO

--CREATE TABLE employees(
--	id INT IDENTITY(1,1) PRIMARY KEY,
--	employee_name VARCHAR(100) NOT NULL,
--	gender VARCHAR(20) NOT NULL,
--	position VARCHAR(100) NOT NULL,
--	department VARCHAR(100), 
--	salary DECIMAL(18, 2),
--	email VARCHAR(100) UNIQUE,
--	phone VARCHAR(20),
--	hire_date DATE,
--	created_at DATETIME DEFAULT GETDATE()
--);

--INSERT INTO employees 
--(employee_name, gender, position, department, salary, email, phone, hire_date)
--VALUES
--('Andi Saputra', 'Laki-laki', 'Manager', 'IT', 8000000, 'andi@gmail.com', '081234567801', '2024-01-10'),
--('Budi Santoso', 'Laki-laki', 'Programmer', 'IT', 6500000, 'budi@gmail.com', '081234567802', '2024-02-15'),
--('Citra Amelia', 'Perempuan', 'HRD', 'Human Resource', 6000000, 'citra@gmail.com', '081234567803', '2024-03-20'),
--('Dewi Lestari', 'Perempuan', 'Finance', 'Finance', 5500000, 'dewi@gmail.com', '081234567804', '2024-04-05'),
--('Eko Prasetyo', 'Laki-laki', 'Designer', 'Creative', 5000000, 'eko@gmail.com', '081234567805', '2024-05-12');

--SELECT * FROM employees;

--INSERT INTO employees 
--(employee_name, gender, position, department, salary, email, phone, hire_date)
--VALUES 
--('Amelia Mustika Ratu', 'Perempuan', 'Sekretaris', 'Finance', 10500500, 'amel@gmail.com', '083234967806', '2020-01-01');

--SELECT * FROM employees;

--UPDATE employees 
--SET salary = 7555999
--WHERE id = 2;

--SELECT * FROM employees;

--DELETE FROM employees 
--WHERE id = 5;

--SELECT * FROM employees;

--CREATE TABLE books (
--	id INT IDENTITY(1,1) PRIMARY KEY,
--	isbn VARCHAR(20) NOT NULL,
--	title VARCHAR(150) NOT NULL, 
--	author VARCHAR(100) NOT NULL,
--	publisher VARCHAR(100),
--	publication_year INT,
--	price DECIMAL(18,2),

--	CONSTRAINT UQ_books_isbn UNIQUE(isbn),
--	CONSTRAINT UQ_books_title UNIQUE (title)
--);

--INSERT INTO books 
--(isbn, title, author, publisher, publication_year, price)
--VALUES 
--('9786020324784', 'Belajar SQL Server', 'Andi', 'Gramedia', 2024, 85000),
--('9786020324785', 'Belajar Laravel', 'Budi', 'Elex Media', 2025, 95000),
--('9786020324786', 'Belajar Flutter', 'Citra', 'Informatika', 2025, 100000);

--BEGIN TRY 
--	INSERT INTO books 
--	(isbn, title, author, publisher, publication_year, price)
--	VALUES 
--	 ('8786140324784', 'Matematika Parenting', 'Basalamah', 'Gramedia', 2021, 55000);

--	PRINT 'Data buku berhasil ditambahkan';

--END TRY 

--BEGIN CATCH 

--	PRINT 'VALIDASI ERROR: Data buku sudah terdaftar atau tidak valid!';

--	PRINT ERROR_MESSAGE();
--end CATCH;

--SELECT * FROM books;

--UPDATE books 
--SET title = 'Tips Main Catur Untuk Pemula'
--WHERE id = 1;