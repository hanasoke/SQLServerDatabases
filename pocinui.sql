-- CREATE DATABASE BelajarSQLServer;
-- GO

-- USE BelajarSQLServer;
-- GO

-- CREATE TABLE siswa (
--    id INT IDENTITY(1,1) PRIMARY KEY,
--    nama VARCHAR(100) NOT NULL,
--    kelas VARCHAR(20),
--    jurusan VARCHAR(50),
--    no_hp VARCHAR(20),
--    alamat VARCHAR(200)
-- );
-- GO

-- CREATE TABLE program (
--    id INT IDENTITY(1,1) PRIMARY KEY,
--    nama_program VARCHAR(100) NOT NULL,
--    jenjang VARCHAR(20),
--    harga DECIMAL(12,2),
--    deskripsi VARCHAR(500)
-- );

-- INSERT INTO program
--    (nama_program, jenjang, harga, deskripsi)
-- VALUES
--    ('Matematika', 'SMP', 150000, 'Program belajar matematika SMP'),
--    ('Fisika', 'SMA', 200000, 'Program belajar fisika SMA'),
--    ('Bahasa Inggris', 'SMP', 175000, 'Program belajar Bahasa Inggris SMP');


-- SELECT * FROM program;

