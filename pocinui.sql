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
--   id INT IDENTITY(1,1) PRIMARY KEY,
--   nama_program VARCHAR(100) NOT NULL,
--   jenjang VARCHAR(20),
--   harga DECIMAL(12,2),
--   deskripsi VARCHAR(500)
-- );

--INSERT INTO program
  -- (nama_program, jenjang, harga, deskripsi)
  -- VALUES
  -- ('Matematika', 'SMP', 150000, 'Program belajar matematika SMP'),
  -- ('Fisika', 'SMA', 200000, 'Program belajar fisika SMA'),
  -- ('Bahasa Inggris', 'SMP', 175000, 'Program belajar Bahasa Inggris SMP');


-- SELECT * FROM program;

-- WITH DataDuplikat AS (
--    SELECT
--        id,
--        ROW_NUMBER() OVER (
--            PARTITION BY nama_program, jenjang, harga, deskripsi
--            ORDER BY id
--        ) AS nomor
--    FROM program
--)
-- DELETE FROM DataDuplikat
-- WHERE nomor > 1;

--INSERT INTO siswa 
  --(nama, kelas, jurusan, no_hp, alamat) 
 -- VALUES 
--	('Andi', 'XII', 'IPA', '081234567890', 'Bekasi'),
--	('Hanas', 'XI', 'IPS', '081234567891', 'Jakarta'),
--	('Citra', 'X', 'IPA', '081234567891', 'Depok');
--GO 

SELECT * FROM siswa;

-- UPDATE siswa
-- SET nama = 'Hanas'
-- WHERE nama = 'Andi' AND jurusan = 'IPS';

--WITH DataDuplikat AS (
--    SELECT
--        id,
--        ROW_NUMBER() OVER (
--            PARTITION BY nama, kelas, jurusan, no_hp, alamat
--            ORDER BY id
--        ) AS nomor
--    FROM siswa 
--)
--DELETE FROM DataDuplikat
--WHERE nomor > 1;

-- CREATE TABLE pendaftaran (
--	id INT IDENTITY(1,1) PRIMARY KEY,
-- 	siswa_id INT NOT NULL,
--	program_id INT NOT NULL,
--	tanggal_daftar DATE NOT NULL,

--	FOREIGN KEY (siswa_id) REFERENCES siswa(id),
--	FOREIGN KEY (program_id) REFERENCES program(id)
-- );

--SELECT
--    siswa.nama,
--    program.nama_program,
--    program.harga,
--    pendaftaran.tanggal_daftar
--FROM pendaftaran
--JOIN siswa
--    ON pendaftaran.siswa_id = siswa.id
--JOIN program
--    ON pendaftaran.program_id = program.id;